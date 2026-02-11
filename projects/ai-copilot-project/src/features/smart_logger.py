"""
Smart Logger - Sistema de Logging Inteligente
Gerado com assistência de IA (Claude/GPT-4)
"""

import functools
import json
import sys
from datetime import datetime
from pathlib import Path
from typing import Any, Callable, Optional

from loguru import logger

class SmartLogger:
    """
    Logger inteligente com contexto automático e formatação estruturada.
    
    Features:
    - Detecção automática de contexto (função, módulo, linha)
    - Níveis dinâmicos baseados em conteúdo
    - Saída JSON para análise automatizada
    - Decorator para logging automático de funções
    """
    
    def __init__(
        self,
        log_dir: str = "logs",
        app_name: str = "app",
        retention: str = "7 days",
        rotation: str = "10 MB"
    ):
        self.log_dir = Path(log_dir)
        self.log_dir.mkdir(exist_ok=True)
        self.app_name = app_name
        
        # Configuração de sinks
        self._configure_logger(retention, rotation)
    
    def _configure_logger(self, retention: str, rotation: str) -> None:
        """Configura sinks para console e arquivo."""
        
        # Remove handler padrão
        logger.remove()
        
        # Console - formato legível
        logger.add(
            sys.stdout,
            format="<green>{time:YYYY-MM-DD HH:mm:ss}</green> | "
                   "<level>{level: <8}</level> | "
                   "<cyan>{name}</cyan>:<cyan>{function}</cyan>:<cyan>{line}</cyan> | "
                   "<level>{message}</level>",
            level="INFO",
            colorize=True
        )
        
        # Arquivo JSON estruturado
        json_sink = self.log_dir / f"{self.app_name}_structured.jsonl"
        logger.add(
            str(json_sink),
            format="{message}",
            serialize=True,  # JSON automático
            rotation=rotation,
            retention=retention,
            level="DEBUG",
            encoding="utf-8"
        )
    
    def log(
        self,
        level: str,
        message: str,
        context: Optional[dict] = None,
        **kwargs
    ) -> None:
        """
        Log com contexto enriquecido.
        
        Args:
            level: Nível do log (DEBUG, INFO, WARNING, ERROR, CRITICAL)
            message: Mensagem principal
            context: Dicionário com dados adicionais
            **kwargs: Campos extras para serialização
        """
        # Detecta severidade automática para erros
        if level == "AUTO":
            level = self._detect_level(message)
        
        # Constrói payload estruturado
        payload = {
            "timestamp": datetime.utcnow().isoformat(),
            "app": self.app_name,
            "level": level,
            "message": message,
            "context": context or {},
            **kwargs
        }
        
        # Log com bind para campos extras
        logger.bind(**payload).log(level, message)
    
    def _detect_level(self, message: str) -> str:
        """Detecta nível baseado em palavras-chave."""
        error_keywords = ['error', 'exception', 'failed', 'crash', 'critical']
        warning_keywords = ['warning', 'deprecated', 'slow', 'timeout']
        
        msg_lower = message.lower()
        
        if any(kw in msg_lower for kw in error_keywords):
            return "ERROR"
        elif any(kw in msg_lower for kw in warning_keywords):
            return "WARNING"
        return "INFO"
    
    def auto_log(
        self,
        func: Callable,
        log_args: bool = False,
        log_result: bool = False,
        level: str = "INFO"
    ) -> Callable:
        """
        Decorator para logging automático de funções.
        
        Args:
            func: Função a ser decorada
            log_args: Logar argumentos de entrada
            log_result: Logar valor de retorno
            level: Nível do log
        """
        @functools.wraps(func)
        def wrapper(*args, **kwargs):
            start_time = datetime.utcnow()
            
            # Contexto da função
            context = {
                "function": func.__name__,
                "module": func.__module__,
                "file": func.__code__.co_filename,
                "line": func.__code__.co_firstlineno
            }
            
            if log_args:
                # Sanitiza args (remove dados sensíveis)
                context["args_count"] = len(args)
                context["kwargs_keys"] = list(kwargs.keys())
            
            try:
                result = func(*args, **kwargs)
                
                execution_time = (datetime.utcnow() - start_time).total_seconds()
                
                self.log(
                    level=level,
                    message=f"Function {func.__name__} executed successfully",
                    context={
                        **context,
                        "execution_time_ms": round(execution_time * 1000, 2),
                        "success": True
                    },
                    result_logged=log_result
                )
                
                return result
                
            except Exception as e:
                self.log(
                    level="ERROR",
                    message=f"Function {func.__name__} failed: {str(e)}",
                    context={
                        **context,
                        "exception_type": type(e).__name__,
                        "success": False
                    }
                )
                raise
        
        return wrapper

# Instância global
smart_logger = SmartLogger()

# Exemplo de uso
if __name__ == "__main__":
    @smart_logger.auto_log(log_args=True, log_result=True)
    def process_payment(user_id: int, amount: float) -> dict:
        """Simula processamento de pagamento."""
        return {"status": "success", "transaction_id": "txn_12345"}
    
    # Teste
    result = process_payment(123, 99.90)
    smart_logger.log("INFO", "Sistema iniciado", context={"version": "1.0.0"})

"""
Testes para features geradas com IA
Validam qualidade e funcionalidade do código
"""

import pytest
import json
from pathlib import Path
from src.features.smart_logger import SmartLogger
from src.features.ai_code_review import AICodeReviewer, ReviewComment

class TestSmartLogger:
    """Testes do sistema de logging inteligente."""
    
    def test_initialization(self, tmp_path):
        """Testa inicialização correta."""
        log_dir = tmp_path / "logs"
        logger = SmartLogger(log_dir=str(log_dir), app_name="test")
        
        assert log_dir.exists()
        assert logger.app_name == "test"
    
    def test_log_creation(self, tmp_path):
        """Testa criação de logs."""
        log_dir = tmp_path / "logs"
        logger = SmartLogger(log_dir=str(log_dir))
        
        logger.log("INFO", "Test message", context={"test": True})
        
        # Verifica arquivo JSONL
        log_files = list(log_dir.glob("*.jsonl"))
        assert len(log_files) == 1
        
        content = log_files[0].read_text()
        data = json.loads(content)
        assert data["message"] == "Test message"
        assert data["context"]["test"] is True
    
    def test_auto_log_decorator(self, tmp_path):
        """Testa decorator automático."""
        log_dir = tmp_path / "logs"
        logger = SmartLogger(log_dir=str(log_dir))
        
        @logger.auto_log(log_args=True)
        def sample_func(x: int, y: str) -> dict:
            return {"result": x}
        
        result = sample_func(42, "test")
        assert result["result"] == 42
        
        # Verifica se log foi criado
        log_files = list(log_dir.glob("*.jsonl"))
        assert len(log_files) > 0

class TestAICodeReviewer:
    """Testes do revisor de código."""
    
    def test_ast_analysis_bare_except(self):
        """Detecta bare except."""
        reviewer = AICodeReviewer()
        
        code = '''
try:
    pass
except:
    pass
'''
        comments = reviewer._ast_analysis(code)
        
        assert any(c.category == "best_practice" and "bare" in c.message.lower() 
                   for c in comments)
    
    def test_ast_analysis_eval_detected(self):
        """Detecta uso de eval."""
        reviewer = AICodeReviewer()
        
        code = 'result = eval(user_input)'
        comments = reviewer._ast_analysis(code)
        
        security_comments = [c for c in comments if c.category == "security"]
        assert len(security_comments) > 0
        assert any("eval" in c.message for c in security_comments)
    
    def test_report_generation(self):
        """Testa geração de relatório."""
        reviewer = AICodeReviewer()
        
        comments = [
            ReviewComment(line=10, severity="critical", 
                         category="security", message="SQL Injection risk"),
            ReviewComment(line=20, severity="warning",
                         category="style", message="Line too long")
        ]
        
        report = reviewer.generate_report(comments)
        
        assert "SQL Injection" in report
        assert "Line too long" in report
        assert "🔴" in report  # Emoji crítico
        assert "🟡" in report  # Emoji warning

if __name__ == "__main__":
    pytest.main([__file__, "-v"])

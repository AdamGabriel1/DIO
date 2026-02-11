# src/features/ai_code_review.py
"""
Sistema de Code Review Automatizado com IA
Analisa código Python e sugere melhorias usando LLM
"""

import ast
import openai
from pathlib import Path
from typing import List, Dict, Optional
from dataclasses import dataclass

@dataclass
class ReviewComment:
    line: int
    severity: str  # 'info', 'warning', 'critical'
    category: str  # 'style', 'security', 'performance', 'best_practice'
    message: str
    suggestion: Optional[str] = None

class AICodeReviewer:
    """
    Revisor de código baseado em IA.
    Combina análise estática (AST) com sugestões de LLM.
    """
    
    SYSTEM_PROMPT = """Você é um revisor de código Python sênior.
    Analise o código fornecido e identifique:
    1. Problemas de segurança (injeção, exposição de dados)
    2. Bugs potenciais (race conditions, tratamento de exceções)
    3. Oportunidades de performance (complexidade algorítmica)
    4. Violações de PEP 8 e boas práticas
    5. Sugestões de refatoração para legibilidade
    
    Responda em formato JSON:
    {
        "comments": [
            {
                "line": <número>,
                "severity": "info|warning|critical",
                "category": "style|security|performance|best_practice",
                "message": "descrição do problema",
                "suggestion": "código corrigido sugerido"
            }
        ],
        "summary": "visão geral da qualidade do código"
    }
    """
    
    def __init__(self, api_key: Optional[str] = None):
        self.client = openai.OpenAI(api_key=api_key) if api_key else None
    
    def analyze_file(self, filepath: str) -> List[ReviewComment]:
        """Analisa arquivo Python completo."""
        code = Path(filepath).read_text(encoding='utf-8')
        return self.analyze_code(code, filepath)
    
    def analyze_code(self, code: str, filename: str = "input.py") -> List[ReviewComment]:
        """
        Pipeline de análise: AST + IA.
        """
        comments = []
        
        # 1. Análise AST local (rápida, não depende de API)
        ast_comments = self._ast_analysis(code)
        comments.extend(ast_comments)
        
        # 2. Análise com IA (se API disponível)
        if self.client:
            ai_comments = self._ai_analysis(code, filename)
            comments.extend(ai_comments)
        
        return sorted(comments, key=lambda x: x.line)
    
    def _ast_analysis(self, code: str) -> List[ReviewComment]:
        """Análise estática usando Abstract Syntax Trees."""
        comments = []
        
        try:
            tree = ast.parse(code)
        except SyntaxError as e:
            return [ReviewComment(
                line=e.lineno or 1,
                severity='critical',
                category='best_practice',
                message=f'Syntax error: {e.msg}',
                suggestion='Corrija o erro de sintaxe antes da análise'
            )]
        
        for node in ast.walk(tree):
            # Detecta bare except
            if isinstance(node, ast.ExceptHandler):
                if node.type is None:
                    comments.append(ReviewComment(
                        line=node.lineno,
                        severity='warning',
                        category='best_practice',
                        message='Bare except clause detected',
                        suggestion='Use "except Exception:" ou especifique a exceção'
                    ))
            
            # Detecta uso de eval/exec
            elif isinstance(node, ast.Call):
                if isinstance(node.func, ast.Name) and node.func.id in ('eval', 'exec'):
                    comments.append(ReviewComment(
                        line=node.lineno,
                        severity='critical',
                        category='security',
                        message=f'Dangerous function {node.func.id}() detected',
                        suggestion='Use ast.literal_eval() ou json.loads() para dados seguros'
                    ))
            
            # Detecta variáveis não usadas
            elif isinstance(node, ast.FunctionDef):
                local_vars = set()
                used_vars = set()
                
                for child in ast.walk(node):
                    if isinstance(child, ast.Name):
                        if isinstance(child.ctx, ast.Store):
                            local_vars.add(child.id)
                        elif isinstance(child.ctx, ast.Load):
                            used_vars.add(child.id)
                
                unused = local_vars - used_vars - {'self', 'cls'}
                for var in unused:
                    # Simplificação: assume linha da função
                    pass  # Implementação completa requer análise mais profunda
        
        return comments
    
    def _ai_analysis(self, code: str, filename: str) -> List[ReviewComment]:
        """Análise usando modelo de linguagem."""
        try:
            response = self.client.chat.completions.create(
                model="gpt-4",
                messages=[
                    {"role": "system", "content": self.SYSTEM_PROMPT},
                    {"role": "user", "content": f"Arquivo: {filename}\n\n```python\n{code}\n```"}
                ],
                temperature=0.1,
                max_tokens=2000
            )
            
            # Parse da resposta (simplificado)
            content = response.choices[0].message.content
            
            # Extrai JSON da resposta
            import json
            try:
                data = json.loads(content)
                return [
                    ReviewComment(
                        line=c.get('line', 0),
                        severity=c.get('severity', 'info'),
                        category=c.get('category', 'best_practice'),
                        message=c.get('message', ''),
                        suggestion=c.get('suggestion')
                    )
                    for c in data.get('comments', [])
                ]
            except json.JSONDecodeError:
                # Fallback: parse manual ou log
                return []
                
        except Exception as e:
            print(f"[!] Erro na análise IA: {e}")
            return []
    
    def generate_report(self, comments: List[ReviewComment]) -> str:
        """Gera relatório formatado."""
        if not comments:
            return "✅ Nenhum problema detectado!"
        
        report = ["# Code Review Report\n"]
        
        severity_emoji = {
            'critical': '🔴',
            'warning': '🟡',
            'info': '🔵'
        }
        
        for comment in comments:
            emoji = severity_emoji.get(comment.severity, '⚪')
            report.append(f"{emoji} **Linha {comment.line}** ({comment.category})")
            report.append(f"   {comment.message}")
            if comment.suggestion:
                report.append(f"   💡 Sugestão: `{comment.suggestion}`")
            report.append("")
        
        return "\n".join(report)

# Uso
if __name__ == "__main__":
    reviewer = AICodeReviewer()
    
    # Exemplo de código com problemas
    sample_code = '''
def process_data(data):
    try:
        result = eval(data)  # Perigoso!
        return result
    except:
        pass  # Bare except
    '''
    
    comments = reviewer.analyze_code(sample_code)
    print(reviewer.generate_report(comments))

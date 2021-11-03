from cli.Context import Context
from BooleanFunction import BooleanFunction


class ContextManager:

    def __init__(self):
        self.current_context = None
        self.contexts = dict()

    def get_context(self, name: str = None) -> Context:
        if not name:
            return self.contexts[self.current_context]
        return self.contexts[name]

    def switch_context(self, name: str):
        if name in self.contexts:
            self.current_context = name
        else:
            raise Exception("Unknown context name.")

    def add_context(self, name: str, benchmark: BooleanFunction):
        self.contexts[name] = Context(benchmark)
        self.current_context = name

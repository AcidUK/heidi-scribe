#import FreeSimpleGUI as sg
import PySimpleGUI as sg

class Gui():
    def __init__(self):
        self.state = []

    def update(self, history, exam, imp, plan):
        self.state['history'] = history
        self.state['exam'] = exam
        self.state['imp'] = imp
        self.state['plan'] = plan

    def clear(self):
        self.state = []
    
    def show_gui(self):

        # All the stuff inside your window.
        layout = [  [sg.Checkbox('History', default=True, enable_events=True, k="history_check")],
                    [sg.Multiline(default_text=self.state['history'], size=(None, 5), k="history_text")],
                    [sg.HorizontalSeparator()],
                    [sg.Checkbox('Examination', default=True, enable_events=True, k="exam_check")],
                    [sg.Multiline(default_text=self.state['exam'], size=(None, 4), k="exam_text")],
                    [sg.HorizontalSeparator()],
                    [sg.Checkbox('Impression', default=True, enable_events=True, k="imp_check")],
                    [sg.Multiline(default_text=self.state['imp'], size=(None, 3), k="imp_text")],
                    [sg.HorizontalSeparator()],
                    [sg.Checkbox('Plan', default=True, enable_events=True, k="plan_check")],
                    [sg.Multiline(default_text=self.state['plan'], size=(None, 5), k="plan_text")],
                    [sg.HorizontalSeparator()],
                    [sg.Button('Ok') ]]

        # Create the Window
        window = sg.Window('History Clipboard Monitor', layout, keep_on_top=True)

        enabled_map = {
            'history_text': 'history_check',
            'exam_text': 'exam_check',
            'imp_text': 'imp_check',
            'plan_text': 'plan_check',
        }

        # Event Loop to process "events" and get the "values" of the inputs
        while True:
            event, values = window.read()
            
            for k,v in enabled_map.items():
                window[k].update(visible=values[v])
                
            # if user closes window or clicks cancel
            if event == sg.WIN_CLOSED or event == 'Ok':
                self.clear()

                for s in ['history', 'exam', 'imp', 'plan']:
                    if values[s + '_check']:
                        self.state[s] = values[s + '_text']

                break
            
        window.close()
        return self.state
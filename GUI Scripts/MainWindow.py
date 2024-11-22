import tkinter as tk
from tkinter import ttk, messagebox
from tkcalendar import DateEntry
import pyodbc
import InmatesManagement as im
import DisciplinaryActions as da
import InmatesRelease as ir
import ProgramsManagement as pm

# Database connection setup


def connect_to_db():
    try:
        conn = pyodbc.connect(
            'Driver={ODBC Driver 17 for SQL Server};'
            'Server=MOAAZ74;'
            'Database=Prison_DB;'
            'Trusted_Connection=yes;'
        )
        return conn
    except Exception as e:
        messagebox.showerror("Database Error", str(e))
        return None


# Initialize the main window
root = tk.Tk()
root.title("Prison Management System")
root.geometry("400x500")
root.config(bg="#f5f3e7")  # Background color to match your design

# Create a title label
title_label = tk.Label(root, text="PRISON MANAGEMENT SYSTEM",
                       font=("Arial", 16, "bold"), bg="#f5f3e7")
title_label.pack(pady=20)

conn = connect_to_db()

# Create functions that wrap the imported module calls


def open_inmate_management():
    im.manage_inmates_window(conn)


def open_inmate_release():
    ir.release_inmate_window(conn)


def open_disciplinary_actions():
    da.disciplinary_actions_window(conn)


def open_program_management():
    pm.program_management_window(conn)


# Create buttons with the same color scheme
buttons_data = [
    ("Inmates Management", open_inmate_management),
    ("Inmates Release", open_inmate_release),
    ("Disciplinary Actions", open_disciplinary_actions),
    ("Programs Management", open_program_management),
    ("Exit", root.quit)  # Pass function reference directly without parentheses
]

for btn_text, btn_command in buttons_data:
    color = "#eb8489" if btn_text == "Exit" else "#93b5cc"
    btn = tk.Button(root, text=btn_text, font=("Arial", 14), bg=color,
                    fg="black", width=25, height=2, command=btn_command)
    btn.pack(pady=10)

root.mainloop()

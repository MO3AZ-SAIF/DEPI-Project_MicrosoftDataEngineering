import tkinter as tk
from tkinter import messagebox


def disciplinary_actions_window(conn):
    # Create a database connection
    c = conn.cursor()

    # Function to add disciplinary action to the database
    def add_action():
        inmate_id = entry_inmate_id.get()
        action_description = text_action.get("1.0", tk.END).strip()
        consequence = text_consequence.get("1.0", tk.END).strip()

        if inmate_id and action_description and consequence:
            c.execute('EXEC InmateManagement.InsertDisciplinaryAction @InmateID = ?, @ActionDescription = ?, @Consequence = ?;',
                      (inmate_id, action_description, consequence))
            conn.commit()
            messagebox.showinfo(
                "Success", "Disciplinary action added successfully!")
            clear_entries()
        else:
            messagebox.showwarning("Input Error", "Please fill all fields!")

    # Clear input fields
    def clear_entries():
        entry_inmate_id.delete(0, tk.END)
        text_action.delete("1.0", tk.END)
        text_consequence.delete("1.0", tk.END)

    # Create the main window
    root = tk.Tk()
    root.title("Disciplinary Actions")
    root.geometry("400x400")
    root.config(bg="#F4F4E2")

    # Main Frame
    frame = tk.Frame(root, bg="#F4F4E2")
    frame.pack(pady=20)

    # Title Label
    label_title = tk.Label(frame, text="DISCIPLINARY ACTIONS", font=(
        "Helvetica", 16, "bold"), bg="#F4F4E2")
    label_title.grid(row=0, column=0, columnspan=2, padx=10, pady=10)

    # Set a common width for all input fields
    common_width = 30

    # Inmate ID
    label_inmate_id = tk.Label(frame, text="Inmate ID", bg="#F4F4E2")
    label_inmate_id.grid(row=1, column=0, padx=10, pady=10, sticky="w")
    entry_inmate_id = tk.Entry(frame, width=common_width)
    entry_inmate_id.grid(row=1, column=1, padx=10, pady=10)

    # Action Description
    label_action = tk.Label(frame, text="Action Description", bg="#F4F4E2")
    label_action.grid(row=2, column=0, padx=10, pady=10, sticky="w")
    text_action = tk.Text(frame, height=4, width=common_width)
    text_action.grid(row=2, column=1, padx=10, pady=10)

    # Consequence
    label_consequence = tk.Label(frame, text="Consequence", bg="#F4F4E2")
    label_consequence.grid(row=3, column=0, padx=10, pady=10, sticky="w")
    text_consequence = tk.Text(frame, height=4, width=common_width)
    text_consequence.grid(row=3, column=1, padx=10, pady=10)

    # Add Button
    button_add = tk.Button(frame, text="Add", command=add_action,
                           bg="#E77B71", fg="white", width=common_width-2)
    button_add.grid(row=4, column=0, columnspan=2, padx=10, pady=20)

    root.mainloop()

    # Close the database connection on exit
    conn.close()

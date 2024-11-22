import tkinter as tk
from tkinter import messagebox


def release_inmate_window(conn):
    # Create a database connection
    c = conn.cursor()

    # Function to Release inmate
    def release_inmate():
        inmate_id = entry_inmate_id.get()
        Reason = text_reason.get("1.0", tk.END).strip()

        if inmate_id and Reason:
            c.execute(
                'EXEC InmateManagement.InsertReleaseRecord @InmateID = ?, @Reason = ?;', (inmate_id, Reason))
            conn.commit()
            messagebox.showinfo("Success", "Inmate Released successfully!")
            clear_entries()
        else:
            messagebox.showwarning("Input Error", "Please fill all fields!")

    # Clear input fields
    def clear_entries():
        entry_inmate_id.delete(0, tk.END)
        text_reason.delete("1.0", tk.END)

    # Create the main window
    root = tk.Tk()
    root.title("Inmates Release")
    root.geometry("400x400")
    root.config(bg="#F4F4E2")

    # Main Frame
    frame = tk.Frame(root, bg="#F4F4E2")
    frame.pack(pady=20)

    # Title Label
    label_title = tk.Label(frame, text="INMATES RELEASE", font=(
        "Helvetica", 16, "bold"), bg="#F4F4E2")
    label_title.grid(row=0, column=0, columnspan=2, padx=10, pady=10)

    # Set a common width for all input fields
    common_width = 30

    # Inmate ID
    label_inmate_id = tk.Label(frame, text="Inmate ID", bg="#F4F4E2")
    label_inmate_id.grid(row=1, column=0, padx=10, pady=10, sticky="w")
    entry_inmate_id = tk.Entry(frame, width=common_width)
    entry_inmate_id.grid(row=1, column=1, padx=10, pady=10)

    # Reason
    label_reason = tk.Label(frame, text="Reason", bg="#F4F4E2")
    label_reason.grid(row=2, column=0, padx=10, pady=10, sticky="w")
    text_reason = tk.Text(frame, height=4, width=common_width)
    text_reason.grid(row=2, column=1, padx=10, pady=10)

    # Add Button
    button_add = tk.Button(frame, text="Add", command=release_inmate,
                           bg="#E77B71", fg="white", width=common_width-2)
    button_add.grid(row=4, column=0, columnspan=2, padx=10, pady=20)

    root.mainloop()

    # Close the database connection on exit
    conn.close()

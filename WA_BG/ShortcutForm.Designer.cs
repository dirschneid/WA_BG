namespace WA_BG
{
    partial class ShortcutForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.uiKey = new System.Windows.Forms.TextBox();
            this.uiModifierCtrl = new System.Windows.Forms.CheckBox();
            this.uiModifierShift = new System.Windows.Forms.CheckBox();
            this.uiModifierAlt = new System.Windows.Forms.CheckBox();
            this.buttonOk = new System.Windows.Forms.Button();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.uiTimeout = new System.Windows.Forms.NumericUpDown();
            this.groupBox3 = new System.Windows.Forms.GroupBox();
            this.uiComment = new System.Windows.Forms.TextBox();
            this.groupBox1.SuspendLayout();
            this.groupBox2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.uiTimeout)).BeginInit();
            this.groupBox3.SuspendLayout();
            this.SuspendLayout();
            // 
            // uiKey
            // 
            this.uiKey.Location = new System.Drawing.Point(154, 21);
            this.uiKey.Name = "uiKey";
            this.uiKey.Size = new System.Drawing.Size(139, 20);
            this.uiKey.TabIndex = 0;
            this.uiKey.KeyDown += new System.Windows.Forms.KeyEventHandler(this.textKey_KeyDown);
            // 
            // uiModifierCtrl
            // 
            this.uiModifierCtrl.AutoSize = true;
            this.uiModifierCtrl.Location = new System.Drawing.Point(63, 23);
            this.uiModifierCtrl.Name = "uiModifierCtrl";
            this.uiModifierCtrl.Size = new System.Drawing.Size(41, 17);
            this.uiModifierCtrl.TabIndex = 6;
            this.uiModifierCtrl.Text = "Ctrl";
            this.uiModifierCtrl.UseVisualStyleBackColor = true;
            // 
            // uiModifierShift
            // 
            this.uiModifierShift.AutoSize = true;
            this.uiModifierShift.Location = new System.Drawing.Point(10, 23);
            this.uiModifierShift.Name = "uiModifierShift";
            this.uiModifierShift.Size = new System.Drawing.Size(47, 17);
            this.uiModifierShift.TabIndex = 8;
            this.uiModifierShift.Text = "Shift";
            this.uiModifierShift.UseVisualStyleBackColor = true;
            // 
            // uiModifierAlt
            // 
            this.uiModifierAlt.AutoSize = true;
            this.uiModifierAlt.Location = new System.Drawing.Point(110, 23);
            this.uiModifierAlt.Name = "uiModifierAlt";
            this.uiModifierAlt.Size = new System.Drawing.Size(38, 17);
            this.uiModifierAlt.TabIndex = 9;
            this.uiModifierAlt.Text = "Alt";
            this.uiModifierAlt.UseVisualStyleBackColor = true;
            // 
            // buttonOk
            // 
            this.buttonOk.DialogResult = System.Windows.Forms.DialogResult.OK;
            this.buttonOk.Location = new System.Drawing.Point(240, 190);
            this.buttonOk.Name = "buttonOk";
            this.buttonOk.Size = new System.Drawing.Size(75, 23);
            this.buttonOk.TabIndex = 10;
            this.buttonOk.Text = "Select";
            this.buttonOk.UseVisualStyleBackColor = true;
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.uiKey);
            this.groupBox1.Controls.Add(this.uiModifierAlt);
            this.groupBox1.Controls.Add(this.uiModifierShift);
            this.groupBox1.Controls.Add(this.uiModifierCtrl);
            this.groupBox1.Location = new System.Drawing.Point(12, 70);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(303, 55);
            this.groupBox1.TabIndex = 11;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Shortcut";
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.uiTimeout);
            this.groupBox2.Location = new System.Drawing.Point(12, 131);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(303, 53);
            this.groupBox2.TabIndex = 12;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "Timeout (sec), up to 20 min";
            // 
            // uiTimeout
            // 
            this.uiTimeout.Location = new System.Drawing.Point(10, 19);
            this.uiTimeout.Maximum = new decimal(new int[] {
            1200,
            0,
            0,
            0});
            this.uiTimeout.Minimum = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this.uiTimeout.Name = "uiTimeout";
            this.uiTimeout.Size = new System.Drawing.Size(283, 20);
            this.uiTimeout.TabIndex = 0;
            this.uiTimeout.Value = new decimal(new int[] {
            1,
            0,
            0,
            0});
            // 
            // groupBox3
            // 
            this.groupBox3.Controls.Add(this.uiComment);
            this.groupBox3.Location = new System.Drawing.Point(12, 12);
            this.groupBox3.Name = "groupBox3";
            this.groupBox3.Size = new System.Drawing.Size(303, 52);
            this.groupBox3.TabIndex = 13;
            this.groupBox3.TabStop = false;
            this.groupBox3.Text = "Comment";
            // 
            // uiComment
            // 
            this.uiComment.Location = new System.Drawing.Point(10, 19);
            this.uiComment.Name = "uiComment";
            this.uiComment.Size = new System.Drawing.Size(283, 20);
            this.uiComment.TabIndex = 0;
            // 
            // ShortcutForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(329, 227);
            this.Controls.Add(this.groupBox3);
            this.Controls.Add(this.buttonOk);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.groupBox1);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow;
            this.MaximizeBox = false;
            this.Name = "ShortcutForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Select shortcut";
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.groupBox2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.uiTimeout)).EndInit();
            this.groupBox3.ResumeLayout(false);
            this.groupBox3.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.TextBox uiKey;
        private System.Windows.Forms.CheckBox uiModifierCtrl;
        private System.Windows.Forms.CheckBox uiModifierShift;
        private System.Windows.Forms.CheckBox uiModifierAlt;
        private System.Windows.Forms.Button buttonOk;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.NumericUpDown uiTimeout;
        private System.Windows.Forms.GroupBox groupBox3;
        private System.Windows.Forms.TextBox uiComment;
    }
}
reportextension 50123 StandardSalesOrderConfExt extends "Standard Sales - Order Conf."
{
    dataset
    {
        add(Header)
        {
            column(Notes; AllNotes)
            {
            }
        }
        modify(Header)
        {
            trigger OnAfterAfterGetRecord()
            var
                RecordLink: Record "Record Link";
                RecordLinkMgt: Codeunit "Record Link Management";
                TypHelper: Codeunit "Type Helper";
                CRLF: Text[2];
            begin
                AllNotes := '';
                CRLF := TypHelper.CRLFSeparator();
                RecordLink.Reset();
                RecordLink.SetRange("Record ID", Header.RecordId);
                RecordLink.SetRange(Type, RecordLink.Type::Note);
                RecordLink.SetAutoCalcFields(Note);
                if RecordLink.FindSet() then
                    repeat
                        if AllNotes = '' then
                            AllNotes := RecordLinkMgt.ReadNote(RecordLink)
                        else
                            AllNotes := AllNotes + CRLF + '-------------------------' + CRLF + RecordLinkMgt.ReadNote(RecordLink);
                    until RecordLink.Next() = 0;
            end;
        }
    }
    var
        AllNotes: Text;
}

page 50000 "LabelPicture"
{
    Caption = 'Label Picture';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = CardPart;
    SourceTable = "Production Order";
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            field("Label Image"; rec."Label Image")
            {
                ApplicationArea = All;
                ShowCaption = false;
                ToolTip = 'Label Picture';
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(TakePicture)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Take';
                Image = Camera;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Activate the camera on the device.';

                trigger OnAction()
                var
                   
                    Picstream: InStream;
                    LabelPictureName: Text;
                    MimeType: Label 'image/jpge', Locked = true;

                begin      
                    TestField("No.");
                    if Camera.GetPicture(Picstream, LabelPictureName) then begin
                        Clear(rec."Label Image");
                        rec."Label Image".ImportStream(Picstream, LabelPictureName, MimeType);
                        rec.Modify();
                    end;
                end;
            }

            action(DeletePicture)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Delete';
                Enabled = DeleteExportEnabled;
                Image = Delete;
                ToolTip = 'Delete the record.';

                trigger OnAction()
                begin
                    TestField("No.");

                    if not Confirm(DeleteImageQst) then
                        exit;

                    Clear("Label Image");
                    Modify(true);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetEditableOnPictureActions;
    end;

    trigger OnOpenPage()
    begin
    end;

    var
        Camera: Codeunit Camera;
        [InDataSet]
        CameraAvailable: Boolean;
        OverrideImageQst: Label 'The existing picture will be replaced. Do you want to continue?';
        DeleteImageQst: Label 'Are you sure you want to delete the picture?';
        SelectPictureTxt: Label 'Select a picture to upload';
        DeleteExportEnabled: Boolean;

    local procedure SetEditableOnPictureActions()
    begin
        DeleteExportEnabled := "Label Image".HasValue;
    end;

}

.class Lcom/nmi/mtv/app/ui/condor/epg/ViewTVGuide$2;
.super Ljava/lang/Object;
.source "ViewTVGuide.java"

# interfaces
.implements Landroid/view/View$OnTouchListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/nmi/mtv/app/ui/condor/epg/ViewTVGuide;-><init>(Landroid/content/Context;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/nmi/mtv/app/ui/condor/epg/ViewTVGuide;


# direct methods
.method constructor <init>(Lcom/nmi/mtv/app/ui/condor/epg/ViewTVGuide;)V
    .locals 0
    .param p1, "this$0"    # Lcom/nmi/mtv/app/ui/condor/epg/ViewTVGuide;

    .prologue
    .line 109
    iput-object p1, p0, Lcom/nmi/mtv/app/ui/condor/epg/ViewTVGuide$2;->this$0:Lcom/nmi/mtv/app/ui/condor/epg/ViewTVGuide;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onTouch(Landroid/view/View;Landroid/view/MotionEvent;)Z
    .locals 1
    .param p1, "v"    # Landroid/view/View;
    .param p2, "event"    # Landroid/view/MotionEvent;

    .prologue
    .line 112
    iget-object v0, p0, Lcom/nmi/mtv/app/ui/condor/epg/ViewTVGuide$2;->this$0:Lcom/nmi/mtv/app/ui/condor/epg/ViewTVGuide;

    invoke-static {v0}, Lcom/nmi/mtv/app/ui/condor/epg/ViewTVGuide;->-get0(Lcom/nmi/mtv/app/ui/condor/epg/ViewTVGuide;)Landroid/view/GestureDetector;

    move-result-object v0

    invoke-virtual {v0, p2}, Landroid/view/GestureDetector;->onTouchEvent(Landroid/view/MotionEvent;)Z

    .line 113
    const/4 v0, 0x0

    return v0
.end method

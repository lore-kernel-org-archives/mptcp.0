Content-Type: multipart/mixed; boundary="===============7030713760585091431=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v7 mptcp-next 1/7] mptcp: create the
 listening socket for new port
Date: Fri, 11 Dec 2020 16:21:20 +0100
Message-ID: <8d83a6f809c0856b4488247da8d7d48bea1fa66f.camel@redhat.com>
In-Reply-To: 20201210034836.GA3190@MiBook
X-Status: 
X-Keywords:                  
X-UID: 7149

--===============7030713760585091431==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-12-10 at 11:48 +0800, Geliang Tang wrote:
> Hi Paolo,
> =

> On Wed, Dec 09, 2020 at 04:25:33PM +0100, Paolo Abeni wrote:
> > On Wed, 2020-12-09 at 20:33 +0800, Geliang Tang wrote:
> > > The full log and the patch is attached. Apply this patch and run
> > > mptcp_join.sh can reproduce the warning.
> > =

> > I tried applying the v7 posted on the ML, plus some manging to let it
> > apply on top of current export. The end result is quite alike the patch
> > attached here.
> > =

> > Still I can't reproduce the issue.
> =

> Thanks for your help.
> =

> v7 should be added the following code in pm_netlink.c to invoke
> sock_release to reproduce the issue:
> =

> @@ -885,6 +968,8 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *skb,=
 struct genl_info *info)
>         spin_unlock_bh(&pernet->lock);
> =

>         mptcp_nl_remove_subflow_and_signal_addr(sock_net(skb->sk), &entry=
->addr);
> +       if (entry->lsk)
> +               sock_release(entry->lsk);
>         kfree_rcu(entry, rcu);
> =

>         return ret;
> =

> > I'm wondering if the kconfig matters here (beyond CONFIG_LOCKDEP=3Dy, I
> > mean). Could you please share the config you are using ?

Ok, I can reproduce the issue with the above chunk. Looks like it's
just a neste lock issue. I'm unsure why lockdep did not splat before -
the issue has been there since sometime.

Anyhow the following fixes the issue here:
---
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 56bc1ed94ca7..63f3043c1c1d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2144,7 +2144,7 @@ void __mptcp_close_ssk(struct sock *sk, struct sock *=
ssk,
 =

 	list_del(&subflow->node);
 =

-	lock_sock(ssk);
+	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
 =

 	/* if we are invoked by the msk cleanup code, the subflow is
 	 * already orphaned
---
/P


--===============7030713760585091431==--

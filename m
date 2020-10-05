Content-Type: multipart/mixed; boundary="===============5823468431555686021=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: INFO: task hung in lock_sock_nested (3)
Date: Mon, 05 Oct 2020 15:17:03 +0200
Message-ID: <c73586823d1a40b68a40bb971a3601dd13fba766.camel@redhat.com>
In-Reply-To: 000000000000d494a605b0b20f8c@google.com
X-Status: 
X-Keywords:                  
X-UID: 6200

--===============5823468431555686021==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-10-02 at 08:48 -0700, syzbot wrote:
> Hello,
> =

> syzbot found the following issue on:
> =

> HEAD commit:    87d5034d Merge tag 'mlx5-updates-2020-09-30' of git://git=
...
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1377fb37900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D7b5cc8ec2218e=
99d
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dfcf8ca5817d6e92=
c6567
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D14566267900=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D14458a4d900000
> =

> The issue was bisected to:
> =

> commit ab174ad8ef76276cadfdae98731d31797d265927
> Author: Paolo Abeni <pabeni(a)redhat.com>
> Date:   Mon Sep 14 08:01:12 2020 +0000
> =

>     mptcp: move ooo skbs into msk out of order queue.
> =


I can't easily reproduce the issue with the above c repro. I think it's
just a matter of timing - slower CPU will make the races harder to
reproduce right? Can I expect/hope more success with the syz-repro
instead? I'm asking beforehands because the local setup is less
immediate for that one.

Not being able to analyze the bug in a live system, I'm wild guessing
the race addressed below could be the root cause - even if that
predates the bisected commit.

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git=
 master
---
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f483eab0081a..db14a7307a8f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1034,6 +1034,11 @@ static void mptcp_nospace(struct mptcp_sock *msk)
 		if (sock)
 			set_bit(SOCK_NOSPACE, &sock->flags);
 	}
+
+        /* mptcp_data_acked() could run just before we set the NOSPACE bit,
+         * so explicitly check for snd_una value
+         */
+        mptcp_clean_una((struct sock *)msk);
 }
 =

 static bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)

--===============5823468431555686021==--

Content-Type: multipart/mixed; boundary="===============2042039377363621982=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: WARNING in mptcp_reset_timer
Date: Wed, 18 Nov 2020 16:44:02 +0100
Message-ID: <89d3320227621447393b2ad33890770b6b7711af.camel@redhat.com>
In-Reply-To: 000000000000b7f48605b45f80c5@google.com
X-Status: 
X-Keywords:                  
X-UID: 6775

--===============2042039377363621982==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-11-18 at 02:59 -0800, syzbot wrote:
> Hello,
> =

> syzbot found the following issue on:
> =

> HEAD commit:    7c8ca812 Add linux-next specific files for 20201117
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D14ccfce2500000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dff4bc71371dc5=
b13
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D42aa53dafb66a07=
e5a24
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1342e36e500=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D17f29bba500000
> =

> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+42aa53dafb66a07e5a24(a)syzkaller.appspotmail.com

#syz test: https://github.com/multipath-tcp/mptcp_net-next.git master
---
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8df013daea88..aeda4357de9a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1261,11 +1261,12 @@ static void mptcp_push_pending(struct sock *sk, uns=
igned int flags)
 		mptcp_push_release(sk, ssk, &info);
 =

 out:
-	/* start the timer, if it's not pending */
-	if (!mptcp_timer_pending(sk))
-		mptcp_reset_timer(sk);
-	if (copied)
+	if (copied) {
+		/* start the timer, if it's not pending */
+		if (!mptcp_timer_pending(sk))
+			mptcp_reset_timer(sk);
 		__mptcp_check_send_data_fin(sk);
+	}
 }
 =

 static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)

--===============2042039377363621982==--

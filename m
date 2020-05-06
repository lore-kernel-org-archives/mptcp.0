Content-Type: multipart/mixed; boundary="===============6319507275096376715=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 2/7] mptcp: make sure timer is
 inited/started once data is pending for transmission
Date: Wed, 06 May 2020 15:02:23 +0200
Message-ID: <20200506130228.1478-3-fw@strlen.de>
In-Reply-To: 20200506130228.1478-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 4321

--===============6319507275096376715==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The mptcp_connect self-tests with additional '-m mmap' argument triggers a
(harmless) WARN_ON_ONCE splat in mptcp_reset_timer() as the mptcp timer
is not initialized yet.

This is because the timer is only set up after the transmit loop, but
consecutive iterations can trigger the splat.

Make sure the timer is set as soon as we pass the first chunk of data.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/3
Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 25427797753b..ab6599dfda59 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -785,6 +785,11 @@ static int mptcp_sendmsg(struct sock *sk, struct msghd=
r *msg, size_t len)
 		}
 =

 		copied +=3D ret;
+		mptcp_set_timeout(sk, ssk);
+		/* start the timer, if it's not pending */
+		if (!mptcp_timer_pending(sk))
+			mptcp_reset_timer(sk);
+
 		tx_ok =3D msg_data_left(msg);
 		if (!tx_ok)
 			break;
@@ -796,12 +801,10 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
 		}
 	}
 =

-	mptcp_set_timeout(sk, ssk);
 	if (copied) {
 		ret =3D copied;
 		tcp_push(ssk, msg->msg_flags, mss_now, tcp_sk(ssk)->nonagle,
 			 size_goal);
-
 		/* start the timer, if it's not pending */
 		if (!mptcp_timer_pending(sk))
 			mptcp_reset_timer(sk);
-- =

2.26.2

--===============6319507275096376715==--

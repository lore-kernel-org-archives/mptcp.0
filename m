Content-Type: multipart/mixed; boundary="===============3128566615712539563=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 3/7] mptcp: make sure timer is inited once
 data is pending for transmission
Date: Mon, 11 May 2020 13:55:34 +0200
Message-ID: <20200511115538.6015-4-fw@strlen.de>
In-Reply-To: 20200511115538.6015-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 4362

--===============3128566615712539563==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The mptcp_connect self-tests with additional '-m mmap' argument triggers a
(harmless) WARN_ON_ONCE splat in mptcp_reset_timer() as the msk sockets
timer_ival is still 0.

This is because the timer is only set up after the transmit loop, but
the splat can be triggered once the first mptcp-level ACK is processed.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/3
Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 13fb04d45083..3e8117837b41 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -647,6 +647,9 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct s=
ock *ssk,
 out:
 	if (!retransmission)
 		pfrag->offset +=3D frag_truesize;
+
+	mptcp_set_timeout(sk, ssk);
+
 	*write_seq +=3D ret;
 	mptcp_subflow_ctx(ssk)->rel_write_seq +=3D ret;
 =

@@ -829,7 +832,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
 		}
 	}
 =

-	mptcp_set_timeout(sk, ssk);
 	if (copied) {
 		ret =3D copied;
 		tcp_push(ssk, msg->msg_flags, mss_now, tcp_sk(ssk)->nonagle,
@@ -1195,7 +1197,6 @@ static void mptcp_worker(struct work_struct *work)
 	dfrag->offset =3D orig_offset;
 	dfrag->data_len =3D orig_len;
 =

-	mptcp_set_timeout(sk, ssk);
 	release_sock(ssk);
 =

 reset_unlock:
-- =

2.26.2

--===============3128566615712539563==--

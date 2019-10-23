Content-Type: multipart/mixed; boundary="===============1255973700381217470=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 4/4] mptcp: switch mptcp_poll to mptcp socket wait
 queue
Date: Wed, 23 Oct 2019 16:23:55 +0200
Message-ID: <20191023142355.31599-5-fw@strlen.de>
In-Reply-To: 20191023142355.31599-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2289

--===============1255973700381217470==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tcp_poll places current task on a wait queue.  This can cause us to block
forever -- some subflows might never receive any data because they're
used as a backup/fallback path.

This makes mptcp_poll wait on the mptcp socket wait queue instead.
__tcp_poll is used instead to tcp_poll so current task won't wait
again after mptcp socket has been woken from the subflow layer.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c7755cde9810..c2b29f8d0377 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1238,11 +1238,13 @@ static __poll_t mptcp_poll(struct file *file, struc=
t socket *sock,
 		return ret;
 	}
 =

+	sock_poll_wait(file, sock, wait);
+
 	mptcp_for_each_subflow(msk, subflow) {
 		struct socket *tcp_sock;
 =

 		tcp_sock =3D mptcp_subflow_tcp_socket(subflow);
-		ret |=3D tcp_poll(file, tcp_sock, wait);
+		ret |=3D __tcp_poll(tcp_sock->sk);
 	}
 	release_sock(sk);
 =

-- =

2.21.0

--===============1255973700381217470==--

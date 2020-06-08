Content-Type: multipart/mixed; boundary="===============5692584533442421564=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 2/3] Squash-to: "net: mptcp: improve fallback to
 TCP"
Date: Mon, 08 Jun 2020 23:51:31 +0200
Message-ID: <e13417cbebcc883dcec3f9fd0a7c1c86e74db691.1591652866.git.pabeni@redhat.com>
In-Reply-To: cover.1591652866.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4619

--===============5692584533442421564==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Drop socket lock on mptcp poll: we don't need it anymore,
as we only use atomic ops on msk flags

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 3 ---
 net/mptcp/subflow.c  | 5 +++--
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 817472998c37..d6e786f20681 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1945,7 +1945,6 @@ static __poll_t mptcp_poll(struct file *file, struct =
socket *sock,
 =

 	msk =3D mptcp_sk(sk);
 	sock_poll_wait(file, sock, wait);
-	lock_sock(sk);
 =

 	if (test_bit(MPTCP_DATA_READY, &msk->flags))
 		mask =3D EPOLLIN | EPOLLRDNORM;
@@ -1955,8 +1954,6 @@ static __poll_t mptcp_poll(struct file *file, struct =
socket *sock,
 	if (sk->sk_shutdown & RCV_SHUTDOWN)
 		mask |=3D EPOLLIN | EPOLLRDNORM | EPOLLRDHUP;
 =

-	release_sock(sk);
-
 	return mask;
 }
 =

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index cd0f8c14be40..db066a43925f 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -247,10 +247,11 @@ static void subflow_finish_connect(struct sock *sk, c=
onst struct sk_buff *skb)
 		pr_debug("subflow=3D%p, thmac=3D%llu, remote_nonce=3D%u", subflow,
 			 subflow->thmac, subflow->remote_nonce);
 	} else  {
+		if (subflow->request_mptcp)
+			MPTCP_INC_STATS(sock_net(sk),
+					MPTCP_MIB_MPCAPABLEACTIVEFALLBACK);
 		mptcp_do_fallback(sk);
 		pr_fallback(mptcp_sk(subflow->conn));
-		MPTCP_INC_STATS(sock_net(sk),
-				MPTCP_MIB_MPCAPABLEACTIVEFALLBACK);
 	}
 =

 	if (mptcp_check_fallback(sk))
-- =

2.21.3

--===============5692584533442421564==--

Content-Type: multipart/mixed; boundary="===============5238381125098119037=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: fix state update on accept()
Date: Thu, 09 May 2019 18:43:08 +0200
Message-ID: <bd845eebe7d58a27e8ff603d4aa4e1c9bbd9b9fe.1557420146.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 1136

--===============5238381125098119037==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We must update the newly created socket status, not the listener
socket.

Fixes: cc0d09002896 ("mptcp: Implement MPTCP receive path")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8028bb7ae321..fa77d399a593 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -586,7 +586,7 @@ static struct sock *mptcp_accept(struct sock *sk, int f=
lags, int *err,
 	} else {
 		msk->subflow =3D new_sock;
 	}
-	inet_sk_state_store(sk, TCP_ESTABLISHED);
+	inet_sk_state_store(new_mptcp_sock->sk, TCP_ESTABLISHED);
 =

 	return new_mptcp_sock->sk;
 }
-- =

2.20.1


--===============5238381125098119037==--

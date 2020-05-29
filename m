Content-Type: multipart/mixed; boundary="===============8867365142049834857=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net] mptcp: remove msk from the token container at
 destruction time.
Date: Fri, 29 May 2020 11:28:34 +0200
Message-ID: <eca7eae3ef534c9fd09ec144d972435898b8f92e.1590744492.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4551

--===============8867365142049834857==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently we remote the msk from the token container only
via mptcp_close(). The MPTCP master socket can be destroyed
also via other paths (e.g. if not yet accepted, when shutting
down the listener socket). When we hit the latter scenario,
dangling msk references are left into the token container,
leading to memory corruption and/or UaF.

This change addresses the issue by moving the token removal
into the msk destructor.

Fixes: 79c0949e9a09 ("mptcp: Add key generation and token tree")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0b9368c30311..2867160a9524 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1346,7 +1346,6 @@ static void mptcp_close(struct sock *sk, long timeout)
 =

 	lock_sock(sk);
 =

-	mptcp_token_destroy(msk->token);
 	inet_sk_state_store(sk, TCP_CLOSE);
 =

 	/* be sure to always acquire the join list lock, to sync vs
@@ -1532,6 +1531,7 @@ static void mptcp_destroy(struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 =

+	mptcp_token_destroy(msk->token);
 	if (msk->cached_ext)
 		__skb_ext_put(msk->cached_ext);
 =

-- =

2.21.3

--===============8867365142049834857==--

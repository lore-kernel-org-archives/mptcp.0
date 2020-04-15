Content-Type: multipart/mixed; boundary="===============0068705724848282260=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp 2/7] mptcp: fix 'Attempt to release TCP socket
 in state' warnings
Date: Wed, 15 Apr 2020 19:19:49 +0200
Message-ID: <20200415171954.15321-3-fw@strlen.de>
In-Reply-To: 20200415171954.15321-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 4181

--===============0068705724848282260==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We need to set sk_state to CLOSED, else we will get following:

IPv4: Attempt to release TCP socket in state 3 00000000b95f109e
IPv4: Attempt to release TCP socket in state 10 00000000b95f109e

First one is from inet_sock_destruct(), second one from
mptcp_sk_clone failure handling.  Setting sk_state to CLOSED isn't
enough, we also need to orphan sk so it has DEAD flag set.
Otherwise, a very similar warning is printed from inet_sock_destruct().

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 7 +++++--
 net/mptcp/subflow.c  | 8 +++++++-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2118b51afd60..2bdfe2ea35bb 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1364,12 +1364,15 @@ struct sock *mptcp_sk_clone(const struct sock *sk, =
struct request_sock *req)
 	msk->subflow =3D NULL;
 =

 	if (unlikely(mptcp_token_new_accept(subflow_req->token, nsk))) {
+		nsk->sk_state =3D TCP_CLOSE;
 		bh_unlock_sock(nsk);
 =

 		/* we can't call into mptcp_close() here - possible BH context
-		 * free the sock directly
+		 * free the sock directly.
+		 * sk_clone_lock() sets nsk refcnt to two, hence call sk_free()
+		 * too.
 		 */
-		nsk->sk_prot->destroy(nsk);
+		sk_common_release(nsk);
 		sk_free(nsk);
 		return NULL;
 	}
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 936f748075a7..3a94f859347a 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -370,6 +370,12 @@ static void mptcp_sock_destruct(struct sock *sk)
 	inet_sock_destruct(sk);
 }
 =

+static void mptcp_force_close(struct sock *sk)
+{
+	inet_sk_state_store(sk, TCP_CLOSE);
+	sk_common_release(sk);
+}
+
 static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 					  struct sk_buff *skb,
 					  struct request_sock *req,
@@ -467,7 +473,7 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 out:
 	/* dispose of the left over mptcp master, if any */
 	if (unlikely(new_msk))
-		sock_put(new_msk);
+		mptcp_force_close(new_msk);
 	return child;
 =

 close_child:
-- =

2.24.1

--===============0068705724848282260==--

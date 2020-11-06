Content-Type: multipart/mixed; boundary="===============4737398794246522124=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2] Squash-to "mptcp: refactor shutdown and close"
Date: Fri, 06 Nov 2020 22:26:54 +0100
Message-ID: <f4551b5fce944cf69dbbecbacf5ac354999b76fe.1604697929.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 6576

--===============4737398794246522124==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The msk status for fallback socket is not tracked correctly.
We must switch to close only after the subflow is moved
there, or the worker will not run and pending mptcp data
will not be spooled after close()

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 13 +++++++++----
 net/mptcp/subflow.c  |  1 -
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a6bd06c724d5..4abec5f74f1c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -764,8 +764,10 @@ static void mptcp_check_for_eof(struct mptcp_sock *msk)
 =

 	mptcp_for_each_subflow(msk, subflow)
 		receivers +=3D !subflow->rx_eof;
+	if (receivers)
+		return;
 =

-	if (!receivers && !(sk->sk_shutdown & RCV_SHUTDOWN)) {
+	if (!(sk->sk_shutdown & RCV_SHUTDOWN)) {
 		/* hopefully temporary hack: propagate shutdown status
 		 * to msk, when all subflows agree on it
 		 */
@@ -775,6 +777,8 @@ static void mptcp_check_for_eof(struct mptcp_sock *msk)
 		set_bit(MPTCP_DATA_READY, &msk->flags);
 		sk->sk_data_ready(sk);
 	}
+	if (sk->sk_state !=3D TCP_CLOSE && sk->sk_shutdown =3D=3D SHUTDOWN_MASK)
+		inet_sk_state_store(sk, TCP_CLOSE);
 }
 =

 static bool mptcp_ext_cache_refill(struct mptcp_sock *msk)
@@ -2157,11 +2161,12 @@ static void mptcp_close(struct sock *sk, long timeo=
ut)
 	lock_sock(sk);
 	sk->sk_shutdown =3D SHUTDOWN_MASK;
 =

-	if (sk->sk_state =3D=3D TCP_LISTEN ||
-	    __mptcp_check_fallback((struct mptcp_sock *)sk)) {
+	if ((1 << sk->sk_state) & (TCPF_LISTEN | TCP_CLOSE)) {
 		inet_sk_state_store(sk, TCP_CLOSE);
 		goto cleanup;
-	} else if (sk->sk_state =3D=3D TCP_CLOSE) {
+	} else if (__mptcp_check_fallback((struct mptcp_sock *)sk)) {
+		if (!mptcp_send_head(sk))
+			inet_sk_state_store(sk, TCP_CLOSE);
 		goto cleanup;
 	}
 =

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 1e9a72af67dc..fd356dc9d580 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1282,7 +1282,6 @@ static void subflow_state_change(struct sock *sk)
 		mptcp_data_ready(parent, sk);
 =

 	if (__mptcp_check_fallback(mptcp_sk(parent)) &&
-	    !(parent->sk_shutdown & RCV_SHUTDOWN) &&
 	    !subflow->rx_eof && subflow_is_done(sk)) {
 		subflow->rx_eof =3D 1;
 		mptcp_subflow_eof(parent);
-- =

2.26.2

--===============4737398794246522124==--

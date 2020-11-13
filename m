Content-Type: multipart/mixed; boundary="===============3657538761794232359=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next] Squash-to: "mptcp: refactor shutdown and
 close" again
Date: Fri, 13 Nov 2020 17:07:32 +0100
Message-ID: <9527070ab1b0bb6d890d2a7960ada035a610edae.1605283639.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 6713

--===============3657538761794232359==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

fix bad mask and fallback shutdown

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1d9c785c278e..90eb50663b7f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2173,13 +2173,9 @@ static void mptcp_close(struct sock *sk, long timeou=
t)
 	lock_sock(sk);
 	sk->sk_shutdown =3D SHUTDOWN_MASK;
 =

-	if ((1 << sk->sk_state) & (TCPF_LISTEN | TCP_CLOSE)) {
+	if ((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE)) {
 		inet_sk_state_store(sk, TCP_CLOSE);
 		goto cleanup;
-	} else if (__mptcp_check_fallback((struct mptcp_sock *)sk)) {
-		if (!mptcp_send_head(sk))
-			inet_sk_state_store(sk, TCP_CLOSE);
-		goto cleanup;
 	}
 =

 	if (mptcp_close_state(sk))
-- =

2.26.2

--===============3657538761794232359==--

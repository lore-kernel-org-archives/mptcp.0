Content-Type: multipart/mixed; boundary="===============6161691727758930280=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v3 03/13] tcp: factor out __tcp_close() helper
Date: Mon, 16 Nov 2020 10:48:04 +0100
Message-ID: <42f5d69c2eef1b2cd427f46813f7045909d62b96.1605458224.git.pabeni@redhat.com>
In-Reply-To: cover.1605458224.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6741

--===============6161691727758930280==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

unlocked version of protocol level close, will be used by
MPTCP to allow decouple orphaning and subflow level close.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 include/net/tcp.h | 1 +
 net/ipv4/tcp.c    | 9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 8aee43ef0578..d5d22c411918 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -395,6 +395,7 @@ void tcp_update_metrics(struct sock *sk);
 void tcp_init_metrics(struct sock *sk);
 void tcp_metrics_init(void);
 bool tcp_peer_is_proven(struct request_sock *req, struct dst_entry *dst);
+void __tcp_close(struct sock *sk, long timeout);
 void tcp_close(struct sock *sk, long timeout);
 void tcp_init_sock(struct sock *sk);
 void tcp_init_transfer(struct sock *sk, int bpf_op, struct sk_buff *skb);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index a40981e347c0..b285b338a019 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2420,13 +2420,12 @@ bool tcp_check_oom(struct sock *sk, int shift)
 	return too_many_orphans || out_of_socket_memory;
 }
 =

-void tcp_close(struct sock *sk, long timeout)
+void __tcp_close(struct sock *sk, long timeout)
 {
 	struct sk_buff *skb;
 	int data_was_unread =3D 0;
 	int state;
 =

-	lock_sock(sk);
 	sk->sk_shutdown =3D SHUTDOWN_MASK;
 =

 	if (sk->sk_state =3D=3D TCP_LISTEN) {
@@ -2590,6 +2589,12 @@ void tcp_close(struct sock *sk, long timeout)
 out:
 	bh_unlock_sock(sk);
 	local_bh_enable();
+}
+
+void tcp_close(struct sock *sk, long timeout)
+{
+	lock_sock(sk);
+	__tcp_close(sk, timeout);
 	release_sock(sk);
 	sock_put(sk);
 }
-- =

2.26.2

--===============6161691727758930280==--

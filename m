Content-Type: multipart/mixed; boundary="===============8766761569071791873=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 03/13] tcp: factor out __tcp_close() helper
Date: Thu, 12 Nov 2020 11:48:01 +0100
Message-ID: <e204ff31d5684799528721a5ce85c43fe4f65ca9.1605175834.git.pabeni@redhat.com>
In-Reply-To: cover.1605175834.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6673

--===============8766761569071791873==
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
index 374d0a2acc4b..f3d42cb626fc 100644
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
index 391705aaa80e..743b71ca0d78 100644
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

--===============8766761569071791873==--

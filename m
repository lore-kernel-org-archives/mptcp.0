Content-Type: multipart/mixed; boundary="===============5408143646693379166=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 1/8] tcp: factor out __tcp_close() helper
Date: Thu, 24 Sep 2020 15:59:23 +0200
Message-ID: <883f44cfeb0e48545e1ae01ea80c49b8a3f647a9.1600955407.git.pabeni@redhat.com>
In-Reply-To: cover.1600955407.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6014

--===============5408143646693379166==
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
index 852f0d71dd40..16fa67854059 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -392,6 +392,7 @@ void tcp_update_metrics(struct sock *sk);
 void tcp_init_metrics(struct sock *sk);
 void tcp_metrics_init(void);
 bool tcp_peer_is_proven(struct request_sock *req, struct dst_entry *dst);
+void __tcp_close(struct sock *sk, long timeout);
 void tcp_close(struct sock *sk, long timeout);
 void tcp_init_sock(struct sock *sk);
 void tcp_init_transfer(struct sock *sk, int bpf_op, struct sk_buff *skb);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 65057744fac8..a5fc63e58cb3 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2404,13 +2404,12 @@ bool tcp_check_oom(struct sock *sk, int shift)
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
@@ -2574,6 +2573,12 @@ void tcp_close(struct sock *sk, long timeout)
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

--===============5408143646693379166==--

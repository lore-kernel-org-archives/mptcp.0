Content-Type: multipart/mixed; boundary="===============5257143606591094508=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 2/2] tcp: factor out __tcp_close() helper
Date: Fri, 16 Oct 2020 12:51:08 +0200
Message-ID: <223fbbe119ad993d10b3be9012f60cfd8ed58651.1602840570.git.pabeni@redhat.com>
In-Reply-To: cover.1602840570.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6330

--===============5257143606591094508==
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
index e41569e55d97..75c5ee45aaa8 100644
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
index 259dca2bd3dd..046ac30bb041 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2418,13 +2418,12 @@ bool tcp_check_oom(struct sock *sk, int shift)
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
@@ -2588,6 +2587,12 @@ void tcp_close(struct sock *sk, long timeout)
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

--===============5257143606591094508==--

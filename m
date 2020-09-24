Content-Type: multipart/mixed; boundary="===============5223653246144634055=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH net-next 15/16] mptcp: add sk_stop_timer_sync
 helper
Date: Thu, 24 Sep 2020 08:30:01 +0800
Message-ID: <31247220b62d6759de9eb91b841be449714b9d69.1600853093.git.geliangtang@gmail.com>
In-Reply-To: cover.1600853093.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6011

--===============5223653246144634055==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added a new helper sk_stop_timer_sync, it deactivates a timer
like sk_stop_timer, but waits for the handler to finish.

Acked-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 include/net/sock.h | 2 ++
 net/core/sock.c    | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index eaa5cac5e836..a5c6ae78df77 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2195,6 +2195,8 @@ void sk_reset_timer(struct sock *sk, struct timer_lis=
t *timer,
 =

 void sk_stop_timer(struct sock *sk, struct timer_list *timer);
 =

+void sk_stop_timer_sync(struct sock *sk, struct timer_list *timer);
+
 int __sk_queue_drop_skb(struct sock *sk, struct sk_buff_head *sk_queue,
 			struct sk_buff *skb, unsigned int flags,
 			void (*destructor)(struct sock *sk,
diff --git a/net/core/sock.c b/net/core/sock.c
index ba9e7d91e2ef..d9a537e6876a 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2947,6 +2947,13 @@ void sk_stop_timer(struct sock *sk, struct timer_lis=
t* timer)
 }
 EXPORT_SYMBOL(sk_stop_timer);
 =

+void sk_stop_timer_sync(struct sock *sk, struct timer_list *timer)
+{
+	if (del_timer_sync(timer))
+		__sock_put(sk);
+}
+EXPORT_SYMBOL(sk_stop_timer_sync);
+
 void sock_init_data(struct socket *sock, struct sock *sk)
 {
 	sk_init_common(sk);
-- =

2.17.1

--===============5223653246144634055==--

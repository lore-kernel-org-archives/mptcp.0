Content-Type: multipart/mixed; boundary="===============0567401767501154331=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v5 mptcp-next 2/3] mptcp: add
 sk_stop_timer_sync helper
Date: Mon, 21 Sep 2020 15:30:37 +0800
Message-ID: <fc30ac8f663d4b511663598b9ec4ff6ae1527a93.1600672866.git.geliangtang@gmail.com>
In-Reply-To: cover.1600672866.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5956

--===============0567401767501154331==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added a new helper sk_stop_timer_sync, it deactivates a timer
like sk_stop_timer, but waits for the handler to finish.

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

--===============0567401767501154331==--

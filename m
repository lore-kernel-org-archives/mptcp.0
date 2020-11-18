Content-Type: multipart/mixed; boundary="===============3092412305063675141=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v4 1/7] mptcp: open code mptcp variant for lock_sock
Date: Wed, 18 Nov 2020 23:30:10 +0100
Message-ID: <f8114368c329aa1d1e872eaaa464637885d53d42.1605737933.git.pabeni@redhat.com>
In-Reply-To: cover.1605737932.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6797

--===============3092412305063675141==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This allows invoking an additional callback under the
socket spin lock.

Will be used by the next patches to avoid additional
spin lock contention

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/core/sock.c      |  2 +-
 net/mptcp/protocol.h | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 727ea1cc633c..89ee8582bf01 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2486,7 +2486,7 @@ bool sk_page_frag_refill(struct sock *sk, struct page=
_frag *pfrag)
 }
 EXPORT_SYMBOL(sk_page_frag_refill);
 =

-static void __lock_sock(struct sock *sk)
+void __lock_sock(struct sock *sk)
 	__releases(&sk->sk_lock.slock)
 	__acquires(&sk->sk_lock.slock)
 {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 82d5626323b1..e9f553993322 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -253,6 +253,21 @@ struct mptcp_sock {
 	} rcvq_space;
 };
 =

+void __lock_sock(struct sock *sk);
+
+#define mptcp_lock_sock(___sk, cb) do {					\
+	struct sock *__sk =3D (___sk); /* silence macro reuse warning */	\
+	might_sleep();							\
+	spin_lock_bh(&__sk->sk_lock.slock);				\
+	if (__sk->sk_lock.owned)					\
+		__lock_sock(__sk);					\
+	cb;								\
+	__sk->sk_lock.owned =3D 1;					\
+	spin_unlock(&__sk->sk_lock.slock);				\
+	mutex_acquire(&__sk->sk_lock.dep_map, 0, 0, _RET_IP_);		\
+	local_bh_enable();						\
+} while (0)
+
 #define mptcp_for_each_subflow(__msk, __subflow)			\
 	list_for_each_entry(__subflow, &((__msk)->conn_list), node)
 =

-- =

2.26.2

--===============3092412305063675141==--

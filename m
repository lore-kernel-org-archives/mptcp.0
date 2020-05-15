Content-Type: multipart/mixed; boundary="===============2026990476448910901=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v2 2/3] inet_connection_sock: factor out
 destroy helper.
Date: Fri, 15 May 2020 19:22:16 +0200
Message-ID: <9cb1cf2e8b9dc89510ab38c938e2ba102b207d2f.1589558049.git.pabeni@redhat.com>
In-Reply-To: cover.1589558049.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4395

--===============2026990476448910901==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Move the steps to prepare an inet_connection_sock for
forced disposal inside a separate helper. No functional
changes inteded, this will just simplify the next patch.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
Reviewed-by: Christoph Paasch <cpaasch(a)apple.com>
---
 include/net/inet_connection_sock.h | 8 ++++++++
 net/ipv4/inet_connection_sock.c    | 6 +-----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connecti=
on_sock.h
index a3f076befa4f..2f1f8c3efb26 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -287,6 +287,14 @@ static inline int inet_csk_reqsk_queue_is_full(const s=
truct sock *sk)
 void inet_csk_reqsk_queue_drop(struct sock *sk, struct request_sock *req);
 void inet_csk_reqsk_queue_drop_and_put(struct sock *sk, struct request_soc=
k *req);
 =

+static inline void inet_csk_prepare_for_destroy_sock(struct sock *sk)
+{
+	/* The below has to be done to allow calling inet_csk_destroy_sock */
+	sock_set_flag(sk, SOCK_DEAD);
+	percpu_counter_inc(sk->sk_prot->orphan_count);
+	inet_sk(sk)->inet_num =3D 0;
+}
+
 void inet_csk_destroy_sock(struct sock *sk);
 void inet_csk_prepare_forced_close(struct sock *sk);
 =

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_soc=
k.c
index 5f34eb951627..d6faf3702824 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -896,11 +896,7 @@ void inet_csk_prepare_forced_close(struct sock *sk)
 	/* sk_clone_lock locked the socket and set refcnt to 2 */
 	bh_unlock_sock(sk);
 	sock_put(sk);
-
-	/* The below has to be done to allow calling inet_csk_destroy_sock */
-	sock_set_flag(sk, SOCK_DEAD);
-	percpu_counter_inc(sk->sk_prot->orphan_count);
-	inet_sk(sk)->inet_num =3D 0;
+	inet_csk_prepare_for_destroy_sock(sk);
 }
 EXPORT_SYMBOL(inet_csk_prepare_forced_close);
 =

-- =

2.21.3

--===============2026990476448910901==--

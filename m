Content-Type: multipart/mixed; boundary="===============7346880713060798951=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 02/12] mptcp: Improved debugging
Date: Mon, 26 Mar 2018 09:32:05 +0200
Message-ID: <20180326073215.83607-3-cpaasch@apple.com>
In-Reply-To: 20180326073215.83607-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 409

--===============7346880713060798951==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Allow to print the value of ret when mptcp_add_sock fails.

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/mptcp/mptcp_ipv4.c | 3 ++-
 net/mptcp/mptcp_ipv6.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/mptcp_ipv4.c b/net/mptcp/mptcp_ipv4.c
index 99ff09225ebf..36cdbf09a5b9 100644
--- a/net/mptcp/mptcp_ipv4.c
+++ b/net/mptcp/mptcp_ipv4.c
@@ -280,7 +280,8 @@ int mptcp_init4_subsockets(struct sock *meta_sk, const =
struct mptcp_loc4 *loc,
 	lockdep_set_class_and_name(&(sk)->sk_lock.slock, &meta_slock_key, meta_sl=
ock_key_name);
 	lockdep_init_map(&(sk)->sk_lock.dep_map, meta_key_name, &meta_key, 0);
 =

-	if (mptcp_add_sock(meta_sk, sk, loc->loc4_id, rem->rem4_id, GFP_KERNEL)) {
+	ret =3D mptcp_add_sock(meta_sk, sk, loc->loc4_id, rem->rem4_id, GFP_KERNE=
L);
+	if (ret) {
 		net_err_ratelimited("%s mptcp_add_sock failed ret: %d\n",
 				    __func__, ret);
 		goto error;
diff --git a/net/mptcp/mptcp_ipv6.c b/net/mptcp/mptcp_ipv6.c
index 04b69220baef..bde4a9d7ab32 100644
--- a/net/mptcp/mptcp_ipv6.c
+++ b/net/mptcp/mptcp_ipv6.c
@@ -306,7 +306,8 @@ int mptcp_init6_subsockets(struct sock *meta_sk, const =
struct mptcp_loc6 *loc,
 	lockdep_set_class_and_name(&(sk)->sk_lock.slock, &meta_slock_key, meta_sl=
ock_key_name);
 	lockdep_init_map(&(sk)->sk_lock.dep_map, meta_key_name, &meta_key, 0);
 =

-	if (mptcp_add_sock(meta_sk, sk, loc->loc6_id, rem->rem6_id, GFP_KERNEL)) {
+	ret =3D mptcp_add_sock(meta_sk, sk, loc->loc6_id, rem->rem6_id, GFP_KERNE=
L);
+	if (ret) {
 		net_err_ratelimited("%s mptcp_add_sock failed ret: %d\n",
 				    __func__, ret);
 		goto error;
-- =

2.16.2


--===============7346880713060798951==--

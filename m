Content-Type: multipart/mixed; boundary="===============6451164153689513527=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH net-next 14/16] mptcp: add struct
 mptcp_pm_add_entry
Date: Thu, 24 Sep 2020 08:30:00 +0800
Message-ID: <26617b54898c115de8d916633b8e42055ed5c678.1600853093.git.geliangtang@gmail.com>
In-Reply-To: cover.1600853093.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6010

--===============6451164153689513527==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a new struct mptcp_pm_add_entry to describe add_addr's entry.

Acked-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index b33aebd85bd5..701972b55a45 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -28,6 +28,11 @@ struct mptcp_pm_addr_entry {
 	struct rcu_head		rcu;
 };
 =

+struct mptcp_pm_add_entry {
+	struct list_head	list;
+	struct mptcp_addr_info	addr;
+};
+
 struct pm_nl_pernet {
 	/* protects pernet updates */
 	spinlock_t		lock;
@@ -181,7 +186,7 @@ static void check_work_pending(struct mptcp_sock *msk)
 static bool lookup_anno_list_by_saddr(struct mptcp_sock *msk,
 				      struct mptcp_addr_info *addr)
 {
-	struct mptcp_pm_addr_entry *entry;
+	struct mptcp_pm_add_entry *entry;
 =

 	list_for_each_entry(entry, &msk->pm.anno_list, list) {
 		if (addresses_equal(&entry->addr, addr, false))
@@ -194,23 +199,23 @@ static bool lookup_anno_list_by_saddr(struct mptcp_so=
ck *msk,
 static bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 				     struct mptcp_pm_addr_entry *entry)
 {
-	struct mptcp_pm_addr_entry *clone =3D NULL;
+	struct mptcp_pm_add_entry *add_entry =3D NULL;
 =

 	if (lookup_anno_list_by_saddr(msk, &entry->addr))
 		return false;
 =

-	clone =3D kmemdup(entry, sizeof(*entry), GFP_ATOMIC);
-	if (!clone)
+	add_entry =3D kmalloc(sizeof(*add_entry), GFP_ATOMIC);
+	if (!add_entry)
 		return false;
 =

-	list_add(&clone->list, &msk->pm.anno_list);
+	list_add(&add_entry->list, &msk->pm.anno_list);
 =

 	return true;
 }
 =

 void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 {
-	struct mptcp_pm_addr_entry *entry, *tmp;
+	struct mptcp_pm_add_entry *entry, *tmp;
 =

 	pr_debug("msk=3D%p", msk);
 =

@@ -654,7 +659,7 @@ __lookup_addr_by_id(struct pm_nl_pernet *pernet, unsign=
ed int id)
 static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
 				      struct mptcp_addr_info *addr)
 {
-	struct mptcp_pm_addr_entry *entry, *tmp;
+	struct mptcp_pm_add_entry *entry, *tmp;
 =

 	list_for_each_entry_safe(entry, tmp, &msk->pm.anno_list, list) {
 		if (addresses_equal(&entry->addr, addr, false)) {
-- =

2.17.1

--===============6451164153689513527==--

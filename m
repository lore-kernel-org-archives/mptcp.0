Content-Type: multipart/mixed; boundary="===============5361169753899895330=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v5 mptcp-next 1/3] mptcp: export
 lookup_anno_list_by_saddr
Date: Fri, 19 Feb 2021 11:08:02 +0800
Message-ID: <43921930efc54abcbc10c5984ad3950231ae26e9.1613703548.git.geliangtang@gmail.com>
In-Reply-To: cover.1613703548.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7857

--===============5361169753899895330==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch exported the static function lookup_anno_list_by_saddr, and
renamed it to mptcp_lookup_anno_list_by_saddr.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 10 +++++-----
 net/mptcp/protocol.h   |  3 +++
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 59ea64e5e914..55fdcb1b5281 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -245,9 +245,9 @@ static void check_work_pending(struct mptcp_sock *msk)
 		WRITE_ONCE(msk->pm.work_pending, false);
 }
 =

-static struct mptcp_pm_add_entry *
-lookup_anno_list_by_saddr(struct mptcp_sock *msk,
-			  struct mptcp_addr_info *addr)
+struct mptcp_pm_add_entry *
+mptcp_lookup_anno_list_by_saddr(struct mptcp_sock *msk,
+				struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_add_entry *entry;
 =

@@ -331,7 +331,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 	struct sock *sk =3D (struct sock *)msk;
 =

 	spin_lock_bh(&msk->pm.lock);
-	entry =3D lookup_anno_list_by_saddr(msk, addr);
+	entry =3D mptcp_lookup_anno_list_by_saddr(msk, addr);
 	if (entry)
 		entry->retrans_times =3D ADD_ADDR_RETRANS_MAX;
 	spin_unlock_bh(&msk->pm.lock);
@@ -351,7 +351,7 @@ static bool mptcp_pm_alloc_anno_list(struct mptcp_sock =
*msk,
 =

 	lockdep_assert_held(&msk->pm.lock);
 =

-	if (lookup_anno_list_by_saddr(msk, &entry->addr))
+	if (mptcp_lookup_anno_list_by_saddr(msk, &entry->addr))
 		return false;
 =

 	add_entry =3D kmalloc(sizeof(*add_entry), GFP_ATOMIC);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b92bb3972cb7..99c7f1aa7af0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -657,6 +657,9 @@ bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk=
, const struct sock *sk);
 struct mptcp_pm_add_entry *
 mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 		       struct mptcp_addr_info *addr);
+struct mptcp_pm_add_entry *
+mptcp_lookup_anno_list_by_saddr(struct mptcp_sock *msk,
+				struct mptcp_addr_info *addr);
 =

 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
-- =

2.29.2

--===============5361169753899895330==--

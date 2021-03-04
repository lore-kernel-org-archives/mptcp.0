Content-Type: multipart/mixed; boundary="===============1963406688639405125=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 2/6] Squash to "mptcp: add
 rm_list_tx in mptcp_pm_data"
Date: Thu, 04 Mar 2021 14:42:44 +0800
Message-ID: <20210304064248.9636-3-geliangtang@gmail.com>
In-Reply-To: 20210304064248.9636-1-geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 8011

--===============1963406688639405125==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch changed the type of argument rm_list from "struct mptcp_rm_list
rm_list" to "const struct mptcp_rm_list *rm_list".

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm.c         | 8 ++++----
 net/mptcp/pm_netlink.c | 2 +-
 net/mptcp/protocol.h   | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 67b5a0390bf0..a234e149c9c2 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -39,18 +39,18 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 	return 0;
 }
 =

-int mptcp_pm_remove_addr(struct mptcp_sock *msk, struct mptcp_rm_list rm_l=
ist)
+int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_lis=
t *rm_list)
 {
 	u8 rm_addr =3D READ_ONCE(msk->pm.addr_signal);
 =

-	pr_debug("msk=3D%p, rm_list_nr=3D%d", msk, rm_list.nr);
+	pr_debug("msk=3D%p, rm_list_nr=3D%d", msk, rm_list->nr);
 =

 	if (rm_addr) {
 		pr_warn("addr_signal error, rm_addr=3D%d", rm_addr);
 		return -EINVAL;
 	}
 =

-	msk->pm.rm_list_tx =3D rm_list;
+	msk->pm.rm_list_tx =3D *rm_list;
 	rm_addr |=3D BIT(MPTCP_RM_ADDR_SIGNAL);
 	WRITE_ONCE(msk->pm.addr_signal, rm_addr);
 	return 0;
@@ -267,7 +267,7 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, un=
signed int remaining,
 	if (!mptcp_pm_should_rm_signal(msk))
 		goto out_unlock;
 =

-	len =3D mptcp_rm_addr_len(msk->pm.rm_list_tx);
+	len =3D mptcp_rm_addr_len(&msk->pm.rm_list_tx);
 	if (len < 0) {
 		WRITE_ONCE(msk->pm.addr_signal, 0);
 		goto out_unlock;
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 071928a96012..d73e813a6553 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1102,7 +1102,7 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_so=
ck *msk,
 	ret =3D remove_anno_list_by_saddr(msk, addr);
 	if (ret || force) {
 		spin_lock_bh(&msk->pm.lock);
-		mptcp_pm_remove_addr(msk, list);
+		mptcp_pm_remove_addr(msk, &list);
 		spin_unlock_bh(&msk->pm.lock);
 	}
 	return ret;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4b4cc538e490..49169a42abe9 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -661,7 +661,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
 			   bool echo);
-int mptcp_pm_remove_addr(struct mptcp_sock *msk, struct mptcp_rm_list rm_l=
ist);
+int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_lis=
t *rm_list);
 int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8 local_id);
 =

 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
-- =

2.29.2

--===============1963406688639405125==--

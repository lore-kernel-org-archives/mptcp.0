Content-Type: multipart/mixed; boundary="===============5338678597011038191=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][RFC mptcp-next 4/6] mptcp: add mptcpi_local_addr_* in
 mptcp_info
Date: Tue, 26 Jan 2021 21:21:51 +0800
Message-ID: <54bb5802527e4b8b52f8fc9d0a8e561218e25637.1611667027.git.geliangtang@gmail.com>
In-Reply-To: dec50a09c5e543c16d2bd7fddce8ca20d007843b.1611667027.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7486

--===============5338678597011038191==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add mptcpi_local_addr_used and mptcpi_local_addr_max in struct mptcp_info,
and rename mptcpi_add_addr_signal to mptcpi_add_addr_signaled.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 include/uapi/linux/mptcp.h | 4 +++-
 net/mptcp/mptcp_diag.c     | 4 +++-
 net/mptcp/pm_netlink.c     | 3 ++-
 net/mptcp/protocol.h       | 1 +
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 3674a451a18c..43b674458747 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -92,11 +92,13 @@ enum {
 =

 struct mptcp_info {
 	__u8	mptcpi_subflows;
-	__u8	mptcpi_add_addr_signal;
+	__u8	mptcpi_add_addr_signaled;
 	__u8	mptcpi_add_addr_accepted;
+	__u8	mptcpi_local_addr_used;
 	__u8	mptcpi_subflows_max;
 	__u8	mptcpi_add_addr_signal_max;
 	__u8	mptcpi_add_addr_accepted_max;
+	__u8	mptcpi_local_addr_max;
 	__u32	mptcpi_flags;
 	__u32	mptcpi_token;
 	__u64	mptcpi_write_seq;
diff --git a/net/mptcp/mptcp_diag.c b/net/mptcp/mptcp_diag.c
index 00ed742f48a4..195113e51c31 100644
--- a/net/mptcp/mptcp_diag.c
+++ b/net/mptcp/mptcp_diag.c
@@ -126,13 +126,15 @@ static void mptcp_diag_get_info(struct sock *sk, stru=
ct inet_diag_msg *r,
 =

 	slow =3D lock_sock_fast(sk);
 	info->mptcpi_subflows =3D READ_ONCE(msk->pm.subflows);
-	info->mptcpi_add_addr_signal =3D READ_ONCE(msk->pm.add_addr_signaled);
+	info->mptcpi_add_addr_signaled =3D READ_ONCE(msk->pm.add_addr_signaled);
 	info->mptcpi_add_addr_accepted =3D READ_ONCE(msk->pm.add_addr_accepted);
+	info->mptcpi_local_addr_used =3D READ_ONCE(msk->pm.local_addr_used);
 	info->mptcpi_subflows_max =3D mptcp_pm_get_subflows_max(msk);
 	val =3D mptcp_pm_get_add_addr_signal_max(msk);
 	info->mptcpi_add_addr_signal_max =3D val;
 	val =3D mptcp_pm_get_add_addr_accept_max(msk);
 	info->mptcpi_add_addr_accepted_max =3D val;
+	info->mptcpi_local_addr_max =3D mptcp_pm_get_local_addr_max(msk);
 	if (test_bit(MPTCP_FALLBACK_DONE, &msk->flags))
 		flags |=3D MPTCP_INFO_FLAG_FALLBACK;
 	if (READ_ONCE(msk->can_ack))
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index bb0d4456d855..b6ee53623005 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -228,13 +228,14 @@ unsigned int mptcp_pm_get_subflows_max(struct mptcp_s=
ock *msk)
 }
 EXPORT_SYMBOL_GPL(mptcp_pm_get_subflows_max);
 =

-static unsigned int mptcp_pm_get_local_addr_max(struct mptcp_sock *msk)
+unsigned int mptcp_pm_get_local_addr_max(struct mptcp_sock *msk)
 {
 	struct pm_nl_pernet *pernet;
 =

 	pernet =3D net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
 	return READ_ONCE(pernet->local_addr_max);
 }
+EXPORT_SYMBOL_GPL(mptcp_pm_get_local_addr_max);
 =

 static void check_work_pending(struct mptcp_sock *msk)
 {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 98b0169ab531..cdd110de8fa5 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -718,6 +718,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, st=
ruct sock_common *skc);
 unsigned int mptcp_pm_get_add_addr_signal_max(struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_accept_max(struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_subflows_max(struct mptcp_sock *msk);
+unsigned int mptcp_pm_get_local_addr_max(struct mptcp_sock *msk);
 =

 static inline struct mptcp_ext *mptcp_get_ext(struct sk_buff *skb)
 {
-- =

2.29.2

--===============5338678597011038191==--

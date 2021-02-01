Content-Type: multipart/mixed; boundary="===============9167958179169415223=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v2 02/15] mptcp: drop *_max fields in
 mptcp_pm_data
Date: Mon, 01 Feb 2021 15:09:07 -0800
Message-ID: <20210201230920.66027-3-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20210201230920.66027-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7558

--===============9167958179169415223==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Geliang Tang <geliangtang(a)gmail.com>

This patch drops the per-msk values add_addr_signal_max,
add_addr_accept_max, local_addr_max and subflows_max fields in struct
mptcp_pm_data, uses the pernet *_max values instead. And adds four new
helpers to get the pernet *_max values separately.

Co-developed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/mptcp_diag.c |  6 +--
 net/mptcp/pm.c         |  9 +++--
 net/mptcp/pm_netlink.c | 90 ++++++++++++++++++++++++++++++------------
 net/mptcp/protocol.h   |  7 ++--
 4 files changed, 77 insertions(+), 35 deletions(-)

diff --git a/net/mptcp/mptcp_diag.c b/net/mptcp/mptcp_diag.c
index b70ae4ba3000..00ed742f48a4 100644
--- a/net/mptcp/mptcp_diag.c
+++ b/net/mptcp/mptcp_diag.c
@@ -128,10 +128,10 @@ static void mptcp_diag_get_info(struct sock *sk, stru=
ct inet_diag_msg *r,
 	info->mptcpi_subflows =3D READ_ONCE(msk->pm.subflows);
 	info->mptcpi_add_addr_signal =3D READ_ONCE(msk->pm.add_addr_signaled);
 	info->mptcpi_add_addr_accepted =3D READ_ONCE(msk->pm.add_addr_accepted);
-	info->mptcpi_subflows_max =3D READ_ONCE(msk->pm.subflows_max);
-	val =3D READ_ONCE(msk->pm.add_addr_signal_max);
+	info->mptcpi_subflows_max =3D mptcp_pm_get_subflows_max(msk);
+	val =3D mptcp_pm_get_add_addr_signal_max(msk);
 	info->mptcpi_add_addr_signal_max =3D val;
-	val =3D READ_ONCE(msk->pm.add_addr_accept_max);
+	val =3D mptcp_pm_get_add_addr_accept_max(msk);
 	info->mptcpi_add_addr_accepted_max =3D val;
 	if (test_bit(MPTCP_FALLBACK_DONE, &msk->flags))
 		flags |=3D MPTCP_INFO_FLAG_FALLBACK;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 0a6ebd0642ec..01a846b25771 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -78,10 +78,13 @@ void mptcp_pm_new_connection(struct mptcp_sock *msk, in=
t server_side)
 bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_data *pm =3D &msk->pm;
+	unsigned int subflows_max;
 	int ret =3D 0;
 =

+	subflows_max =3D mptcp_pm_get_subflows_max(msk);
+
 	pr_debug("msk=3D%p subflows=3D%d max=3D%d allow=3D%d", msk, pm->subflows,
-		 pm->subflows_max, READ_ONCE(pm->accept_subflow));
+		 subflows_max, READ_ONCE(pm->accept_subflow));
 =

 	/* try to avoid acquiring the lock below */
 	if (!READ_ONCE(pm->accept_subflow))
@@ -89,8 +92,8 @@ bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
 =

 	spin_lock_bh(&pm->lock);
 	if (READ_ONCE(pm->accept_subflow)) {
-		ret =3D pm->subflows < pm->subflows_max;
-		if (ret && ++pm->subflows =3D=3D pm->subflows_max)
+		ret =3D pm->subflows < subflows_max;
+		if (ret && ++pm->subflows =3D=3D subflows_max)
 			WRITE_ONCE(pm->accept_subflow, false);
 	}
 	spin_unlock_bh(&pm->lock);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index c429bd82313e..6aeadcaef8ae 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -196,11 +196,46 @@ select_signal_address(struct pm_nl_pernet *pernet, un=
signed int pos)
 	return ret;
 }
 =

+unsigned int mptcp_pm_get_add_addr_signal_max(struct mptcp_sock *msk)
+{
+	struct pm_nl_pernet *pernet;
+
+	pernet =3D net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
+	return READ_ONCE(pernet->add_addr_signal_max);
+}
+EXPORT_SYMBOL_GPL(mptcp_pm_get_add_addr_signal_max);
+
+unsigned int mptcp_pm_get_add_addr_accept_max(struct mptcp_sock *msk)
+{
+	struct pm_nl_pernet *pernet;
+
+	pernet =3D net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
+	return READ_ONCE(pernet->add_addr_accept_max);
+}
+EXPORT_SYMBOL_GPL(mptcp_pm_get_add_addr_accept_max);
+
+unsigned int mptcp_pm_get_subflows_max(struct mptcp_sock *msk)
+{
+	struct pm_nl_pernet *pernet;
+
+	pernet =3D net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
+	return READ_ONCE(pernet->subflows_max);
+}
+EXPORT_SYMBOL_GPL(mptcp_pm_get_subflows_max);
+
+static unsigned int mptcp_pm_get_local_addr_max(struct mptcp_sock *msk)
+{
+	struct pm_nl_pernet *pernet;
+
+	pernet =3D net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
+	return READ_ONCE(pernet->local_addr_max);
+}
+
 static void check_work_pending(struct mptcp_sock *msk)
 {
-	if (msk->pm.add_addr_signaled =3D=3D msk->pm.add_addr_signal_max &&
-	    (msk->pm.local_addr_used =3D=3D msk->pm.local_addr_max ||
-	     msk->pm.subflows =3D=3D msk->pm.subflows_max))
+	if (msk->pm.add_addr_signaled =3D=3D mptcp_pm_get_add_addr_signal_max(msk=
) &&
+	    (msk->pm.local_addr_used =3D=3D mptcp_pm_get_local_addr_max(msk) ||
+	     msk->pm.subflows =3D=3D mptcp_pm_get_subflows_max(msk)))
 		WRITE_ONCE(msk->pm.work_pending, false);
 }
 =

@@ -327,17 +362,24 @@ static void mptcp_pm_create_subflow_or_signal_addr(st=
ruct mptcp_sock *msk)
 {
 	struct sock *sk =3D (struct sock *)msk;
 	struct mptcp_pm_addr_entry *local;
+	unsigned int add_addr_signal_max;
+	unsigned int local_addr_max;
 	struct pm_nl_pernet *pernet;
+	unsigned int subflows_max;
 =

 	pernet =3D net_generic(sock_net(sk), pm_nl_pernet_id);
 =

+	add_addr_signal_max =3D mptcp_pm_get_add_addr_signal_max(msk);
+	local_addr_max =3D mptcp_pm_get_local_addr_max(msk);
+	subflows_max =3D mptcp_pm_get_subflows_max(msk);
+
 	pr_debug("local %d:%d signal %d:%d subflows %d:%d\n",
-		 msk->pm.local_addr_used, msk->pm.local_addr_max,
-		 msk->pm.add_addr_signaled, msk->pm.add_addr_signal_max,
-		 msk->pm.subflows, msk->pm.subflows_max);
+		 msk->pm.local_addr_used, local_addr_max,
+		 msk->pm.add_addr_signaled, add_addr_signal_max,
+		 msk->pm.subflows, subflows_max);
 =

 	/* check first for announce */
-	if (msk->pm.add_addr_signaled < msk->pm.add_addr_signal_max) {
+	if (msk->pm.add_addr_signaled < add_addr_signal_max) {
 		local =3D select_signal_address(pernet,
 					      msk->pm.add_addr_signaled);
 =

@@ -349,15 +391,15 @@ static void mptcp_pm_create_subflow_or_signal_addr(st=
ruct mptcp_sock *msk)
 			}
 		} else {
 			/* pick failed, avoid fourther attempts later */
-			msk->pm.local_addr_used =3D msk->pm.add_addr_signal_max;
+			msk->pm.local_addr_used =3D add_addr_signal_max;
 		}
 =

 		check_work_pending(msk);
 	}
 =

 	/* check if should create a new subflow */
-	if (msk->pm.local_addr_used < msk->pm.local_addr_max &&
-	    msk->pm.subflows < msk->pm.subflows_max) {
+	if (msk->pm.local_addr_used < local_addr_max &&
+	    msk->pm.subflows < subflows_max) {
 		local =3D select_local_address(pernet, msk);
 		if (local) {
 			struct mptcp_addr_info remote =3D { 0 };
@@ -373,7 +415,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(stru=
ct mptcp_sock *msk)
 		}
 =

 		/* lookup failed, avoid fourther attempts later */
-		msk->pm.local_addr_used =3D msk->pm.local_addr_max;
+		msk->pm.local_addr_used =3D local_addr_max;
 		check_work_pending(msk);
 	}
 }
@@ -391,17 +433,22 @@ void mptcp_pm_nl_subflow_established(struct mptcp_soc=
k *msk)
 void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 {
 	struct sock *sk =3D (struct sock *)msk;
+	unsigned int add_addr_accept_max;
 	struct mptcp_addr_info remote;
 	struct mptcp_addr_info local;
+	unsigned int subflows_max;
 	bool use_port =3D false;
 =

+	add_addr_accept_max =3D mptcp_pm_get_add_addr_accept_max(msk);
+	subflows_max =3D mptcp_pm_get_subflows_max(msk);
+
 	pr_debug("accepted %d:%d remote family %d",
-		 msk->pm.add_addr_accepted, msk->pm.add_addr_accept_max,
+		 msk->pm.add_addr_accepted, add_addr_accept_max,
 		 msk->pm.remote.family);
 	msk->pm.add_addr_accepted++;
 	msk->pm.subflows++;
-	if (msk->pm.add_addr_accepted >=3D msk->pm.add_addr_accept_max ||
-	    msk->pm.subflows >=3D msk->pm.subflows_max)
+	if (msk->pm.add_addr_accepted >=3D add_addr_accept_max ||
+	    msk->pm.subflows >=3D subflows_max)
 		WRITE_ONCE(msk->pm.accept_addr, false);
 =

 	/* connect to the specified remote address, using whatever
@@ -687,19 +734,12 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, =
struct sock_common *skc)
 void mptcp_pm_nl_data_init(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_data *pm =3D &msk->pm;
-	struct pm_nl_pernet *pernet;
 	bool subflows;
 =

-	pernet =3D net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
-
-	pm->add_addr_signal_max =3D READ_ONCE(pernet->add_addr_signal_max);
-	pm->add_addr_accept_max =3D READ_ONCE(pernet->add_addr_accept_max);
-	pm->local_addr_max =3D READ_ONCE(pernet->local_addr_max);
-	pm->subflows_max =3D READ_ONCE(pernet->subflows_max);
-	subflows =3D !!pm->subflows_max;
-	WRITE_ONCE(pm->work_pending, (!!pm->local_addr_max && subflows) ||
-		   !!pm->add_addr_signal_max);
-	WRITE_ONCE(pm->accept_addr, !!pm->add_addr_accept_max && subflows);
+	subflows =3D !!mptcp_pm_get_subflows_max(msk);
+	WRITE_ONCE(pm->work_pending, (!!mptcp_pm_get_local_addr_max(msk) && subfl=
ows) ||
+		   !!mptcp_pm_get_add_addr_signal_max(msk));
+	WRITE_ONCE(pm->accept_addr, !!mptcp_pm_get_add_addr_accept_max(msk) && su=
bflows);
 	WRITE_ONCE(pm->accept_subflow, subflows);
 }
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 1460705aaad0..fcab3784e4fa 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -202,10 +202,6 @@ struct mptcp_pm_data {
 	u8		add_addr_accepted;
 	u8		local_addr_used;
 	u8		subflows;
-	u8		add_addr_signal_max;
-	u8		add_addr_accept_max;
-	u8		local_addr_max;
-	u8		subflows_max;
 	u8		status;
 	u8		rm_id;
 };
@@ -713,6 +709,9 @@ void mptcp_pm_nl_add_addr_send_ack(struct mptcp_sock *m=
sk);
 void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *msk);
 void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk, u8 rm_id);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *s=
kc);
+unsigned int mptcp_pm_get_add_addr_signal_max(struct mptcp_sock *msk);
+unsigned int mptcp_pm_get_add_addr_accept_max(struct mptcp_sock *msk);
+unsigned int mptcp_pm_get_subflows_max(struct mptcp_sock *msk);
 =

 static inline struct mptcp_ext *mptcp_get_ext(struct sk_buff *skb)
 {
-- =

2.30.0

--===============9167958179169415223==--

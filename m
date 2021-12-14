Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8CD68
	for <mptcp@lists.linux.dev>; Tue, 14 Dec 2021 16:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1639501166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ohl5zYsWNwYXRSsrQGQXr/HuIfGyhAAwQj0p4h6+CCo=;
	b=AuJxmHs++85aVZDJvQqPsCCSVbeQ8snvSdu7wxA4OhmUY8wp5aqVLOdzJfzV5xfkspCDOG
	ta5SSv93aNnykV8wIZjYkA9vfp9FfLEMqmwCri2DFB/nUgXPnV5e/mjE/gY/QGlomXepRv
	Sa1vI24ymVXeHJVXFBlRGuHm7ar9Ol0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-207-CcwWFxEtNWCid3yUGwclUQ-1; Tue, 14 Dec 2021 11:59:24 -0500
X-MC-Unique: CcwWFxEtNWCid3yUGwclUQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1AD0B10B7440
	for <mptcp@lists.linux.dev>; Tue, 14 Dec 2021 16:59:23 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.135])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5042A1059112
	for <mptcp@lists.linux.dev>; Tue, 14 Dec 2021 16:59:22 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v6 mptcp-next 3/7] mptcp: keep track of local endpoint still available for each msk
Date: Tue, 14 Dec 2021 17:58:53 +0100
Message-Id: <5eaf8fbe74237b5decd5c1b7d87856b6a40e0a46.1639500873.git.pabeni@redhat.com>
In-Reply-To: <cover.1639500873.git.pabeni@redhat.com>
References: <cover.1639500873.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

Include into the path manager status a bitmap tracking the list
of local endpoints still available - not yet used - for the
relavant mptcp socket.
Keep such map updated at endpoint creation/deleteion time, so
that we can easily skip already used endpoint at local address
selection time.
The endpoint used by the initial subflow is lazyly accounted at
subflow creation time: the usage bitmap is be up2date before
endpoint selection and we avoid such unneeded task in some relevant
scenarions - e.g. busy servers accepting incoming subflows but
not creating any additional ones nor annuncing additional addresses.

Overall this allows for fair local endpoints usage in case of
subflow failure.

As a side effect, this patch also enforces that each endpoint
is used at most once for each mptcp connection.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v4 -> v5:
 - track MPC subflow, too
 - update self-tests accordingly

v3 -> v4:
 - track the available (not yet used) id instead of the used ones
 - track both
 - cleanup duplication with id_bitmap
---
 net/mptcp/pm.c                                |   1 +
 net/mptcp/pm_netlink.c                        | 116 +++++++++++-------
 net/mptcp/protocol.c                          |   3 +-
 net/mptcp/protocol.h                          |  11 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh |   5 +-
 5 files changed, 86 insertions(+), 50 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 761995a34124..d6d22f18c418 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -376,6 +376,7 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
 	WRITE_ONCE(msk->pm.accept_subflow, false);
 	WRITE_ONCE(msk->pm.remote_deny_join_id0, false);
 	msk->pm.status = 0;
+	bitmap_fill(msk->pm.id_avail_bitmap, MAX_ADDR_ID + 1);
 
 	mptcp_pm_nl_data_init(msk);
 }
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d18b13e3e74c..1be7f92e9fc8 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -38,9 +38,6 @@ struct mptcp_pm_add_entry {
 	u8			retrans_times;
 };
 
-#define MAX_ADDR_ID		255
-#define BITMAP_SZ DIV_ROUND_UP(MAX_ADDR_ID + 1, BITS_PER_LONG)
-
 struct pm_nl_pernet {
 	/* protects pernet updates */
 	spinlock_t		lock;
@@ -52,14 +49,14 @@ struct pm_nl_pernet {
 	unsigned int		local_addr_max;
 	unsigned int		subflows_max;
 	unsigned int		next_id;
-	unsigned long		id_bitmap[BITMAP_SZ];
+	DECLARE_BITMAP(id_bitmap, MAX_ADDR_ID + 1);
 };
 
 #define MPTCP_PM_ADDR_MAX	8
 #define ADD_ADDR_RETRANS_MAX	3
 
 static bool addresses_equal(const struct mptcp_addr_info *a,
-			    struct mptcp_addr_info *b, bool use_port)
+			    const struct mptcp_addr_info *b, bool use_port)
 {
 	bool addr_equals = false;
 
@@ -173,6 +170,9 @@ select_local_address(const struct pm_nl_pernet *pernet,
 		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
 			continue;
 
+		if (!test_bit(entry->addr.id, msk->pm.id_avail_bitmap))
+			continue;
+
 		if (entry->addr.family != sk->sk_family) {
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 			if ((entry->addr.family == AF_INET &&
@@ -183,23 +183,17 @@ select_local_address(const struct pm_nl_pernet *pernet,
 				continue;
 		}
 
-		/* avoid any address already in use by subflows and
-		 * pending join
-		 */
-		if (!lookup_subflow_by_saddr(&msk->conn_list, &entry->addr)) {
-			ret = entry;
-			break;
-		}
+		ret = entry;
+		break;
 	}
 	rcu_read_unlock();
 	return ret;
 }
 
 static struct mptcp_pm_addr_entry *
-select_signal_address(struct pm_nl_pernet *pernet, unsigned int pos)
+select_signal_address(struct pm_nl_pernet *pernet, struct mptcp_sock *msk)
 {
 	struct mptcp_pm_addr_entry *entry, *ret = NULL;
-	int i = 0;
 
 	rcu_read_lock();
 	/* do not keep any additional per socket state, just signal
@@ -208,12 +202,14 @@ select_signal_address(struct pm_nl_pernet *pernet, unsigned int pos)
 	 * can lead to additional addresses not being announced.
 	 */
 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
+		if (!test_bit(entry->addr.id, msk->pm.id_avail_bitmap))
+			continue;
+
 		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
 			continue;
-		if (i++ == pos) {
-			ret = entry;
-			break;
-		}
+
+		ret = entry;
+		break;
 	}
 	rcu_read_unlock();
 	return ret;
@@ -257,9 +253,11 @@ EXPORT_SYMBOL_GPL(mptcp_pm_get_local_addr_max);
 
 static void check_work_pending(struct mptcp_sock *msk)
 {
-	if (msk->pm.add_addr_signaled == mptcp_pm_get_add_addr_signal_max(msk) &&
-	    (msk->pm.local_addr_used == mptcp_pm_get_local_addr_max(msk) ||
-	     msk->pm.subflows == mptcp_pm_get_subflows_max(msk)))
+	struct pm_nl_pernet *pernet = net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
+
+	if (msk->pm.subflows == mptcp_pm_get_subflows_max(msk) ||
+	    (find_next_and_bit(pernet->id_bitmap, msk->pm.id_avail_bitmap, MAX_ADDR_ID + 1, 0) ==
+	     MAX_ADDR_ID + 1))
 		WRITE_ONCE(msk->pm.work_pending, false);
 }
 
@@ -459,6 +457,35 @@ static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk, bool fullm
 	return i;
 }
 
+static struct mptcp_pm_addr_entry *
+__lookup_addr_by_id(struct pm_nl_pernet *pernet, unsigned int id)
+{
+	struct mptcp_pm_addr_entry *entry;
+
+	list_for_each_entry(entry, &pernet->local_addr_list, list) {
+		if (entry->addr.id == id)
+			return entry;
+	}
+	return NULL;
+}
+
+static int
+lookup_id_by_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *addr)
+{
+	struct mptcp_pm_addr_entry *entry;
+	int ret = -1;
+
+	rcu_read_lock();
+	list_for_each_entry(entry, &pernet->local_addr_list, list) {
+		if (addresses_equal(&entry->addr, addr, entry->addr.port)) {
+			ret = entry->addr.id;
+			break;
+		}
+	}
+	rcu_read_unlock();
+	return ret;
+}
+
 static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 {
 	struct sock *sk = (struct sock *)msk;
@@ -474,6 +501,19 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 	local_addr_max = mptcp_pm_get_local_addr_max(msk);
 	subflows_max = mptcp_pm_get_subflows_max(msk);
 
+	/* do lazy endpoint usage accounting for the MPC subflows */
+	if (unlikely(!(msk->pm.status & BIT(MPTCP_PM_MPC_ENDPOINT_ACCOUNTED))) && msk->first) {
+		struct mptcp_addr_info local;
+		int mpc_id;
+
+		local_address((struct sock_common *)msk->first, &local);
+		mpc_id = lookup_id_by_addr(pernet, &local);
+		if (mpc_id < 0)
+			__clear_bit(mpc_id, msk->pm.id_avail_bitmap);
+
+		msk->pm.status |= BIT(MPTCP_PM_MPC_ENDPOINT_ACCOUNTED);
+	}
+
 	pr_debug("local %d:%d signal %d:%d subflows %d:%d\n",
 		 msk->pm.local_addr_used, local_addr_max,
 		 msk->pm.add_addr_signaled, add_addr_signal_max,
@@ -481,21 +521,16 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 	/* check first for announce */
 	if (msk->pm.add_addr_signaled < add_addr_signal_max) {
-		local = select_signal_address(pernet,
-					      msk->pm.add_addr_signaled);
+		local = select_signal_address(pernet, msk);
 
 		if (local) {
 			if (mptcp_pm_alloc_anno_list(msk, local)) {
+				__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
 				msk->pm.add_addr_signaled++;
 				mptcp_pm_announce_addr(msk, &local->addr, false);
 				mptcp_pm_nl_addr_send_ack(msk);
 			}
-		} else {
-			/* pick failed, avoid fourther attempts later */
-			msk->pm.local_addr_used = add_addr_signal_max;
 		}
-
-		check_work_pending(msk);
 	}
 
 	/* check if should create a new subflow */
@@ -509,19 +544,16 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 			int i, nr;
 
 			msk->pm.local_addr_used++;
-			check_work_pending(msk);
 			nr = fill_remote_addresses_vec(msk, fullmesh, addrs);
+			if (nr)
+				__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
 			spin_unlock_bh(&msk->pm.lock);
 			for (i = 0; i < nr; i++)
 				__mptcp_subflow_connect(sk, &local->addr, &addrs[i]);
 			spin_lock_bh(&msk->pm.lock);
-			return;
 		}
-
-		/* lookup failed, avoid fourther attempts later */
-		msk->pm.local_addr_used = local_addr_max;
-		check_work_pending(msk);
 	}
+	check_work_pending(msk);
 }
 
 static void mptcp_pm_nl_fully_established(struct mptcp_sock *msk)
@@ -735,6 +767,7 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 			msk->pm.subflows--;
 			__MPTCP_INC_STATS(sock_net(sk), rm_type);
 		}
+		__set_bit(rm_list->ids[1], msk->pm.id_avail_bitmap);
 		if (!removed)
 			continue;
 
@@ -764,6 +797,9 @@ void mptcp_pm_nl_work(struct mptcp_sock *msk)
 
 	msk_owned_by_me(msk);
 
+	if (!(pm->status & MPTCP_PM_WORK_MASK))
+		return;
+
 	spin_lock_bh(&msk->pm.lock);
 
 	pr_debug("msk=%p status=%x", msk, pm->status);
@@ -1197,18 +1233,6 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
 	return 0;
 }
 
-static struct mptcp_pm_addr_entry *
-__lookup_addr_by_id(struct pm_nl_pernet *pernet, unsigned int id)
-{
-	struct mptcp_pm_addr_entry *entry;
-
-	list_for_each_entry(entry, &pernet->local_addr_list, list) {
-		if (entry->addr.id == id)
-			return entry;
-	}
-	return NULL;
-}
-
 int mptcp_pm_get_flags_and_ifindex_by_id(struct net *net, unsigned int id,
 					 u8 *flags, int *ifindex)
 {
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4a8f2476cc75..63602c68f03d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2508,8 +2508,7 @@ static void mptcp_worker(struct work_struct *work)
 
 	mptcp_check_fastclose(msk);
 
-	if (msk->pm.status)
-		mptcp_pm_nl_work(msk);
+	mptcp_pm_nl_work(msk);
 
 	if (test_and_clear_bit(MPTCP_WORK_EOF, &msk->flags))
 		mptcp_check_for_eof(msk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 47d24478763c..e63fe60f70b8 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -173,16 +173,24 @@ enum mptcp_pm_status {
 	MPTCP_PM_ADD_ADDR_SEND_ACK,
 	MPTCP_PM_RM_ADDR_RECEIVED,
 	MPTCP_PM_ESTABLISHED,
-	MPTCP_PM_ALREADY_ESTABLISHED,	/* persistent status, set after ESTABLISHED event */
 	MPTCP_PM_SUBFLOW_ESTABLISHED,
+	MPTCP_PM_ALREADY_ESTABLISHED,	/* persistent status, set after ESTABLISHED event */
+	MPTCP_PM_MPC_ENDPOINT_ACCOUNTED /* persistent status, set after MPC local address is
+					 * accounted int id_avail_bitmap
+					 */
 };
 
+/* Status bits below MPTCP_PM_ALREADY_ESTABLISHED need pm worker actions */
+#define MPTCP_PM_WORK_MASK ((1 << MPTCP_PM_ALREADY_ESTABLISHED) - 1)
+
 enum mptcp_addr_signal_status {
 	MPTCP_ADD_ADDR_SIGNAL,
 	MPTCP_ADD_ADDR_ECHO,
 	MPTCP_RM_ADDR_SIGNAL,
 };
 
+#define MAX_ADDR_ID		255
+
 struct mptcp_pm_data {
 	struct mptcp_addr_info local;
 	struct mptcp_addr_info remote;
@@ -201,6 +209,7 @@ struct mptcp_pm_data {
 	u8		local_addr_used;
 	u8		subflows;
 	u8		status;
+	DECLARE_BITMAP(id_avail_bitmap, MAX_ADDR_ID + 1);
 	struct mptcp_rm_list rm_list_tx;
 	struct mptcp_rm_list rm_list_rx;
 };
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 2684ef9c0d42..526b05771d08 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1109,7 +1109,10 @@ signal_address_tests()
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags signal
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags signal
 	run_tests $ns1 $ns2 10.0.1.1
-	chk_add_nr 4 4
+
+	# the server will not signal the address teminating
+	# the MPC subflow
+	chk_add_nr 3 3
 }
 
 link_failure_tests()
-- 
2.33.1


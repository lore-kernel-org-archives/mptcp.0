Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE14F2CAC
	for <mptcp@lists.linux.dev>; Fri,  3 Dec 2021 15:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1638544820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zkMZusmujnYG8+69mD4tt9+7KekuqPJQvWZEHi/butk=;
	b=K4/5xK6l/heESDPCUgtmQ2eV+IRtGBkKNDJ3XWClRmGyucoSt4md36Tgx7thFV+0+MVUS6
	apX54p82X4mILVs5rK8Jkk9fQA/lxgHOLNcO94ilKAuillic080dHc01Rblfp+yu443azu
	LsjKM286ywri7GFcVmDwghm8KPExt0E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-350-HEqlTBq3N66gm9q3jryv6Q-1; Fri, 03 Dec 2021 10:20:18 -0500
X-MC-Unique: HEqlTBq3N66gm9q3jryv6Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9891683DD2F
	for <mptcp@lists.linux.dev>; Fri,  3 Dec 2021 15:20:17 +0000 (UTC)
Received: from gerbillo.fritz.box (unknown [10.39.192.107])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0E97E5F4E0
	for <mptcp@lists.linux.dev>; Fri,  3 Dec 2021 15:20:16 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v4 3/5] mptcp: keep track of local endpoint still available for each msk
Date: Fri,  3 Dec 2021 16:19:40 +0100
Message-Id: <20e1d11df9396b33ab49b07204bd8b7db2e21a01.1638544716.git.pabeni@redhat.com>
In-Reply-To: <cover.1638544716.git.pabeni@redhat.com>
References: <cover.1638544716.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
This allows for fair local endpoints usage in case of subflow
failure.

As a side effect, this patch also enforces that each endpoint
is used at most once for each mptcp connection.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v3 -> v4:
 - track the available (not yet used) id instead of the used ones
 - track both
 - cleanup duplication with id_bitmap
---
 net/mptcp/pm.c         |  1 +
 net/mptcp/pm_netlink.c | 57 ++++++++++++++++++------------------------
 net/mptcp/protocol.h   |  3 +++
 3 files changed, 28 insertions(+), 33 deletions(-)

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
index d18b13e3e74c..b3dc19fd1d37 100644
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
@@ -52,7 +49,7 @@ struct pm_nl_pernet {
 	unsigned int		local_addr_max;
 	unsigned int		subflows_max;
 	unsigned int		next_id;
-	unsigned long		id_bitmap[BITMAP_SZ];
+	DECLARE_BITMAP(id_bitmap, MAX_ADDR_ID + 1);
 };
 
 #define MPTCP_PM_ADDR_MAX	8
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
 
@@ -481,21 +479,16 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
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
@@ -509,19 +502,16 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
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
@@ -735,6 +725,7 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 			msk->pm.subflows--;
 			__MPTCP_INC_STATS(sock_net(sk), rm_type);
 		}
+		__set_bit(rm_list->ids[1], msk->pm.id_avail_bitmap);
 		if (!removed)
 			continue;
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 47d24478763c..b1ab476520aa 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -183,6 +183,8 @@ enum mptcp_addr_signal_status {
 	MPTCP_RM_ADDR_SIGNAL,
 };
 
+#define MAX_ADDR_ID		255
+
 struct mptcp_pm_data {
 	struct mptcp_addr_info local;
 	struct mptcp_addr_info remote;
@@ -190,6 +192,7 @@ struct mptcp_pm_data {
 
 	spinlock_t	lock;		/*protects the whole PM data */
 
+	DECLARE_BITMAP(id_avail_bitmap, MAX_ADDR_ID + 1);
 	u8		addr_signal;
 	bool		server_side;
 	bool		work_pending;
-- 
2.33.1


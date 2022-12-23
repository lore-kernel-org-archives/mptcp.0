Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED297A498
	for <mptcp@lists.linux.dev>; Fri, 23 Dec 2022 19:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1671822025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ghBJVfFZFDXwXCBFFoN6ZIlCCxpPV7mON6nb9Zh0YPM=;
	b=fyjWjuDu2gPHKbpUQR/CxFNaFUqHnNK0/9ue2V+B2qmfbexM6iML1b1Mgb5HKlg0QZMdzS
	A6XPAkfKBqWs2FC60wzCGuZHdnqcnxBWNITzZJ6xxoPX9kdsrbFq+AQWBGBRKJFeZdHEiM
	3iBmBdcR/c22Nqggkxv/ZXbCExkkWj4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-45-mIluhuabP8a6S15PtNlqoA-1; Fri, 23 Dec 2022 14:00:24 -0500
X-MC-Unique: mIluhuabP8a6S15PtNlqoA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 21FB23832783
	for <mptcp@lists.linux.dev>; Fri, 23 Dec 2022 19:00:24 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.156])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 888F740C945A
	for <mptcp@lists.linux.dev>; Fri, 23 Dec 2022 19:00:23 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 2/3] mptcp: let the in kernel PM use mixed ipv4 and ipv6 addresses
Date: Fri, 23 Dec 2022 20:00:13 +0100
Message-Id: <61ebbe1bdb47f74d856b3edee06112999da50f07.1671821017.git.pabeni@redhat.com>
In-Reply-To: <cover.1671821017.git.pabeni@redhat.com>
References: <cover.1671821017.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Currently the in kernel PM arbitrary enforces that created subflow's
family must match the main MPTCP socket. The RFC allow instead for
mixing IPv4 and IPv6 subflows.

This patch changes the in kernel PM logic to create subflows matching
the currently selected source (or destination) address. IPv4 sockets
can pick only IPv4 addresses, while IPv6 sockets not restricted to
V6ONLY can pick either IPv4 and IPv6 addresses, effectively
allowing the creation of IPv4 and IPv6 subflows under the same msk.

While at that, factor out a new helper for address family matching,
taking care of ipv4 vs ipv4-mapped-ipv6.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/269
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/pm_netlink.c | 68 ++++++++++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 26 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index f2a43e13bacd..23c4e74312f7 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -152,7 +152,6 @@ static struct mptcp_pm_addr_entry *
 select_local_address(const struct pm_nl_pernet *pernet,
 		     const struct mptcp_sock *msk)
 {
-	const struct sock *sk = (const struct sock *)msk;
 	struct mptcp_pm_addr_entry *entry, *ret = NULL;
 
 	msk_owned_by_me(msk);
@@ -165,16 +164,6 @@ select_local_address(const struct pm_nl_pernet *pernet,
 		if (!test_bit(entry->addr.id, msk->pm.id_avail_bitmap))
 			continue;
 
-		if (entry->addr.family != sk->sk_family) {
-#if IS_ENABLED(CONFIG_MPTCP_IPV6)
-			if ((entry->addr.family == AF_INET &&
-			     !ipv6_addr_v4mapped(&sk->sk_v6_daddr)) ||
-			    (sk->sk_family == AF_INET &&
-			     !ipv6_addr_v4mapped(&entry->addr.addr6)))
-#endif
-				continue;
-		}
-
 		ret = entry;
 		break;
 	}
@@ -420,10 +409,34 @@ static bool lookup_address_in_vec(const struct mptcp_addr_info *addrs, unsigned
 	return false;
 }
 
+/* if sk is ipv4 or ipv6_only allows only same-family local and remote addresses,
+ * otherwise allow any matching local/remote pair
+ */
+static bool addr_families_match(const struct sock *sk,
+				const struct mptcp_addr_info *loc,
+				const struct mptcp_addr_info *remote)
+{
+	if (sk->sk_family == loc->family && sk->sk_family == remote->family)
+		return true;
+
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	if (sk->sk_family == AF_INET || sk->sk_ipv6only)
+		return false;
+
+	if (loc->family == remote->family ||
+	    (loc->family == AF_INET && ipv6_addr_v4mapped(&remote->addr6)) ||
+	    (remote->family == AF_INET && ipv6_addr_v4mapped(&loc->addr6)))
+		return true;
+#endif
+	return false;
+}
+
 /* Fill all the remote addresses into the array addrs[],
  * and return the array size.
  */
-static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk, bool fullmesh,
+static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk,
+					      struct mptcp_addr_info *local,
+					      bool fullmesh,
 					      struct mptcp_addr_info *addrs)
 {
 	bool deny_id0 = READ_ONCE(msk->pm.remote_deny_join_id0);
@@ -443,6 +456,9 @@ static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk, bool fullm
 		if (deny_id0)
 			return 0;
 
+		if (!addr_families_match(sk, local, &remote))
+			return 0;
+
 		msk->pm.subflows++;
 		addrs[i++] = remote;
 	} else {
@@ -453,6 +469,9 @@ static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk, bool fullm
 			if (deny_id0 && !addrs[i].id)
 				continue;
 
+			if (!addr_families_match(sk, local, &addrs[i]))
+				continue;
+
 			if (!lookup_address_in_vec(addrs, i, &addrs[i]) &&
 			    msk->pm.subflows < subflows_max) {
 				msk->pm.subflows++;
@@ -600,10 +619,10 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		fullmesh = !!(local->flags & MPTCP_PM_ADDR_FLAG_FULLMESH);
 
 		msk->pm.local_addr_used++;
-		nr = fill_remote_addresses_vec(msk, fullmesh, addrs);
-		if (nr)
-			__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
+		nr = fill_remote_addresses_vec(msk, &local->addr, fullmesh, addrs);
+		__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
 		spin_unlock_bh(&msk->pm.lock);
+
 		for (i = 0; i < nr; i++)
 			__mptcp_subflow_connect(sk, &local->addr, &addrs[i]);
 		spin_lock_bh(&msk->pm.lock);
@@ -625,6 +644,7 @@ static void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk)
  * and return the array size.
  */
 static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
+					     struct mptcp_addr_info *remote,
 					     struct mptcp_addr_info *addrs)
 {
 	struct sock *sk = (struct sock *)msk;
@@ -642,15 +662,8 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_FULLMESH))
 			continue;
 
-		if (entry->addr.family != sk->sk_family) {
-#if IS_ENABLED(CONFIG_MPTCP_IPV6)
-			if ((entry->addr.family == AF_INET &&
-			     !ipv6_addr_v4mapped(&sk->sk_v6_daddr)) ||
-			    (sk->sk_family == AF_INET &&
-			     !ipv6_addr_v4mapped(&entry->addr.addr6)))
-#endif
-				continue;
-		}
+		if (!addr_families_match(sk, &entry->addr, remote))
+			continue;
 
 		if (msk->pm.subflows < subflows_max) {
 			msk->pm.subflows++;
@@ -664,7 +677,10 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 	 */
 	if (!i) {
 		memset(&local, 0, sizeof(local));
-		local.family = msk->pm.remote.family;
+		local.family = remote->family;
+
+		if (!addr_families_match(sk, &local, remote))
+			return 0;
 
 		msk->pm.subflows++;
 		addrs[i++] = local;
@@ -703,7 +719,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	/* connect to the specified remote address, using whatever
 	 * local address the routing configuration will pick.
 	 */
-	nr = fill_local_addresses_vec(msk, addrs);
+	nr = fill_local_addresses_vec(msk, &remote, addrs);
 
 	msk->pm.add_addr_accepted++;
 	if (msk->pm.add_addr_accepted >= add_addr_accept_max ||
-- 
2.38.1


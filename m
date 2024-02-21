Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6628F3C1D
	for <mptcp@lists.linux.dev>; Wed, 21 Feb 2024 06:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708497089; cv=none; b=qcwf6z8/RR+iPYAdSY0F1S8GzdfFEMYEpPUjl3fXUZ6xfbZLp+2Rb4C71LS56vlL+33zaM+pB0Ha0UyQEnTXGwXijGN3GRKw0uXXizAPGnxeEM4ugle7c4zrpAPeIhybS/vThTcysjGLG6dJynG+A+cEB4HZXxdGGy9ZneA2Mf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708497089; c=relaxed/simple;
	bh=NANA/0QfS51GGL26cKvktvqO8FyzZ/ZWS17UCPlyreU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r9O2EiB2sNun29pIuq+zRntBaehTP/wWo1gLwrasaheSlpu3+eBLG6l2jxxDCRe2ysCKrSHCaEjrZA8FKbO4UCbxPSZcjgF7bsITlX3rCticGzLGv+UFW7q2RUtC9g9pnVmAi810BDEntH6KDP37l4OqZmPegs2sVFJa5uuM54Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uXwi1C5L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uXwi1C5L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 173C8C433B2;
	Wed, 21 Feb 2024 06:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708497088;
	bh=NANA/0QfS51GGL26cKvktvqO8FyzZ/ZWS17UCPlyreU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uXwi1C5L4/gIwOeJrSwyrAQP/M7FAtAnf8594W37r7YevvFsClrxTTZIu0A2CKOcQ
	 l0T/TOavk4SCZvpTa4UXA+jpszGG6ABv6IoVqi+8N3Rc4XcPmNgL3yt6shcpqzNcIl
	 liLwHd9Fw+xCCnFamNx8J1fOdlxqF0RY0yxZTZmrYz52aEQmGkbwyYO9gIk3yafz0t
	 d8klUo9/aYeaPN6GWt3xC+mTEBOpD/5NfIJDCxuWWLmZK/MaQ5/UEsiuqxEDglwMIp
	 IvJ1c+nWkPmSQufovL8e1IPd7tWuaNXiRy27xMIZXU/XYnxTcJLj6iGmf97+4AO65+
	 PbS+iRHvzdIhg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 6/8] mptcp: add use_id parameter for addresses_equal
Date: Wed, 21 Feb 2024 14:31:13 +0800
Message-Id: <a911da17e335a0dc22dd722e484d7a79a10967c9.1708497039.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708497039.git.tanggeliang@kylinos.cn>
References: <cover.1708497039.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new parameter use_id for mptcp_addresses_equal() to
test the address ids, as well as the address. This can be used to test
if the two given addresses are identically equal, they have both the
same address and the same address id.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c           |  2 +-
 net/mptcp/pm_netlink.c   | 32 +++++++++++++++++++-------------
 net/mptcp/pm_userspace.c |  6 +++---
 net/mptcp/protocol.h     |  3 ++-
 4 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 55406720c607..c632c9ef69db 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -418,7 +418,7 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	 */
 	mptcp_local_address((struct sock_common *)msk, &msk_local);
 	mptcp_local_address((struct sock_common *)skc, &skc_local);
-	if (mptcp_addresses_equal(&msk_local, &skc_local, false))
+	if (mptcp_addresses_equal(&msk_local, &skc_local, false, false))
 		return 0;
 
 	if (mptcp_pm_is_userspace(msk))
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 5c17d39146ea..1bf5c3440f84 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -54,7 +54,8 @@ pm_nl_get_pernet_from_msk(const struct mptcp_sock *msk)
 }
 
 bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
-			   const struct mptcp_addr_info *b, bool use_port)
+			   const struct mptcp_addr_info *b,
+			   bool use_port, bool use_id)
 {
 	bool addr_equals = false;
 
@@ -75,10 +76,14 @@ bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
 
 	if (!addr_equals)
 		return false;
-	if (!use_port)
+	if (!use_port && !use_id)
 		return true;
 
-	return a->port == b->port;
+	if (use_port && use_id)
+		return (a->port == b->port) && (a->id == b->id);
+	if (use_port)
+		return a->port == b->port;
+	return a->id == b->id;
 }
 
 void mptcp_local_address(const struct sock_common *skc, struct mptcp_addr_info *addr)
@@ -117,7 +122,7 @@ static bool lookup_subflow_by_saddr(const struct list_head *list,
 		skc = (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
 
 		mptcp_local_address(skc, &cur);
-		if (mptcp_addresses_equal(&cur, saddr, saddr->port))
+		if (mptcp_addresses_equal(&cur, saddr, saddr->port, false))
 			return true;
 	}
 
@@ -135,7 +140,7 @@ static bool lookup_subflow_by_daddr(const struct list_head *list,
 		skc = (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
 
 		remote_address(skc, &cur);
-		if (mptcp_addresses_equal(&cur, daddr, daddr->port))
+		if (mptcp_addresses_equal(&cur, daddr, daddr->port, false))
 			return true;
 	}
 
@@ -244,7 +249,7 @@ mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
 	lockdep_assert_held(&msk->pm.lock);
 
 	list_for_each_entry(entry, &msk->pm.anno_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, addr, true))
+		if (mptcp_addresses_equal(&entry->addr, addr, true, false))
 			return entry;
 	}
 
@@ -261,7 +266,7 @@ bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk)
 
 	spin_lock_bh(&msk->pm.lock);
 	list_for_each_entry(entry, &msk->pm.anno_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, &saddr, true)) {
+		if (mptcp_addresses_equal(&entry->addr, &saddr, true, false)) {
 			ret = true;
 			goto out;
 		}
@@ -504,7 +509,7 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
 	struct mptcp_pm_addr_entry *entry;
 
 	list_for_each_entry(entry, &pernet->local_addr_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, info, entry->addr.port))
+		if (mptcp_addresses_equal(&entry->addr, info, entry->addr.port, false))
 			return entry;
 	}
 	return NULL;
@@ -744,12 +749,12 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 		struct mptcp_addr_info local, remote;
 
 		mptcp_local_address((struct sock_common *)ssk, &local);
-		if (!mptcp_addresses_equal(&local, addr, addr->port))
+		if (!mptcp_addresses_equal(&local, addr, addr->port, false))
 			continue;
 
 		if (rem && rem->family != AF_UNSPEC) {
 			remote_address((struct sock_common *)ssk, &remote);
-			if (!mptcp_addresses_equal(&remote, rem, rem->port))
+			if (!mptcp_addresses_equal(&remote, rem, rem->port, false))
 				continue;
 		}
 
@@ -924,7 +929,8 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 		entry->addr.port = 0;
 	list_for_each_entry(cur, &pernet->local_addr_list, list) {
 		if (mptcp_addresses_equal(&cur->addr, &entry->addr,
-					  cur->addr.port || entry->addr.port)) {
+					  cur->addr.port || entry->addr.port,
+					  false)) {
 			/* allow replacing the exiting endpoint only if such
 			 * endpoint is an implicit one and the user-space
 			 * did not provide an endpoint id
@@ -1067,7 +1073,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, skc, entry->addr.port)) {
+		if (mptcp_addresses_equal(&entry->addr, skc, entry->addr.port, false)) {
 			ret = entry->addr.id;
 			break;
 		}
@@ -1456,7 +1462,7 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 			goto next;
 
 		mptcp_local_address((struct sock_common *)msk, &msk_local);
-		if (!mptcp_addresses_equal(&msk_local, addr, addr->port))
+		if (!mptcp_addresses_equal(&msk_local, addr, addr->port, false))
 			goto next;
 
 		lock_sock(sk);
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 09a60f440fef..f2fb02ed9731 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -41,7 +41,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 
 	spin_lock_bh(&msk->pm.lock);
 	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
-		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true);
+		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true, false);
 		if (addr_match && entry->addr.id == 0 && needs_id)
 			entry->addr.id = e->addr.id;
 		id_match = (e->addr.id == entry->addr.id);
@@ -92,7 +92,7 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 	struct mptcp_pm_addr_entry *entry, *tmp;
 
 	list_for_each_entry_safe(entry, tmp, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, &addr->addr, false)) {
+		if (mptcp_addresses_equal(&entry->addr, &addr->addr, false, false)) {
 			/* TODO: a refcount is needed because the entry can
 			 * be used multiple times (e.g. fullmesh mode).
 			 */
@@ -144,7 +144,7 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 
 	spin_lock_bh(&msk->pm.lock);
 	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (mptcp_addresses_equal(&e->addr, skc, false)) {
+		if (mptcp_addresses_equal(&e->addr, skc, false, false)) {
 			entry = e;
 			break;
 		}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7905783c95e4..1c32f579e1a1 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -670,7 +670,8 @@ void mptcp_set_owner_r(struct sk_buff *skb, struct sock *sk);
 void mptcp_set_state(struct sock *sk, int state);
 
 bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
-			   const struct mptcp_addr_info *b, bool use_port);
+			   const struct mptcp_addr_info *b,
+			   bool use_port, bool use_id);
 void mptcp_local_address(const struct sock_common *skc, struct mptcp_addr_info *addr);
 
 /* called with sk socket lock held */
-- 
2.40.1


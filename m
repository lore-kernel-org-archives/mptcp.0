Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386CF18D626
	for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 09:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729069972; cv=none; b=dYtlS8h5BF6UREAAcs+pdPY/Csh+ZPOLOktYXmxIUxhsQ3yi4xRoKPMLBZ8QWbZm+zXHWkSJ5sNbjRuqN70x17wXpv9PfAmcnphbOPo8KUaSaXNUA68NqQ1MluhIOR7BEU+ctoK9tVTJtNS9B+7iU0peZvnB+T+IoCRTiRkVIwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729069972; c=relaxed/simple;
	bh=nKkyplpOdqOaKeJCh1uW60xTSN8hbuvpssiZOQ0nLc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IS7HHCOQ1ebsw1uOFIDew1JoOykRDTfX1zRsAPSlCk0GoPNJGRxt6BG5stSJdZt4x2Z7IM3JnCEW3KeiSEIpRy3gwM+0NCGYSYkaqfwRX+7ksSp44MfwPOVgwpOMAH9VoMjXrZuBtcX3M477iAeUFj1OkEM8zfwoWOzNO3weIMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIM9QWcZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIM9QWcZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A78D9C4CECF;
	Wed, 16 Oct 2024 09:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729069971;
	bh=nKkyplpOdqOaKeJCh1uW60xTSN8hbuvpssiZOQ0nLc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YIM9QWcZgXUUsK0bQXFRu0YQ9Mixp+de5U7O5TNEKTVBCgd7dwL2QDJnOfviE8zMj
	 ccRXGhWUAB0r+aDUsUYOs41emdkoMbYGbKVbs2yo/QkD1XBiiqWvaw1T/wFlXQwVFk
	 tnyljbhiOgzS8AjNWy38BrKw8GLFF6CsmyYHygrAzXjcQejyN7CT32spWcf4bA2T9P
	 XmAJVXlA6HwvfxTHJII0EiOkqHMHPKML2CdmXkO18zaM0/O6c1JKAMDTbWXCf9uKof
	 4Mcf607slAMrjRfikoamudLB8hAhrplv3eXbWYpni9vnetty+NwD1TZOOsnlb8FweI
	 +2Qe4Z9AEM3pw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 03/33] mptcp: add mptcp_for_each_address macros
Date: Wed, 16 Oct 2024 17:12:07 +0800
Message-ID: <36d6f8988939d9cdbfd83b0fb804d322eeb106fb.1729069853.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729069853.git.tanggeliang@kylinos.cn>
References: <cover.1729069853.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Similar to mptcp_for_each_subflow() and mptcp_for_each_subflow_safe()
macros, this patch adds two new macros mptcp_for_each_address() and
mptcp_for_each_address_safe() to iterate over the address entries on
userspace_pm_local_addr_list of the mptcp socket.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 12 ++++++------
 net/mptcp/protocol.h     |  5 +++++
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 2cceded3a83a..00a7f9dd90cf 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -41,7 +41,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	bitmap_zero(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 
 	spin_lock_bh(&msk->pm.lock);
-	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
+	mptcp_for_each_address(msk, e) {
 		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true);
 		if (addr_match && entry->addr.id == 0 && needs_id)
 			entry->addr.id = e->addr.id;
@@ -92,7 +92,7 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 {
 	struct mptcp_pm_addr_entry *entry, *tmp;
 
-	list_for_each_entry_safe(entry, tmp, &msk->pm.userspace_pm_local_addr_list, list) {
+	mptcp_for_each_address_safe(msk, entry, tmp) {
 		if (mptcp_addresses_equal(&entry->addr, &addr->addr, false)) {
 			/* TODO: a refcount is needed because the entry can
 			 * be used multiple times (e.g. fullmesh mode).
@@ -112,7 +112,7 @@ mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
 {
 	struct mptcp_pm_addr_entry *entry;
 
-	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+	mptcp_for_each_address(msk, entry) {
 		if (entry->addr.id == id)
 			return entry;
 	}
@@ -127,7 +127,7 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 			     inet_sk((struct sock *)msk))->inet_sport;
 
 	spin_lock_bh(&msk->pm.lock);
-	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
+	mptcp_for_each_address(msk, e) {
 		if (mptcp_addresses_equal(&e->addr, skc, false)) {
 			entry = e;
 			break;
@@ -155,7 +155,7 @@ bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
 	bool backup = false;
 
 	spin_lock_bh(&msk->pm.lock);
-	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+	mptcp_for_each_address(msk, entry) {
 		if (mptcp_addresses_equal(&entry->addr, skc, false)) {
 			backup = !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
 			break;
@@ -642,7 +642,7 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 
 	lock_sock(sk);
 	spin_lock_bh(&msk->pm.lock);
-	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+	mptcp_for_each_address(msk, entry) {
 		if (test_bit(entry->addr.id, bitmap->map))
 			continue;
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7848a1989d17..a0f7b62c8c12 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -354,6 +354,11 @@ struct mptcp_sock {
 #define mptcp_for_each_subflow_safe(__msk, __subflow, __tmp)			\
 	list_for_each_entry_safe(__subflow, __tmp, &((__msk)->conn_list), node)
 
+#define mptcp_for_each_address(__msk, __entry)			\
+	list_for_each_entry(__entry, &((__msk)->pm.userspace_pm_local_addr_list), list)
+#define mptcp_for_each_address_safe(__msk, __entry, __tmp)			\
+	list_for_each_entry_safe(__entry, __tmp, &((__msk)->pm.userspace_pm_local_addr_list), list)
+
 extern struct genl_family mptcp_genl_family;
 
 static inline void msk_owned_by_me(const struct mptcp_sock *msk)
-- 
2.43.0


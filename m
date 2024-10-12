Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD271922CA
	for <mptcp@lists.linux.dev>; Sat, 12 Oct 2024 14:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728742806; cv=none; b=oSrxLx56wNKIPDALcEA2imBA6fIMU+UrDxMXvOuPVmSuJPLVxpqBXwVIL5U/cwLRh9dAqtqWb0R/G53Z5+p5QrLIihRvEG6UNdcW6/kgb/qAAy+VP+tEEC+Apab42opLHWZ8TACAsrklbBCfUKYfuTtvxt37O+L4FXy9lCokD0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728742806; c=relaxed/simple;
	bh=TpN68kbKXHxCrx1JwqvHFzDXhArZtu6TA9dlbd/rY2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nou7wfS1oQEPYRRgrdHnlQUdKSe6AMZv2Y7RuHXndy3Nk2hcq/JNceFTSfXws5UZLzHUU3Id5fQO71SB28sR1D9cm2qhaJgUdQz2etDTwYO6lmA2UMAiCoazlWhkSvzHToqYSw5/keF2xT6qGNjKewSJr37TP5N5K7YOUlWI38g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uaw5C1J6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uaw5C1J6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B97D6C4CECC;
	Sat, 12 Oct 2024 14:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728742805;
	bh=TpN68kbKXHxCrx1JwqvHFzDXhArZtu6TA9dlbd/rY2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uaw5C1J6dRAAsAoyb+MsNZgBvIkykSHllJfOAE4GFXZdUqXt2p0fP9dO1WMvJ6QdX
	 IZLks9kcxOC2ks0SZYxTwURUBBMZowk0sJF/jfbU8jGMwiRsOek9VLvbzBn61Flmf8
	 64VJXlsz1+yB6w0F79fFM698Vlxt8Zu4QjlsmZdC7f7I9465ILpBwxquUFyQAyXaRK
	 j916n9O8yJEYEsbX0e+qpFnYpC2/wxG9AHuJ4I4vnBVGYpfrQ4kygRDfxQMttAg4YA
	 2+nfHh/Hfh1ub8Ozx3EtXhp0GgO27/wIGXIzWs9nyf/y56FjoIaBuYoTsOks/0uLry
	 K+/1qo9c5/skA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 04/11] mptcp: add mptcp_for_each_address macros
Date: Sat, 12 Oct 2024 22:19:44 +0800
Message-ID: <d49f0387a827d928dbe3be0e54fc655499874c2b.1728742592.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728742591.git.tanggeliang@kylinos.cn>
References: <cover.1728742591.git.tanggeliang@kylinos.cn>
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
index 6aaf10b8ddd1..4baa2a7dfd26 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -41,7 +41,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	bitmap_zero(id_bitmap.map, MPTCP_PM_MAX_ADDR_ID + 1);
 
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
@@ -601,7 +601,7 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 
 	lock_sock(sk);
 	spin_lock_bh(&msk->pm.lock);
-	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+	mptcp_for_each_address(msk, entry) {
 		if (test_bit(entry->addr.id, bitmap->map))
 			continue;
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 56b2c431dcb5..dc777a3e05a2 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -358,6 +358,11 @@ struct mptcp_sock {
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


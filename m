Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EC41547F5
	for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 09:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588497; cv=none; b=A84RcKnRW0tFgsHA72Y70S/HtZyIe4P2YR3d1bxjKflPEbjZdZYLvrzS7hKf+PukyzHHr3hKg/8gn2OjI3XAVPzFIQzsji1TH69r9zyvo9prUfykpCqOWLAK9ofICjoCONDo8lI20GroEwCEtjjIXVFmlJG4HzT+pGXvMURFv1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588497; c=relaxed/simple;
	bh=FT6dAoK+FPKTgZBEhzOzK0ZJKe8o8jHNJZkXW9DFfCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I6rWs7fbcwaADStLe6kGQk6NketheRQJyyVYfBo/TGVzP2Ccp2EiOA3syEQuHAQtagZcqadGd3goOCy+GD8k2LqghTweaDbx4xTeHlwm+9dAgJU7vf02h6D0Tc/WSQUMmftlFgZJxdSKQFtMIC/Xf8GEzriVlWpFVViKtMnP+n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0Wpdgxq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0Wpdgxq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB88C4CEC3;
	Tue, 22 Oct 2024 09:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729588497;
	bh=FT6dAoK+FPKTgZBEhzOzK0ZJKe8o8jHNJZkXW9DFfCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H0Wpdgxqvobww1or/IPkzrIClon183hYwLo0EQIBdWJBNZsGkoEaIlQE6euxtZy3Y
	 X+DfK4bquaYS5/CDTA2/ShOhS8ZCD0CsLdqOC8ECsgK+N+WDLFL8xqBsz1gTaxIgUu
	 EU0ZVSPw/r14WmNqCbocM1a03oBEB2ZByQX/bCxjrmIIMqsJuMeqXxVTFwctLcmzfn
	 4zG6e4OEfEO2yCc+aFblrA3dd39nGn+RD350v367tX+g5VBUOSxPwLqKiE6xn0ftZY
	 CiOO9VNLiXImkrV03XSEavbtTyOC+2iN9V6l5OJRNUFXges7N1PxjGBUcxP5vgJKLb
	 YqOc46iP+fSMg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 03/36] mptcp: add mptcp_for_each_address macros
Date: Tue, 22 Oct 2024 17:14:11 +0800
Message-ID: <b6b53fd730a0edd0024963468d078488ad5e67aa.1729588019.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1729588019.git.tanggeliang@kylinos.cn>
References: <cover.1729588019.git.tanggeliang@kylinos.cn>
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
index b4c72a73594f..ce3b12778b3f 100644
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
2.45.2


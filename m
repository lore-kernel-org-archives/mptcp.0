Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21771AD9F9
	for <mptcp@lists.linux.dev>; Thu,  5 Dec 2024 07:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733382912; cv=none; b=b7GdRlApvatB7CqgYe4Jpq2KJcTRyhrMuHi+dOaq8WxVp1HZ0zLSPqJQGzGBJHWeRTCGrS52p4DSLLfvXa4asLO4yeK4g+tVxe7MsovBEYYg8tjWI+al/WVq5mKdfoi0JbKQKjOFV2hw9Pp5tWEL9aGgDnNYx3UgjBB20sp3YE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733382912; c=relaxed/simple;
	bh=8+gtOBUHsd1UC+C2OyLbslLF3X4b8omu0pIePHSRbLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FNkD53wnDwNugAJxZ7Wmtdmrf4PMlWx2uxoqj7UTdHiPbMeUBcDRrWrlAwF4bEr8fhr6xazGc8wQjUK6LnaPy5FR/hz/7dW+NBxhCb5BAp5xQUSUwzRAAc14/TyX/Quru+YviO+RfCNgC7bGY0dFAJC5H1afLWrCVnTw+qawUwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwLP024d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwLP024d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4BAC4CED1;
	Thu,  5 Dec 2024 07:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733382912;
	bh=8+gtOBUHsd1UC+C2OyLbslLF3X4b8omu0pIePHSRbLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VwLP024dNc52I7JO+aiElVYOL5Lb+i7v+dB0saiSLwaQe7Qt9R17uRocGBfMDRRgV
	 G9xUqxJ4MSZxBMs3yLvj4xU77Vb6dpjmpo6tYbYsJY1ohT1m8VK1rFdnQZmd1O90sn
	 jet8hO4klWcszuwEHm6fM32X7GypPwTtLv3kN2iMEXVBT6MCyUI1KU66QtLN9frTwm
	 Q0KWu8vUaQug7ISr2Z8E7F6vGguFe60nJvN37VeKFPL5DSAER5ngjp7UOhhkBaahLT
	 pe30SsgEwDtMuVti7L1Cf+lHkIEOVCez/j5zjsjdbz8mTVwzb3mw3m6mGrFxCzIizZ
	 I9ntHPtvKUv8Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 2/7] mptcp: add mptcp_for_each_userspace_pm_addr macro
Date: Thu,  5 Dec 2024 15:14:54 +0800
Message-ID: <9b4d4aa521fc94ce45b2cfa66ec4c94816f2fdc0.1733382223.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733382222.git.tanggeliang@kylinos.cn>
References: <cover.1733382222.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Similar to mptcp_for_each_subflow() macro, this patch adds a new macro
mptcp_for_each_userspace_pm_addr() for userspace PM to iterate over the
address entries on the local address list userspace_pm_local_addr_list
of the mptcp socket.

This patch doesn't change the behaviour of the code, just refactoring.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 3664f3c1572e..c99ec28c1bd5 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -8,6 +8,9 @@
 #include "mib.h"
 #include "mptcp_pm_gen.h"
 
+#define mptcp_for_each_userspace_pm_addr(__msk, __entry)	\
+	list_for_each_entry(__entry, &((__msk)->pm.userspace_pm_local_addr_list), list)
+
 void mptcp_free_local_addr_list(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_addr_entry *entry, *tmp;
@@ -32,7 +35,7 @@ mptcp_userspace_pm_lookup_addr(struct mptcp_sock *msk,
 {
 	struct mptcp_pm_addr_entry *entry;
 
-	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+	mptcp_for_each_userspace_pm_addr(msk, entry) {
 		if (mptcp_addresses_equal(&entry->addr, addr, false))
 			return entry;
 	}
@@ -54,7 +57,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	bitmap_zero(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 
 	spin_lock_bh(&msk->pm.lock);
-	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
+	mptcp_for_each_userspace_pm_addr(msk, e) {
 		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true);
 		if (addr_match && entry->addr.id == 0 && needs_id)
 			entry->addr.id = e->addr.id;
@@ -124,7 +127,7 @@ mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
 {
 	struct mptcp_pm_addr_entry *entry;
 
-	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+	mptcp_for_each_userspace_pm_addr(msk, entry) {
 		if (entry->addr.id == id)
 			return entry;
 	}
@@ -659,7 +662,7 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 
 	lock_sock(sk);
 	spin_lock_bh(&msk->pm.lock);
-	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+	mptcp_for_each_userspace_pm_addr(msk, entry) {
 		if (test_bit(entry->addr.id, bitmap->map))
 			continue;
 
-- 
2.45.2


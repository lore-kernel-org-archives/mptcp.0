Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8273482C60
	for <mptcp@lists.linux.dev>; Thu,  7 Nov 2024 06:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730961954; cv=none; b=LIFXtdIlh6Ilw7TNjd4yIzzmIV6VOS1EFP41hnTfLm8W754yZK2r1B/goQnh5xtNqQxdt8a4/0l7AstFcyY45efRGD+ne4B3VHHvcZNMw9KBOosxcmmSkxGY1mBvST9Qq/ypdbKVGzlsqvAgFs3yTkwmX+NBRnQJ8zh+uubavAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730961954; c=relaxed/simple;
	bh=8+gtOBUHsd1UC+C2OyLbslLF3X4b8omu0pIePHSRbLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j8S9x6v/sxmSw9XfHjqu+nVchD23jYwwPZ9sa8L8Te7g+yRI5FF4s4hoN1+dUsm7Lrga3LyEd7xwTtrjh2IOa3kB0Kc1vLj6ParuwD15h9KuPw2X9eQsWY12zsEwxed+pGco5SRsJa9cJsQgh0OizTnljM/pXLrtkiBfxPiPdvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=um7TSqvd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="um7TSqvd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320F5C4CECC;
	Thu,  7 Nov 2024 06:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730961954;
	bh=8+gtOBUHsd1UC+C2OyLbslLF3X4b8omu0pIePHSRbLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=um7TSqvdrufI0lUQSxrCymwHeqGhr3m4OjvfeLfdvKTnrxooSRIAQeddB7b+m+GoB
	 Odot4gRwFAE/uu7lBXh6HEwtoUsqMV5OHZXfh/J4dD6wc4K1PjpOWA1WkXf5lX0Qtx
	 jC0229tKoULItpRFOcsU9aC62R/rz4BpjY2gsH65r5dkyiRRy9abjerP6+5xPJMq7H
	 +XaXviGSNrNK3FlCd2FXBHFmo6QxNLU/IzTa/grVgad51YTsc7wOzPHETaqVrI2AZ6
	 2QoJCKYf3WZ3gcRT8j552JtOpNN2+HvWhIWlT9Szlr1M0UKefPtToi/zQuG4CNn9w8
	 3jCgl5rIb7LkQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 2/9] mptcp: add mptcp_for_each_userspace_pm_addr macro
Date: Thu,  7 Nov 2024 14:45:36 +0800
Message-ID: <445d9405c0cc633058e40f715e38b59b8729eee9.1730961809.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1730961809.git.tanggeliang@kylinos.cn>
References: <cover.1730961809.git.tanggeliang@kylinos.cn>
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


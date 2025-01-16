Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA5C1946B8
	for <mptcp@lists.linux.dev>; Thu, 16 Jan 2025 07:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737012432; cv=none; b=BhOvlRYk+iloE7HqdH8jncw34J/8z3kBYI0aAjpmU3jUPi95YmE5bG/1UrZItl0O0qBSK2KIA0WlgfNPzwbuuYeevbUzQDprnP+GNCLHWl+tDjb2hoko4Pj99irslBK+ev+R6JT4Wpxzq/OSxmxDaMHsXZ1/lVQXrWj1jtiyajU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737012432; c=relaxed/simple;
	bh=UAytOR39GwZbtz5iZ7M1WnJAsJybN3U2rWQwbAznRpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VzI/C35dhJQnkgsJ96eTeX9k1AKV95GEBz49rGMbRbJUcCvP0k6uivCsDuJeaMFyrVzfm4m4U54XyLJ454Oajnj84EIV+7/fKVFxHEEnDHk8QFyyPbfaNz4ZQbzvRziK+rCKWgK/OnRG3KwJMoBgpOKWk/mVyyvtgaV4UBGoLmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvHFnKiB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvHFnKiB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4869C4CEDF;
	Thu, 16 Jan 2025 07:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737012431;
	bh=UAytOR39GwZbtz5iZ7M1WnJAsJybN3U2rWQwbAznRpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AvHFnKiBodyR49NxHN/VZ4oidbBdCL+nXwWuoM0NyiC3lSFJeJiAA1jpjqruoiZG8
	 btIu/mzWr7uYxHR0EuOmUe8fJoDN/UjVoCMh+fhv/IM1e4kkNVvZ4cEJeELy+YOaqR
	 hb5qkxmoPwEAVaKgJLLA2r1f/39VqsUy4s8KGXag4A7Ij+mky9v7EVVtYQgQFFx3wA
	 LZm64sRLa8HblGQkHwN+jdraiITsIv+dGd1SdF03e6+vGryYcRzdYh1TkIRx8OOIoD
	 VR/mxnXm8CF0p+4c+21htkV7i9GVIQVrwIbgjpK+8NwE4PsTzlXQ2gMCO9w/SsYeU8
	 e/l/FaBQ7WwpA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 3/7] mptcp: add struct mptcp_pm_addr_id_bitmap
Date: Thu, 16 Jan 2025 15:26:55 +0800
Message-ID: <30d07c758cfb06aeb312fe37238ce60fc120da13.1737012165.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1737012165.git.tanggeliang@kylinos.cn>
References: <cover.1737012165.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

To simplify the use of bitmap in BPF, a new type for MPTCP userspace
pm id bitmap, struct mptcp_pm_addr_id_bitmap is defined. Because
there's no way to use DECLARE_BITMAP macro in BPF program, and it's
not easy to reimplement it in BPF.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 17 ++++++++---------
 net/mptcp/protocol.h     |  4 ++++
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 540b2080f02b..5c7a8817595c 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -47,7 +47,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 						    struct mptcp_pm_addr_entry *entry,
 						    bool needs_id)
 {
-	DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+	struct mptcp_pm_addr_id_bitmap id_bitmap;
 	struct mptcp_pm_addr_entry *match = NULL;
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_addr_entry *e;
@@ -55,7 +55,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	bool id_match = false;
 	int ret = -EINVAL;
 
-	bitmap_zero(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+	bitmap_zero(id_bitmap.map, MPTCP_PM_MAX_ADDR_ID + 1);
 
 	spin_lock_bh(&msk->pm.lock);
 	mptcp_for_each_userspace_pm_addr(msk, e) {
@@ -69,7 +69,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		} else if (addr_match || id_match) {
 			break;
 		}
-		__set_bit(e->addr.id, id_bitmap);
+		__set_bit(e->addr.id, id_bitmap.map);
 	}
 
 	if (!match && !addr_match && !id_match) {
@@ -84,7 +84,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 
 		*e = *entry;
 		if (!e->addr.id && needs_id)
-			e->addr.id = find_next_zero_bit(id_bitmap,
+			e->addr.id = find_next_zero_bit(id_bitmap.map,
 							MPTCP_PM_MAX_ADDR_ID + 1,
 							1);
 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
@@ -633,18 +633,17 @@ int mptcp_userspace_pm_set_flags(struct mptcp_pm_addr_entry *local,
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 				 struct netlink_callback *cb)
 {
-	struct id_bitmap {
-		DECLARE_BITMAP(map, MPTCP_PM_MAX_ADDR_ID + 1);
-	} *bitmap;
 	const struct genl_info *info = genl_info_dump(cb);
+	struct mptcp_pm_addr_id_bitmap *bitmap;
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
 	int ret = -EINVAL;
 	struct sock *sk;
 
-	BUILD_BUG_ON(sizeof(struct id_bitmap) > sizeof(cb->ctx));
+	BUILD_BUG_ON(sizeof(struct mptcp_pm_addr_id_bitmap) >
+		     sizeof(cb->ctx));
 
-	bitmap = (struct id_bitmap *)cb->ctx;
+	bitmap = (struct mptcp_pm_addr_id_bitmap *)cb->ctx;
 
 	msk = mptcp_userspace_pm_get_sock(info);
 	if (!msk)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 20941405a1ea..aca3de2baf81 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -212,6 +212,10 @@ enum mptcp_addr_signal_status {
 /* max value of mptcp_addr_info.id */
 #define MPTCP_PM_MAX_ADDR_ID		U8_MAX
 
+struct mptcp_pm_addr_id_bitmap {
+	DECLARE_BITMAP(map, MPTCP_PM_MAX_ADDR_ID + 1);
+};
+
 struct mptcp_pm_data {
 	struct mptcp_addr_info local;
 	struct mptcp_addr_info remote;
-- 
2.43.0


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895E222DC20
	for <mptcp@lists.linux.dev>; Tue, 14 Jan 2025 09:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736846390; cv=none; b=Zl0q+xADBty0szA/A4+wzc0BVK/MBrXM25mCMLzb2PPpx0x2aErZAgnbmk+KfZM4jrXXJmgquLWghDaxaCPisd1zgWowkqMqTDAbk5siqZYgSbVWWXhp59IgJL7OJ2VA1IMPdHOUXiMMJ/wpxKsgqDfA6YrM+bA1KGPNclGDpu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736846390; c=relaxed/simple;
	bh=5JEA0GO5ILcqc037TTapUXLwv0Sb0arfSRkEMOl4XV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qtyVoxSKqOUmDmdGObV1RZnx/gwx85iBtWDFYH0WQLuucc6xORsqmhR1s6iIJNZmdnImTB1Yfx1GU1BEfZulKS1V/Elxkd4jIAm3GAuztdQuZgl7w/ULU1JOD9R0V4RP6jBUiioTV0I/agSV6h/jyAUV9J1pLVEj4YjILTw26P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QH6QkVCU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QH6QkVCU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734D7C4CEDD;
	Tue, 14 Jan 2025 09:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736846390;
	bh=5JEA0GO5ILcqc037TTapUXLwv0Sb0arfSRkEMOl4XV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QH6QkVCUcLe4KofjxOYz77GjrG302hVaEZJwr3LhGofeXx8uq6A3SQPLuybt9ks42
	 GR4soDUZZA/sxJEGDmoe0WH0RE6lvVIW92rFTz9kpyXuXAqVHrLXo6BRfxAWe9Tjcy
	 x8g7cjHEW/tqssm/uF8z2MQfGbqtnVVlo6J9gR9Uv0nR8LMsgmFp2jUBULNlacExVT
	 cjIoWGKzIsgEOivTffAyisamFH8YLtMVtjmsOINgi4cyczW1LRRCAzothfc182d2Ue
	 NTj54Lrf/T2Bq7JGs5HpqmnEaAaAOl8PkF3vrlt1X/AcD+SPFWlPGwGpMFd6uT48Dq
	 Bvy7Y2kaQ0Z6Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 2/6] mptcp: add struct mptcp_pm_addr_id_bitmap
Date: Tue, 14 Jan 2025 17:19:34 +0800
Message-ID: <c81842651079703e2c7d168bc3e2db2151657db0.1736845893.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736845893.git.tanggeliang@kylinos.cn>
References: <cover.1736845893.git.tanggeliang@kylinos.cn>
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
 net/mptcp/pm_userspace.c | 14 ++++++--------
 net/mptcp/protocol.h     |  4 ++++
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index b50462b527bd..e53426a5fc52 100644
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
@@ -633,16 +633,14 @@ int mptcp_userspace_pm_set_flags(struct mptcp_pm_addr_entry *local,
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
 
-	bitmap = (struct id_bitmap *)cb->ctx;
+	bitmap = (struct mptcp_pm_addr_id_bitmap *)cb->ctx;
 
 	msk = mptcp_userspace_pm_get_sock(info);
 	if (!msk)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 54451bffd103..2060a3801814 100644
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


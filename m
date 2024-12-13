Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF23188CC9
	for <mptcp@lists.linux.dev>; Fri, 13 Dec 2024 07:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734075353; cv=none; b=UctagIevkFDaJK/Fy+lIm5l1luRqeXVG8nBtv8QJFuh92ArqDfDp4aj6rFG3Fytl36AFIO6X8qEir7DWVhUaGN4g+Xyt4ODX8eN1wQKZT4n8ppAoHRlkNhjmgjTZwhOSSw6avBYEP3dcHHlWWxvnFo4VQYWoFJJtFPV2SKZL0rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734075353; c=relaxed/simple;
	bh=dQdvA5+myEe9gkDTm+R/mFfs24TrgIwbsoP6o9nQhjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GSF0PBDCPngrqwypnmKHsyDEef1irm+X+omua6b5utWV6A3URzb1v1VpxuPloKCEFP8khhVNjNU1q/BkElQusw3nwJcvSjhRU2mGWlfEPbz2ATVs8qm4knmvaFxWsJtO5jDLWkXN0tyDwZTjncoo6dEu2aarls6Gj5JAaXjJr2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdzCVyqF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdzCVyqF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66946C4CED0;
	Fri, 13 Dec 2024 07:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734075352;
	bh=dQdvA5+myEe9gkDTm+R/mFfs24TrgIwbsoP6o9nQhjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bdzCVyqF2DWVTa2NxiOQ62kiz+karVRPgnQWhSRCclFpSp4S/yvKQKpc3BOVgFX50
	 YEIYgaxwPFEJQ0QAgtx9v13ZLKzPoyh1wgmiqbr50PEMG7d0YwnYW8JzPOfkCla/IV
	 KbSdQdvYKB7u41pFMSU2QuMwY/D8hxGlnD0XpeWPGKG2YOeL4kjYI35cMVD5cH/t77
	 0wqh9ztVviOq8q4z18cIMKNOe8pNr3vkIt5OCZvKN6zzFxDhDXZZAEOh60Cw/eOIrB
	 R82ZB6ov39/TDWggict2CwNiBuhnbZZ7Ykaiq4r2gpv2rcYAbvNqRaPNphiSvdRirW
	 odPT+fUYT2QZQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 7/8] mptcp: add mptcp_pm_addr_id_bitmap_t type
Date: Fri, 13 Dec 2024 15:35:28 +0800
Message-ID: <789602f25f9fc73043f85417b6e147c49d894b66.1734074788.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1734074788.git.tanggeliang@kylinos.cn>
References: <cover.1734074788.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Similar to defining types such as nodemask_t, dma_cap_mask_t and
cpumask_t to simplify the use of bitmap, a new type for MPTCP
userspace pm id bitmap, mptcp_pm_addr_id_bitmap_t is defined to
easily modify dump_addr() interface of the path managers to accept
an mptcp_pm_addr_id_bitmap_t type parameter. It also allows this
parameter of dump_addr() can be modified by BPF program when
implementing this interface of a BFP path manager. Because a
dump_addr() interface that accepts an 'unsigned long *bitmap'
or 'unsigned long bitmap[]' parameter is difficult to implement
in BPF program.

In addition, this also makes it easier for us to implement similar
logic to mptcp_userspace_pm_append_new_local_addr() in BPF path
manager, because there's no way to use DECLARE_BITMAP macro in BPF
program, and it's not easy to reimplement it in BPF.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h      |  7 +++++++
 net/mptcp/pm_userspace.c | 14 ++++++--------
 net/mptcp/protocol.h     |  3 ---
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 814b5f2e3ed5..220b1f60e8c1 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -120,6 +120,13 @@ struct mptcp_sched_ops {
 	void (*release)(struct mptcp_sock *msk);
 } ____cacheline_aligned_in_smp;
 
+/* max value of mptcp_addr_info.id */
+#define MPTCP_PM_MAX_ADDR_ID		U8_MAX
+
+typedef struct {
+	DECLARE_BITMAP(map, MPTCP_PM_MAX_ADDR_ID + 1);
+} mptcp_pm_addr_id_bitmap_t;
+
 #ifdef CONFIG_MPTCP
 void mptcp_init(void);
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 7dc417255e8f..0d9bea3a04a2 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -47,15 +47,15 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 						    struct mptcp_pm_addr_entry *entry,
 						    bool needs_id)
 {
-	DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 	struct mptcp_pm_addr_entry *match = NULL;
 	struct sock *sk = (struct sock *)msk;
+	mptcp_pm_addr_id_bitmap_t id_bitmap;
 	struct mptcp_pm_addr_entry *e;
 	bool addr_match = false;
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
@@ -618,16 +618,14 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 				 struct netlink_callback *cb,
 				 const struct genl_info *info)
 {
-	struct id_bitmap {
-		DECLARE_BITMAP(map, MPTCP_PM_MAX_ADDR_ID + 1);
-	} *bitmap;
+	mptcp_pm_addr_id_bitmap_t *bitmap;
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
 	int ret = -EINVAL;
 	struct sock *sk;
 	void *hdr;
 
-	bitmap = (struct id_bitmap *)cb->ctx;
+	bitmap = (mptcp_pm_addr_id_bitmap_t *)cb->ctx;
 
 	msk = mptcp_userspace_pm_get_sock(info);
 	if (!msk)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 1f9c66f53865..da2cf524c5da 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -208,9 +208,6 @@ enum mptcp_addr_signal_status {
 	MPTCP_RM_ADDR_SIGNAL,
 };
 
-/* max value of mptcp_addr_info.id */
-#define MPTCP_PM_MAX_ADDR_ID		U8_MAX
-
 struct mptcp_pm_data {
 	struct mptcp_addr_info local;
 	struct mptcp_addr_info remote;
-- 
2.45.2


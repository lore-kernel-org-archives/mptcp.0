Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C5522DFA4
	for <mptcp@lists.linux.dev>; Wed, 15 Jan 2025 07:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736924511; cv=none; b=GFx3u2lTWraQUK59oSMhxRd4YxJrTZ2Qu11TON3gwJil53eZXxXT01UcecwD1wINqkXQ6U45d+z+4s9pUAGOnjFb5TLoQHP86dDmXOZQXUAz9VpgPBpkr0Q9SHIv96k6APKpSwVs7G4debdgDNKSPXy+fTgREpbEzl+4hocs/R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736924511; c=relaxed/simple;
	bh=VQTbXInIocsUug3Gaqad5FUcamm3egJMgNUOEl9m6Tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X3zM5oaRrBPeq0Sz2S6GYs09Z7arIQKhP3nhImJjkyWPlZiaNDgcTF3EmABuvxNlqy5gVkE/+q8Frq5Rs40pWr+O28PPg5igxM65qbhhtFsht33/TXPkAnLqNDUsTN8AjNFjGaSVlUOCynWB0W6Rn1cWFP0R00z/lalxKeMPeLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tUmEV1jX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tUmEV1jX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E71BFC4CEDF;
	Wed, 15 Jan 2025 07:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736924511;
	bh=VQTbXInIocsUug3Gaqad5FUcamm3egJMgNUOEl9m6Tg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tUmEV1jXgLFu2F4LvpG2n+L1s0ECncHOfNZxYeBoQBPBFoEAtLO6ZjMxYzId3Ya97
	 dlSEp0bR71PsEqeeOcS3rvmlA98X67KsOArv7JD4XG5IbXlbKH/G1SkG343Hai+T1/
	 +CZsEVkZQi6C/iEmE5eRL3tHVveSSBGkUHWKNVewvg3gPtBmJt12UC0QoDangl3t0c
	 Q+Tm4OAJs1T2Dn+drtgAEDmcJEQjyHrAttWUeHNwyVVnicCn7+VF3CVQAvHmq5ywrZ
	 mnDEQ8gUjso0ESiT6iMTcvyO7u7Lg4yD9AdE2Q9ZdtQWYwl2GvN3fRzOM1JHGCtLSM
	 A1qvgF4IgaOTw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 2/7] mptcp: add struct mptcp_pm_addr_id_bitmap
Date: Wed, 15 Jan 2025 15:01:35 +0800
Message-ID: <19ea261f2ff5d7bb5b2333f6294d30c092a5df3e.1736924314.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736924314.git.tanggeliang@kylinos.cn>
References: <cover.1736924314.git.tanggeliang@kylinos.cn>
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


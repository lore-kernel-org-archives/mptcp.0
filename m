Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFA51990B7
	for <mptcp@lists.linux.dev>; Thu, 16 Jan 2025 07:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737012435; cv=none; b=Wc9eJsWgNFEmDVp+fKozKa1qN+Ajtg0I5Iw/IehzHcciIbxKYOKd4aluRgI3LGdy7HuJyKEon6mtrZ9FMHFtobuSXj33UHfHuXie+hGduZwuRKT/D6NbNnHISSbiNLskEZEsgLAdUKaE2PyvwXt5+Aeic/hzVLc8X/DuhIOTI5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737012435; c=relaxed/simple;
	bh=DaI7SQT8GY/NiSZNUbwTbINnuZ4DangVC/mvANmBa2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q2ONaDkZsBDC6AhISSJw1c3axuy4T8JYfYweMUbJiwLLb92x6xRl3BCfvJR6zPegxOD+hz4gHobBXW2i0+vxvNSGD+QdgtrR6D4w4MxQGPtlY/rPz18q+z+uVmQGo3aItTwc8Nf+xvmU4/8uQ7XsWhHTECTb8W/hFppEkCBZNEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqS29tfx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqS29tfx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F223C4CEE3;
	Thu, 16 Jan 2025 07:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737012435;
	bh=DaI7SQT8GY/NiSZNUbwTbINnuZ4DangVC/mvANmBa2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oqS29tfxRtxbIHuzXsEaDLv38xYErOIVGnXSZGgk290iM7ZiZEMlQknJCyn3b6QbD
	 2GDngZyc60CuO22/i+9j6WS6zd1D3uBBZnsjq48LdxA+rApuYOFLSONbvx69uVTOax
	 J+B4eV6B56B5JlZy3El5rgj0B8gRqIkrcMxTd9pLp/SNP3pkgYwkeaP/+P0n205Xiw
	 GrZpX0qdZ9jcTRj1EOLPWuDJ3HbG9opofkslXj53IOtDO3vr5FCGSU0KD4Ti9qPcU3
	 00uiJql36fMGlvRDXU/8LGEcTk6C6mVudtWosNNMLqBrod8htOqXdopO+bK2wr8dcv
	 7eZuqJUhZJ7wQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 5/7] mptcp: drop match in userspace_pm_append_new_local_addr
Date: Thu, 16 Jan 2025 15:26:57 +0800
Message-ID: <a6dc4b582e968566d34846237f6647c94c7895c8.1737012165.git.tanggeliang@kylinos.cn>
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

The variable 'match' in mptcp_userspace_pm_append_new_local_addr() is a
redundant one, and this patch drops it.

No need to define 'match' as 'struct mptcp_pm_addr_entry *' type. In this
function, it's only used to check whether it's NULL. It can be defined as
a Boolean one.

Also other variables 'addr_match' and 'id_match' make 'match' a redundant
one, which can be replaced by directly checking 'addr_match && id_match'.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index bd09a637049d..8a0202d8bfa4 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -48,7 +48,6 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 						    bool needs_id)
 {
 	struct mptcp_pm_addr_id_bitmap id_bitmap;
-	struct mptcp_pm_addr_entry *match = NULL;
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_addr_entry *e;
 	bool addr_match = false;
@@ -63,16 +62,12 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		if (addr_match && entry->addr.id == 0 && needs_id)
 			entry->addr.id = e->addr.id;
 		id_match = (e->addr.id == entry->addr.id);
-		if (addr_match && id_match) {
-			match = e;
+		if (addr_match || id_match)
 			break;
-		} else if (addr_match || id_match) {
-			break;
-		}
 		__set_bit(e->addr.id, id_bitmap.map);
 	}
 
-	if (!match && !addr_match && !id_match) {
+	if (!addr_match && !id_match) {
 		/* Memory for the entry is allocated from the
 		 * sock option buffer.
 		 */
@@ -90,7 +85,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
 		msk->pm.local_addr_used++;
 		ret = e->addr.id;
-	} else if (match) {
+	} else if (addr_match && id_match) {
 		ret = entry->addr.id;
 	}
 
-- 
2.43.0


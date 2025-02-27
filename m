Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C616A21CC73
	for <mptcp@lists.linux.dev>; Thu, 27 Feb 2025 06:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740638665; cv=none; b=clMkrHBsbWhEPOubrcWr9lA9c7Uf93eA7lQyHokDFzw/2kAM5Tpogn9BwGz8F4U1kTSE8y0SSkSg/2QVFx2DBEiATl3j/6XADgANNWvZzZcMxmcgXlbkiFjdEw1aY+iXmNMKUUWUcoT0R/I0aUqovQ1ft2LYe+u6zzfXFefqyrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740638665; c=relaxed/simple;
	bh=MjLRvCPiOpwfmWzZC+qmAntgioCC/aZW3A7R6x5xR3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GELhP+TtekLr0mj93Q9VitIxqulD7+RsyS+9MOKvvb9n9eLxLTYQBEVHuR6r6kkskvTfaizvf4k3oud8yFKnzHOtHJlLi7uYL1jlsdAPVbBmLVxnV/Y5bw+BOU9lRKmFjLNkl9PHfZa1Xvq8yyyU1UJ+BvdW4rRXyqGaGG80k1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2aUCMUM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2aUCMUM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726F1C4CEDD;
	Thu, 27 Feb 2025 06:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740638665;
	bh=MjLRvCPiOpwfmWzZC+qmAntgioCC/aZW3A7R6x5xR3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R2aUCMUMJ34uQHWmgyrL/59XqjUQsTdpRbpgqhUWd88oPmrsgVfH+MRiPvMYmh/2Q
	 I7duGBsyf0V+SaNdPlnvi+Wm3JSIMItxgE90tJ5/ci0Qvkjr98F0aKg92RF0NFS9Xp
	 +KPFjcp+MZBnc5TY3usvWihWjBZKSVPVuNTGIYQoZD/jjrwqXIjo+bTzg6K8qsnKo4
	 Ml5lHdzxf9gLL3WSoyroTvj7NhX6GrCOt/YoEbwja4eC39LW5NDVCfs0SMlVsiowqH
	 bDkONmBjtwXle+iLtgCXiSxLF0S3uf08lXngq4PqO2rGZtGRp6qoHtG2oV7mz5/YV5
	 iTVx0PCWTFqGA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 6/6] mptcp: pm: in-kernel: drop changed parameter of set_flags
Date: Thu, 27 Feb 2025 14:43:57 +0800
Message-ID: <1e2f2a9bcdf69bd241dec4c5455c4aa135927cb6.1740638334.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740638334.git.tanggeliang@kylinos.cn>
References: <cover.1740638334.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

To drop the additional "changed" parameter of mptcp_nl_set_flags(),
store "entry->flags" to "remote->flags" before modifying it in
mptcp_pm_nl_set_flags(), so that "changed" value can be obtained by
comparing "local->flags" and "remote->flags" in mptcp_nl_set_flags().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 053f2bec9042..2f22c3bf88e2 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1916,13 +1916,16 @@ static void mptcp_pm_nl_fullmesh(struct mptcp_sock *msk,
 
 static void mptcp_nl_set_flags(struct net *net,
 			       struct mptcp_pm_addr_entry *local,
-			       u8 changed)
+			       struct mptcp_pm_addr_entry *remote)
 {
 	u8 is_subflow = !!(local->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW);
 	u8 bkup = !!(local->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
+	u8 changed, mask = MPTCP_PM_ADDR_FLAG_BACKUP |
+			   MPTCP_PM_ADDR_FLAG_FULLMESH;
 	long s_slot = 0, s_num = 0;
 	struct mptcp_sock *msk;
 
+	changed = (local->flags ^ remote->flags) & mask;
 	if (changed == MPTCP_PM_ADDR_FLAG_FULLMESH && !is_subflow)
 		return;
 
@@ -1987,12 +1990,13 @@ int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,
 		return -EINVAL;
 	}
 
+	remote->flags = entry->flags;
 	changed = (local->flags ^ entry->flags) & mask;
 	entry->flags = (entry->flags & ~mask) | (local->flags & mask);
 	*local = *entry;
 	spin_unlock_bh(&pernet->lock);
 
-	mptcp_nl_set_flags(net, local, changed);
+	mptcp_nl_set_flags(net, local, remote);
 	return 0;
 }
 
-- 
2.43.0


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312EB199956
	for <mptcp@lists.linux.dev>; Mon,  7 Oct 2024 10:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728298415; cv=none; b=ijFoeGAXa4t7pOPaRv0rOnUR060E67U8Zt77j7uEheXlYh5WQTPSBeIdWOuk+yWCST556fmGJ3d6K94eXhsXo72JaGVB7KDWc5EKntN3PTYv4xOvf3XwgdpxKGlUloOMhLuM9Bvd6aSAepEcFTB7jdcE73L3Nnc67Zc4wlhNPn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728298415; c=relaxed/simple;
	bh=vqOcOg8dsGwhak4/lx17NFlGIdPz8M3KC4JMpErX4cE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nRlTc0lVB6H9ZRGQ2grtqcnzj1Ly5xrxSgczf7D0kGeMbFxPqKrw5pSRj7iajLxY2X5ytowgNiu0tbtZEN8k/MTBJvUcScVWCOpaTP2kxGSw6ntfjkgO19QSQLqz+DHZtLtTRdCZnk/rv2cs7jdhmmx93JYLxGWx4H3QnrUeaJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tmsYphFH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tmsYphFH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A1DC4CEC6;
	Mon,  7 Oct 2024 10:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728298414;
	bh=vqOcOg8dsGwhak4/lx17NFlGIdPz8M3KC4JMpErX4cE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tmsYphFHTmnVLhkgbBeDsl9aqnUU8ukzxGB+lpMYvvzGzAaN/ZAt89ZhOHZfLl+hy
	 0u6lhwSuBvjbvBwX9IgcsZK/cfVLt4VkwQyX5FS6Jds2bTYBLzMOsas2Rv77CrQFC+
	 ywDJJA1kxQ9V3tNdEZLiCOquX91zQ2MnbuyCVLRrcck481oYj53ub3Bw3wZxJgmzbD
	 wZKcl/4iLmxr8bnpY7duJx0/Og1DzkmP+1bSoh/Ua7MVGMz/99DkoTd90kll04iwok
	 GweFsHtp6l7qPScYwNuhmoPSWmQ2uWheAeIpx+MkqR6/KHXmUPyymZMzgXTX1sN+8y
	 oGucI6Pwc/64g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 04/10] mptcp: use sock_kfree_s instead of kfree
Date: Mon,  7 Oct 2024 18:53:16 +0800
Message-ID: <47ee37e871195c5235c2d76cbe1f50c3be4a1f58.1728298100.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728298100.git.tanggeliang@kylinos.cn>
References: <cover.1728298100.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The local address entries on the userspace_pm_local_addr_list are allocated
by sock_kmalloc(). It's better to use sock_kfree_s() to free them, instead
of using kfree().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 6aaf10b8ddd1..b7272289d4c1 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -91,6 +91,7 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 						struct mptcp_pm_addr_entry *addr)
 {
 	struct mptcp_pm_addr_entry *entry, *tmp;
+	struct sock *sk = (struct sock *)msk;
 
 	list_for_each_entry_safe(entry, tmp, &msk->pm.userspace_pm_local_addr_list, list) {
 		if (mptcp_addresses_equal(&entry->addr, &addr->addr, false)) {
@@ -98,7 +99,7 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 			 * be used multiple times (e.g. fullmesh mode).
 			 */
 			list_del_rcu(&entry->list);
-			kfree(entry);
+			sock_kfree_s(sk, entry, sizeof(*entry));
 			msk->pm.local_addr_used--;
 			return 0;
 		}
-- 
2.43.0


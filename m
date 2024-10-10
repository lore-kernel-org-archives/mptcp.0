Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DE3178372
	for <mptcp@lists.linux.dev>; Thu, 10 Oct 2024 05:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728539308; cv=none; b=fh2T5VVVyLqDtLV5cwUlr5rohzTlZI7BAoS1hSRH21crOuzX050OSMNL1XAVy5bNG/c30Rt1K8qlWC40+tPdqj42xO9tFiZoLJY5GbdACm+IY75v4Y805w6gb9Fr/t3VcfEeUmyS55T7czwCmhMuglLHN/1oniM/DHTT/DnclCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728539308; c=relaxed/simple;
	bh=Vgmg8a6K8iVpjllsRYvZXr5hm6ZiY+oZFMBddg6YNeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rnXv0FUyuz5e7DzCN+WVgXhp2fLfycTHatirTEibm5UyFkSOyO6cjmcs3FLXEFUxvYoyuWFMRSCPWi5DYh1sdWvFK5xOi8LIettlMszKT9lWDYoUQcLGSUWCixG2Dvn0HhoZ54Uf3Ea0773j55SGA7U+xr3OviKO13Ddec+kKfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhKXkpKe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhKXkpKe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7FB8C4CEC5;
	Thu, 10 Oct 2024 05:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728539306;
	bh=Vgmg8a6K8iVpjllsRYvZXr5hm6ZiY+oZFMBddg6YNeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UhKXkpKeGee/WnuY3ehN0ObVgGVBVl2sH2lmJkQbsbXoVEqhbqYo0ZshtJlXOHvhJ
	 Um++u/zrg5iPkE4ysJ5BVMNJc604GjzZ/N8ONhBN04GdFw7UUz7bM/9d2ZMZcGLKsQ
	 O3RLnxjneHlwCKkgtTrcLIvJy/E/lviilBc5MDCxPu7U6FzBT6Pmvn1PxWraI8nM5H
	 Ps+1tCmkrrWjDY0e9OJ19eMMdzutXrNl7H8n+9xZ9Xs+DBjiZ4ZSUAUv4MZOKIgieL
	 X6SLfS4uLwf2x8m9I/Cd1Nuvxl+pvrKoCQcLLFfg0nYNdAVsdndOnvo0xZtL1vKZeY
	 8tztw8mLHjefQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 11/15] mptcp: hold pm lock when deleting entry
Date: Thu, 10 Oct 2024 13:47:56 +0800
Message-ID: <1de80bc1c399d9ff66cd66dd7e490772e8f4ebfc.1728538976.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728538975.git.tanggeliang@kylinos.cn>
References: <cover.1728538975.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

When traversing userspace_pm_local_addr_list and deleting an entry from
it in mptcp_pm_nl_remove_doit(), msk->pm.lock should be held.

Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 50b1aea7a719..05ad0d17ea81 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -310,14 +310,17 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	lock_sock(sk);
 
+	spin_lock_bh(&msk->pm.lock);
 	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id_val);
 	if (!match) {
 		GENL_SET_ERR_MSG(info, "address with specified id not found");
+		spin_unlock_bh(&msk->pm.lock);
 		release_sock(sk);
 		goto out;
 	}
 
 	list_move(&match->list, &free_list);
+	spin_unlock_bh(&msk->pm.lock);
 
 	mptcp_pm_remove_addrs(msk, &free_list);
 
-- 
2.43.0


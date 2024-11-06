Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B406190468
	for <mptcp@lists.linux.dev>; Wed,  6 Nov 2024 03:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730864617; cv=none; b=hYRRjjJRMj4x51HtxmmARmFyA8AlM/S/CtsvdMXHawgAixMyiQQqid0+9LZdv+PxI6dOySt3n2QrSdoqWf+Klg9/C/q/tS7ZVEhgfu0Mh+FNLrvbCizLGR+hCO9Gcxbn5mW3MJVIlz3zeXGamvXxyIYtNyjr37jWGzZMnimZZ1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730864617; c=relaxed/simple;
	bh=yvLMk9KcAMuec6YD64hAg1REJJFI0rivAp8JZLpHvEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AsUA33DJGAqr/BUVYfscmwFJxisVKJIPOuTCjhUgAN50tqxLLyyYhMH2JLaXK7X+VFsML6BCRArWKzowS2GHuVKcFQNAkMJxK8iiRxLZAZjqzgqf2W5JmfRhNAcucIszdJNUj/qSZSWkJl0odadYu8db5dgZh8c01Kf99/mF8W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UN9BCkt5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UN9BCkt5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A85C4CECD;
	Wed,  6 Nov 2024 03:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730864617;
	bh=yvLMk9KcAMuec6YD64hAg1REJJFI0rivAp8JZLpHvEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UN9BCkt5CPyT8o3H6Q7KAH6/3ftAth8DDCUFJthctO08v2MaHyS+eQbiSZCiczbjv
	 LWiToOAFaopCnCYw7D+iWhLUlAEd0rg+Nnqqx7TIKj2F64HFhE1N+5t2stfPX76vVQ
	 jmItbh6qHgIviyM/w+gDBS13Lm3XhD6W/CGZW6cIKw6YZApj/EVXjlUq8+JndaJ29s
	 cbdvenSBc+l4NxXF2RIXG1Rm3japhMWJkperSCoopfdxOt8HD+YRfxGEsHgbQXwQXR
	 h4x87Td34cHREP3BtXxlGefJNV5+/c/eDWRuDqzPXMvw6PIAUB+jtSs5BSN/MqjuHj
	 FyYQHmDId8fzw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net v2 2/2] mptcp: hold pm lock when deleting entry
Date: Wed,  6 Nov 2024 11:43:24 +0800
Message-ID: <b5369cd4835c40f340d4817b9af294319a328469.1730864444.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1730864444.git.tanggeliang@kylinos.cn>
References: <cover.1730864444.git.tanggeliang@kylinos.cn>
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

This patch holds this lock before mptcp_userspace_pm_lookup_addr_by_id()
and releases it after list_move() in mptcp_pm_nl_remove_doit().

Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 3f888bfe1462..e35178f5205f 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -308,14 +308,17 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
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
2.45.2


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7D4161302
	for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 09:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588522; cv=none; b=aZ5bYSaA3c7oYIdcHnid/ss40X5SMHRn118QJZ5tbOpEmXmY1dz52ZtKDBlPDtAd/feo5jEqpcCR8NzRLGYsM6lT/+FdrNmcmQsueeYSQpYt0zguGYpkVcxQEB0msBIxcVmFvJBxrp5XalNy7shS3VjmI/FoLe5+2v92UkC+kig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588522; c=relaxed/simple;
	bh=TrO3hZdUM1LRJu1284LtEC2Bzf6jQydLeF7xIrndI6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NmV/VdYRwHTF+N9SE+u5So/BzCmqDACUWwAOJ7bhYiELAOjanftEg5vueDUrUQaliqwgAM332nwMMwe75D5MarbnP2d4XbPqW59yijz4OEtgULiiFio3hBd9vLda8ZL7ijEEzM+4ZlhkbzQmLOmnO7HoGrM6nFrRakl5vkdnXsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nb1AJ8CQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nb1AJ8CQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C37C4CEC3;
	Tue, 22 Oct 2024 09:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729588521;
	bh=TrO3hZdUM1LRJu1284LtEC2Bzf6jQydLeF7xIrndI6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nb1AJ8CQBbQh5keS6XBOC+kiWYWchwOJJZbVy1lEkTEA3pAhg3nj9otKAWT4vcQgm
	 lEA4Cl2xEmu5EOaY8GHydifudkhbqrYsV087zkABp7sIlBw7Bn8DrOGKl7LnXdsM+g
	 nO4zJORzixZYBEyyTbIDidsDMuvzhvwyeIA5GJZFIooOQ4W69avUa+ZpVoRiX8xjFG
	 hIgxUvI5jGMM6aG6boIYa7DQw4DTJ4Fz6MugJthwAZ70rqQJghRkEfErWMOsOlQAxw
	 DBMq1rsdCUhutgpCiKkhn3tC6xq3/8r1hztewROvY1vineyNiBk3Bv5nnoQ9fcMbhc
	 tzUwczM+on0Tw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 18/36] mptcp: change rem type of set_flags
Date: Tue, 22 Oct 2024 17:14:26 +0800
Message-ID: <2cb23f8a0ef052f9e37c2199982ec749e33e7e47.1729588019.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1729588019.git.tanggeliang@kylinos.cn>
References: <cover.1729588019.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Generally, in the path manager interfaces, the local address is defined as
an mptcp_pm_addr_entry type address, while the remote address is defined as
an mptcp_addr_info type one:

	(struct mptcp_pm_addr_entry *local, struct mptcp_addr_info *remote)

But the set_flags() interface uses two mptcp_pm_addr_entry type parameters.
This patch changes the second one to mptcp_addr_info type and use helper
mptcp_pm_parse_addr() to parse it instead of using mptcp_pm_parse_entry().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index ec2ac0f9c8f5..b83f4af632b5 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -540,9 +540,9 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry loc = { .addr = { .family = AF_UNSPEC }, };
-	struct mptcp_pm_addr_entry rem = { .addr = { .family = AF_UNSPEC }, };
 	struct nlattr *attr_rem = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
+	struct mptcp_addr_info rem = { .family = AF_UNSPEC, };
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
 	int ret = -EINVAL;
@@ -560,13 +560,13 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 		goto set_flags_err;
 
 	if (attr_rem) {
-		ret = mptcp_pm_parse_entry(attr_rem, info, false, &rem);
+		ret = mptcp_pm_parse_addr(attr_rem, info, &rem);
 		if (ret < 0)
 			goto set_flags_err;
 	}
 
 	if (loc.addr.family == AF_UNSPEC ||
-	    rem.addr.family == AF_UNSPEC) {
+	    rem.family == AF_UNSPEC) {
 		GENL_SET_ERR_MSG(info, "invalid address families");
 		ret = -EINVAL;
 		goto set_flags_err;
@@ -586,7 +586,7 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 	spin_unlock_bh(&msk->pm.lock);
 
 	lock_sock(sk);
-	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc.addr, &rem.addr, bkup);
+	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc.addr, &rem, bkup);
 	release_sock(sk);
 
 set_flags_err:
-- 
2.45.2


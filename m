Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C69613B2A9
	for <mptcp@lists.linux.dev>; Fri, 17 Jan 2025 23:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737156416; cv=none; b=stI5QlAQaErBZoiECHD0tje/6/d6vboNErbaYIlR/UBRoiaYzuP6/xArFAOQZs/rv5cyaAdHobhqU2Oloekjt33QKqxWUFdNHHT1dkbWWDdvK9/0FaEuyJzvKheNgpnoW1dK45cJY0eL2XU4ME65PVmnOPdOOHeQF9srVIZkrEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737156416; c=relaxed/simple;
	bh=lMmH/1tOPE3CcxngxSpgBhxFJcqWSG+eiNTqoh6zEX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mGWKi+YEHOwCWevgel8/IINlI45scCIyw2LSRB8rBN26orPlC+43nP1hrBNAYOcnSjkVYXjmb4a2Cb5+T9Dr2PdW1QW6wNKZSm9XsvMoruNgWVWWLmMjVJr7OE7qCVvFyYiZjzcxLJ+zIVQ4Pf00zJ/PdHX1KGw6thRa+GNWYrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AiHuuzvn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AiHuuzvn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADCBDC4CEDD;
	Fri, 17 Jan 2025 23:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737156415;
	bh=lMmH/1tOPE3CcxngxSpgBhxFJcqWSG+eiNTqoh6zEX0=;
	h=From:To:Cc:Subject:Date:From;
	b=AiHuuzvn9TfXTHcr3tvvBhB7LbinIwR0NROBIMWs7Ze4V7lJCAi0AbmfGmGThOha1
	 RExBH5lpoUkSCBVojOCWesWxQ/zOIV7qfpPnax7U9FwpIaIKd5qXwWEb1auDISazOE
	 EYjgTgr5QsnqB7gDmTRO0eKQtfqtOV0orjZMyJ7a+JcHpz71/tmRqlRHKM9dKQXdFb
	 efxw25gs2sl4FKLCSU126a+SoBaS9Tpz/+7q+bhlY1wKOCAlmfdqF4Xp5GagpXHzpe
	 w9EERRObwDs26cMvRGe5FwbXfeJNY4aeasIGeb0ZKDQMM8gi+pu6BNV5dgy+Bk9TeM
	 OIOI5G/+I2QkA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next] Squash to "mptcp: pm: add id parameter for get_addr"
Date: Sat, 18 Jan 2025 07:26:09 +0800
Message-ID: <625cc0fceb9d347ed6a029396a8d202cbb24d2c4.1737156352.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

No need to drop 'attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];' in
mptcp_userspace_pm_get_addr() too, add it back.

Alse update mptcp_pm_nl_get_addr() to keep the original two-line
assignment of 'attr'.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c   | 4 +++-
 net/mptcp/pm_userspace.c | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index f7da750ab94f..b3d32f43a5a1 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1775,13 +1775,15 @@ int mptcp_nl_fill_addr(struct sk_buff *skb,
 
 int mptcp_pm_nl_get_addr(u8 id, struct genl_info *info)
 {
-	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
 	struct mptcp_pm_addr_entry *entry;
 	struct sk_buff *msg;
+	struct nlattr *attr;
 	void *reply;
 	int ret;
 
+	attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
+
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!msg)
 		return -ENOMEM;
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 79e2d12e0888..e005d5302e1c 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -700,6 +700,8 @@ int mptcp_userspace_pm_get_addr(u8 id, struct genl_info *info)
 
 	sk = (struct sock *)msk;
 
+	attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
+
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!msg) {
 		ret = -ENOMEM;
-- 
2.45.2


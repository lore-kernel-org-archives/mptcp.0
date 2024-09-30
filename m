Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D0B5464B
	for <mptcp@lists.linux.dev>; Mon, 30 Sep 2024 09:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727689515; cv=none; b=DljmpL+Wc2BSvFYVXt15P6ObEJ3lTZ5LunYjukKJIrRIXu9kv6xCj2PvCnlCi6qKjlIrMHqWzfMbGI8s6tYEuhd4C+2uE4oA6twHoXoiUxuOliOB/NXA5Kp3T82DwO+4TJpQsMefUvYsN8f3xYP8kMOyn28CXB+6uBTalZPKqvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727689515; c=relaxed/simple;
	bh=OScfSMpWwzSstn+h6M1iHWK9BPdMbz78Gq4Jb84ji7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eQHuOiBVXmt9eFWVnzhZuthq0oZ9tSU/GKWxwRmKxlJVkv3mExwH1C5k3wveL7xQEViuPVUf2k2GGRw0pFBLVH2cmdaz2Ps5i+M3/kjj9X9kICfSOD5UFuvm2a5zK2ytUQK1w5z+YQERKP2Kq2TkEoGZFsDS1DspLi7GnHTio+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/iHzaEv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/iHzaEv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBBCFC4CEC7;
	Mon, 30 Sep 2024 09:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727689514;
	bh=OScfSMpWwzSstn+h6M1iHWK9BPdMbz78Gq4Jb84ji7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m/iHzaEvJ48rIUxIsyMILOBuNacxe9KaIUhqWjBnAcipYFjU7tKyChUXOU5Dz0SDg
	 h+QM0EeryydJ8M6WY8d8D+Xw5fhC+X/yfAJJXxMoQ6Lvp5gdwe5usJHIyNGoW7Fz4J
	 fpmKKiG8/ZNKOtV+qVpwDntqGGtS9SutWfhtpXaiFUCE8Rf0fdOFr5rHMxpYoAm1le
	 U1eNtvZ3hbtKPKFPePLc1AN0ZkeZbUCGAeGKrLVmTj6/PeTF6ng46kf6EYdR10jpPP
	 6WnfksDb877XVyzOBu03QRonlYko+hr3pYw961SGhxAL6eAY4V3+44/9yU7g+YoobY
	 dRGbANxPGBwDg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 4/7] mptcp: change info of get_addr as const
Date: Mon, 30 Sep 2024 17:44:59 +0800
Message-ID: <50d8817698e3063629c509178e6451548caa36eb.1727689369.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727689369.git.tanggeliang@kylinos.cn>
References: <cover.1727689369.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

get_addr() interfece will be invoked by dump_addr(), which using a const
parameter "info", so this patch change "info" parameter of get_addr() as
const too.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c   | 9 ++++++---
 net/mptcp/pm_userspace.c | 2 +-
 net/mptcp/protocol.h     | 2 +-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ef47b54d8328..dc87f9ee9000 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1791,12 +1791,15 @@ int mptcp_nl_fill_addr(struct sk_buff *skb,
 }
 
 static int mptcp_pm_nl_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
-				struct genl_info *info)
+				const struct genl_info *info)
 {
-	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
+	struct net *net = genl_info_net(info);
 	struct mptcp_pm_addr_entry *entry;
+	struct pm_nl_pernet *pernet;
 	int ret = -EINVAL;
 
+	pernet = pm_nl_get_pernet(net);
+
 	spin_lock_bh(&pernet->lock);
 	entry = __lookup_addr_by_id(pernet, id);
 	if (entry) {
@@ -1809,7 +1812,7 @@ static int mptcp_pm_nl_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 }
 
 static int mptcp_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
-			     struct genl_info *info)
+			     const struct genl_info *info)
 {
 	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
 		return mptcp_userspace_pm_get_addr(id, addr, info);
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 7c0bb084303b..95c7cb56e9b4 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -669,7 +669,7 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 }
 
 int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
-				struct genl_info *info)
+				const struct genl_info *info)
 {
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct net *net = genl_info_net(info);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4342be369914..be2028ffebde 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1128,7 +1128,7 @@ bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 				 struct netlink_callback *cb);
 int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
-				struct genl_info *info);
+				const struct genl_info *info);
 
 static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflow)
 {
-- 
2.43.0


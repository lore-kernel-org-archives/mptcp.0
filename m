Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C54218FDB7
	for <mptcp@lists.linux.dev>; Tue,  8 Oct 2024 09:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728381513; cv=none; b=Ep19x/zE1+7IGE7imvVYb/P3GzKUQOIdWVTKOaX5TaHXZXVLLZmj2roY8j3LWFe4TqUt0egHZS0PwApJ0hzXqu5olIZ7E9eyUkK3c/DiEP7mPB6kCNEaCix44XH0Wh+7bzGmBBUK7hf3LVi/jLuLyQ9V4I+YTaWJghBfatXLcV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728381513; c=relaxed/simple;
	bh=aHhY2tExyzXjbYpYfo1acXjacscqUnDaJUAFmLZfAHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C/qQRMn7yAKidHzfmNNtXKDFnQHezPcPg/n9w0l5Q7Lar4PHhVLBIJywePxxStBGMzKm3vyCCnUHgyD9KGG84zEuEKkcNVGRFkn/SOnntDrrMp1S/0CgrwmaOeDsJldUjE6V2pIfosiPj9jYX2TR2JCAGWSDzxOuu2rNwfzzeCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vl+4A1Tc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vl+4A1Tc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F787C4CECC;
	Tue,  8 Oct 2024 09:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728381512;
	bh=aHhY2tExyzXjbYpYfo1acXjacscqUnDaJUAFmLZfAHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vl+4A1TcD3SHV2miilW4OyrQM+E8clMvSC+V8mknwJ2yCBxarHO/VfJa8rcHufrVu
	 cfoqOjQqPRVZdLroiVniPltI8d8uCSsHECsScrHeVrEoZbWkDJDGEn/sJd31Saen7/
	 14JfyIGBdW4kb7+bg8yWYvm+nopsCazjKxekHUdyCoF0Ws9yawsF+QlQ/jNfzxdSry
	 9GOlMaMcyE1LxfII+l8CMKXfv5PQkAI/a5oQNXgdoFbsgdzPNhQLVTdTQM7+Uqg05f
	 JozSpRMLKqV9Zggf4ORmJqBnubu96EBCLuvLRe/9mFmZ5DxQs4LWC+zsaw3KDhhzmY
	 DZWcl/LgysaQA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 04/13] mptcp: change info of get_addr as const
Date: Tue,  8 Oct 2024 17:58:08 +0800
Message-ID: <dafdde3b34b08faee48b399412067b8945706db5.1728381245.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728381245.git.tanggeliang@kylinos.cn>
References: <cover.1728381245.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

get_addr() interfeces will be invoked by dump_addr(), which using const
parameters "info", so this patch changes "info" parameters of get_addr()
as const too.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c   | 9 ++++++---
 net/mptcp/pm_userspace.c | 2 +-
 net/mptcp/protocol.h     | 2 +-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 8bc38a4cd278..2ab966393c55 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1792,12 +1792,15 @@ int mptcp_nl_fill_addr(struct sk_buff *skb,
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
@@ -1810,7 +1813,7 @@ static int mptcp_pm_nl_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 }
 
 static int mptcp_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
-			     struct genl_info *info)
+			     const struct genl_info *info)
 {
 	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
 		return mptcp_userspace_pm_get_addr(id, addr, info);
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 4c4693c5aae9..373ff0186bee 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -630,7 +630,7 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 }
 
 int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
-				struct genl_info *info)
+				const struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
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


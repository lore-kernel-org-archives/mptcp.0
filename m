Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E07960244
	for <mptcp@lists.linux.dev>; Tue, 20 Feb 2024 09:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708423130; cv=none; b=acLKwMVtFeya2EA/JKE8AD0c76R1FPA5z3lECxhEDo3nOQ1KsLQvQlYWr+iZg6YnQ6ekfEPJ6jbtNey5gKvPUF8mop4INOSXJmTVUA7dpfPPRh/gOhyVxI809ieWvJFW5jasMzLtnj3Qbu1ObD+N+JusMKczJoGoeBiv4yrhxZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708423130; c=relaxed/simple;
	bh=Lh485gU/pRHBpb0ApxIFt936Y85aPsD6BUnfHhSMqqA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ej39tE4w5aRwMAjaRp/seaKFGkDJzNcx17e1BbHfTX64eSRCGMoj3jM0mWkJdr8czoPpYXxdQPsGOM3vtuMEEGqKzfuLrcwezP3CKGgCjQjJ8iFFuTRE5E4PnvJeM78MBHFKvWfpSWjcH2fHuiWaRZhAsbAYfrB27PbVufaae/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUTynqZz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUTynqZz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15D5C433C7;
	Tue, 20 Feb 2024 09:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708423129;
	bh=Lh485gU/pRHBpb0ApxIFt936Y85aPsD6BUnfHhSMqqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QUTynqZz0N5WyxiRlM7LO9oUJAryIvEHzLrh54WwD2DxaBg06Y/ViOBv9FMzW0NQ2
	 r7wDGG/nhC6wvdoTeAC6d8sjF5RBJDjU9G6DIdUYJfsvMYMokqSJ0YeXdAYoam23vG
	 4Wlsw3cn3qapMP+ZCLC/3NIirKKB7L/nx2yHOVCzHxOF0aM3qQV5VAyiZxv1lhbW9E
	 IDcWbARG44oDLpNb7QE8rNvWgKKKMjIgXWUe3/rNl6ATU/vmAPsl0lmnm84P8Vpawn
	 1KIInFeeOVWd+a//HjMIjVgSHPlHG2aimpsk6TPHelwQGAy+8MI1di/m7RY/whAwhY
	 iFCjZDnvb/J2w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v14 12/14] mptcp: get addr in userspace pm list
Date: Tue, 20 Feb 2024 17:58:26 +0800
Message-Id: <6f72a269e2aec84329be171db9464bf12736fc63.1708422758.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708422758.git.tanggeliang@kylinos.cn>
References: <cover.1708422758.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch renames mptcp_pm_nl_get_addr_doit() as a dedicated in-kernel
netlink PM get addr function mptcp_pm_nl_get_addr(). and invoke a new
wrapper mptcp_pm_get_addr() in mptcp_pm_nl_get_addr_doit.

If a token is gotten in the wrapper, that means a userspace PM is used.
So invoke mptcp_userspace_pm_get_addr() to get addr in userspace PM list.
Otherwise, invoke mptcp_pm_nl_get_addr().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c         | 7 +++++++
 net/mptcp/pm_netlink.c | 7 ++++++-
 net/mptcp/protocol.h   | 2 ++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 193198cec74a..b4bdd92a5648 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -441,6 +441,13 @@ int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id
 	return mptcp_pm_nl_get_flags_and_ifindex_by_id(msk, id, flags, ifindex);
 }
 
+int mptcp_pm_get_addr(struct sk_buff *skb, struct genl_info *info)
+{
+	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
+		return mptcp_userspace_pm_get_addr(skb, info);
+	return mptcp_pm_nl_get_addr(skb, info);
+}
+
 int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb)
 {
 	const struct genl_info *info = genl_info_dump(cb);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 7b15bb4f12c1..f04e354b0c64 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1672,7 +1672,7 @@ int mptcp_nl_fill_addr(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
-int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
+int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
@@ -1722,6 +1722,11 @@ int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
+int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return mptcp_pm_get_addr(skb, info);
+}
+
 int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 			  struct netlink_callback *cb)
 {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a4fa66c14f7f..d611968ae6a4 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1076,6 +1076,8 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 			  struct netlink_callback *cb);
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 				 struct netlink_callback *cb);
+int mptcp_pm_get_addr(struct sk_buff *skb, struct genl_info *info);
+int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info);
 int mptcp_userspace_pm_get_addr(struct sk_buff *skb,
 				struct genl_info *info);
 
-- 
2.40.1


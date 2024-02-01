Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE7E3A8D2
	for <mptcp@lists.linux.dev>; Thu,  1 Feb 2024 05:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706764757; cv=none; b=J9uHNPgRLCrYsSjh0vfmm4zjwCMa6DJYRXtTgsMpev3nAzIIEdUYQMBfl37TTJeNDU0lDeMMhc7AbvQKR8esIkmGeiRTbyVn251LkVEJxwYke4tuGQJ81J/0GJAsnM7DTrLD6quZ3/lj/Ca4fwH1dOVCcfx8aYdvpR4iUwaAVvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706764757; c=relaxed/simple;
	bh=aZ7hkh0awxFpyFz4tZITiwTCKprCqkdXtReB0vIBLZg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fNzhMGVfGwmWACGPBAQVGe84oGyO3xFP+mihtCFdtTQAYisGPG/tLS4wQ1rFKnyv4dqgohsEY83NJqo3qO5dCYhqnH3LySx2JDEXXICyt4Nh1vCYaBfnCEd2OwhNjnIqXiN5OS5vEe4CIkttwtHkPI5MPV8dfhHpWCLBWkMibgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qic7RpEm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qic7RpEm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A00C433F1;
	Thu,  1 Feb 2024 05:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706764756;
	bh=aZ7hkh0awxFpyFz4tZITiwTCKprCqkdXtReB0vIBLZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qic7RpEmxGDwh+2qHCdJ2Clyr+bCO1QBZds1sCyZ5fRxnG+vKd4ttf2YLt2a3UtO1
	 aJNFzZbVrKq1gqkLJTvLkl6KguqjxSxwCzR1cNbe8hTvJLxt69JEUPUpkBcr2LdRlP
	 F2G6/ekvs4181rF73nnxPdsOue4T69W2s6xcRSmezOVUBs5Ah7OwXzSKAEnGdCxC9p
	 Uqw7/E33EjItih3jOsYgh+vLGaltNsKlO5mU11pb4pk4N24h6td5yIOpPX1aU4U5pS
	 yySf7cT3AFzkm++eX2fyV8ce5iLXDE+DeTKzWwwZmm3ENJjeo9WGNZWYzv7WxFo3Dc
	 bceJk4KeOmsAw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 03/15] mptcp: add token for get-addr in yaml
Date: Thu,  1 Feb 2024 13:18:53 +0800
Message-Id: <7d83b7cd1a83491f4dbe842f5cf2b73b7b60d15b.1706764519.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1706764519.git.tanggeliang@kylinos.cn>
References: <cover.1706764519.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds token paramenter together with addr in get-addr section in
mptcp_pm.yaml, then use the following commands to update mptcp_pm_gen.c
and mptcp_pm_gen.h:

./tools/net/ynl/ynl-gen-c.py --mode kernel \
        --spec Documentation/netlink/specs/mptcp_pm.yaml --source \
        -o net/mptcp/mptcp_pm_gen.c
./tools/net/ynl/ynl-gen-c.py --mode kernel \
        --spec Documentation/netlink/specs/mptcp_pm.yaml --header \
        -o net/mptcp/mptcp_pm_gen.h

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 Documentation/netlink/specs/mptcp_pm.yaml | 3 ++-
 net/mptcp/mptcp_pm_gen.c                  | 7 ++++---
 net/mptcp/mptcp_pm_gen.h                  | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
index 49f90cfb4698..af525ed29792 100644
--- a/Documentation/netlink/specs/mptcp_pm.yaml
+++ b/Documentation/netlink/specs/mptcp_pm.yaml
@@ -292,13 +292,14 @@ operations:
     -
       name: get-addr
       doc: Get endpoint information
-      attribute-set: endpoint
+      attribute-set: attr
       dont-validate: [ strict ]
       flags: [ uns-admin-perm ]
       do: &get-addr-attrs
         request:
           attributes:
            - addr
+           - token
         reply:
           attributes:
            - addr
diff --git a/net/mptcp/mptcp_pm_gen.c b/net/mptcp/mptcp_pm_gen.c
index 670da7822e6c..c30a2a90a192 100644
--- a/net/mptcp/mptcp_pm_gen.c
+++ b/net/mptcp/mptcp_pm_gen.c
@@ -32,8 +32,9 @@ const struct nla_policy mptcp_pm_del_addr_nl_policy[MPTCP_PM_ENDPOINT_ADDR + 1]
 };
 
 /* MPTCP_PM_CMD_GET_ADDR - do */
-const struct nla_policy mptcp_pm_get_addr_nl_policy[MPTCP_PM_ENDPOINT_ADDR + 1] = {
-	[MPTCP_PM_ENDPOINT_ADDR] = NLA_POLICY_NESTED(mptcp_pm_address_nl_policy),
+const struct nla_policy mptcp_pm_get_addr_nl_policy[MPTCP_PM_ATTR_TOKEN + 1] = {
+	[MPTCP_PM_ATTR_ADDR] = NLA_POLICY_NESTED(mptcp_pm_address_nl_policy),
+	[MPTCP_PM_ATTR_TOKEN] = { .type = NLA_U32, },
 };
 
 /* MPTCP_PM_CMD_FLUSH_ADDRS - do */
@@ -110,7 +111,7 @@ const struct genl_ops mptcp_pm_nl_ops[11] = {
 		.doit		= mptcp_pm_nl_get_addr_doit,
 		.dumpit		= mptcp_pm_nl_get_addr_dumpit,
 		.policy		= mptcp_pm_get_addr_nl_policy,
-		.maxattr	= MPTCP_PM_ENDPOINT_ADDR,
+		.maxattr	= MPTCP_PM_ATTR_TOKEN,
 		.flags		= GENL_UNS_ADMIN_PERM,
 	},
 	{
diff --git a/net/mptcp/mptcp_pm_gen.h b/net/mptcp/mptcp_pm_gen.h
index ac9fc7225b6a..e24258f6f819 100644
--- a/net/mptcp/mptcp_pm_gen.h
+++ b/net/mptcp/mptcp_pm_gen.h
@@ -18,7 +18,7 @@ extern const struct nla_policy mptcp_pm_add_addr_nl_policy[MPTCP_PM_ENDPOINT_ADD
 
 extern const struct nla_policy mptcp_pm_del_addr_nl_policy[MPTCP_PM_ENDPOINT_ADDR + 1];
 
-extern const struct nla_policy mptcp_pm_get_addr_nl_policy[MPTCP_PM_ENDPOINT_ADDR + 1];
+extern const struct nla_policy mptcp_pm_get_addr_nl_policy[MPTCP_PM_ATTR_TOKEN + 1];
 
 extern const struct nla_policy mptcp_pm_flush_addrs_nl_policy[MPTCP_PM_ENDPOINT_ADDR + 1];
 
-- 
2.40.1


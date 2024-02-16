Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5002179B2
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 07:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708069349; cv=none; b=DNywUozXd2DorimoQbN3yrHj+motW5XlOvcO5wlwH6kOcNZ4b/03OaHOOO+HlSQUVcE/vMPWBsjNaSBygdzbp6YPjP30fdDYfltPTz/Ztv+2zq/9NzQdXqmcltdJqtsmmZMsvYP8rphupjN7Cs6EX30Jggb7ZxlML8sti45b3X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708069349; c=relaxed/simple;
	bh=WXNJVLSDil1/0p973BkNOj6TasTWBdJpcU4wNM08Ar8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OiMTngNIAPnqhHDUUJbYwmpbhSaVHXgDOwiTO0hF1/uGzCOoRsyHUq+TAeWFMiwcVfFn2jYAeonnzY645do2uaZPOx+rQx0+0W9HczcFJLwb/r0Npx2T4NoeIwTvM5CQtYg9PwzVKT5Mic/nEt4LQ+Fk4azKuJQoa0zVb7yUwVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XzSuWyLp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XzSuWyLp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A21BBC433F1;
	Fri, 16 Feb 2024 07:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708069348;
	bh=WXNJVLSDil1/0p973BkNOj6TasTWBdJpcU4wNM08Ar8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XzSuWyLpngcOTaDR5cBRGDZifeWlE7SXff0Bopt2R/mz9Ssq0eN22bykBJxQacTTx
	 FXEL24xUx/R2sr0HUIqSE0krOgzZnHFly8xNzDznShYqUcQmSriQYOC8goqW+pYRIW
	 a0iejNp6EywfFY1qzeuhv4DBLVPqhdjoZkLGPpCYXSKR8QTjlVhwrm6f0gkguklaFP
	 8iAUW5/BRATua+eOGaFxCE3N1YgXE9R5N4bOyAPydpIcvDYwv+XcQ7XfLO6a1Bcq6J
	 Aj7KuOMYtnn3D4h9AKy6SjjaQ4uuVz6Njw3xafoOA4vuM7Ky0jiTGH22Iu96kyorQZ
	 YVhIDjWgi2vEQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v13 03/14] mptcp: add token for get-addr in yaml
Date: Fri, 16 Feb 2024 15:42:05 +0800
Message-Id: <19464bdd7ef79bab1b7c747d247060e9a63584c9.1708069036.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708069036.git.tanggeliang@kylinos.cn>
References: <cover.1708069036.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds token parameter together with addr in get-addr section in
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


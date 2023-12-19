Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA31318EB4
	for <mptcp@lists.linux.dev>; Tue, 19 Dec 2023 13:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E4Yhhcm+"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702992718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HyKUE8AsP03b+/TCotX/V8AVBsVsQ7AjbvK0Om7ZZ2k=;
	b=E4Yhhcm+jo3U0UR3DUPzk79Po4Hc8fNVrbij/FSuyaLF///KkqrnH3nLX0gj+ab6gk/e0s
	YNz7n0uRhxVRuBvd5wTtdTvTK1Bt6RcZX8kj9fYzT1x98daR66e21aVr2B5sDI/C8cUcHp
	33deFWc74Tvx/s+gEhFUdY86bEWQDys=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v4 05/14] mptcp: add token for get-addr in yaml
Date: Tue, 19 Dec 2023 21:32:09 +0800
Message-Id: <0a9dad2c2aafd1688760d1ee5d02da08476f90b5.1702992525.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1702992525.git.geliang.tang@linux.dev>
References: <cover.1702992525.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch adds token paramenter together with addr in get-addr section
in mptcp.yaml, then use the following commands to update mptcp_pm_gen.c
and mptcp_pm_gen.h:

./tools/net/ynl/ynl-gen-c.py --mode kernel \
        --spec Documentation/netlink/specs/mptcp.yaml --source \
        -o net/mptcp/mptcp_pm_gen.c
./tools/net/ynl/ynl-gen-c.py --mode kernel \
        --spec Documentation/netlink/specs/mptcp.yaml --header \
        -o net/mptcp/mptcp_pm_gen.h

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 Documentation/netlink/specs/mptcp_pm.yaml | 5 ++++-
 net/mptcp/mptcp_pm_gen.c                  | 7 ++++---
 net/mptcp/mptcp_pm_gen.h                  | 2 +-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
index 49f90cfb4698..cc731dbaa427 100644
--- a/Documentation/netlink/specs/mptcp_pm.yaml
+++ b/Documentation/netlink/specs/mptcp_pm.yaml
@@ -292,20 +292,23 @@ operations:
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
+           - token
       dump:
         reply:
          attributes:
            - addr
+           - token
     -
       name:  flush-addrs
       doc: flush addresses
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
2.35.3


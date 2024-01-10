Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4764487BD
	for <mptcp@lists.linux.dev>; Wed, 10 Jan 2024 13:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fIiDfzCT"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704892786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cmm/PJrscQMyVtD8CoypjiP9pFomkB6JhkJatXGztPE=;
	b=fIiDfzCTlGtvd5AsSt7t0evJio4tpDR7Qc4vf+hTBlkrxQ9hhzwbBzp6oFAedtb+poTCbN
	2JsQVTfgoetN8pSxNWUeKYKkIY1JkI8RWVVmJuiZN61P3+mDTdeZSqVBlL8HDXpjQReEhM
	5if/hg4+2nfkkfo0WXYhyzoga2FUf4k=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v8 01/23] mptcp: add mptcp_pm_parse_needs_id helper
Date: Wed, 10 Jan 2024 21:19:09 +0800
Message-Id: <0cdb985ddf5d566693b9a372b7eea61611f04cf5.1704892316.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1704892316.git.geliang.tang@linux.dev>
References: <cover.1704892316.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch adds a new helper mptcp_pm_parse_needs_id() to check whether
an address ID is set from PM or not. It will be used in the next two
commits.

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 net/mptcp/pm.c       | 17 +++++++++++++++++
 net/mptcp/protocol.h |  2 ++
 2 files changed, 19 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 4ae19113b8eb..e16312fde6fb 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -533,6 +533,23 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
 	bitmap_fill(msk->pm.id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 }
 
+bool mptcp_pm_parse_needs_id(const struct nlattr *attr,
+			     struct genl_info *info)
+{
+	struct nlattr *tb[MPTCP_PM_ADDR_ATTR_MAX + 1];
+	int err;
+
+	if (attr) {
+		/* no validation needed - was already done via nested policy */
+		err = nla_parse_nested_deprecated(tb, MPTCP_PM_ADDR_ATTR_MAX, attr,
+						  mptcp_pm_address_nl_policy, info->extack);
+		if (!err && tb[MPTCP_PM_ADDR_ATTR_ID])
+			return false;
+	}
+
+	return true;
+}
+
 void mptcp_pm_data_init(struct mptcp_sock *msk)
 {
 	spin_lock_init(&msk->pm.lock);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f7b9c1b995df..63c6e6dbc867 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -886,6 +886,8 @@ int mptcp_pm_parse_addr(struct nlattr *attr, struct genl_info *info,
 int mptcp_pm_parse_entry(struct nlattr *attr, struct genl_info *info,
 			 bool require_family,
 			 struct mptcp_pm_addr_entry *entry);
+bool mptcp_pm_parse_needs_id(const struct nlattr *attr,
+			     struct genl_info *info);
 bool mptcp_pm_addr_families_match(const struct sock *sk,
 				  const struct mptcp_addr_info *loc,
 				  const struct mptcp_addr_info *rem);
-- 
2.40.1


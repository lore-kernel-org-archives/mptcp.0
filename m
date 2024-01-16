Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABB68495
	for <mptcp@lists.linux.dev>; Tue, 16 Jan 2024 03:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iF6wz0Tb"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705376131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4OODewU0DefaEHW5OGMbaDOQRjfjk/Aze8a5tLq2Fs4=;
	b=iF6wz0TblenL4uaiFAyQ1RqBcmrOm+JdSyUfPuTGEVF1/6a91YgyMRaITzfVpYAaU7ZzAV
	OaAHqQXt6OJIRhz/ntkBEjMeI5gVjx/T5EnlMp7OyYQRsJYAhKgzeXdeQT8NWXB0Q4BKsU
	071647adSfBcawCEiy9rLnXhdNK+kxc=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 01/23] mptcp: add pm_has_addr_attr_id helper
Date: Tue, 16 Jan 2024 11:34:49 +0800
Message-Id: <75a870baf775b146c7e074a64baed38f181352b9.1705375746.git.tanggeliang@kylinos.cn>
In-Reply-To: <cover.1705375746.git.tanggeliang@kylinos.cn>
References: <cover.1705375746.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new helper mptcp_pm_has_addr_attr_id() to check whether
an address ID is set from PM or not. It will be used in the next two
commits.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c       | 12 ++++++++++++
 net/mptcp/protocol.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 4ae19113b8eb..6856d10368be 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -533,6 +533,18 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
 	bitmap_fill(msk->pm.id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 }
 
+bool mptcp_pm_has_addr_attr_id(const struct nlattr *attr,
+			       struct genl_info *info)
+{
+	struct nlattr *tb[MPTCP_PM_ADDR_ATTR_MAX + 1];
+
+	if (!nla_parse_nested_deprecated(tb, MPTCP_PM_ADDR_ATTR_MAX, attr,
+					 mptcp_pm_address_nl_policy, info->extack) &&
+	    tb[MPTCP_PM_ADDR_ATTR_ID])
+		return true;
+	return false;
+}
+
 void mptcp_pm_data_init(struct mptcp_sock *msk)
 {
 	spin_lock_init(&msk->pm.lock);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f7b9c1b995df..def791ce751b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -886,6 +886,8 @@ int mptcp_pm_parse_addr(struct nlattr *attr, struct genl_info *info,
 int mptcp_pm_parse_entry(struct nlattr *attr, struct genl_info *info,
 			 bool require_family,
 			 struct mptcp_pm_addr_entry *entry);
+bool mptcp_pm_has_addr_attr_id(const struct nlattr *attr,
+			       struct genl_info *info);
 bool mptcp_pm_addr_families_match(const struct sock *sk,
 				  const struct mptcp_addr_info *loc,
 				  const struct mptcp_addr_info *rem);
-- 
2.40.1


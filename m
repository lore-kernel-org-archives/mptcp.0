Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63926FD0
	for <mptcp@lists.linux.dev>; Tue, 16 Jan 2024 03:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="umrc2lqH"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705376142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OSRVvO4ZE3CnVf7cYpIxqm24Uh+8V6lqKwQQc4NNFUo=;
	b=umrc2lqHuCsXiRvCuwzQr6GkJ8otJbPtwq9Nb/zd6GBK4n2h7liiLeIhwVL+mXZkp7KI8V
	wse6nfyPxci8n70kRxFOXB5ZjiKThaa2eAx2hK7Dyrfwn9pbclNvQqH43n5MvVyAqWEpG+
	CMOMH5olQxgzLpXGf7Yla7ZYqx8E6ug=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 10/23] mptcp: check userspace pm subflow flag
Date: Tue, 16 Jan 2024 11:34:58 +0800
Message-Id: <92c239facbce684eeb3ff559127702e6366f5228.1705375746.git.tanggeliang@kylinos.cn>
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

Just like MPTCP_PM_ADDR_FLAG_SIGNAL flag is checked in userspace PM
announce mptcp_pm_nl_announce_doit(), MPTCP_PM_ADDR_FLAG_SUBFLOW flag
should be checked in mptcp_pm_nl_subflow_create_doit() too.

If MPTCP_PM_ADDR_FLAG_SUBFLOW flag is not set, there's no flags field
in the output of dump_addr. This looks a bit strange:

	id 10 flags  10.0.3.2

This patch uses mptcp_pm_parse_entry() instead of mptcp_pm_parse_addr()
to get the flags of the entry. Add MPTCP_PM_ADDR_FLAG_SUBFLOW flag check
in mptcp_pm_nl_subflow_create_doit().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 45d974adf382..93e8b7cd4423 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -361,11 +361,18 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	err = mptcp_pm_parse_addr(laddr, info, &addr_l);
+	err = mptcp_pm_parse_entry(laddr, info, true, &local);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
 		goto create_err;
 	}
+	addr_l = local.addr;
+
+	if (!(local.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)) {
+		GENL_SET_ERR_MSG(info, "invalid addr flags");
+		err = -EINVAL;
+		goto create_err;
+	}
 
 	err = mptcp_pm_parse_addr(raddr, info, &addr_r);
 	if (err < 0) {
@@ -379,7 +386,6 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	local.addr = addr_l;
 	err = mptcp_userspace_pm_append_new_local_addr(msk, &local,
 						       !mptcp_pm_has_addr_attr_id(laddr, info));
 	if (err < 0) {
-- 
2.40.1


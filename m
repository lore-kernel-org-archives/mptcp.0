Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58422487BD
	for <mptcp@lists.linux.dev>; Wed, 10 Jan 2024 13:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UAOEW/SU"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704892795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K1+vjNf7BdT7DUc04m/NTmeqEnbHKzLnfi3G1aBT9AM=;
	b=UAOEW/SUUK0tK+nRXd0K+enzLT0EBArXJ69BAspnCdabr77HBEIl+F6S2UTluQaFwQxxbN
	rqcJmW6R+71EDTADj7rCCJMQ/c/1ztAv16fTQJz3R5HwjHS0L7pU7G9KIrhg6mJOXkr8NW
	AE9G+691WU8z6n0fYukcaWneikH7q4k=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v8 10/23] mptcp: check userspace pm subflow flag
Date: Wed, 10 Jan 2024 21:19:18 +0800
Message-Id: <123f092fbfeab1c2db795b69eeac76cb6cffac62.1704892316.git.geliang.tang@linux.dev>
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

Just like MPTCP_PM_ADDR_FLAG_SIGNAL flag is checked in userspace PM
announce mptcp_pm_nl_announce_doit(), MPTCP_PM_ADDR_FLAG_SUBFLOW flag
should be checked in mptcp_pm_nl_subflow_create_doit() too.

If MPTCP_PM_ADDR_FLAG_SUBFLOW flag is not set, there's no flags field
in the output of dump_addr. This looks a bit strange:

	id 10 flags  10.0.3.2

This patch uses mptcp_pm_parse_entry() instead of mptcp_pm_parse_addr()
to get the flags of the entry. Add MPTCP_PM_ADDR_FLAG_SUBFLOW flag check
in mptcp_pm_nl_subflow_create_doit().

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 net/mptcp/pm_userspace.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index a7e3c0fcbbaa..cae425a67880 100644
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
 						       mptcp_pm_parse_needs_id(laddr, info));
 	if (err < 0) {
-- 
2.40.1


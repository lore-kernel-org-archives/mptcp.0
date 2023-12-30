Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283B6EA8
	for <mptcp@lists.linux.dev>; Sat, 30 Dec 2023 02:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TAuDowTN"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703904567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zp71Y18YzNEQJyWF7DHB8p9je0w3P5vKcVX2AdEfyDo=;
	b=TAuDowTNnKsHNhFbU6+knNtun5RQvI7bglRznDMi0ZLFXB7yjZLDn4BbKwWJGh1x00OKf4
	ISVdUY6Zrf7b6Ku7MVuwo9Uxget16wdEi8/RPLyzDI6lAAIf+61/kEkTsvGqxOJ9hEXjFn
	Ltd0soH18AnX4LGTW1IxflQ9+ccmfgI=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v7 11/24] mptcp: check userspace pm subflow flag
Date: Sat, 30 Dec 2023 10:48:06 +0800
Message-Id: <264d927f841e3ce0f3258e6cc9c78de167e08e81.1703904325.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1703904325.git.geliang.tang@linux.dev>
References: <cover.1703904325.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch checks MPTCP_PM_ADDR_FLAG_SUBFLOW flag when creating a subflow
by userspace PM in mptcp_pm_nl_subflow_create_doit(). If it's not set,
don't create the subflow.

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 net/mptcp/pm_userspace.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 98237108ddcf..b9f5dfe922f9 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -371,6 +371,12 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 	addr_l = local.addr;
 
+	if (!(local.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)) {
+		GENL_SET_ERR_MSG(info, "invalid addr flags");
+		err = -EINVAL;
+		goto create_err;
+	}
+
 	err = mptcp_pm_parse_addr(raddr, info, &addr_r);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, raddr, "error parsing remote addr");
-- 
2.39.2


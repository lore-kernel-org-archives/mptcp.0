Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29131B274
	for <mptcp@lists.linux.dev>; Tue, 19 Dec 2023 13:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QImS/Ik6"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702994353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IAghL3z9GM4qCUM+AP9rYv4WtxrUXP74Ua9zrQJVuR4=;
	b=QImS/Ik6oJGRx0ZXl0E8aHVAz4rBwLJ6FYh56+U5L4JhdH1OnvbpZ6qNL+RWHJfJW30oGJ
	9vvjnYYr0XxA/snH2VxOqJhZ2YoKj1tz2sXwrb5NFXEDieiAbevOKlzORlJuoPTdMix8kN
	s7hGnQKGeaLIKfMDoJpPlTGaV7l5Bno=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next] Squash to "mptcp: dump addrs in userspace pm list"
Date: Tue, 19 Dec 2023 21:59:45 +0800
Message-Id: <d55a27c4e616f27f70a43207e4bbd165c62c5851.1702994377.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

'return' is missing here, sorry.

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 net/mptcp/pm_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 09d3fd6444f0..e56f9dbf0938 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1754,7 +1754,7 @@ int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
 	const struct genl_info *info = genl_info_dump(cb);
 
 	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
-	       mptcp_userspace_pm_dump_addr(msg, cb);
+		return mptcp_userspace_pm_dump_addr(msg, cb);
 
 	return mptcp_pm_nl_dump_addr(msg, cb);
 }
-- 
2.35.3


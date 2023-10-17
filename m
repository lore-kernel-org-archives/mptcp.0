Received: from out-208.mta0.migadu.com (out-208.mta0.migadu.com [91.218.175.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3088363D1
	for <mptcp@lists.linux.dev>; Tue, 17 Oct 2023 03:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R99+Nrzd"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1697511778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=thUBdzNohzDR3dgJ+Zx9OiaooRVCe0fJn/cTf0rh1Gk=;
	b=R99+NrzdaKsrVE8ECGknQC+c3rUymZY0xarGZLuhw6JkGKl4Pq8QthjYfak0USzdGUltd4
	Dm82jV7Mpq6wE5R0lcISv0zCNw4Z03zHjiRtlWjQo5DOl/yiYuk9ZdDk3QU1LQqdov9g4c
	vRa/WmOcqxBhhlDgZQIyRq8433Uv02w=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next v17 8/9] mptcp: userspace pm rename remove_err to out
Date: Tue, 17 Oct 2023 11:00:27 +0800
Message-Id: <31fc480c03c7106543e2a9c38f48eb1b5d836a0b.1697511436.git.geliang.tang@suse.com>
In-Reply-To: <cover.1697511436.git.geliang.tang@suse.com>
References: <cover.1697511436.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Geliang Tang <geliang.tang@suse.com>

The value of 'err' will be not only '-EINVAL', but alse '0' most of the
time. So it's better to rename the lable 'remove_err' to 'out'.

Suggested-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index ea50e694125d..cdff3e631d2d 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -276,12 +276,12 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	if (!mptcp_pm_is_userspace(msk)) {
 		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
-		goto remove_err;
+		goto out;
 	}
 
 	if (id_val == 0) {
 		err = mptcp_userspace_remove_id_zero_address(msk, info);
-		goto remove_err;
+		goto out;
 	}
 
 	lock_sock(sk);
@@ -296,7 +296,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 	if (!match) {
 		GENL_SET_ERR_MSG(info, "address with specified id not found");
 		release_sock(sk);
-		goto remove_err;
+		goto out;
 	}
 
 	list_move(&match->list, &free_list);
@@ -310,7 +310,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	err = 0;
- remove_err:
+out:
 	sock_put(sk);
 	return err;
 }
-- 
2.35.3


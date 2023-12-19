Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051D54C9C
	for <mptcp@lists.linux.dev>; Tue, 19 Dec 2023 02:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wvm63Vwn"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702951515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wiKp+yp9sD3/MgmOWyQTCXqF1hHLdh1xASrwowdCyY4=;
	b=wvm63VwngVeR0nIN9BJeINW3jsc/ckM7Fiw6Wg/CuO7uUZyMAd0oc+9Ah41rsDU0fE9GTG
	109JGrOcTJ+SVWqsVwp6NfB7lObnUVYLeE79MhnXsAloMyQmM7LVi7BB+mVl1rrQVYuMgr
	mRmAtTClEsSwrxDy4DlcWsZCqtbvXPk=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v2 1/4] Squash to "mptcp: use mptcp_set_state" 1
Date: Tue, 19 Dec 2023 10:03:53 +0800
Message-Id: <a56b046de9e00d7462eae4f234ec156220786e0d.1702951288.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1702951288.git.geliang.tang@linux.dev>
References: <cover.1702951288.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove the comment.

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 net/mptcp/pm_netlink.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index b93683b5e618..bf4d96f6f99a 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1048,9 +1048,6 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	if (err)
 		return err;
 
-	/* avoid replacing inet_sk_state_store with mptcp_set_state here, as the
-	 * old status is known to be TCP_CLOSE, hence will not affect the count.
-	 */
 	inet_sk_state_store(newsk, TCP_LISTEN);
 	lock_sock(ssk);
 	err = __inet_listen_sk(ssk, backlog);
-- 
2.35.3


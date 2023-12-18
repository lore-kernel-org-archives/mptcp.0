Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60006107B0
	for <mptcp@lists.linux.dev>; Mon, 18 Dec 2023 08:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FAOY/tif"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702889318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wiKp+yp9sD3/MgmOWyQTCXqF1hHLdh1xASrwowdCyY4=;
	b=FAOY/tif3jfXNwVdAneXQYqiiHMUPLmHqMCRM/1tPQdQCz+MjTquVSAOUI/3t3cHE15rQW
	m4LExUDWJGm6NsC6Kz7lct6d90JXUumg+UyeBpxUG5+dMZViTKSd1pUrtgGydl9xtfz9Nq
	JpBYT90pHid6Ak0LlPEFSE8Ums61OE8=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next 1/5] Squash to "mptcp: use mptcp_set_state" 1
Date: Mon, 18 Dec 2023 16:47:13 +0800
Message-Id: <85ce8b86865dc6fd8c984ef126dd6872baa028db.1702889134.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1702889134.git.geliang.tang@linux.dev>
References: <cover.1702889134.git.geliang.tang@linux.dev>
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


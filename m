Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E0F1FDD
	for <mptcp@lists.linux.dev>; Tue, 19 Dec 2023 02:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r3Ygk3AC"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702951516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HVMhsKLZTyQR2IW3wdxY5wyDLDlcJPEPOzs7MRL07Go=;
	b=r3Ygk3ACepmFkSBgndT8d57YvXwGgjGSpir8BI4D6M3ePFwinWZhhj3FSbiyMkiBjj8sZ/
	fiG2C6/k6Ctg/wlJ3iXSR19UsR5CE+rqxLroCejxQZSMiOxyUZkNuhNvKnAJlZNDZgZY1P
	d7uMBx6iWEs1vh//TmKQnIuoMBK8FrY=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v2 2/4] mptcp: move inet_sk_state_store under lock
Date: Tue, 19 Dec 2023 10:03:54 +0800
Message-Id: <cc2521325ecde449a31e1d6f101a8e22b8a3519a.1702951288.git.geliang.tang@linux.dev>
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

This patch moves inet_sk_state_store() under the socket lock in
mptcp_pm_nl_create_listen_socket(). This is a pre-req patch for
using mptcp_set_state() instead of inet_sk_state_store().

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 net/mptcp/pm_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index bf4d96f6f99a..c35ae045a925 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1030,6 +1030,7 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 
 	lock_sock(newsk);
 	ssk = __mptcp_nmpc_sk(mptcp_sk(newsk));
+	inet_sk_state_store(newsk, TCP_LISTEN);
 	release_sock(newsk);
 	if (IS_ERR(ssk))
 		return PTR_ERR(ssk);
@@ -1048,7 +1049,6 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	if (err)
 		return err;
 
-	inet_sk_state_store(newsk, TCP_LISTEN);
 	lock_sock(ssk);
 	err = __inet_listen_sk(ssk, backlog);
 	if (!err)
-- 
2.35.3


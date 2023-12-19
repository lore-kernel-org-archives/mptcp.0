Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC894695
	for <mptcp@lists.linux.dev>; Tue, 19 Dec 2023 02:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JxcvIHAJ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702951517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nmbzJ9eI/iTWvQpTVfZNnJC26dc0VdtCIBL1/IQEe78=;
	b=JxcvIHAJK4W+iRk8nfG17n2h/FxwloJgDS99Dvn8WZ6TLH9smKY607GhIP0OCrqwx9/om4
	nFGgZ16qXmkx6oM3OOfcFpHAFC71qroNLdG1eeZWtPZAjTusFBr5OmwHqBRNYT97/x5V6F
	dpw/H6IwqE2yPoA1aBvAAr/u76ZFlvY=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v2 3/4] Squash to "mptcp: use mptcp_set_state" 2
Date: Tue, 19 Dec 2023 10:03:55 +0800
Message-Id: <d5049afafeb86ce0ba12ccd3e6e4d055a38e445f.1702951288.git.geliang.tang@linux.dev>
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

Use mptcp_set_state() in mptcp_pm_nl_create_listen_socket().

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 net/mptcp/pm_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index c35ae045a925..1b754cf525de 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1030,7 +1030,7 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 
 	lock_sock(newsk);
 	ssk = __mptcp_nmpc_sk(mptcp_sk(newsk));
-	inet_sk_state_store(newsk, TCP_LISTEN);
+	mptcp_set_state(newsk, TCP_LISTEN);
 	release_sock(newsk);
 	if (IS_ERR(ssk))
 		return PTR_ERR(ssk);
-- 
2.35.3


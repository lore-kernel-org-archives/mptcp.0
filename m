Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59108107B7
	for <mptcp@lists.linux.dev>; Mon, 18 Dec 2023 08:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cX3DekId"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702889319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oq1x055y/ZPL/0misyDl/EbFgbm8C7ER63akTSQlvnU=;
	b=cX3DekIdkLaDaicRZznxiyjhWVuUhGl9A14NLbyLwzAKsCCs7G4E8XnRyUdv4aIcBMLmwK
	kElQKu9juUmuM3LI4wJjxaqe0OXeUXg71ywi/KVCKJ1Fw3WKwnJ6vFMkoj+wolR+/wbIOA
	q5L/7SVH9Av6R0u9ojZPABcJyFRT6RQ=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next 2/5] mptcp: move inet_sk_state_store under lock
Date: Mon, 18 Dec 2023 16:47:14 +0800
Message-Id: <84b7f01dcee92c4c1ae00523baa5f98f0cb64671.1702889134.git.geliang.tang@linux.dev>
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

This patch moves inet_sk_state_store() under the socket lock in
mptcp_pm_nl_create_listen_socket(). This is a pre-req patch for
using mptcp_set_state() instead of inet_sk_state_store().

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 net/mptcp/pm_netlink.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index bf4d96f6f99a..0e6da322c8f2 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1030,9 +1030,10 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 
 	lock_sock(newsk);
 	ssk = __mptcp_nmpc_sk(mptcp_sk(newsk));
-	release_sock(newsk);
-	if (IS_ERR(ssk))
+	if (IS_ERR(ssk)) {
+		release_sock(newsk);
 		return PTR_ERR(ssk);
+	}
 
 	mptcp_info2sockaddr(&entry->addr, &addr, entry->addr.family);
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
@@ -1045,10 +1046,14 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	else if (ssk->sk_family == AF_INET6)
 		err = inet6_bind_sk(ssk, (struct sockaddr *)&addr, addrlen);
 #endif
-	if (err)
+	if (err) {
+		release_sock(newsk);
 		return err;
+	}
 
 	inet_sk_state_store(newsk, TCP_LISTEN);
+	release_sock(newsk);
+
 	lock_sock(ssk);
 	err = __inet_listen_sk(ssk, backlog);
 	if (!err)
-- 
2.35.3


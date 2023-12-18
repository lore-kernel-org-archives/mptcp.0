Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5576A107BA
	for <mptcp@lists.linux.dev>; Mon, 18 Dec 2023 08:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rKHNwYbz"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702889320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IiPfB3P9669iZvHnORoMvNrAlpin6RnCDND0Je89AA0=;
	b=rKHNwYbzPjspfG/g1gJPMRmdRfA9lq7PdxZlPEd+8vYvx5N9k5zm2ttJppYQ/bWNIvjBkU
	5JxJ4jC0TGYci7EHcQus1AsYwpWZRPLv6ylc8KUuHovF+CJHU2JxWV19XBjdUgU/w2GsZ7
	ifAJFZRCoMpNYO0iQtLbqOpjffvVJEQ=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next 3/5] Squash to "mptcp: use mptcp_set_state" 2
Date: Mon, 18 Dec 2023 16:47:15 +0800
Message-Id: <390cb921a4255234d7ba4664a0cc8f15563b5896.1702889134.git.geliang.tang@linux.dev>
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

Use mptcp_set_state() in mptcp_pm_nl_create_listen_socket().

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 net/mptcp/pm_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 0e6da322c8f2..c84cc0908cfc 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1051,7 +1051,7 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 		return err;
 	}
 
-	inet_sk_state_store(newsk, TCP_LISTEN);
+	mptcp_set_state(newsk, TCP_LISTEN);
 	release_sock(newsk);
 
 	lock_sock(ssk);
-- 
2.35.3


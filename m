Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7625136195B
	for <mptcp@lists.linux.dev>; Mon, 27 Jul 2026 02:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785119387; cv=none; b=EfJUAJXGt573bsbiHS3jZ3Kcq1t9aFpS/CEZMDdoei52dZo3xiXil5H5OYAC61b2utfXy0cnVLJXrxT3Sx+FXfRVifVSk06b/W4c9g1xLgEw798EOv/ApSGfyQciD1hlN098/ljgO2+RWILJlZg7NF52S/UQKZ4NxkRvciUBN2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785119387; c=relaxed/simple;
	bh=6wfibqnOLMR0ktaIFslCHrqRHEi2i1YDEreYu2sdh2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QaLfnYBQ7OrZebLCjdBsFi9UJQjg6tBcom0VetstQO5MdonizITSydcXwXsgWIpYhOyBxtrE5z3aQzGP8EbH2j+cm+rtIARAEoX17OeuiYgcVxVLW7xlVW9rDyvyvQnlZUaCMztu9fyfZxlMFRsX8Nx15dTZaHeHZ5pltHzOvis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z44i+Oye; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z44i+Oye"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785119382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yPSgShtA3PN6HuXQ+teAnK39RMaNZU94aTpzP6J8sm8=;
	b=Z44i+OyeMM7TIE306HjfUDYxT2IgPX9jvTwOoFML5V4tnMjbJx5cEg1N/NUy8vAbbTNZJQ
	QG2F1z83+qCN0mG3rUYkshUeJeL7k6OT9HyfTqEEc2X5GiZK1/d0LKOgUlLQIhMqWLDMij
	s+UquSee+8F9ouOfY+ou4jAXlOZJGCw=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next v3 1/7] mptcp: drop unused @max arg of __mptcp_setsockopt_set_val
Date: Mon, 27 Jul 2026 10:28:43 +0800
Message-ID: <20260727022849.20923-2-gang.yan@linux.dev>
In-Reply-To: <20260727022849.20923-1-gang.yan@linux.dev>
References: <20260727022849.20923-1-gang.yan@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

The @max argument is never read in the function body. Remove it and the
MAX_TCP_KEEP* values passed by the TCP_KEEPIDLE/INTVL/KEEPCNT callers.

Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/mptcp/sockopt.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index fcf6feb2a9eb..9c4faa0d82ef 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -632,7 +632,7 @@ static int mptcp_setsockopt_sol_tcp_congestion(struct mptcp_sock *msk, sockptr_t
 	return ret;
 }
 
-static int __mptcp_setsockopt_set_val(struct mptcp_sock *msk, int max,
+static int __mptcp_setsockopt_set_val(struct mptcp_sock *msk,
 				      int (*set_val)(struct sock *, int),
 				      int *msk_val, int val)
 {
@@ -876,18 +876,15 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 		ret = __mptcp_setsockopt_sol_tcp_nodelay(msk, val);
 		break;
 	case TCP_KEEPIDLE:
-		ret = __mptcp_setsockopt_set_val(msk, MAX_TCP_KEEPIDLE,
-						 &tcp_sock_set_keepidle_locked,
+		ret = __mptcp_setsockopt_set_val(msk, &tcp_sock_set_keepidle_locked,
 						 &msk->keepalive_idle, val);
 		break;
 	case TCP_KEEPINTVL:
-		ret = __mptcp_setsockopt_set_val(msk, MAX_TCP_KEEPINTVL,
-						 &tcp_sock_set_keepintvl,
+		ret = __mptcp_setsockopt_set_val(msk, &tcp_sock_set_keepintvl,
 						 &msk->keepalive_intvl, val);
 		break;
 	case TCP_KEEPCNT:
-		ret = __mptcp_setsockopt_set_val(msk, MAX_TCP_KEEPCNT,
-						 &tcp_sock_set_keepcnt,
+		ret = __mptcp_setsockopt_set_val(msk, &tcp_sock_set_keepcnt,
 						 &msk->keepalive_cnt,
 						 val);
 		break;
-- 
2.43.0


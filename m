Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5279133689D
	for <mptcp@lists.linux.dev>; Tue, 21 Jul 2026 02:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784601677; cv=none; b=pcp+KSugwO6XuoAdv7OZg73nvweWARYsDGJ/B1Q1wsgYT9JvyiLsuxNfkCwjb/zPlMeqqFfL+1w2FwrsJ3RLgTtKtd0Q5Es9ci4C4MEO3elLJdjQTP1NwvUoMSuJ9hms+Hz9Zgbg6fWjD7K17WC4oqpuUcUQhQu+naWq6rbWCZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784601677; c=relaxed/simple;
	bh=6wfibqnOLMR0ktaIFslCHrqRHEi2i1YDEreYu2sdh2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=heiB60sDgjxGeF9eQBqXGLhSgXYUg2EnVwNeQPmK2U8bce5pJ988f/HuoR/OFgczbHJVhtKNNTLetT85gno8Ew2Zcc8r2MS0cCLvmyZwpysLJNwYBaac9AC2k+y6mEtJeHs8ZiWGm84e5Tz/nd0xg/c+SkuxUznIABDKEQpePJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bSfFphDR; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bSfFphDR"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784601674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yPSgShtA3PN6HuXQ+teAnK39RMaNZU94aTpzP6J8sm8=;
	b=bSfFphDRoD4zmLon1Z6HYlggmo2iOJjtCCU+BdpAbY7FmWFsuyQAtHqL0EYGd/iqdXdyEk
	Hg+oBZv5m78eT18/K4CEeua31/Qa/Kk4MNo13YEIJ5ILheCpvN3J+LiNKwuxaAnp3s/HgO
	Lxh4006D7JwKNPrByzQU0v8zSSK3/MM=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next v2 1/7] mptcp: drop unused @max arg of __mptcp_setsockopt_set_val
Date: Tue, 21 Jul 2026 10:40:56 +0800
Message-ID: <d9d4385718d5db0030813969c6f9ea45da69a45a.1784601268.git.yangang@kylinos.cn>
In-Reply-To: <cover.1784601268.git.yangang@kylinos.cn>
References: <cover.1784601268.git.yangang@kylinos.cn>
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


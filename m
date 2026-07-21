Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D0333689D
	for <mptcp@lists.linux.dev>; Tue, 21 Jul 2026 02:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784601680; cv=none; b=Kxxa3/ofj3OaGZRhgGuy/rwoV96RuMxDkxIoxxyRMu5fMMEDG14EQkUAZd2dG43zuITr+68HbShNIcX65WXFuXuWjyI+wzkuSPD1w4lWVecHiLCaimEbWijG6h2PD0PsegY4FMBb3ONiMOQu2BuQ84rvx3PzbMrtwVANyT6oYGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784601680; c=relaxed/simple;
	bh=6OzbjMu3kU+VXVmKHEHfXbxjpGlXUd2yuZXVPmkKTRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AwiAGqjcEjPabR26U1sIo9nL+ojoYwGaNsNEoTvdn49KgWe1m9kuit4A2dop1nSL1b2hiTrcUvMcHh2iOELHllaQ3ad2bsS1M1iSB76gJgV+STxptIVwLvjBiME3YE9FWr/gA/pgsPkQ4M6Oi4KUFPqnJ2yEhTM1QH0/kFLnPto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oIM/Pe5V; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oIM/Pe5V"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784601677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WAPvGHNVb9dxiFeuE9XdX0m1Z95/0PNHtFQ+ykI01nE=;
	b=oIM/Pe5VQTehLAv8w9BnsuekBPxoRuSWUeufTgThhZhyJe/4n2DTRu4TavNj/3zyiurueE
	ry+prdAzyEMGoFGlUGIn8W2tMibNT8SVG8266C3L0NtBhflwkZjnMLUecGHAssigsnstOp
	gm4OASshVu3+5VFTiBEJTuneROwT7FE=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next v2 2/7] mptcp: take TCP_MAXSEG handling into __mptcp_setsockopt_set_val
Date: Tue, 21 Jul 2026 10:40:57 +0800
Message-ID: <11304a8f1ec63390553390404d9164f7a4213b79.1784601268.git.yangang@kylinos.cn>
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

mptcp_setsockopt_all_sf is only used in 'TCP_MAXSEG', and it can be
replaced with __mptcp_setsockopt_set_val.

Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/ipv4/tcp.c      |  1 +
 net/mptcp/sockopt.c | 27 ++-------------------------
 2 files changed, 3 insertions(+), 25 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index b427f924608c..5915d0e62f43 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3830,6 +3830,7 @@ int tcp_sock_set_maxseg(struct sock *sk, int val)
 	WRITE_ONCE(tcp_sk(sk)->rx_opt.user_mss, val);
 	return 0;
 }
+EXPORT_SYMBOL(tcp_sock_set_maxseg);
 
 /*
  *	Socket option code for TCP.
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 9c4faa0d82ef..3e000436ab94 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -808,28 +808,6 @@ static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 	return ret;
 }
 
-static int mptcp_setsockopt_all_sf(struct mptcp_sock *msk, int level,
-				   int optname, sockptr_t optval,
-				   unsigned int optlen)
-{
-	struct mptcp_subflow_context *subflow;
-	int ret = 0;
-
-	mptcp_for_each_subflow(msk, subflow) {
-		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-		int err;
-
-		err = tcp_setsockopt(ssk, level, optname, optval, optlen);
-		if (err < 0 && ret == 0)
-			ret = err;
-	}
-
-	if (!ret)
-		sockopt_seq_inc(msk);
-
-	return ret;
-}
-
 static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 				    sockptr_t optval, unsigned int optlen)
 {
@@ -889,9 +867,8 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 						 val);
 		break;
 	case TCP_MAXSEG:
-		msk->maxseg = val;
-		ret = mptcp_setsockopt_all_sf(msk, SOL_TCP, optname, optval,
-					      optlen);
+		ret = __mptcp_setsockopt_set_val(msk, &tcp_sock_set_maxseg,
+						 &msk->maxseg, val);
 		break;
 	default:
 		ret = -ENOPROTOOPT;
-- 
2.43.0


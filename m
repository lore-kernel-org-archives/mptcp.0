Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875A0358360
	for <mptcp@lists.linux.dev>; Fri, 22 May 2026 09:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779441175; cv=none; b=LlWXAhJd4rrypdsbX1nPPUkOXyHsTxcNMwV3v8dt7GDQYJMXGns2IMcilMuOP2ld4n4SF4txjZ1vXA4mEtWW4SrBcjxXAPO7HLZldAh5zmrMcChi0TztJ5aD19VuozVYssGMldNgaAJKvgMlrfvzxE2mzbPEglO3CGHHJndYS+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779441175; c=relaxed/simple;
	bh=K3y1K/KFNpYe2CZYGuIiLPIV/7xHaHM54y5KQQqL9Fw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Re7JnUsdDtO19I7Ep4K2RzdA6tcATYQxWTJkV8pxxrV5M1WS/rQy21/tMtiaP3dxZxsmrZoEA44pa4NZvSqJcarB0lGYN52BEpuWUCGezCsghk8k2YI2ngTRKbxTRHcFJ6crcclLukBPEO7FV9NPyEMir1FPBmBQQPdXuQnCOoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=thVOsehW; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="thVOsehW"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779441171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=onjfyP1u1aDKTa9Tjki765y2aYux/WNHnsuuGsZ89Ig=;
	b=thVOsehWGqYR9CFrPZyCbqjeChOm72gZ6hj0/hoei7qYy+Y4aee4IDtwTa1nYD4+uvF1At
	peSrr/bRBmkaPoSvxLj2UhJkRp+tG//ZBA4Fys87QmdTKwMLDdNzuLcBxrQFZOG+YpaxlN
	bB7GBcLKepNnjdvJbOELE4BfhCkM3ZI=
From: Gang Yan <gang.yan@linux.dev>
Date: Fri, 22 May 2026 17:12:31 +0800
Subject: [PATCH mptcp-next v5 1/6] mptcp: replace lock_sock_fast with
 lock_sock in sockopt
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-sockopt_lock-v5-1-108629a46e98@kylinos.cn>
References: <20260522-sockopt_lock-v5-0-108629a46e98@kylinos.cn>
In-Reply-To: <20260522-sockopt_lock-v5-0-108629a46e98@kylinos.cn>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Gang Yan <yangang@kylinos.cn>, pabeni@redhat.com
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

Replace lock_sock_fast()/unlock_sock_fast() with lock_sock()/
release_sock() in the MPTCP sockopt handlers to avoid accidentally
introducing sleeping operations inside the lock_sock_fast() critical
section.

This is consistent with how other sockopt handlers in the Net code
already use lock_sock()/release_sock().

Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/mptcp/sockopt.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 1cf608e7357b..35a74e44a500 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -77,8 +77,8 @@ static void mptcp_sol_socket_sync_intval(struct mptcp_sock *msk, int optname, in
 
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-		bool slow = lock_sock_fast(ssk);
 
+		lock_sock(ssk);
 		switch (optname) {
 		case SO_DEBUG:
 			sock_valbool_flag(ssk, SOCK_DBG, !!val);
@@ -114,7 +114,7 @@ static void mptcp_sol_socket_sync_intval(struct mptcp_sock *msk, int optname, in
 		}
 
 		subflow->setsockopt_seq = msk->setsockopt_seq;
-		unlock_sock_fast(ssk, slow);
+		release_sock(ssk);
 	}
 
 	release_sock(sk);
@@ -270,8 +270,8 @@ static int mptcp_setsockopt_sol_socket_linger(struct mptcp_sock *msk, sockptr_t
 	sockopt_seq_inc(msk);
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-		bool slow = lock_sock_fast(ssk);
 
+		lock_sock(ssk);
 		if (!ling.l_onoff) {
 			sock_reset_flag(ssk, SOCK_LINGER);
 		} else {
@@ -280,7 +280,7 @@ static int mptcp_setsockopt_sol_socket_linger(struct mptcp_sock *msk, sockptr_t
 		}
 
 		subflow->setsockopt_seq = msk->setsockopt_seq;
-		unlock_sock_fast(ssk, slow);
+		release_sock(ssk);
 	}
 
 	release_sock(sk);
@@ -749,11 +749,10 @@ static int mptcp_setsockopt_v4_set_tos(struct mptcp_sock *msk, int optname,
 	val = READ_ONCE(inet_sk(sk)->tos);
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-		bool slow;
 
-		slow = lock_sock_fast(ssk);
+		lock_sock(ssk);
 		__ip_sock_set_tos(ssk, val);
-		unlock_sock_fast(ssk, slow);
+		release_sock(ssk);
 	}
 	release_sock(sk);
 
@@ -1647,12 +1646,11 @@ int mptcp_set_rcvlowat(struct sock *sk, int val)
 	WRITE_ONCE(sk->sk_rcvbuf, space);
 	mptcp_for_each_subflow(mptcp_sk(sk), subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-		bool slow;
 
-		slow = lock_sock_fast(ssk);
+		lock_sock(ssk);
 		WRITE_ONCE(ssk->sk_rcvbuf, space);
 		WRITE_ONCE(tcp_sk(ssk)->window_clamp, val);
-		unlock_sock_fast(ssk, slow);
+		release_sock(ssk);
 	}
 	return 0;
 }

-- 
2.43.0


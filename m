Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E0A2749ED
	for <mptcp@lists.linux.dev>; Sat,  9 May 2026 06:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778309088; cv=none; b=R0l3+tVUEGwrGd2xCMgPU0cQjzTw53EdL/2GFR5e12vG/h/v28fE6PH43rJzIjQP+KfvlY8OF/K2IEWXJaAGNRU6h6Rdd7w3ZyqKUwjatrzOk6wOhXMeMBBDn3rEBQgRovq+rVyyp08oKEG+drUag8uOaiWPHZLaHSmWaOLG48g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778309088; c=relaxed/simple;
	bh=FSLPt7MDale0HBrqi3QDh8LkvmgTT+dO6TUbSAOPERg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ush/X/Y2TwvJ+zANoCDjBNa5o8tvw+2OJxB3eoCdAtZL5UTCAVjXVpeckWlt1jSxPu/IhDXhsEoBfkzbamLQETIrmH23Gyrbt5q29KpcGQ5WPMNX03Jl4ppWeyR/CNEmoWl5mQHDosnNQLUqVdgJMvCy1Yl6LYNDhdj6QHB/5rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BiIdSicd; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BiIdSicd"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778309085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6xwQt15CGGzxD1N/8flBhD0Su6ovM59SKdddRmcT+Ls=;
	b=BiIdSicdTy2bn/SZo5P65zhjdSs8DXFdaRJTl0anvkdMcfepYghYiLpMMuHahAotNfZMv9
	plpnqUTwzrTt2qbNM0k7feksq+nKugD0Xbu/OKW1+IjImIzVnpASWnJJ4XGVAAc+VnwQZ+
	bQVDR6Sd58Q3znMIL4YL/BalH9tYSEY=
From: Gang Yan <gang.yan@linux.dev>
Date: Sat, 09 May 2026 14:44:23 +0800
Subject: [PATCH mptcp-net v4 2/2] mptcp: use sockopt_ns_capable() in
 setsockopt congestion control
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260509-sockopt_lock-v4-2-33f3a1c4d7a0@kylinos.cn>
References: <20260509-sockopt_lock-v4-0-33f3a1c4d7a0@kylinos.cn>
In-Reply-To: <20260509-sockopt_lock-v4-0-33f3a1c4d7a0@kylinos.cn>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Gang Yan <yangang@kylinos.cn>
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

When a BPF program calls bpf_setsockopt(), it may run in softirq
context where ns_capable() is not appropriate as there is no valid
credential context.  Use sockopt_ns_capable() instead, which skips
the capability check when invoked from a BPF program.

Additionally, the load is changed from 'true' to
'!has_current_bpf_ctx()' like tcp does.

Fixes: e42c7beee71d ("bpf: net: Consider has_current_bpf_ctx() when testing capable() in sk_setsockopt()")
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/mptcp/sockopt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 57ffde0d0b87..8535beaaf6b4 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -598,7 +598,7 @@ static int mptcp_setsockopt_sol_tcp_congestion(struct mptcp_sock *msk, sockptr_t
 
 	name[ret] = 0;
 
-	cap_net_admin = ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN);
+	cap_net_admin = sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN);
 
 	ret = 0;
 	sockopt_lock_sock(sk);
@@ -608,7 +608,7 @@ static int mptcp_setsockopt_sol_tcp_congestion(struct mptcp_sock *msk, sockptr_t
 		int err;
 
 		lock_sock(ssk);
-		err = tcp_set_congestion_control(ssk, name, true, cap_net_admin);
+		err = tcp_set_congestion_control(ssk, name, !has_current_bpf_ctx(), cap_net_admin);
 		if (err < 0 && ret == 0)
 			ret = err;
 		subflow->setsockopt_seq = msk->setsockopt_seq;

-- 
2.43.0


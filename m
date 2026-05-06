Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A632835294E
	for <mptcp@lists.linux.dev>; Wed,  6 May 2026 10:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778063668; cv=none; b=Tp4mGVfEQUzKKc5Tkd7R4rbcCFLBSoo57oG7nIeKjEZOWU6nnOVMel8YeQwoqBnM6RXLQ+C0EFOrs12ZvPSA5PXkTHYBVq/1/UpRm9G1cxVqhvXCDG1lJFXymbUXcfxwgVp5YUHb3kWrQIaO7EWoIrMczgoIGxjdNAXKQK30M+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778063668; c=relaxed/simple;
	bh=e1uR/rhFqyMDfcfrV9spJPg3ehMRMcThHOV3Gb3btE4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e5gBPOdWgaV5vpFcNK/Zc+EJfpYaB7lG4BxAx2J0tVk8Dmm+Ye7jz9Fk305GAqf0SCRHO9VRw2ioO10QQI0MMFx3LZGPpoD4atUtyidChFfFCd3K9ah8sYklJP9PR4tNwtgVCQE2J9E9YPIfHvkbdcRb7/p/jVBJg4GQ5y3UbdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ABGbXNkA; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ABGbXNkA"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778063664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7RTL/e0453AnaGgbMDI9xSPYBK/YN8km3RiD4o+RQu4=;
	b=ABGbXNkA2gVI91pbIS5eqPYMZyfyxTpAGnC2vGdV3le3EGsPo5vqO+fFq/q6VUkp5ZfkKL
	sfgrfMhfWOFKP9v0mBPsfCYVelvRhAXDq4uQfQpKY/oh5fq5qbm4z8486R6X5gH9JNULBz
	oM2XY1MCBoRRtJonnLaDA2Y/uLGhREo=
From: Gang Yan <gang.yan@linux.dev>
Date: Wed, 06 May 2026 18:33:55 +0800
Subject: [PATCH mptcp-net v3 2/2] mptcp: use sockopt_ns_capable() in
 setsockopt congestion control
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-sockopt_lock-v3-2-06bd417c6d63@kylinos.cn>
References: <20260506-sockopt_lock-v3-0-06bd417c6d63@kylinos.cn>
In-Reply-To: <20260506-sockopt_lock-v3-0-06bd417c6d63@kylinos.cn>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Gang Yan <yangang@kylinos.cn>
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

When a BPF program calls bpf_setsockopt(), it may run in softirq
context where ns_capable() is not appropriate as there is no valid
credential context.  Use sockopt_ns_capable() instead, which skips
the capability check when invoked from a BPF program.

Fixes: e42c7beee71d ("bpf: net: Consider has_current_bpf_ctx() when testing capable() in sk_setsockopt()")
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/mptcp/sockopt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 552e07296b38..059c386f427b 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -598,7 +598,7 @@ static int mptcp_setsockopt_sol_tcp_congestion(struct mptcp_sock *msk, sockptr_t
 
 	name[ret] = 0;
 
-	cap_net_admin = ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN);
+	cap_net_admin = sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN);
 
 	ret = 0;
 	sockopt_lock_sock(sk);

-- 
2.43.0


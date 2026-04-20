Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EA23859FF
	for <mptcp@lists.linux.dev>; Mon, 20 Apr 2026 09:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776677654; cv=none; b=c94XRMFug2s7a4SkuA4yGOrZbf+519F7krDJ6x3pZWxydvEMwd0IXCV14jm0/tyq+WAQ9f/iqvFlQfC+clKjpdEkFybBlggXK+qnLy/4S/fMlHoamtWXfLZ0QdSifehrr6BM5aUS3RrBQLrqSDsPQfpwjQv8Z8E61GXmlgmlmLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776677654; c=relaxed/simple;
	bh=dx52v6jM4tpvZk+6p1LVxzoA6NdIxcwEWBjW4vdi8aA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NbXgOHTGe+VveHQzVikEa1Wo/cCRJ714BtPVv8B0bhS9bfsEyVAn0+K6UTAK/odPvPZKeYGafCxk7hLj58uF00bJt4CdFG1zKQ2+e2DeVWcJaYRl3wQ86KLs6QuYSXwWrReu6Ueu80Z96EKC+l2OkVqZigXqvQiaMdBf7lSXsdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ktidcgLd; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ktidcgLd"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776677651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dWeEhy85LR6HPRembMFhsCZ1lmoVNWz/JbjHD40K//Y=;
	b=ktidcgLdQi/YMGILdG0MaaFm4a11W2xcjpcLZdq4ZkVsIjl4gcTqNxVicSKpkPtB/LX2PW
	sYQRuPENW3zpfC30p351ihYpFn7G/5yEp1ImrjKmGchPPtZtur/oshA0hBzaPkeOieHG83
	1mYcgCyYk9OzkWy67XwjdnS3XB6hrwc=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-net] mptcp: sockopt: set timestamp flags on subflow socket, not msk
Date: Mon, 20 Apr 2026 17:33:43 +0800
Message-ID: <20260420093343.16443-1-gang.yan@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

Both mptcp_setsockopt_sol_socket_tstamp() and
mptcp_setsockopt_sol_socket_timestamping() iterate over subflows,
acquire the subflow socket lock, but then erroneously pass the MPTCP
msk socket to sock_set_timestamp() / sock_set_timestamping() instead
of the subflow ssk. As a result, the timestamp flags are set on the
wrong socket and have no effect on the actual subflows.

Pass ssk instead of sk to both helpers.

Fixes: 3f4f958c3a3c ("mptcp: sockopt: propagate timestamp request to subflows")
Fixes: 6c9a0a0f2333 ("mptcp: setsockopt: convert to mptcp_setsockopt_sol_socket_timestamping()")
Assisted-by: GLM-5.1
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/mptcp/sockopt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index de90a2897d2d..79db15903e7a 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -161,7 +161,7 @@ static int mptcp_setsockopt_sol_socket_tstamp(struct mptcp_sock *msk, int optnam
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		bool slow = lock_sock_fast(ssk);
 
-		sock_set_timestamp(sk, optname, !!val);
+		sock_set_timestamp(ssk, optname, !!val);
 		unlock_sock_fast(ssk, slow);
 	}
 
@@ -237,7 +237,7 @@ static int mptcp_setsockopt_sol_socket_timestamping(struct mptcp_sock *msk,
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		bool slow = lock_sock_fast(ssk);
 
-		sock_set_timestamping(sk, optname, timestamping);
+		sock_set_timestamping(ssk, optname, timestamping);
 		unlock_sock_fast(ssk, slow);
 	}
 
-- 
2.43.0


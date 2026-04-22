Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7143C1991
	for <mptcp@lists.linux.dev>; Wed, 22 Apr 2026 09:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776849584; cv=none; b=Ak/LCehRwqrzt2D/hVmw8J74Z96i21jaPt8uR9SjsapyKFiOPCxBGHfPybFonSbL9svJGED+iSsHcNyXN7UiNZEKgqXiJ7NbfpEmnEK9207KsC9MXBgB71+h/Dfb1I6FpjgMXa32VthbSrb5ZKc0qelSWHDMvWg/MubjNham63Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776849584; c=relaxed/simple;
	bh=dHCWYXsYM2rsezefVv5ETAATazNDnnIMOEicVDlD9I8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ACfE9PPijtbzIeV+bcL5zKfrg52F9+8FWg3hV/yZyyuepjwoVKlyWI5OH2EaKtV/RKdECQ2knXOhhFbjXqHZbeq+RT6Jz5DypDXazFT/RKA4Oo9+++OUVDNrdimWUREOQVoHi8pW10bDXT20lhZOcZcL6TruSAqYURGoDe0GLFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W9gJEFP3; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W9gJEFP3"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776849581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B97cXjBSdb3A/fFcfg5oOJk6t+upyJLlk/0NcHwunyQ=;
	b=W9gJEFP3hECu+IdNgf6czv79TbjrB/Db5YmUbib9v3HBzd8eDNAY/dGKGm0iIAsRVMwD/1
	yWXFpH212QDIiPjBlJ8tfEN1jPf3oPtsoI291cz3IznJHObqYqlxV+WzFggywqui+daONp
	cm1hYHu2zFxRaSNJnmUJGd1mhmfWifA=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-net 1/2] mptcp: fix scheduling with atomic in timestamp sockopt
Date: Wed, 22 Apr 2026 17:19:21 +0800
Message-ID: <20260422091927.77770-2-gang.yan@linux.dev>
In-Reply-To: <20260422091927.77770-1-gang.yan@linux.dev>
References: <20260422091927.77770-1-gang.yan@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

Using lock_sock_fast() (atomic context) around sock_set_timestamp()
and sock_set_timestamping() is unsafe, as both helpers can sleep.

Replace lock_sock_fast() with sleepable lock_sock()/release_sock()
to avoid scheduling while atomic panic.

Assisted-by: Sashiko
Fixes: 9061f24bf82e ("mptcp: sockopt: propagate timestamp request to subflows")
Fixes: 6c9a0a0f2333 ("mptcp: setsockopt: convert to mptcp_setsockopt_sol_socket_timestamping()")
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/mptcp/sockopt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 79db15903e7a..0efe40be2fde 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -159,10 +159,10 @@ static int mptcp_setsockopt_sol_socket_tstamp(struct mptcp_sock *msk, int optnam
 	lock_sock(sk);
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-		bool slow = lock_sock_fast(ssk);
 
+		lock_sock(ssk);
 		sock_set_timestamp(ssk, optname, !!val);
-		unlock_sock_fast(ssk, slow);
+		release_sock(ssk);
 	}
 
 	release_sock(sk);
@@ -235,10 +235,10 @@ static int mptcp_setsockopt_sol_socket_timestamping(struct mptcp_sock *msk,
 
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-		bool slow = lock_sock_fast(ssk);
 
+		lock_sock(ssk);
 		sock_set_timestamping(ssk, optname, timestamping);
-		unlock_sock_fast(ssk, slow);
+		release_sock(ssk);
 	}
 
 	release_sock(sk);
-- 
2.43.0


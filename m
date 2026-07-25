Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71071253958
	for <mptcp@lists.linux.dev>; Sat, 25 Jul 2026 13:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784985253; cv=none; b=nQXeKEvS0HQdk3owOd+2suOxcvK7GMjCsygWT2N42Nij1JYv2vCnD9w3w8yKp9letq1lN9XUfwP4VTyAbSD9mLypjJReFVjwZp4pT6h8yOCzu1d7f8XHTjN2i9ZQgSAJ2WZmE0H9lDJ1Fy6vh0v8qLAOvui9I0SylIE1P5KN+SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784985253; c=relaxed/simple;
	bh=9qU4Vb2AP1lR+FkMg2hxSUxiBrxulIXnxEZVAWX86/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TQl7MMmD7J2s5umxR1hpHox7BGxVD9kbOze/AGX3/UIdRzepB2lLYLQ1k6s7MnY/MyagjfJ58l3hfPvs+OWu8MpWLUPpkiFIu/Ki1ASsAjTTL94/r6zzBmvdIwRXSY8rTwIwKtBF/5XBj70ogS5k3JtuENbhow/z3zLGrm8tPIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2ZAwaiA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2ZAwaiA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF66A1F000E9;
	Sat, 25 Jul 2026 13:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784985252;
	bh=Ep5w7qcPFEaguSGfLYzCUc0XaQhWMbbQ5Ekt3QGueuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y2ZAwaiA/IJDYwerbPRl/Wq4732+V6vyq8ekUfYg2fYruxsDplynujeznPqw4DvqJ
	 0cm97AYBQPRC+ASLK9IxcTa/aiasdnBwTJ5il815gqSfl/gy6XrD1LRq9deHyisgpA
	 uz94mK6a+pCehZ7XrHT8ArMtBxJnD5ztjhnBaiT0kZjVhJS6WrOKzWZcY/nMphiROZ
	 ib16CMNuKBqCIL1L1fyHmfmwd0Cym1TR3pmQjkQHilOJfxH+gK9nn8xPqCiRYtBYTf
	 DgoVBUKmtTHX1cy0g8nGC940mePqWoWkEewMYbSYLkReWI/wJ8N35UxcPZHnKVWclU
	 3KQbGFCCpDVOg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 2/6] mptcp: don't reset dst when setting default 0 tos
Date: Sat, 25 Jul 2026 21:13:39 +0800
Message-ID: <80a22df256550b7bbed7a7e06b8d8c6a6019fee0.1784985085.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1784985085.git.tanggeliang@kylinos.cn>
References: <cover.1784985085.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

__ip_sock_set_tos() is called unconditionally during setsockopt and
on each sync_socket_options() pass, even when inet_sk(sk)->tos is 0
(the default). On SOCK_STREAM the helper masks out the ECN bits and
writes sk_tos2prio(), which leaves priority=0 alone but still calls
sk_dst_reset() unconditionally, forcing a route lookup on the next
packet. Guard both call sites with 'if (val > 0)' so the default-0
case is a no-op.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/sockopt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index fcf6feb2a9eb..1b2487a5ae2f 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -762,7 +762,8 @@ static int mptcp_setsockopt_v4_set_tos(struct mptcp_sock *msk, int optname,
 		bool slow;
 
 		slow = lock_sock_fast(ssk);
-		__ip_sock_set_tos(ssk, val);
+		if (val > 0)
+			__ip_sock_set_tos(ssk, val);
 		unlock_sock_fast(ssk, slow);
 	}
 	release_sock(sk);
@@ -1562,7 +1563,8 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	ssk->sk_bound_dev_if = sk->sk_bound_dev_if;
 	ssk->sk_incoming_cpu = sk->sk_incoming_cpu;
 	ssk->sk_ipv6only = sk->sk_ipv6only;
-	__ip_sock_set_tos(ssk, inet_sk(sk)->tos);
+	if (inet_sk(sk)->tos > 0)
+		__ip_sock_set_tos(ssk, inet_sk(sk)->tos);
 
 	if (sk->sk_userlocks & tx_rx_locks) {
 		ssk->sk_userlocks |= sk->sk_userlocks & tx_rx_locks;
-- 
2.53.0


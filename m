Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02872147EB
	for <mptcp@lists.linux.dev>; Mon,  9 Dec 2024 08:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733734051; cv=none; b=XhK54CgsXwv7ikC7xpLB/N0Y59i+0BBuO7lZ0R4aPGZeCno5Js7cFThhl0dYjqNRRxGKH2OJ4SEu1G4qJrApZJAOmvPynd5P6Qn7dM25suG1YcvK80cHL4gzg1VtutnbLLiLn4fx207UyKVu+nA7A1EFMMUAp0sN9tADTVv0cto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733734051; c=relaxed/simple;
	bh=SQV9nesIDZg3IV89hJf9DcNukyegI2kFcLBPZJpMrJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ifqz5BRUVSeK+76fRUQEzOQLwqVQvyauwLhARxZl3DM8T3m7YbTOaQymLeGgClXyq8KUDHUbW3gWB90DnFH2GeNMe+EuikNcqcfzGtQzpVYsp0zZWIj/NKDdgKLXQNyjH9pwbw6wCp+XECecvxvRr4i7vsvr9RYbPFnkiiHK868=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IzH/J0ph; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzH/J0ph"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48094C4CED1;
	Mon,  9 Dec 2024 08:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733734050;
	bh=SQV9nesIDZg3IV89hJf9DcNukyegI2kFcLBPZJpMrJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IzH/J0phb9ZBi6kokH38xBkR+F5YFS7iUfxCqOoPaQo0dZJORAdE96YFY2EZXPenw
	 B8YBgTlP/DDIUxWlqRDV1Zri7/hqXgdaG3WOgGJ2ksD1T9JKF97oS0ZKh00b/Kovuo
	 bEt5hmbosjyms17zYEhBZHCXcPQZwkMkBG6OZfILainJiXOC7gTVlI4Ar10a7ZRX6f
	 dbAku99jmFpDTHKWnSiTHjYt85upsiRGJ5sixX6Hd9J4rNaZgvZG9hkeK9wxnVju5Q
	 QZG6UTaUy6TK2J9raFK3v1MhY19wHSbilrBBpJ+Pk/8NURbNZx0fpXPaYRRvezFUx2
	 j0xuoWw3WpWpw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 5/5] Squash to "selftests/bpf: Add mptcp_subflow bpf_iter subtest"
Date: Mon,  9 Dec 2024 16:47:16 +0800
Message-ID: <d4af92e42f3f7e3891b575878543e893f6906937.1733733573.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733733573.git.tanggeliang@kylinos.cn>
References: <cover.1733733573.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use bpf_skc_to_mptcp_sock() and mptcp_subflow_tcp_sock() instead of
bpf_mptcp_sk() and bpf_mptcp_subflow_tcp_sock().

IPPROTO_MPTCP is checked in bpf_skc_to_mptcp_sock(), no need to check
it in BPF program.

bpf_skc_to_mptcp_sock() and bpf_mptcp_subflow_ctx() may return NULL,
need to check the return values.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf.h       |  1 -
 tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c | 11 +++++------
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
index 3b20cfd44505..b1f6e1fb467e 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
@@ -46,7 +46,6 @@ mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
 extern struct mptcp_sock *bpf_mptcp_sock_acquire(struct mptcp_sock *msk) __ksym;
 extern void bpf_mptcp_sock_release(struct mptcp_sock *msk) __ksym;
 
-extern struct mptcp_sock *bpf_mptcp_sk(struct sock *sk) __ksym;
 extern struct mptcp_subflow_context *
 bpf_mptcp_subflow_ctx(const struct sock *sk) __ksym;
 extern struct sock *
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c
index 1bede22a7e3d..fd5691a4073b 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c
@@ -21,12 +21,11 @@ int iters_subflow(struct bpf_sockopt *ctx)
 	struct mptcp_sock *msk;
 	int local_ids = 0;
 
-	if (!sk || sk->protocol != IPPROTO_MPTCP ||
-	    ctx->level != SOL_TCP || ctx->optname != TCP_IS_MPTCP)
+	if (ctx->level != SOL_TCP || ctx->optname != TCP_IS_MPTCP)
 		return 1;
 
-	msk = bpf_mptcp_sk((struct sock *)sk);
-	if (msk->pm.server_side || !msk->pm.subflows)
+	msk = bpf_skc_to_mptcp_sock(sk);
+	if (!msk || msk->pm.server_side || !msk->pm.subflows)
 		return 1;
 
 	msk = bpf_mptcp_sock_acquire(msk);
@@ -41,7 +40,7 @@ int iters_subflow(struct bpf_sockopt *ctx)
 		local_ids += subflow->subflow_id;
 
 		/* only to check the following kfunc works */
-		ssk = bpf_mptcp_subflow_tcp_sock(subflow);
+		ssk = mptcp_subflow_tcp_sock(subflow);
 	}
 
 	if (!ssk)
@@ -53,7 +52,7 @@ int iters_subflow(struct bpf_sockopt *ctx)
 
 	/* only to check the following kfunc works */
 	subflow = bpf_mptcp_subflow_ctx(ssk);
-	if (subflow->token != msk->token)
+	if (!subflow || subflow->token != msk->token)
 		goto out;
 
 	ids = local_ids;
-- 
2.45.2


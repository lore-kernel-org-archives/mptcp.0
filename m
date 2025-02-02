Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F901C07C8
	for <mptcp@lists.linux.dev>; Sun,  2 Feb 2025 04:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738470970; cv=none; b=Bde+I2Y3ggUG/ksmlqvcphb+nWX2xY4dj3lgkGpOzDsJz0AgJdAZTvkqr/U1UO0P0NLAxBTwh46TwquSJw5CAsbujdZeDnHsOk7WXOJCo1zUFQMtA6K13gtjpUywAP5/RzWaIWml/dr2pvrvUMLZMCThAB2jaa0X1F1SugQlEZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738470970; c=relaxed/simple;
	bh=7QzOLXpGKUMbyhs+AvYypVItCDLQIAUOdG7nJ3xnPII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DXDlUplMCsl7zN0QFDJ31UjtbXq/c6fMRP/74fYAxWSMsQ5hus+DIKOcqJveVnOjj513xHoFtNrPX5AQKje/AWdMtlbJouHKSwCmPsiGGaygYwhtC0yh2cTH4uC08dMiQ2q8IwDHkoVKvxF7XJGdx89UBHnMxIB9r4YBBvL+9Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtdIw3u3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtdIw3u3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3234C4CED1;
	Sun,  2 Feb 2025 04:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738470970;
	bh=7QzOLXpGKUMbyhs+AvYypVItCDLQIAUOdG7nJ3xnPII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AtdIw3u3g7Ym0UT3Hk0t4hDbS7ODbD5/KHlmQy7J76eTorU5PObYSFra/cszkJfKf
	 fElB0RqxTKeDxDFErIKhKYozOmPOYCN2Zivx/7TV3yU7NWrTeQN8l01jCtrtEGgG8d
	 fiE/jWRHt5EoGZij8KoajjksN0pi7je+4yniYXLRLfdbSl1tfHzJ0TIq1b6M95ruwJ
	 RqD1Gi50A+FgpgiT1oPk3jcWZnbg7cd/v1KFTPrZNhOo7YYH+5BhuubwLeqe0KhkyU
	 PTo/+MipIt4+wHDs34DbEAywlVAD4uy5L17ClUR9uwREVFwmZiVq4yvw7NFUyhyOTH
	 pgIKPucsUkNBg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 5/5] Squash to "selftests/bpf: Add mptcp_subflow bpf_iter subtest"
Date: Sun,  2 Feb 2025 12:35:11 +0800
Message-ID: <b5fee152138c047d02911d31e12d7f5616ae56f2.1738470660.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1738470660.git.tanggeliang@kylinos.cn>
References: <cover.1738470660.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use bpf_core_cast() instead of bpf_skc_to_mptcp_sock().
Change the 2nd parameter type of bpf_for_each() as 'struct sock'.
Drop bpf_mptcp_sock_acquire/release.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/bpf_experimental.h      | 2 +-
 tools/testing/selftests/bpf/progs/mptcp_bpf.h       | 3 ---
 tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c | 8 ++------
 3 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 2ab3f0063c0f..6a96c56f0725 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -577,7 +577,7 @@ extern void bpf_iter_css_destroy(struct bpf_iter_css *it) __weak __ksym;
 
 struct bpf_iter_mptcp_subflow;
 extern int bpf_iter_mptcp_subflow_new(struct bpf_iter_mptcp_subflow *it,
-				      struct mptcp_sock *msk) __weak __ksym;
+				      struct sock *sk) __weak __ksym;
 extern struct mptcp_subflow_context *
 bpf_iter_mptcp_subflow_next(struct bpf_iter_mptcp_subflow *it) __weak __ksym;
 extern void
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
index b1f6e1fb467e..ede9111ee597 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
@@ -43,9 +43,6 @@ mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
 }
 
 /* ksym */
-extern struct mptcp_sock *bpf_mptcp_sock_acquire(struct mptcp_sock *msk) __ksym;
-extern void bpf_mptcp_sock_release(struct mptcp_sock *msk) __ksym;
-
 extern struct mptcp_subflow_context *
 bpf_mptcp_subflow_ctx(const struct sock *sk) __ksym;
 extern struct sock *
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c
index fd5691a4073b..2c0d11cb9864 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c
@@ -24,14 +24,11 @@ int iters_subflow(struct bpf_sockopt *ctx)
 	if (ctx->level != SOL_TCP || ctx->optname != TCP_IS_MPTCP)
 		return 1;
 
-	msk = bpf_skc_to_mptcp_sock(sk);
+	msk = bpf_core_cast(sk, struct mptcp_sock);
 	if (!msk || msk->pm.server_side || !msk->pm.subflows)
 		return 1;
 
-	msk = bpf_mptcp_sock_acquire(msk);
-	if (!msk)
-		return 1;
-	bpf_for_each(mptcp_subflow, subflow, msk) {
+	bpf_for_each(mptcp_subflow, subflow, (struct sock *)sk) {
 		/* Here MPTCP-specific packet scheduler kfunc can be called:
 		 * this test is not doing anything really useful, only to
 		 * verify the iteration works.
@@ -58,6 +55,5 @@ int iters_subflow(struct bpf_sockopt *ctx)
 	ids = local_ids;
 
 out:
-	bpf_mptcp_sock_release(msk);
 	return 1;
 }
-- 
2.43.0


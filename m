Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC661D7E57
	for <mptcp@lists.linux.dev>; Fri, 24 Jan 2025 10:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737714534; cv=none; b=YQ3JRVOEsYFPil9tB8S+6kG8xWtHfIv/4PE/2o3+RZtfE13XVL5zkd1h9aHbBHgzu+4cpwW9S/oadGT18UqkeRDbNCnZT68OG6r18EUnuZeUq3uZb7j1NhWgpdOQRdTlbLRRFbsjCakxfczPmgfND1PxgduC86t4N5VM3XhXEJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737714534; c=relaxed/simple;
	bh=h2n87wCU2BBgP3HSC8BIpxpCqxLNz3114U8TmdaBA/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j2E29lNHsK3QdkaPD92oEaa6Xl5Fhn3ejTLxzUO5heO2+qQN6VdhoFGPT9Xn7ma/XkDaj3cDAdqTflqwRP/pL+/UF7vHL9UTCjoQo5iWygyZ7T3Qh+eRE3PTb/OZuijkgTFohIRJQ/gkQRb7wAny3BrAB4Ei3hTKa7nS4/eC+WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vk72zNt+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vk72zNt+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D79C4CED2;
	Fri, 24 Jan 2025 10:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737714533;
	bh=h2n87wCU2BBgP3HSC8BIpxpCqxLNz3114U8TmdaBA/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vk72zNt+rL1F8vnGgl1wTwS87Zp6L9ajjWF+J4DdwU+tJGI4aBU4KF5TOMsJMHLyN
	 vW8RQUFfU1eNAGDoCfNjVdnoAtO4pyV0cl3lPmeWYf3gt338FRUJuMxip/zDZ3fSGX
	 tR60Zy2Hkdhjj2BXE+mV9B+XocekAuQPr6SJqowvJQForTLeYk7d+8WJ68PH3pTlUq
	 LCqkV5O+ApfWxZtEIY2sHSfUa+3Bmx0rFSi97AaQNjMwZs6UZ/gNy9jFTmeM9Xa7iX
	 RXff1aCCNxL8Xr7G+S++oVeeu6LsHrMrf+iELK40sgQLBV6sxnL9ZKF8rBAclaHo/5
	 lYrS9oZw6AVog==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 3/3] Squash to "selftests/bpf: Add mptcp_subflow bpf_iter subtest"
Date: Fri, 24 Jan 2025 18:28:41 +0800
Message-ID: <19d3e15f4f32c29c4c3ba5049b123f96ac0fde5c.1737714424.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1737714424.git.tanggeliang@kylinos.cn>
References: <cover.1737714424.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Drop bpf_mptcp_sock_acquire/release.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/bpf_experimental.h      | 2 +-
 tools/testing/selftests/bpf/progs/mptcp_bpf.h       | 3 ---
 tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c | 6 +-----
 3 files changed, 2 insertions(+), 9 deletions(-)

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
index fd5691a4073b..6124c484efe3 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c
@@ -28,10 +28,7 @@ int iters_subflow(struct bpf_sockopt *ctx)
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


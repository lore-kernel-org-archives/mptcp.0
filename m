Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E99BA3D
	for <mptcp@lists.linux.dev>; Thu, 21 Nov 2024 07:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732173029; cv=none; b=G8L3k/Uty11VlAP6gXp+GrId70oaT/SoL4xKn50vfzDIhtGYyQOOVvtTygBi9j29sq/Y/AGceMla3NVRpqIhvEEvRdVI6MfAo/WnsmZTs9SWVfFWcDSlvJKETcl0Z5tH3IhPvCRGRfJDL2JmVH1f/Q/fYK5tPixYHeWFWSlDV1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732173029; c=relaxed/simple;
	bh=j86koVjy9m5DQMFl9dmS/aL9/28ANwXTgkirhcoNrU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h33+H8nnPxVQNFKPVlbUvsAncaEbZpkYJlJ/aNMA5HEL67aPbIUXmBKROFAmYovrEzd/GOVTnukEyh6n1D0UNTSC47AaR7gOb87EEGCt933NPcwn0hjqS8Q1V+kH1M3HxRe/WgV6pas8/kdhyFSytYRaX5JE9ZcAIIDp9nXZ4OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGzHWiCM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGzHWiCM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46201C4CECE;
	Thu, 21 Nov 2024 07:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732173028;
	bh=j86koVjy9m5DQMFl9dmS/aL9/28ANwXTgkirhcoNrU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gGzHWiCMbIYuJYZ4bv+4aUON9zeB8ssJfQuNVb91szbzoEG+1mZ46AB4P3lyj0mtE
	 +2q+UiyMmcGOCf6gZyahKdfPCMf00he9Spax7lM3d+xO/0gftiuzRxBfEIaEQ4Y/so
	 hnDorQHJ/JFwnd2ZsbDpSxv4fr70ZT87IfGhbHe1YQkWc+czkvqckmMTn0C8JRSIId
	 +t2GN/0/LR2B0c6sqs6P5QHfutJG+hzfs4fIiGAXENoSI9pa9hO4Wlwq3dktm9SOqS
	 aSIXjpqoqPsQP5jr288G9zYXoscSDSmsEKlpMe0bmOtOTGzUZ2VikrCbE7LhLKl9tW
	 I4E4Y/Xb+jjRA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 3/3] Squash to "selftests/bpf: Add mptcp_subflow bpf_iter subtest"
Date: Thu, 21 Nov 2024 15:10:08 +0800
Message-ID: <ed98ae51ec7d5c8203d8f8dcea6661fede300267.1732172851.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1732172851.git.tanggeliang@kylinos.cn>
References: <cover.1732172851.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

IPPROTO_MPTCP is checked in bpf_mptcp_sk(), no need to check it in BPF
program.

bpf_mptcp_sk() and bpf_mptcp_subflow_ctx() may return NULL, need to
check the return values.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c
index 1bede22a7e3d..5e475edf37b3 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c
@@ -21,12 +21,11 @@ int iters_subflow(struct bpf_sockopt *ctx)
 	struct mptcp_sock *msk;
 	int local_ids = 0;
 
-	if (!sk || sk->protocol != IPPROTO_MPTCP ||
-	    ctx->level != SOL_TCP || ctx->optname != TCP_IS_MPTCP)
+	if (ctx->level != SOL_TCP || ctx->optname != TCP_IS_MPTCP)
 		return 1;
 
 	msk = bpf_mptcp_sk((struct sock *)sk);
-	if (msk->pm.server_side || !msk->pm.subflows)
+	if (!msk || msk->pm.server_side || !msk->pm.subflows)
 		return 1;
 
 	msk = bpf_mptcp_sock_acquire(msk);
@@ -53,7 +52,7 @@ int iters_subflow(struct bpf_sockopt *ctx)
 
 	/* only to check the following kfunc works */
 	subflow = bpf_mptcp_subflow_ctx(ssk);
-	if (subflow->token != msk->token)
+	if (!subflow || subflow->token != msk->token)
 		goto out;
 
 	ids = local_ids;
-- 
2.45.2


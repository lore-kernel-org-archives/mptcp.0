Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B04518E043
	for <mptcp@lists.linux.dev>; Thu, 12 Sep 2024 09:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726133171; cv=none; b=ALvDCQckVdL1A4yT5wJMR19DTXNl+wqPb87n+ujMiO7AiJ4apdUHfyUbjxxXhum+RfrmimI8NmvRfmiIMAux2o95kLl5flLcorg2GT1XxgjxCWgFCuqPIPc+RAlDnYcoiLLrSHCbDmzxvn4wkWtugdML/9H/E82EphgUKFq4qTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726133171; c=relaxed/simple;
	bh=Zb+32JUdCvzFr6YS3HVWxtO3o2fz5/zgF4mbGXoaSRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FG/Rf4XwaRoDiJii1M9AtUswEVLa4nz1eQ7dKG3n61Z8xnF/eDuGW+OIclOZ3T8KceFARpt3mMDQcxybq6wFaS3fS/u0NGPGUDaTME8EjpeRvf5jQchsYggAjorMH8NKE2g/MhcMKtP+Bn+vzKm3NAEMtNkLrH5ylzOb3pvgxYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9f88HAC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9f88HAC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1ED4C4CEC3;
	Thu, 12 Sep 2024 09:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726133171;
	bh=Zb+32JUdCvzFr6YS3HVWxtO3o2fz5/zgF4mbGXoaSRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d9f88HACDwNszXkA7ti4PxRsoR+bKMBSyFdZJokAaldLNoMc80ZpILUp3f8Oleh8i
	 Bxlake77nBXvhK3bPQ7PISSvnp0RQQyES/UjrHUMH7ZCAUu2aRGzTJzxVkr+inueG1
	 bUPKZtwv7bp+bmq30HJXYpr/UCu/WafClQUIatY8D/8gc5pEqkaitOBhMOu5E5/dMB
	 L3jRQ1ukeJlbbpYSWqvPzjJi0dH0s1HQ9CvAZEYHhXdoFXTpYrbF3SD4nnHxRlRqg6
	 k5L2+2t2s9bza7n4vTyAGM2PpZmJ5jnNqDssB8+YR+LP2p+tipHO1d9qYV5QD5csCY
	 tkQf1AyxPQdIA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 5/5] Squash to "selftests/bpf: Add bpf_burst scheduler & test"
Date: Thu, 12 Sep 2024 17:25:55 +0800
Message-ID: <543ecc733565d61caad8dd953ebcbcb5b689094a.1726132802.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1726132802.git.tanggeliang@kylinos.cn>
References: <cover.1726132802.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Drop mptcp_subflow_active declaration.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
index eb21119aa8f7..dcab196867fe 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
@@ -16,7 +16,6 @@ struct bpf_subflow_send_info {
 	__u64 linger_time;
 };
 
-extern bool mptcp_subflow_active(struct mptcp_subflow_context *subflow) __ksym;
 extern void mptcp_set_timeout(struct sock *sk) __ksym;
 extern __u64 mptcp_wnd_end(const struct mptcp_sock *msk) __ksym;
 extern bool tcp_stream_memory_free(const struct sock *sk, int wake) __ksym;
-- 
2.43.0


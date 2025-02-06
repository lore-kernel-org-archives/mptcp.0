Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6F2225A27
	for <mptcp@lists.linux.dev>; Thu,  6 Feb 2025 09:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738832717; cv=none; b=e9rGJ5zr1atB+g7E9vmu7b69rg0hKIJqqZzAl2a69eHrJ7yuiUPryZERklSvwvL+nxBQaVSBo4NFCEs7AFaE4rcMgrogZ7FNgv3t2eHyCfvE33AEOoYYvHlnRtdF8aLp6FV5awyy5WV/FhfiDgLBdCfBNjPjerIfQjw9MuCsgTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738832717; c=relaxed/simple;
	bh=1su1M3eNFxvg6tCEug8h33AMhzMJVn4aAseRa4VGjmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UPwxLDuATD5oBea3+XWDTVf2eWzOd6qFyoQa0KhoqvKg8DFzkdPxr4diPsQgmN5Ig4sCn0VUy0BUGDmKHrlSUlNk7Mrm6h8kLR2P+UNel+MANb5MoVyU0ZxhenlgdWp+cJxueiWAdaohtgjesf/hhXksCZZgUrI7MBvdv37my84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTFNN+mb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTFNN+mb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867CBC4CEDD;
	Thu,  6 Feb 2025 09:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738832715;
	bh=1su1M3eNFxvg6tCEug8h33AMhzMJVn4aAseRa4VGjmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dTFNN+mb+PGeZlpCrp911pUr44rNfcjMMNWMdvUNNfzeIU8AbH/9m59SespEgnTJ1
	 jm4k3HHGqJvlez+MwyIbdgldBM0eC7HAz+DlRM7I+EFiXIMWXH+VY+iHvPP86WvmAL
	 zSluUhPAai/uiq6ZgreE0PJuGlhQnazv2jOL9Yz6T1S6ghBz+3f2oeFlLOPwrrtVF2
	 lwE5Ugu0iWbKyIvMVFafBSMNSAY9KH2PO83iJGtVEOJnCVk6OEq3LOuMfv3//fZr2I
	 uTADr7y1+t2RmFO8gFd1nJz6cJdCXlJfLAITgcDtLHxSNGykkdl37bzBuOmfPsx7tW
	 Z8xAl2fDkLPow==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v13 5/9] Squash to "selftests/bpf: Add bpf_bkup scheduler & test"
Date: Thu,  6 Feb 2025 17:04:55 +0800
Message-ID: <2beb96c1dc2fb8c52977a4191da318ed55d08f47.1738832147.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1738832147.git.tanggeliang@kylinos.cn>
References: <cover.1738832147.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use the newly added bpf_for_each() helper to walk the conn_list.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/progs/mptcp_bpf_bkup.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
index 29be67e2f2ef..b7212101705d 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
@@ -20,26 +20,16 @@ SEC("struct_ops")
 int BPF_PROG(bpf_bkup_get_send, struct mptcp_sock *msk,
 	     struct mptcp_sched_data *data)
 {
-	int nr = -1;
-
-	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
-		struct mptcp_subflow_context *subflow;
-
-		subflow = bpf_mptcp_subflow_ctx_by_pos(data, i);
-		if (!subflow)
-			break;
+	struct mptcp_subflow_context *subflow;
 
+	bpf_for_each(mptcp_subflow, subflow, (struct sock *)msk) {
 		if (!BPF_CORE_READ_BITFIELD_PROBED(subflow, backup) ||
 		    !BPF_CORE_READ_BITFIELD_PROBED(subflow, request_bkup)) {
-			nr = i;
+			mptcp_subflow_set_scheduled(subflow, true);
 			break;
 		}
 	}
 
-	if (nr != -1) {
-		mptcp_subflow_set_scheduled(bpf_mptcp_subflow_ctx_by_pos(data, nr), true);
-		return -1;
-	}
 	return 0;
 }
 
-- 
2.43.0


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20441E511
	for <mptcp@lists.linux.dev>; Sat, 12 Oct 2024 13:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728740561; cv=none; b=fhQWW7JLtIes3YUVB2m6VBIJKMcsMu/ze7GQXUiqWrhdcBYoIdhYsQIwmbwXpuXLvoRZY646kIC1iHKZJTQ5sMgm3VC/CLrvVN7rEMRWUqipPqZr0a7lVCLlJaWqegpFc5yjbEucCOMxwQmCskjNcg3ziZ5NJ37FITK9vwtZ+eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728740561; c=relaxed/simple;
	bh=+Ns9vcAYflyNwdX3DkGpNegQAHdxvHGggo6htLg093M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pqUsG3Hk96yaEO0Xzpy80woB25qOHVLK+1QVenbMbO/zrun3K9vFg+Mmy+TdOrJab8fuWc9x/LwhyALPvzOIajjovW3di38VrOVxgtPVTvteabGPvBkKGvnH+85dHBnvT45uPPxbF09yfVDtr0JRsLOxqicUZUCkczgEDG+aiaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLggZToi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLggZToi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4BDEC4CECD;
	Sat, 12 Oct 2024 13:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728740561;
	bh=+Ns9vcAYflyNwdX3DkGpNegQAHdxvHGggo6htLg093M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kLggZToihN7LBc8LlWFVXpk0N6gs0KlibOxE2b8OXDKqg8ovmaIUauEvAjmoAzWbS
	 hEiW2lMc8oDhUeQN+O4ArN68K4tUS846KKr5UfNLXfdBBAHRaqVpUmvKSbzQFHwAJJ
	 yLOhwE/FSsscuEZV+MauYCJaWUpnPJbcwuDTNRs9IgreM1KVkTzYE8PrC7ZyBYmMZv
	 +jSU7fUwabz2G56bSHfzpWK+w67yznXbW594ZK9K6Eq9LzpoXQOXDCowttXJ/pF/Vx
	 k44Zf8T9kodczI/18kd35cVmQWkMB2kQNupVk0cLhAsKDElNw1pRIF4OjAtg1Z5Weq
	 WfxiyLCwdtk0w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 06/11] Squash to "selftests/bpf: Add bpf_bkup scheduler & test"
Date: Sat, 12 Oct 2024 21:42:11 +0800
Message-ID: <626fcee030e50e5cf9063f8f9660e944b5b635a2.1728738220.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728738219.git.tanggeliang@kylinos.cn>
References: <cover.1728738219.git.tanggeliang@kylinos.cn>
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
index 296f0318d843..70c3a69d4a47 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
@@ -20,26 +20,16 @@ SEC("struct_ops")
 int BPF_PROG(bpf_bkup_get_subflow, struct mptcp_sock *msk,
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
 
+	bpf_for_each(mptcp_subflow, subflow, msk) {
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


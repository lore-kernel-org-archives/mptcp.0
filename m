Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D932B18F2C4
	for <mptcp@lists.linux.dev>; Wed,  9 Oct 2024 10:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728469806; cv=none; b=GPFyyGn255FpXHnBb+wAfXJXvnpWPpCXwIMe5Qq/TdS4vQhe5Mu5fLKWNk9715b0f+uYX8EE20gJdpVP6Kw2/n3YL0VDoObOjXYeDauNJAaYw0pGPSNmWUzp3zXJCRO72FqewlSoW9YC+Suog3O4G6EdDbf+LTLM9C3r4TkOvsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728469806; c=relaxed/simple;
	bh=vAGk2SNZxJ2K0XaAAadSTnWA8wtWMYR0tx03ZiqDhLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QgqX+H7WnSanOKcLx3c9IOwkmKixKcURniMUhPbmljhIE8VdQj+zWqqGkSB0qhQoXgu4tmR7OTBcBYlJFNxM/zzzMuXK2kMGqoE6OQ8+i9/ufx1dW99SfksESFfgTf3QSXHGaOxgKj0Stdm0plV+hF+9AwpTxOzZ/yzp0beFwbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sqoESUCq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sqoESUCq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84648C4CEC5;
	Wed,  9 Oct 2024 10:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728469806;
	bh=vAGk2SNZxJ2K0XaAAadSTnWA8wtWMYR0tx03ZiqDhLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sqoESUCqpfPlEU26mmdKfaFb/lM1os3fGM85yi1aU4MFRiBwYJJ4LgR87qf1L2IST
	 HTVZTYF1Ijn+JRa0Bqi4MYw5akJmfnYTIMFI0YhUthU9Yn/PCph9LegJtT1pmtnHjD
	 neRY/KPTdlLI4DZQMGMr4gV4rqEGPmBM+rU9KOzP4/tiwt4pkEKFBFMVzbpdfT3VvQ
	 9G/By/slgPG/mNhfN7WwPNe0usggfACxfvIJwJFUC1o4y8p8fj1ouNMn8DnAoUyL1t
	 aJDVE11lrCuMwWlaZv0ioJvR89quSW/g4vUb14IEasHNPjWVH9sHVIKJsKdT5Keysb
	 qkp2qF9S1o2Nw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 05/10] Squash to "selftests/bpf: Add bpf_red scheduler & test"
Date: Wed,  9 Oct 2024 18:29:46 +0800
Message-ID: <44c4097b4a3714d81f9a9cbc6f2bbf0393576014.1728469555.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728469555.git.tanggeliang@kylinos.cn>
References: <cover.1728469555.git.tanggeliang@kylinos.cn>
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
 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
index cc0aab732fc4..ce19d604b898 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
@@ -20,12 +20,10 @@ SEC("struct_ops")
 int BPF_PROG(bpf_red_get_subflow, struct mptcp_sock *msk,
 	     struct mptcp_sched_data *data)
 {
-	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (!bpf_mptcp_subflow_ctx_by_pos(data, i))
-			break;
+	struct mptcp_subflow_context *subflow;
 
-		mptcp_subflow_set_scheduled(bpf_mptcp_subflow_ctx_by_pos(data, i), true);
-	}
+	bpf_for_each(mptcp_subflow, subflow, msk)
+		mptcp_subflow_set_scheduled(subflow, true);
 
 	return 0;
 }
-- 
2.43.0


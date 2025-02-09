Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B30339A8
	for <mptcp@lists.linux.dev>; Sun,  9 Feb 2025 10:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739095345; cv=none; b=gnyBpgBiTTnNYDP6IyeSSd8+O8CRO2yy2Tp0I5C2NrwXcGyNqvV+KAdHnvhKNLqlNotZwz9PlGLgSYYzHx838pbKj+AmFuwaPvjYOfkQ2VOCAp0CwJQHeYCHmV8QBGhi26UeJlVZHI4/xo/3jWSepQcJuk6Um6wEjfMusIZH1Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739095345; c=relaxed/simple;
	bh=PvRlww9oxwxOA+huQBk1xHRyv5mmqZH7amLe1b0bbxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tjbmyq1mm/XOfV+gSF+u/mdmzIPb+w7wjXdP4N2LLdWkggvwMmmutahtyVLg3McSqVQENMPFnlnMGXwzQYMNSyapTu/LuP1EqpbPTVAEfYX6psrLoTIdF9HG7/1WYByCUFGVh0dMB4BFoAF8B5lFLJZk3X3BtT7PzcEOmn0xkrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfBd76k2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfBd76k2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4939CC4CEDF;
	Sun,  9 Feb 2025 10:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739095345;
	bh=PvRlww9oxwxOA+huQBk1xHRyv5mmqZH7amLe1b0bbxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mfBd76k2vxWqd1+r5hmAXXHEoBk+RdFbHNuZgi7UFfwkMvpHI61ppKCUI/gAOD5fA
	 slj0iBs2x//FfTgagc8TVVLs9to5o2O4IW8kQgA1fJ2aKIF0XZYzzAIGSSN/vHt2mW
	 OP/1+9oia6KAqCD4ssXq6pxswTornGSISZYpLfIx461pPB3kkPhrVWQBNO50OzAeGi
	 jt/AlepSHvQHs8Mck+z1gw27NZlTufqqSVbbD2/eYfUd2dHMSt5at+6fHj5MN574ja
	 kbX1SNuPQInBxaH6yFEKXmVQ7qjZMzZulvPTIj6cr4/w18T9kcbuqCP3c2TLHPHOC/
	 YhNf7xVCjIQlQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v14 6/8] Squash to "selftests/bpf: Add bpf_red scheduler & test"
Date: Sun,  9 Feb 2025 18:02:05 +0800
Message-ID: <468fcec9db6b5c487bc0627b47fb055ba07c15d9.1739083794.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1739083793.git.tanggeliang@kylinos.cn>
References: <cover.1739083793.git.tanggeliang@kylinos.cn>
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
index 627502e3c851..9f2cab4ba3f7 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
@@ -20,12 +20,10 @@ SEC("struct_ops")
 int BPF_PROG(bpf_red_get_send, struct mptcp_sock *msk,
 	     struct mptcp_sched_data *data)
 {
-	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (!bpf_mptcp_subflow_ctx_by_pos(data, i))
-			break;
+	struct mptcp_subflow_context *subflow;
 
-		mptcp_subflow_set_scheduled(bpf_mptcp_subflow_ctx_by_pos(data, i), true);
-	}
+	bpf_for_each(mptcp_subflow, subflow, (struct sock *)msk)
+		mptcp_subflow_set_scheduled(subflow, true);
 
 	return 0;
 }
-- 
2.43.0


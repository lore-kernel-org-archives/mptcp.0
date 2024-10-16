Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB091C07E7
	for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 09:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729071251; cv=none; b=Jd7w7+24yF6j4J/4U/Dsn+mBLExrxyJ02coRW+AgZU3lkx0Ux8TIgN7Vi/ffIQbIty7jPpvUhx0mi63niEXawhVlqn54BudFEE+XEvMuPcltlzud+YRjK5CvJ1PWlevs7SEF4dJjUVgakPd2dvsHMkpqi8lXHrvY6UebXtQwcY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729071251; c=relaxed/simple;
	bh=+Ns9vcAYflyNwdX3DkGpNegQAHdxvHGggo6htLg093M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fz/PeEzsDU28jkS/q5TjBJr9LF024KfLLPK1N5NFDVClWkPjUnDrbp4jWpata+1dWW7HN4T1+FFw4kHhv0XdIuPhHh2QeAHDES71molhzkPJUQShzSnU2WgRxxozNOGw6jpyCIueBFyZ29TUWfr9lhajuEYSB4oYaeQtY6zrLSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LIrWrw0q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIrWrw0q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43016C4CEC5;
	Wed, 16 Oct 2024 09:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729071250;
	bh=+Ns9vcAYflyNwdX3DkGpNegQAHdxvHGggo6htLg093M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LIrWrw0qaVSrVV9Whk+swGiP3+bNX6dgp8tLzvn6G1K3/c4GNAn9WekxLWGBqQK8Q
	 +KTzi2g8zipOrfYsyAKzJzzzGGoRSyR4K2RLDAgpzgu4uh2P08DvsyVNz+q+24sOkZ
	 JaBbcSZ5uI+IEY/8EPYxPbL5zTLP7IzwJGB+CYBgMsqwaMkfTmUL0KaaJm7g+LeT+u
	 az0DnhrAFQDkANwOMvH59yA2mnl6f4pEI1VzaSsXguGHiR5V0QWWtiRspqT9VAr4Z8
	 2ypGiU7/brMFK7QwLUOi79+WRW2pPckI9Q6C7kR7MU4p1sJgdkARlcoSfGjZV13ddf
	 k5Z/e9RLlG84A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 05/10] Squash to "selftests/bpf: Add bpf_bkup scheduler & test"
Date: Wed, 16 Oct 2024 17:33:41 +0800
Message-ID: <c60f1a6b5fa48c44b1dfe6a687f5ab79eef80b80.1729070999.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729070999.git.tanggeliang@kylinos.cn>
References: <cover.1729070999.git.tanggeliang@kylinos.cn>
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


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF3023CE
	for <mptcp@lists.linux.dev>; Mon, 17 Feb 2025 10:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739788889; cv=none; b=SEX7Od3Ef0qsWcYX7FXEfFd051sOHy1Dddl2RF4icgPRT6tTI5bEHDAB53+CgwdWUMP4+c35APGVHjztp07qlz9os9krEl/wS57uVk7km6gplqK/B82Eknh/KBpIw/VWJN2ulFEUZzKp31GlPXdJD9uOyPJ12cr/Xnj41TRWp+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739788889; c=relaxed/simple;
	bh=1su1M3eNFxvg6tCEug8h33AMhzMJVn4aAseRa4VGjmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s4AVzbSzEREo1n2OCYsLCU7r+joNPa4PBPAeShKPkd9iCTil1XUGm5oIN35d6zhqZBcHvEXdbknA4ltrkM/FYHe8XqpZp4IljTN21AFo1Q3WQL93xEEeqeThR4aG+lyWAaSQj+7pRho59Xv1RQzwzenNDeit84GGE3/DY+LDTl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTzRhRj2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTzRhRj2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E0FC4CED1;
	Mon, 17 Feb 2025 10:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739788889;
	bh=1su1M3eNFxvg6tCEug8h33AMhzMJVn4aAseRa4VGjmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZTzRhRj2g4CT5qqMpoqhyer0cHyEcDO1onRL9NtokQ7+Y2g30uzD6uCFDA6D1iMdU
	 K72b5hCE2pcurWU1APnQvgtOqyQg0qgcxO0Xl+UJYWvs3bMHWIorNJ9qwEPnsKl/8Y
	 JOhVqS/1zYqgN01IYAKIM4BGVgLMZ56SMaLSYGoHyIVfBjt3Eo4K6RNTxcURG4Szbv
	 FuR7Of+z/XcoGdtG57so+7Hhf47IABaJryeEIHrki2mKjbLyKZnvzeUHuHIg5P6AZA
	 MW0VcmJwYZOzc8LaNeOqNJOSAXjABaZDJEqwAkiDcC7jh8+F7CGa3etaxuCYv75DBe
	 OorTJdCV3MqQA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v15 4/8] Squash to "selftests/bpf: Add bpf_bkup scheduler & test"
Date: Mon, 17 Feb 2025 18:41:14 +0800
Message-ID: <16da745e973898c10f57121ca368bcc6dc1bb78f.1739788598.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1739788598.git.tanggeliang@kylinos.cn>
References: <cover.1739788598.git.tanggeliang@kylinos.cn>
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


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E4C18EFE0
	for <mptcp@lists.linux.dev>; Wed,  9 Oct 2024 10:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728469803; cv=none; b=UTfC3wQ5tzNwf1a1WbEywoXiTm5Kk+kFCsPrlyloarrshcD20djLDM/H9hEugE43ownvoIdT1h5RYmlnR8jzbsbOynAsFx+k71nV4bCEKP2bfUpm7b0HH7fsTvQjEzULYkjvqAQxbAq78cBpClFX6gwqdj5rmbCt1q7alCTtWng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728469803; c=relaxed/simple;
	bh=+Ns9vcAYflyNwdX3DkGpNegQAHdxvHGggo6htLg093M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RONKklk7LH1QaPmzEd7EMHDOScUM4wstRCtQdVgHS8vul4yVNne/n2356FYGq2I2bVmemIPLgj8ogXBI3RSTapqmeKC7xj6DlBfX6a376+MaHQho2NoQF4meNoPmSBVagC/yX3UViPlR440AwlvHTxBjvmVEUaDkyl1JZCSWYRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qx6WLqTT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qx6WLqTT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 420A8C4CECF;
	Wed,  9 Oct 2024 10:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728469803;
	bh=+Ns9vcAYflyNwdX3DkGpNegQAHdxvHGggo6htLg093M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qx6WLqTTZfJR8iRv161KoKRUrF+KcFQDf6o/TFw3ERx2IkLtJaN3foc/ooe6IYuXJ
	 hV63DT4na9HWayQvIabEvoPGDFLhjE7HhpE3Y2mlIl4JKBTzTnt4MM+GpAIqiyzc2K
	 1x/s4TA4fFELOezwPglY29wOqdvBuNEvxSCS8CaXrZv9qaUP16gswDhNvleFHcV231
	 O86v9qa0k1GwzJ5c2+jz93fAa98S2kf5BWPd1TI7NvIcolPr4TZUjfBPSFzmfEuViP
	 SFM9bKpdINwtQjn8jxe8pG9qAnbecM//+VcU5NO0pUwlTljkYapxk2y4oJy8z/JV6y
	 PF8BmjrwQ07bg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 03/10] Squash to "selftests/bpf: Add bpf_bkup scheduler & test"
Date: Wed,  9 Oct 2024 18:29:44 +0800
Message-ID: <bda126d0698058a675ed2b3b0111e058e82af5cf.1728469555.git.tanggeliang@kylinos.cn>
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


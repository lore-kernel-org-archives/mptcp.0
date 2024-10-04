Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AD21D88B0
	for <mptcp@lists.linux.dev>; Fri,  4 Oct 2024 12:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728046800; cv=none; b=JBfC02nxrOQSJwbn+ItdasWGqSvWP5m7dkYD6TsH4U+L1aYzonN2wQJOnuUxmDi2ssE2xtth693KkojgdnBSYChyndNV5OY32cPufOTpppj5cW5jyLQ5WmN9r+kKx8FMVRGJi2A2eDZa2dC9nv+IXaGk35olPWAMUREwfvYoOeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728046800; c=relaxed/simple;
	bh=+Ns9vcAYflyNwdX3DkGpNegQAHdxvHGggo6htLg093M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iwLWypUs2BM+LPW/y8GpW4Hy7f72GIcHL9XVkZ4RdsPeFYTZNmMjcd/KWg95lZNL74AFJ8259fIlgnNRXcs3JwVmTcGm4T8vDXvLWVPsJcV8EEL7Mh6q2B9ZHsM98Bx+SwwhRM5eiDU2/i1R+3+XimvyiFcuw2uWU4/EL6Wr8Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qp+Vfmtl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qp+Vfmtl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA68AC4CECF;
	Fri,  4 Oct 2024 12:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728046799;
	bh=+Ns9vcAYflyNwdX3DkGpNegQAHdxvHGggo6htLg093M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qp+VfmtlqtJUF1rzD2aHwc6jp8ngWnwLxXfK0XsdYcuJEp3bGXdSEcIw/oEzhywLE
	 SSa0IfLQ3ULVgLwOdlPUul5y60jtQ3w4LB5ssuTZxYg1eMqumiFDpK1gB2MlwEyYc6
	 ClrlVXidG0qyjngNzKbJn8aZixck795uRPfNBYPP6k4NNp2B093iUT52z4+gkHOPIf
	 Mca7mIXzAxl2tI20YYKpFIVeGt5ovfA7TxlnFpeIdm91cjCLGPYl1XkRSGpl9slYyZ
	 FFyCN4BPRKncwbBpChPQDyVfMzrsnQem4WPJJzVse6h2WdDjsWVCILft7mwLu4eQzV
	 Kva/DH98OxN7w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 3/9] Squash to "selftests/bpf: Add bpf_bkup scheduler & test"
Date: Fri,  4 Oct 2024 20:59:43 +0800
Message-ID: <4fa80f804539410bbde5d66f93ea27260c997076.1728046491.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728046491.git.tanggeliang@kylinos.cn>
References: <cover.1728046491.git.tanggeliang@kylinos.cn>
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


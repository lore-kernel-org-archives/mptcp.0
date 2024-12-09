Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76A62165E6
	for <mptcp@lists.linux.dev>; Mon,  9 Dec 2024 09:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737783; cv=none; b=ADy3Nm9WdUx5GCwX2HqnQb/eyDsE1po8H5Mr87wmr3Xv24iYzGnBJLoVmwdjnj8aQjhzA4acbcF4wgdmP1M/DOjUQmQ/0a0KfsxqlkOWIy1At5duGfx5YtD021QYivAcxL+/OfGB9oT69eYK0jL5b9uCwmx40HrpZHkhsLTdVyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737783; c=relaxed/simple;
	bh=c/nN0hAnbFaNg1uFbuo4jdpJfRpzQ9T6ME6dElk9r44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TS8UFDTMksDwv7FP6qRMLa4SZPaF6wu8h+FPk7Ydxg9CkfXfceCqNLqC4Dbg1Fv1ZR89H1iqCdrlYG5q0QUscPEsDKrPTPM3FCUfacrV0gyZAPsBqMY3Emp2E+RmJtEBOxuI5+YXLD4PfR1ztvhwEyX4uB95MHA3OG+ZZQUtY54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5pyBc2v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5pyBc2v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F3FC4CEDE;
	Mon,  9 Dec 2024 09:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733737783;
	bh=c/nN0hAnbFaNg1uFbuo4jdpJfRpzQ9T6ME6dElk9r44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T5pyBc2vCbAyon29IBtd//JXI4Ns7MRLPMIgVBvNCPQKyPMnreF2dwl7KDusV4ryI
	 1dDgZgxOqdTup9RlKl32sTBklfshE6CydjXK1C4LSPTTXAFvSy8qrvHcAO23Nsp7Mf
	 qQ6rhOqkj9VqNAACM/d85fOi6tzdAgO174idAvJ8IBh1FI4FUGd1k2soSBPKannpXR
	 ERgu41coVX3kibC687oFOyUixvoew8fju8aUzfGdrGDLCNKhJAxyIeTBnfxK6XonSI
	 RrnUQAB5QDRgcJhPhSbowF6scD+b2uBE2kddvKKODhs1VRpxDYq6gcSXwlkGP6KzGW
	 P9feVw33iG+wA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 6/9] Squash to "selftests/bpf: Add bpf_first scheduler & test"
Date: Mon,  9 Dec 2024 17:49:22 +0800
Message-ID: <bf46c44e85605c045436005ce8873108fa1c8867.1733737459.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733737459.git.tanggeliang@kylinos.cn>
References: <cover.1733737459.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use the newly added bpf_for_each() helper to walk the conn_list.

Drop bpf_mptcp_subflow_ctx_by_pos declaration.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf.h       | 3 ---
 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c | 8 +++++++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
index 3b20cfd44505..c393176496f0 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
@@ -55,7 +55,4 @@ bpf_mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow) __ksym;
 extern void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 					bool scheduled) __ksym;
 
-extern struct mptcp_subflow_context *
-bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos) __ksym;
-
 #endif
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
index d57399b407a7..00cb4953c487 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -20,7 +20,13 @@ SEC("struct_ops")
 int BPF_PROG(bpf_first_get_subflow, struct mptcp_sock *msk,
 	     struct mptcp_sched_data *data)
 {
-	mptcp_subflow_set_scheduled(bpf_mptcp_subflow_ctx_by_pos(data, 0), true);
+	struct mptcp_subflow_context *subflow;
+
+	subflow = bpf_mptcp_subflow_ctx(msk->first);
+	if (!subflow)
+		return -1;
+
+	mptcp_subflow_set_scheduled(subflow, true);
 	return 0;
 }
 
-- 
2.45.2


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F7118EFD6
	for <mptcp@lists.linux.dev>; Wed,  9 Oct 2024 10:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728469802; cv=none; b=n5s4o+AUxOB8mpRGrSQfDhBSDApQkLxWwqD/aZnzIomcWUcnZ1GBKNmZha5IJcCOMYRdz3iqPMCdlmh2PwJMrRswcY2uwAlSLXSInxYkQJpI2mFPOBe4v52/CtrfpQ3e8PwSVznvGWriG10G6yxTqNS3TqZbOnraGguum3JXEIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728469802; c=relaxed/simple;
	bh=LBbhZRE7O7iOP8AKfoYUNWYs3cuAD5rsHQ/AU3RUl5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hS9nzTLDUIpF5NJPS8YZCpWiZVsBAPRYNCFWQ6fyY2DORF6f110YUnFmI7DnrbaFaZnPNjpj36w9a3/p5Y7ujSjH/Wo5J0H18f1yaas4lBR+yXNH1vlyvsx9nAtJY1rj2cucBH4ODfe0fcHw8LqIru24AlPTVJDNAxmgPFzLAaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4qeH45g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4qeH45g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82037C4CEC5;
	Wed,  9 Oct 2024 10:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728469801;
	bh=LBbhZRE7O7iOP8AKfoYUNWYs3cuAD5rsHQ/AU3RUl5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i4qeH45gsBthlPVXhkB2iX3W1CjsW2h3WI61GrRySE2Vg6wsVkpE5FbV/D8aQjJ5F
	 PV3eyPGVV1r5f+wz80GxZ7updiOMvgGig/frfjClmunVh8tVZZxon92s7xJQljeBAO
	 j3OWafDFs68KAX+I46boI4pG0gU6jGE4awfrNc5KdxX1KdpJYSXC0OYI1zA+AVmiz+
	 gDz9J8NHVJ3LAuIixcLsg2K5YYjH9kS89+RAjDwh0hA2wBdBF8xDtbRLf6jQduivp6
	 xpMy4uvV92QseNyEoIKpuDSrm8AxcS0sekL2HkcYPGRsbgxP+VrNYwmOlY4pMTElUN
	 0M873HpaSReRg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 02/10] Squash to "selftests/bpf: Add bpf_first scheduler & test"
Date: Wed,  9 Oct 2024 18:29:43 +0800
Message-ID: <acb95bbf8739f909e9e2afafef846be6dcf5bf6a.1728469555.git.tanggeliang@kylinos.cn>
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
 tools/testing/selftests/bpf/progs/mptcp_bpf.h       | 3 ---
 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c | 8 +++++++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
index e18796361394..260bc239655a 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
@@ -55,7 +55,4 @@ bpf_mptcp_subflow_ctx(const struct sock *sk) __ksym;
 extern struct sock *
 bpf_mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow) __ksym;
 
-extern struct mptcp_subflow_context *
-bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos) __ksym;
-
 #endif
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
index d57399b407a7..807685b3ab97 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -20,7 +20,13 @@ SEC("struct_ops")
 int BPF_PROG(bpf_first_get_subflow, struct mptcp_sock *msk,
 	     struct mptcp_sched_data *data)
 {
-	mptcp_subflow_set_scheduled(bpf_mptcp_subflow_ctx_by_pos(data, 0), true);
+	struct mptcp_subflow_context *subflow;
+
+	bpf_for_each(mptcp_subflow, subflow, msk) {
+		mptcp_subflow_set_scheduled(subflow, true);
+		break;
+	}
+
 	return 0;
 }
 
-- 
2.43.0


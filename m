Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84A51D0F66
	for <mptcp@lists.linux.dev>; Wed, 30 Oct 2024 06:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730268665; cv=none; b=CNVn/r7NXzrlvY+uYmIhIQB7nY++waKoD5nc+f9NxgBAhaxqa9qxE5jyC4kbkFuQqEVPtQmWgS5yuwnWkWsERzGPYUhMszdrnmfs8p/YQf3Y8CSB4O4yDcyPetIRnQHiFqjJpcIYu48CRmCz/ORquAO9ZVKAfbhiu1sRzU58yPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730268665; c=relaxed/simple;
	bh=2XQB3Zpf5clOuT0T2zVPlnvDISa6+1HSn5y51VFTke8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hG4kTjKlWaqFlwCBlYqk4nP/pLU/i7kPVzvDoHxutOLP3kKuurvmIcMfeN3e42QHbfQmc9ZCSAkLcTPV7LDA576xZrq+tiujMxnLgjPK/tbJnzxGWOM4zu9+IyPrlv+PJw1Djl45Ieb+VJqi9fMhJDFLEOyYXKwtpLUqxxldLKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNBaNJPu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNBaNJPu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E2FC4CEE5;
	Wed, 30 Oct 2024 06:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730268665;
	bh=2XQB3Zpf5clOuT0T2zVPlnvDISa6+1HSn5y51VFTke8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mNBaNJPuoOb7VK/w0cQkafDA4KsuSxkF1ibxKI1iHMv/p+KKkCYk3oKGohQvykUbp
	 Ljh8qts/7+TBRtf+eGhQEUF7B32Qk/I8WzX7AuEf6XXkW8eiVuVEwXf9U+QCuHD0n/
	 pTi/Zwykp+omM9YDOlwA7TUrvTPC7OuD94KF1rIhSEciqNQHyYNce1wNu6SKhbSSm0
	 PNe3hJLk964bfsJUZlc40e9BCLd2SnY9O00w10CQUKW4QFTmLStmCZxRTMAbbIiFE5
	 /79NddT5x5mwIZ+rGi1xnzcw/xv3TJimpsw26UoOk8RykaqRk7wfu49NixXs0e/zVZ
	 7DXuPesnT1ggA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 07/13] Squash to "selftests/bpf: Add bpf_bkup scheduler & test"
Date: Wed, 30 Oct 2024 14:10:31 +0800
Message-ID: <5843a90bb1e04bd7b635798fc6b1a0667c77f963.1730268415.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1730268415.git.tanggeliang@kylinos.cn>
References: <cover.1730268415.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Update test_bpf_sched().

Use the newly added bpf_for_each() helper to walk the conn_list.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c |  2 +-
 .../selftests/bpf/progs/mptcp_bpf_bkup.c       | 18 ++++--------------
 2 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index a6574a537679..d388bfca21bf 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -696,7 +696,7 @@ static void test_bkup(void)
 	if (!ASSERT_OK_PTR(skel, "open_and_load: bkup"))
 		return;
 
-	test_bpf_sched(skel->obj, "bkup", WITH_DATA, WITHOUT_DATA);
+	test_bpf_sched(skel->maps.bkup, "bkup", WITH_DATA, WITHOUT_DATA);
 	mptcp_bpf_bkup__destroy(skel);
 }
 
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
index 296f0318d843..0c32ce623bab 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
@@ -20,30 +20,20 @@ SEC("struct_ops")
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
 
-SEC(".struct_ops")
+SEC(".struct_ops.link")
 struct mptcp_sched_ops bkup = {
 	.init		= (void *)mptcp_sched_bkup_init,
 	.release	= (void *)mptcp_sched_bkup_release,
-- 
2.45.2


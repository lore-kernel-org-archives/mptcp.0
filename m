Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863E7189F42
	for <mptcp@lists.linux.dev>; Wed, 23 Oct 2024 09:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729676443; cv=none; b=canggBQ49bgQnUUQAx8IJB0QFSHLKOD2sHWdlubDzQEyEmzlIq22v2eZhpdo6zP03bofFfkMsum5EVUkmBaOMgxxWNMcPYYw1iCLUf1N9BHvOGScuyO1xaeJHYnodHhW+X42YQN6mYzl/3gSSSmZvtDbGj35VE6CU8sCaolj0Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729676443; c=relaxed/simple;
	bh=xzK8jOvJ5JqUfgJxJ2WcAObJtneK7GeE7sjTE+kiURY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IFF0OwjwIr0/lE1oKWogsPVh0HKwfpF0XjpXJtJjA6CPai1opYhcTeWIMY1ddE5CoQE1kZvoECWipbPNoD2DB7LiZ4RRnhia6Qgohx7pCQb2oVy7irT2BJsHeQHH6jNewLLxZs6YV96kb4gqQ2PeWc1OTOdP1SrOXrwoz6a0/uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVIpioPU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVIpioPU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3BAC4CEE5;
	Wed, 23 Oct 2024 09:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729676443;
	bh=xzK8jOvJ5JqUfgJxJ2WcAObJtneK7GeE7sjTE+kiURY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EVIpioPUdsgbV392QSideniWLyfoNldhvuGAr3VHR2MUio5LO3/XFHiDQD8Eqlb9i
	 LgztcpGHGhEWyHHwH+de9bMKkcItDQn9dN0ku867SZxDbncrRu1/zit3ykbygZ+U2f
	 bU0CrTbURPsXLeFQZCBZ2WadgJ2FQ3+lZc1NHaXKas9MW/GevOunRuhKGV09rP3Y4U
	 /CQkNONKNFpH/oaDy39C2Vbn46O5v+nYy9vnc4SsYAaiC6AiXBCR+/uPsn4Ni7WveX
	 YxviZ2SMalnRHI2pPaStg8JPKDmAT7liG8XfEaT/JK8dBMS5sAF2bDmWDzmqajPHNt
	 fte7exbinEquA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 07/13] Squash to "selftests/bpf: Add bpf_bkup scheduler & test"
Date: Wed, 23 Oct 2024 17:40:17 +0800
Message-ID: <28803269a2038b188007e8e1caffdd6d95d3c4fb.1729676320.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1729676320.git.tanggeliang@kylinos.cn>
References: <cover.1729676320.git.tanggeliang@kylinos.cn>
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
index 1c63396e1eba..cb0090bafe57 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -714,7 +714,7 @@ static void test_bkup(void)
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


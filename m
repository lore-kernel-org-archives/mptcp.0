Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7772907
	for <mptcp@lists.linux.dev>; Thu,  6 Mar 2025 02:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741227355; cv=none; b=KSI8ksHbOKlodQ+au5oIoZ79PQ1ajlQANrb3YQV7SzXLQHD/nRhGVC0bWoNp9G4/fbYUl/N1zC0EcfePw+asN0qu3LUq9IwD9EDaOAz1V28qaYXehUf4PVe5w6T34lbkzkqxe+7s3p6vgLiqisASGCrxru+53ECrZGAsg2nniCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741227355; c=relaxed/simple;
	bh=mKWBtLvwsTxYg1mZ2L/eCW4k/1resBBBaTvCpp89Lqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SXYZM9xedFyXFvrs8dGwpKRczeTfIb12pAOvknNoeFoCzB0tNE3/J0SvpXw8178280spQoL08hfjYLwMgyC5swS1JIVZxTW3lS6LEFQsEJcS9npp/m2Pq0W5YmRpbgFhZ6DA6fHKeGnrgWauqOFBwPJlb3WZyxUrePPvjWk2NEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOyE7sIo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOyE7sIo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 657DCC4CEE8;
	Thu,  6 Mar 2025 02:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741227354;
	bh=mKWBtLvwsTxYg1mZ2L/eCW4k/1resBBBaTvCpp89Lqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SOyE7sIov90HPOnZkd2j3RPoVN1CCbacmHBU9/b/dzYWCWLkLHBL0iTdueN87EkCX
	 qZ2CiMHxVtD7LR2CT9FgSeSG8L0BiPQ9afmfFSGMj9FZYGjYBME6+WfvdCP273Sa4w
	 BXiRWFVZmtsSL4itX++/I7dsXZ12M7nc6c7moI6RHAy6uCLZu8gu0srgGLdzsgUN1D
	 4LFxxYBytdSlplhRtMLOcO4Q08MLJiFPFlDg0Uyh/ptYB7ZUdj7TDNkQ17wvIj4jHM
	 YaAYnQ9ZvoKmZoXh9K+qnPZxsSSHhxRXxHFsnN61DCqnEM2aN6FRxVVlLcPEYdXWI0
	 X5xFSx4NBZeTQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 5/8] Squash to "selftests/bpf: Add bpf_bkup scheduler & test"
Date: Thu,  6 Mar 2025 10:15:37 +0800
Message-ID: <5334ee7eccc419c9b79c55834e78af0b047b1ebe.1741226722.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741226722.git.tanggeliang@kylinos.cn>
References: <cover.1741226722.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Update test_bpf_sched().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c     | 2 +-
 tools/testing/selftests/bpf/progs/mptcp_bpf.h      | 3 ---
 tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c | 2 +-
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 15f7a2b97623..ea31b3b28367 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -696,7 +696,7 @@ static void test_bkup(void)
 	if (!ASSERT_OK_PTR(skel, "open_and_load: bkup"))
 		return;
 
-	test_bpf_sched(skel->obj, "bkup", WITH_DATA, WITHOUT_DATA);
+	test_bpf_sched(skel->maps.bkup, "bkup", WITH_DATA, WITHOUT_DATA);
 	mptcp_bpf_bkup__destroy(skel);
 }
 
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
index badcffe0942c..4e901941d5dd 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
@@ -4,9 +4,6 @@
 
 #include "bpf_experimental.h"
 
-/* mptcp helpers from include/net/mptcp.h */
-#define MPTCP_SUBFLOWS_MAX 8
-
 /* list helpers from include/linux/list.h */
 static inline int list_is_head(const struct list_head *list,
 			       const struct list_head *head)
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
index 284cca708de0..b62ffdb7e2dd 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
@@ -32,7 +32,7 @@ int BPF_PROG(bpf_bkup_get_send, struct mptcp_sock *msk)
 	return 0;
 }
 
-SEC(".struct_ops")
+SEC(".struct_ops.link")
 struct mptcp_sched_ops bkup = {
 	.init		= (void *)mptcp_sched_bkup_init,
 	.release	= (void *)mptcp_sched_bkup_release,
-- 
2.43.0


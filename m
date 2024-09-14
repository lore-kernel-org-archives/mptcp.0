Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE5A10E9
	for <mptcp@lists.linux.dev>; Sat, 14 Sep 2024 08:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726304380; cv=none; b=RxnGrofwYJjo5oY4uEk56XwgZGRh9MBzwDp6o4WMGUlds6CHUsHoYhXvRsdOSBQ3aeNdVtzPpE7UVv2dd4tO3cStB+QyOsbO26fC+jVla26mUOMLxgt3ZMkB19IE5rBq21fQYHuEsrLQNOwRf29LzPgdQ22IfgMsF3Z3xjM9VAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726304380; c=relaxed/simple;
	bh=HiTklz2CFtiZTKDWh6s7UXBVztznjLS28ql2Yd/Fphk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gAAt5nNKSC5StyrCbc6sOs6r79Z1nvUbqPOUfhz4CUPZHHCwe5UIwIDd1MJAoTNo0S3y67IdmKfb1z5v/x3yQFDCSZs+OBJGdzSxaLEruqDCRAY2mBrQ9SJsLPu8BbGLd0SkBjKCisDkTyE8jI/P/XOXJlzaVrOTB0GcPteafPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hh+wmI7i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hh+wmI7i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B60C4CEC0;
	Sat, 14 Sep 2024 08:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726304379;
	bh=HiTklz2CFtiZTKDWh6s7UXBVztznjLS28ql2Yd/Fphk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hh+wmI7iDrN4LzvGx5tT/sBgaFN2Y2cevmqLqv1pb4rx6bBd7wy6tTxAkO/3jGORF
	 4ZkR4k7FyXXvTPFpJFtsD7A0W9UYRmExHHIOj6oiI++1eHcpqChZ2CvNkoezYvsw1G
	 9LYhvDKxBt95CDe8VOauNGne2isqf2R51fM/SI85ZCBNBTheTj739g/heva33WKOJK
	 IC33kruXTff9rdcSh2jNkLtGQI9iHharNFDXr0rNCh4R4LzM3m7i5MMpvLr8Ob+DDE
	 tFC96RhrRRqUeczuCn8Fwx4lcxTv2PFJSSTDqYN/a1J6q+N5eY8shIJcGeIM+YgVfI
	 3N4jpERzfFn6g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 2/4] Squash to "selftests/bpf: Add mptcp subflow subtest"
Date: Sat, 14 Sep 2024 16:59:28 +0800
Message-ID: <dc81fdee81e3ef2ba3db036ae35b1811dfe10c36.1726304196.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1726304196.git.tanggeliang@kylinos.cn>
References: <cover.1726304196.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Address Martin's comments:

Drop mptcp_subflow__attach.
Use bpf_program__attach_cgroup instead of bpf_prog_attach.
Use the skel->links.{mptcp_subflow, _getsockopt_subflow}, instead of declaring a
local "link".

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 20 +++++++------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index a3e68bc6afa3..acd79be134cd 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -424,10 +424,9 @@ static void run_subflow(void)
 
 static void test_subflow(void)
 {
-	int cgroup_fd, prog_fd, err;
 	struct mptcp_subflow *skel;
 	struct nstoken *nstoken;
-	struct bpf_link *link;
+	int cgroup_fd;
 
 	cgroup_fd = test__join_cgroup("/mptcp_subflow");
 	if (!ASSERT_OK_FD(cgroup_fd, "join_cgroup: mptcp_subflow"))
@@ -439,13 +438,14 @@ static void test_subflow(void)
 
 	skel->bss->pid = getpid();
 
-	err = mptcp_subflow__attach(skel);
-	if (!ASSERT_OK(err, "skel_attach: mptcp_subflow"))
+	skel->links.mptcp_subflow =
+		bpf_program__attach_cgroup(skel->progs.mptcp_subflow, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links.mptcp_subflow, "attach mptcp_subflow"))
 		goto skel_destroy;
 
-	prog_fd = bpf_program__fd(skel->progs.mptcp_subflow);
-	err = bpf_prog_attach(prog_fd, cgroup_fd, BPF_CGROUP_SOCK_OPS, 0);
-	if (!ASSERT_OK(err, "prog_attach"))
+	skel->links._getsockopt_subflow =
+		bpf_program__attach_cgroup(skel->progs._getsockopt_subflow, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links._getsockopt_subflow, "attach _getsockopt_subflow"))
 		goto skel_destroy;
 
 	nstoken = create_netns();
@@ -455,14 +455,8 @@ static void test_subflow(void)
 	if (endpoint_init("subflow") < 0)
 		goto close_netns;
 
-	link = bpf_program__attach_cgroup(skel->progs._getsockopt_subflow,
-					  cgroup_fd);
-	if (!ASSERT_OK_PTR(link, "getsockopt prog"))
-		goto close_netns;
-
 	run_subflow();
 
-	bpf_link__destroy(link);
 close_netns:
 	cleanup_netns(nstoken);
 skel_destroy:
-- 
2.43.0


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E89F4A1D
	for <mptcp@lists.linux.dev>; Wed, 18 Sep 2024 08:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726647929; cv=none; b=lz5fdmnzEPGI1b5XZo1mjNJHVauTGiiXcBN63LCb7/73HxZON+I9TDwU7KTOoVRRg6Q81QwIbQHQKaCzaiGEoJJ+9CHQKBw/o2IjjuoGyGKk0bjSpVezbnbnaD/kkpgdpL8hHky6i34Tkh3HHb2+gErOF1txcWSzXjGHKztldgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726647929; c=relaxed/simple;
	bh=HiTklz2CFtiZTKDWh6s7UXBVztznjLS28ql2Yd/Fphk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NeroyI10SrK8dXn9NtqS/xgPjxoxiq3agjZnMmXRMW8jXm7hZhtw0O+C1d3HB0QItjD6PQfNWMtlf0aiFInzFkaDweMyt5DF+v8AzRD9/8eATEg5LK9xwEXKRNJtIlOPfMNgao80olfJ1voMTfmaxRJrNO3405TQIYeDpQLMU7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oowz1odv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oowz1odv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E367C4CECD;
	Wed, 18 Sep 2024 08:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726647929;
	bh=HiTklz2CFtiZTKDWh6s7UXBVztznjLS28ql2Yd/Fphk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oowz1odvZA3DZfbTpsaDzpG//PM17V0BEifkV4+xhpd1g914XfNlGCtW+OE+2vFJb
	 uz+TRySnh8xjvmYR4O91PqaJa8zLA+rKSCNgDsG8J10pxdDSEj+c+C4YaWTFYNxNhE
	 2ihEDSU9SfaoDtkaJt62AygAXg5JNjAiZ459/oH2+NlnwuuaUfkNpmd5xHgSsxGc1L
	 LxMR1Q5R9V1oFoPOWLGYA4ldgLZj26goeARe60cSqcWNqmx1EMCPvCLOYvnPeShHAY
	 LuLY6ltmOuGy0l5Qo69uQx80qumfODJzlC0lsj2TcLfamxi3ecJagfObENpjJTWD9Z
	 IpbaFrH8sw/WQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 2/6] Squash to "selftests/bpf: Add mptcp subflow subtest"
Date: Wed, 18 Sep 2024 16:25:14 +0800
Message-ID: <b8d00c6dea72b0d3d13c81f8673f8da74dddf7f7.1726647599.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1726647599.git.tanggeliang@kylinos.cn>
References: <cover.1726647599.git.tanggeliang@kylinos.cn>
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


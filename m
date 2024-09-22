Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B581917C2
	for <mptcp@lists.linux.dev>; Sun, 22 Sep 2024 01:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726966835; cv=none; b=iqVbol5NU8gXlaFTZJhZNkWtcDq3EzV52JgnVSaLCv2Nwyx528mwd+Z9SmHjgYpGOGKuc2f/5cgN1vqQiedjl4Lb9H30gH8R0EhqcNJHzNDbccjywVJu/bN6vkwy58uSQwaMtHkCXuFv8asa54mC63Hx2O29VfFFVsPxk4vtLmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726966835; c=relaxed/simple;
	bh=/MQGSpgqw0c9AYsABsR9NU/ONy1mjNkY/DivCQWUUuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oza64VqIQQPB8kqXNWhHj1HnVhb31k23aWTE/Mh/zHHIoi51Crt9FEYjtI4bIA1JiBWzeGzlfsmZ8FYr5TjcFsbpxY2U/Dm9qsMa4T6fdwWTfQ+n/zPA2xKNtoaTBW6RvitykCRfyfUWD5Tb7QqK5rDKzhtOAF0A/0FhK03TnvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJi+NTny; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJi+NTny"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96610C4CEC2;
	Sun, 22 Sep 2024 01:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726966834;
	bh=/MQGSpgqw0c9AYsABsR9NU/ONy1mjNkY/DivCQWUUuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nJi+NTny6ZmbRrQ0WiW5XhK+NntZCFmrFef83/1rOuN5bZvFhr61jUxsEdmkdRR3r
	 AWgNbEtn9VRDsIOl68NjMAmw2TLN4TqOn3avWCncudtLneGwFDD0g7m2XG1/eGxV1c
	 19VuV4mggAqNNQoqJqsD2NvLWXT5DK/MaM/F2EKn7Ntr6lusIClNtm8AmV0uouo5+p
	 yq6h8+gCPRF3fiQUuE6DFCctf90nP50KLhOBNspcOWfvT5J87e6M5FOX5pwu5UQsqv
	 0fyhXvtapIiLPBSlm33PDIwntcN2pEHCY4ENJYrzhHWFdA+K9qfdITUTaNUwIeAnsy
	 +CD+5e80AXXrQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 2/3] Squash to "selftests/bpf: Add mptcp subflow subtest"
Date: Sun, 22 Sep 2024 09:00:25 +0800
Message-ID: <eb6e2006358f2d3bc629b262ade7b86b234b18d5.1726966638.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1726966638.git.tanggeliang@kylinos.cn>
References: <cover.1726966638.git.tanggeliang@kylinos.cn>
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

More subflows for endpoint_init:

Add two more test addresses ADDR_3 and ADDR_4, and adds a new parameter
"subflows" for endpoint_init() to control how many subflows are used for the
tests. This makes it more flexible.

Update the parameters of endpoint_init() in test_subflow().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 56 +++++++++++++------
 1 file changed, 38 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index a3e68bc6afa3..167fd9b190ee 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -20,6 +20,8 @@
 #define NS_TEST "mptcp_ns"
 #define ADDR_1	"10.0.1.1"
 #define ADDR_2	"10.0.1.2"
+#define ADDR_3	"10.0.1.3"
+#define ADDR_4	"10.0.1.4"
 #define PORT_1	10001
 #define WITH_DATA	true
 #define WITHOUT_DATA	false
@@ -351,22 +353,46 @@ static void test_mptcpify(void)
 	close(cgroup_fd);
 }
 
-static int endpoint_init(char *flags)
+static int endpoint_add(char *addr, char *flags)
 {
+	return SYS_NOFAIL("ip -net %s mptcp endpoint add %s %s",
+			  NS_TEST, addr, flags);
+}
+
+static int endpoint_init(char *flags, u8 subflows)
+{
+	int ret = -1;
+
+	if (!subflows || subflows > 4)
+		goto fail;
+
 	SYS(fail, "ip -net %s link add veth1 type veth peer name veth2", NS_TEST);
 	SYS(fail, "ip -net %s addr add %s/24 dev veth1", NS_TEST, ADDR_1);
 	SYS(fail, "ip -net %s link set dev veth1 up", NS_TEST);
 	SYS(fail, "ip -net %s addr add %s/24 dev veth2", NS_TEST, ADDR_2);
 	SYS(fail, "ip -net %s link set dev veth2 up", NS_TEST);
-	if (SYS_NOFAIL("ip -net %s mptcp endpoint add %s %s", NS_TEST, ADDR_2, flags)) {
+
+	SYS(fail, "ip -net %s link add veth3 type veth peer name veth4", NS_TEST);
+	SYS(fail, "ip -net %s addr add %s/24 dev veth3", NS_TEST, ADDR_3);
+	SYS(fail, "ip -net %s link set dev veth3 up", NS_TEST);
+	SYS(fail, "ip -net %s addr add %s/24 dev veth4", NS_TEST, ADDR_4);
+	SYS(fail, "ip -net %s link set dev veth4 up", NS_TEST);
+
+	if (SYS_NOFAIL("ip -net %s mptcp limits set subflows 4", NS_TEST)) {
 		printf("'ip mptcp' not supported, skip this test.\n");
 		test__skip();
 		goto fail;
 	}
 
-	return 0;
+	if (subflows > 1)
+		ret = endpoint_add(ADDR_2, flags);
+	if (subflows > 2)
+		ret = ret ?: endpoint_add(ADDR_3, flags);
+	if (subflows > 3)
+		ret = ret ?: endpoint_add(ADDR_4, flags);
+
 fail:
-	return -1;
+	return ret;
 }
 
 static void wait_for_new_subflows(int fd)
@@ -424,10 +450,9 @@ static void run_subflow(void)
 
 static void test_subflow(void)
 {
-	int cgroup_fd, prog_fd, err;
 	struct mptcp_subflow *skel;
 	struct nstoken *nstoken;
-	struct bpf_link *link;
+	int cgroup_fd;
 
 	cgroup_fd = test__join_cgroup("/mptcp_subflow");
 	if (!ASSERT_OK_FD(cgroup_fd, "join_cgroup: mptcp_subflow"))
@@ -439,30 +464,25 @@ static void test_subflow(void)
 
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
 	if (!ASSERT_OK_PTR(nstoken, "create_netns: mptcp_subflow"))
 		goto skel_destroy;
 
-	if (endpoint_init("subflow") < 0)
-		goto close_netns;
-
-	link = bpf_program__attach_cgroup(skel->progs._getsockopt_subflow,
-					  cgroup_fd);
-	if (!ASSERT_OK_PTR(link, "getsockopt prog"))
+	if (endpoint_init("subflow", 2) < 0)
 		goto close_netns;
 
 	run_subflow();
 
-	bpf_link__destroy(link);
 close_netns:
 	cleanup_netns(nstoken);
 skel_destroy:
-- 
2.43.0


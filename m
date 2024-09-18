Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91FD4A1D
	for <mptcp@lists.linux.dev>; Wed, 18 Sep 2024 08:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726647931; cv=none; b=NCMPU6n43PPULcdh/k5L+Jbey2DIJnjdw9UXSDYf+E1GSz5dUzp/9ZK71EN6JoR/JOnxHu3EUn53FPidAJ3HeOleSfcdB5xphg2qYZiazlgEeTSysGjDXoBUpCMY6gCsqz8iVVlpBQRNtT/o7iK6D7VWA4yhwcWmj2QgGPFhpfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726647931; c=relaxed/simple;
	bh=D8PfTAmPuHjWujUQ9BejNY7QP42pjnoQ8PAlKl55cRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F3c98PRMHX/zay52v+tfQGIDHRYUjzf32h+tbRd/rk010PS+yNQ46YFq2TmQjygq3UuHxcWjv29wV/+16t6q5mdA0SKNnL+xpOGjMEscCQUUaDm6yZUJp88lj5o3FdBjfO48ugjz3TmS+gIgCADpgaEZnVGmBqZja8LB7O5J8rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8apTP3m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8apTP3m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC41AC4CEC3;
	Wed, 18 Sep 2024 08:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726647931;
	bh=D8PfTAmPuHjWujUQ9BejNY7QP42pjnoQ8PAlKl55cRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J8apTP3mBsz4gH3FNfWWtyuMjr6KyMmjgtn0PNBHv8Ot6cu+CPuC4xlGkkAOvw8CM
	 dLv4BFXNQ4Y/KXJ2/q/IiVyDjc4BuWGpHxyGUIVpEEJSE0Fq/KL+m2NV36phuqMjfo
	 IkTUjRd62weJV+zft1W8y7k5FW/P9zXrfNFWiD8SJdGe12QFMDICSivHoZWctQEZsG
	 O8w3J6jnKia+ZA1+iYCenS9p0ulvOcX9Wr4ruXAToTCLSqxrodgl2Vfx0lAxZwaDpe
	 5VMzlI8kcPlMq4MGpLTNv/2+bVELD0L6tvtrQtZ1epfDW65KVDn0PYMkg3u9fT1EVm
	 1d+ghJvYLovhg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 3/6] selftests/bpf: More subflows for endpoint_init
Date: Wed, 18 Sep 2024 16:25:15 +0800
Message-ID: <775a0af80c03fe1af8f36778615bb314278ec847.1726647599.git.tanggeliang@kylinos.cn>
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

Squash to "selftests/bpf: Add mptcp subflow subtest" 2

This patch adds two more test addresses ADDR_3 and ADDR_4, and adds a new
parameter "subflows" for endpoint_init() to control how many subflows are
used for the tests. This makes it more flexible.

Update the parameters of endpoint_init() in test_subflow().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 25 ++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index acd79be134cd..f4715b1692df 100644
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
@@ -351,19 +353,36 @@ static void test_mptcpify(void)
 	close(cgroup_fd);
 }
 
-static int endpoint_init(char *flags)
+static int endpoint_init(char *flags, u8 subflows)
 {
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
 
+	if (subflows > 1)
+		SYS_NOFAIL("ip -net %s mptcp endpoint add %s %s", NS_TEST, ADDR_2, flags);
+	if (subflows > 2)
+		SYS_NOFAIL("ip -net %s mptcp endpoint add %s %s", NS_TEST, ADDR_3, flags);
+	if (subflows > 3)
+		SYS_NOFAIL("ip -net %s mptcp endpoint add %s %s", NS_TEST, ADDR_4, flags);
+
 	return 0;
 fail:
 	return -1;
@@ -452,7 +471,7 @@ static void test_subflow(void)
 	if (!ASSERT_OK_PTR(nstoken, "create_netns: mptcp_subflow"))
 		goto skel_destroy;
 
-	if (endpoint_init("subflow") < 0)
+	if (endpoint_init("subflow", 2) < 0)
 		goto close_netns;
 
 	run_subflow();
-- 
2.43.0


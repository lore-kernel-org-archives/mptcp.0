Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEE529CFE
	for <mptcp@lists.linux.dev>; Tue,  1 Oct 2024 06:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727765248; cv=none; b=DIXkzI+IePn+kd1DWulydTzkwlsdJB35YOxWzkbFsK7uoHFl5dS3Ne4x8BCdgJMa5iMvpZKo4oOyajGmW5NoJINH2BZKxV7L7FBtaEHYhnMS9ZbL1e/4DVwENZMlhQu2UYIBZs/NN+vN76ZGbnAklppI49pDbCGRHvyDGGOK6+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727765248; c=relaxed/simple;
	bh=PqhL1+HJ5QSdK+L/sMvyJR56R2rzBeswxSui00kjs7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eu4Zvfs4YbkUEz9xaCLFksD4wFRwExdWbDqrFijZvGSStP3GPsJetyLwUDqo5MQsT/MntcdQnYWggIhs1JY4D5xJzPDE5q7xA8F1Ms5mPBB6AyKI1VW3wuZTUsxkOojppyjdjACsqTLCwb0RxxqHANU2n+h3XzHpzAhA/rkDz5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYXuoCrG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYXuoCrG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B46C4CEC6;
	Tue,  1 Oct 2024 06:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727765248;
	bh=PqhL1+HJ5QSdK+L/sMvyJR56R2rzBeswxSui00kjs7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XYXuoCrG1+4j+OCTcFU49nnLav+WO9Ag0kncR8/NIqy6Pk9DtYC85Ur9Si46aMgQM
	 x1FdIRHgZlkQvJzW+GumCYDySHtChd67f9Dcnkj3Smh8RKSCEmHEG/ggRunre9MNve
	 Ezy012xsupYD+sO2mgrrLVLzxRaDQjhhrLE4SsaGwUHO7XiAspTdQcGOqgUDwS4Dm7
	 yZuvPS6qWXH0bmnimwzcxSEBPx/9wQya4graxzncfVO6U2umaEOrzXukbC+QO/gYPi
	 C6ftERi3jkkcesFomWTgjTBb/ZYdvgnCbiBQPgZoWliJiwzpqv35ketfFMyDiGPJBw
	 lZnt8sR2EQkfA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 5/7] selftests/bpf: More endpoints for endpoint_init
Date: Tue,  1 Oct 2024 14:47:12 +0800
Message-ID: <5b84c40407eded05011495d2a61e6373f15b2ed3.1727764822.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727764822.git.tanggeliang@kylinos.cn>
References: <cover.1727764822.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds two more test addresses ADDR_3 and ADDR_4, and adds a new
helper address_init() to initialize all these addresses.

Add a new parameter "endpoints" for endpoint_init() to control how many
endpoints are used for the tests. This makes it more flexible.

Update the parameters of endpoint_init() in test_subflow().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 46 +++++++++++++++++--
 1 file changed, 41 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index acd79be134cd..076903680e75 100644
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
@@ -351,22 +353,56 @@ static void test_mptcpify(void)
 	close(cgroup_fd);
 }
 
-static int endpoint_init(char *flags)
+static int address_init(void)
 {
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
+	return 0;
+fail:
+	return -1;
+}
+
+static int endpoint_add(char *addr, char *flags)
+{
+	return SYS_NOFAIL("ip -net %s mptcp endpoint add %s %s", NS_TEST, addr, flags);
+}
+
+static int endpoint_init(char *flags, u8 endpoints)
+{
+	int ret = -1;
+
+	if (!endpoints || endpoints > 4)
+		goto fail;
+
+	if (address_init())
+		goto fail;
+
+	if (SYS_NOFAIL("ip -net %s mptcp limits set add_addr_accepted 4 subflows 4",
+		       NS_TEST)) {
 		printf("'ip mptcp' not supported, skip this test.\n");
 		test__skip();
 		goto fail;
 	}
 
-	return 0;
+	if (endpoints > 1)
+		ret = endpoint_add(ADDR_2, flags);
+	if (endpoints > 2)
+		ret = ret ?: endpoint_add(ADDR_3, flags);
+	if (endpoints > 3)
+		ret = ret ?: endpoint_add(ADDR_4, flags);
+
 fail:
-	return -1;
+	return ret;
 }
 
 static void wait_for_new_subflows(int fd)
@@ -452,7 +488,7 @@ static void test_subflow(void)
 	if (!ASSERT_OK_PTR(nstoken, "create_netns: mptcp_subflow"))
 		goto skel_destroy;
 
-	if (endpoint_init("subflow") < 0)
+	if (endpoint_init("subflow", 2) < 0)
 		goto close_netns;
 
 	run_subflow();
-- 
2.43.0


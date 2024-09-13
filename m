Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E153984D2C
	for <mptcp@lists.linux.dev>; Fri, 13 Sep 2024 09:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726218274; cv=none; b=nb2uD7CXxXdDxazlS+M7RQDvehV0bG5JDiP3hgNYYBvJb0BMDofZl3Oy0CEFWiG/xHajiE/sdullJt81MlPxo3ZNLxbCqMi7Jprtt++R7W0TvvFxISKgQd0RksOOneiVWeEAPhtqiyPTyD+ugPF257RmqJGRBWHuS92SvCcet4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726218274; c=relaxed/simple;
	bh=soOR/tHt9O+AIb5cqYQpoC5z7sYVw7YCzNoqFuvXpfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FuH+Un+h8RLG4Uy6P0qpqETTSgH9ekFaQrcJVij+JEhl77BeisxZRtibuYPtbMMUqHLNijvQWe5fbEqcIC67on78wrUXSoSkgONGopqLmm2Pg9skKxQB7yZKlNoqxqhIcOi7GdB3k+MDEVmwuIQJT5Wr6UXYVaI188kmter7oSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DByDoiHS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DByDoiHS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E52C4CEC0;
	Fri, 13 Sep 2024 09:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726218273;
	bh=soOR/tHt9O+AIb5cqYQpoC5z7sYVw7YCzNoqFuvXpfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DByDoiHStOYL6T/La/yw1CwrONU/BYCk17OeUNAGJ3uAthbz/a6kI4tMCT6DmBndR
	 w4FdNGbMH0a2Io/f7znMS8RRCjvW8elR8/TABtF5LGnpDGuFc/03F6pkR/f1V+U2zr
	 r3lcQ8JCVbxry8NE7tbNWZlcH8Xe8uOFGTX0LfZ9visSx1jeiBe5anbKjWfTJPahGT
	 3GATTvmZxeAwnL5D90NBwtJ0UoBlQ+aBwAfdPDRXfyrsugTy2DnoFRDpi+tfLaDoiI
	 6oACkjYPzbeQdqVP2KiWOfK79+EbJT0tcYCRQ56UwCzBkEvrqfR5GVlcue2znidZev
	 isNisJ6TzHywg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 1/2] selftests/bpf: More subflows for endpoint_init
Date: Fri, 13 Sep 2024 17:04:24 +0800
Message-ID: <1d35ec6fae9269ba68fced83ad64b7e2e5bf8d47.1726217806.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1726217806.git.tanggeliang@kylinos.cn>
References: <cover.1726217806.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds two more test addresses ADDR_3 and ADDR_4, and adds a new
parameter "subflows" for endpoint_init() to control how many subflows are
used for the tests. This makes it more flexible.

Update the parameters of endpoint_init() in test_subflow().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 25 ++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index a3e68bc6afa3..b5fdb6dc36e0 100644
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
+static int endpoint_init(char *flags, int subflows)
 {
+	if (subflows > 4)
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
 
 	link = bpf_program__attach_cgroup(skel->progs._getsockopt_subflow,
-- 
2.43.0


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F001EF925
	for <mptcp@lists.linux.dev>; Fri, 18 Oct 2024 09:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729243154; cv=none; b=CIIFjJ/+n45G8mnWKxQPJFNW4kajXL8K/JhnTNmjjhuLz6NScUW7lIarqcMHqKOaGLsP2R2dQW0o5sIMnEHR1LsWTAfDdDGJIFT3uFuzpc25Q7R3HOiYYkCsqSRYeR0fkuqke44mNr1HiT1OO/l0g9y5mqFLWDdLVG1IzSubYjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729243154; c=relaxed/simple;
	bh=Igt3me+CnEmDDCvFx8jssf6o0vBlnpw5qHsXTC9jK2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gMeNcjF83ZQcnoVaSvwFRVjt57+sLRIBQhEFHvA+NH+l1aAVm6dXMRer0WgQGY0itN8AThmnnCQxYDJ5uEHaApULRpiUXILBEUeX1l8o1gPEI1WtkfxT6fBffU3irfsZEOQ6H7eE10JpU9m5vZIUStjhvT7fVIQH/nG7WJ1/BLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=untXldta; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="untXldta"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1D6C4CECF;
	Fri, 18 Oct 2024 09:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729243154;
	bh=Igt3me+CnEmDDCvFx8jssf6o0vBlnpw5qHsXTC9jK2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=untXldtaPjXQRPlEvvT3F/go1zPY+hmmwcma7hdIe/ZOUOPaTC0ixlebUpXo8GzHY
	 DqKNeNErjBczCYrY6Y3h+baeV0xwsURrqXG0sjanCy67neY4Jslr2fjymDNYJzKTwV
	 jeWcLq0/8jAvrKdDbT3BKnV3I3pTqxGK7PeDE7XAB6bZNRzhSCgdsw9otzk7t1zdB7
	 voAVCe/ZgE3cT6ythLP1HMETeYWc7mLK9dpIcyJ12YsasNwGjORMyuwD4gBL7DSN6D
	 r3/3AGIDsQ/LHbmudyx615UaPSpyQyayPVOA30rz1ateGee44OiHj7iXRtQeLdsJUD
	 NuuRpowUHrXtQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 5/9] selftests/bpf: More endpoints for endpoint_init
Date: Fri, 18 Oct 2024 17:18:07 +0800
Message-ID: <7a6d58423af3592ca45ae04b5cd563ea0c0444f5.1729242644.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729242644.git.tanggeliang@kylinos.cn>
References: <cover.1729242644.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch changes ADDR_2 from "10.0.1.2" to "10.0.2.1", and adds two more
IPv4 test addresses ADDR_3 - ADDR_4, four IPv6 addresses ADDR6_1 - ADDR6_4.
Add a new helper address_init() to initialize all these addresses.

Add a new parameter "endpoints" for endpoint_init() to control how many
endpoints are used for the tests. This makes it more flexible. Update the
parameters of endpoint_init() in test_subflow().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 56 +++++++++++++++++--
 1 file changed, 50 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index d0dc2e4fbe46..02fdff87df2d 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -19,7 +19,13 @@
 
 #define NS_TEST "mptcp_ns"
 #define ADDR_1	"10.0.1.1"
-#define ADDR_2	"10.0.1.2"
+#define ADDR_2	"10.0.2.1"
+#define ADDR_3	"10.0.3.1"
+#define ADDR_4	"10.0.4.1"
+#define ADDR6_1	"dead:beef:1::1"
+#define ADDR6_2	"dead:beef:2::1"
+#define ADDR6_3	"dead:beef:3::1"
+#define ADDR6_4	"dead:beef:4::1"
 #define PORT_1	10001
 #define WITH_DATA	true
 #define WITHOUT_DATA	false
@@ -351,22 +357,60 @@ static void test_mptcpify(void)
 	close(cgroup_fd);
 }
 
-static int endpoint_init(char *flags)
+static int address_init(void)
 {
 	SYS(fail, "ip -net %s link add veth1 type veth peer name veth2", NS_TEST);
 	SYS(fail, "ip -net %s addr add %s/24 dev veth1", NS_TEST, ADDR_1);
+	SYS(fail, "ip -net %s addr add %s/64 dev veth1 nodad", NS_TEST, ADDR6_1);
 	SYS(fail, "ip -net %s link set dev veth1 up", NS_TEST);
 	SYS(fail, "ip -net %s addr add %s/24 dev veth2", NS_TEST, ADDR_2);
+	SYS(fail, "ip -net %s addr add %s/64 dev veth2 nodad", NS_TEST, ADDR6_2);
 	SYS(fail, "ip -net %s link set dev veth2 up", NS_TEST);
-	if (SYS_NOFAIL("ip -net %s mptcp endpoint add %s %s", NS_TEST, ADDR_2, flags)) {
+
+	SYS(fail, "ip -net %s link add veth3 type veth peer name veth4", NS_TEST);
+	SYS(fail, "ip -net %s addr add %s/24 dev veth3", NS_TEST, ADDR_3);
+	SYS(fail, "ip -net %s addr add %s/64 dev veth3 nodad", NS_TEST, ADDR6_3);
+	SYS(fail, "ip -net %s link set dev veth3 up", NS_TEST);
+	SYS(fail, "ip -net %s addr add %s/24 dev veth4", NS_TEST, ADDR_4);
+	SYS(fail, "ip -net %s addr add %s/64 dev veth4 nodad", NS_TEST, ADDR6_4);
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
@@ -452,7 +496,7 @@ static void test_subflow(void)
 	if (!ASSERT_OK_PTR(nstoken, "create_netns: mptcp_subflow"))
 		goto skel_destroy;
 
-	if (endpoint_init("subflow") < 0)
+	if (endpoint_init("subflow", 2) < 0)
 		goto close_netns;
 
 	run_subflow();
-- 
2.43.0


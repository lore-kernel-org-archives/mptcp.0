Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B610A10E9
	for <mptcp@lists.linux.dev>; Sat, 14 Sep 2024 08:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726304381; cv=none; b=gEkX/cFoi3H/R2Lyp4tTTAUwRs3Nn8tgJmE4UYnYJ4D3HUKPI9ok3gqOAXe9zFpCj88aA3MhwdE8gH7IT7LaUFBLT4xT0du5QZcFuQBtZ0Fv7uCXKNFroSCN1GTW33LJalwsX3db/jy78/Av+xja1CUn5+fWKSKITczm28zaue8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726304381; c=relaxed/simple;
	bh=D8PfTAmPuHjWujUQ9BejNY7QP42pjnoQ8PAlKl55cRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XgMM6rx629yiUZ85Hdru3ldfZ4+g3I6WfCR5FdvNq5aOj84AXiUHcdDRyNpnPgQeW6lrKOu/Dqa9x9xr13sVighAHEkFZ20mRlvZANvln7f9pg0ViCrUKfxnx6EjVeTJykSUuHM6IkuKbEegZm28IzykmPWdNE8tzdrVVvAJ1XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WiURwiUl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WiURwiUl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F03C4CECD;
	Sat, 14 Sep 2024 08:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726304381;
	bh=D8PfTAmPuHjWujUQ9BejNY7QP42pjnoQ8PAlKl55cRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WiURwiUl/SkImhqr2vOXHXSBFdFh+0F/tOzJ+Fu1XSS1JU2djIXbVFQ6IdIUhaxXk
	 1uFSVy8Pkipv9a/jG1nIl404r+Dk6pKmTeXPATOvPn22UfRIdP/6dljLc/z3YWaLH+
	 pDk2sGISctPgP6HilJAbwyB4q8mWCCN2nzT5haOTFwp+q2/9yYOvhGWn9mMiHh8wPN
	 NXm5/N0X2MhbXbQ7loddLHryZXMAoKjwrHR5/BDdUELOxUlO+3FEWwA6BS2W6PDBx4
	 6au/T5qsNyaUVDxjA8nJ3PJfG+VD366OYiEXx72mDA0CHNsAg2n0IQQJodwoK2tIoh
	 B8KtQHZtEyjZA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 3/4] selftests/bpf: More subflows for endpoint_init
Date: Sat, 14 Sep 2024 16:59:29 +0800
Message-ID: <d30968fea13fa6d0ffaa222d89d3ec29754e29c6.1726304196.git.tanggeliang@kylinos.cn>
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


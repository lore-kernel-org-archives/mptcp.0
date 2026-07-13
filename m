Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2653E2AB1
	for <mptcp@lists.linux.dev>; Mon, 13 Jul 2026 09:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783936683; cv=none; b=DePiv5pWdaesxQuC5UeMJ/nak0lojX6eTZuzeM3mCSLUY/66R9asu14lb3nHn44uxanFciwiSddwBFeAEw6KhirwTSoeUWN2++a1fNHWijxA7lxJfM0EdcpAbEeUmILSq1V8nkF9Y+N6j7mXABPfN+Qop6luiG2o2N0CLVOYLTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783936683; c=relaxed/simple;
	bh=5ENV5Fd57hzmb7xSW4bYLIJnGboG3xK5zWrvvfpNfQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HRBrih/NZSp06xgBE0OF47wDCOqvR/uW2sS0HqOr4D53Np6AsRcbrXnP6KDkFRV11nMuiC0CNphWDSSoRSKIv0BMM4XzbLw1u31F2zHJ8C8E3t1zSE5O1fYICLDFUnV2CMKGmjkQDDGjWSfEitz9n/W0g+MZGclhGEtIe2/j1Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bOUyYbYq; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bOUyYbYq"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783936679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u5KSWnznuuD2BQAMxk3d2zE+dJZ+HCdUDIt7xKsPYug=;
	b=bOUyYbYqrYSAa04TtF6bPD4Sgd0suWrtiCMt9K9i/hLA8f3H4tSYIS62bJzDyAppY/IKhx
	6rZLPxORJzrBMGDbaXez3QmoBo8sTtm4SbvJUgdguVo1rjRte1kPyTwVuAFWYjKME1ZP+i
	rCTshCZ/ltSDcDZ8dTZSD4VB4yk36Cc=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next 5/5] selftests: bpf: verify mptcp bpf_setsockopt from TCP_CONNECT_CB
Date: Mon, 13 Jul 2026 17:57:35 +0800
Message-ID: <20260713095735.1222033-6-gang.yan@linux.dev>
In-Reply-To: <20260713095735.1222033-1-gang.yan@linux.dev>
References: <20260713095735.1222033-1-gang.yan@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

Add a BPF sockops program attached to BPF_CGROUP_SOCK_OPS that fires
on BPF_SOCK_OPS_TCP_CONNECT_CB and exercises bpf_setsockopt() on the
mptcp master socket (msk).

Two scenarios are covered by the new "setsockopt" subtest:
 - TCP_INQ must succeed and the value (1) must be observable from
   userspace via getsockopt() on the mptcp socket.
 - TCP_CONGESTION needs the subflow lock and is therefore rejected
   in bpf context with -EOPNOTSUPP.

Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 61 +++++++++++++++++++
 .../selftests/bpf/progs/mptcp_setsockopt.c    | 32 ++++++++++
 2 files changed, 93 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_setsockopt.c

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 7f48fd9e94e1..ad59f8fcbb68 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -18,6 +18,7 @@
 #include "mptcp_bpf_rr.skel.h"
 #include "mptcp_bpf_red.skel.h"
 #include "mptcp_bpf_burst.skel.h"
+#include "mptcp_setsockopt.skel.h"
 
 #define NS_TEST "mptcp_ns"
 #define ADDR_1	"10.0.1.1"
@@ -813,6 +814,64 @@ static void test_burst(void)
 	mptcp_bpf_burst__destroy(skel);
 }
 
+static void test_setsockopt(void)
+{
+	struct mptcp_setsockopt *skel;
+	struct netns_obj *netns;
+	int cgroup_fd, server_fd, client_fd;
+	int err;
+	int inq;
+	socklen_t len;
+
+	cgroup_fd = test__join_cgroup("/mptcp_setsockopt");
+	if (!ASSERT_OK_FD(cgroup_fd, "join_cgroup"))
+		return;
+
+	skel = mptcp_setsockopt__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_load"))
+		goto close_cgroup;
+
+	skel->links.mptcp_connect_cb =
+		bpf_program__attach_cgroup(skel->progs.mptcp_connect_cb,
+					   cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links.mptcp_connect_cb, "attach connect_cb"))
+		goto skel_destroy;
+
+	netns = netns_new(NS_TEST, true);
+	if (!ASSERT_OK_PTR(netns, "netns_new"))
+		goto skel_destroy;
+
+	server_fd = start_mptcp_server(AF_INET, NULL, 0, 0);
+	if (!ASSERT_OK_FD(server_fd, "start_mptcp_server"))
+		goto close_netns;
+
+	client_fd = connect_to_fd(server_fd, 0);
+	if (!ASSERT_OK_FD(client_fd, "connect_to_fd"))
+		goto close_server;
+
+	/* TCP_INQ should be set successfullly */
+	ASSERT_EQ(skel->bss->connect_cb_inq_ret, 0, "connect_cb TCP_INQ ret");
+
+	len = sizeof(inq);
+	err = getsockopt(client_fd, SOL_TCP, TCP_INQ, &inq, &len);
+	if (ASSERT_OK(err, "getsockopt TCP_INQ"))
+		ASSERT_EQ(inq, 1, "TCP_INQ value");
+
+	/* TCP_CONGESTION should be -EOPNOTSUPP */
+	ASSERT_EQ(skel->bss->connect_cb_cc_ret, -EOPNOTSUPP,
+		  "connect_cb TCP_CONGESTION ret");
+
+	close(client_fd);
+close_server:
+	close(server_fd);
+close_netns:
+	netns_free(netns);
+skel_destroy:
+	mptcp_setsockopt__destroy(skel);
+close_cgroup:
+	close(cgroup_fd);
+}
+
 void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
@@ -835,4 +894,6 @@ void test_mptcp(void)
 		test_red();
 	if (test__start_subtest("burst"))
 		test_burst();
+	if (test__start_subtest("setsockopt"))
+		test_setsockopt();
 }
diff --git a/tools/testing/selftests/bpf/progs/mptcp_setsockopt.c b/tools/testing/selftests/bpf/progs/mptcp_setsockopt.c
new file mode 100644
index 000000000000..f54b77ea6c5f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_setsockopt.c
@@ -0,0 +1,32 @@
+#include "bpf_tracing_net.h"
+#include "mptcp_bpf.h"
+
+#ifndef TCP_INQ
+#define TCP_INQ 36
+#endif
+
+int connect_cb_inq_ret;
+int connect_cb_cc_ret;
+
+char cc_reno[TCP_CA_NAME_MAX] = "reno";
+
+SEC("sockops")
+int mptcp_connect_cb(struct bpf_sock_ops *skops)
+{
+	struct bpf_sock *sk = skops->sk;
+	int one = 1;
+
+	if (skops->op != BPF_SOCK_OPS_TCP_CONNECT_CB)
+		return 1;
+
+	if (!sk || sk->protocol != IPPROTO_MPTCP)
+		return 1;
+
+	connect_cb_inq_ret =
+		bpf_setsockopt(skops, SOL_TCP, TCP_INQ, &one, sizeof(one));
+	connect_cb_cc_ret =
+		bpf_setsockopt(skops, SOL_TCP, TCP_CONGESTION,
+			       cc_reno, sizeof(cc_reno));
+
+	return 1;
+}
-- 
2.43.0


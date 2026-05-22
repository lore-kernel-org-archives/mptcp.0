Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4503B95EC
	for <mptcp@lists.linux.dev>; Fri, 22 May 2026 09:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779441180; cv=none; b=Epknji+Jm96yKBzzcCmBsrM0pNArmOJSefdqmxLMKPzeTMjYtXhwnF/xb0OCX/v8HjNv8SjyMm/0fWUL14G8Qij4rGphgd3mBhRnlqyQvjh28p8Jd1k82pjqJ7aYAWBaEChvco6nnd0hthuUPV64Clt+pctOtpTTERSqjsSIA9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779441180; c=relaxed/simple;
	bh=PTkef1vyPUBbGN0Ya64G2dNXajS5t+xMqyed5QbytEU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bU5QqB9ucZjkY0tdi0MdpnALg/7zKfgAXdRzbJ38DnbdDzBvbr/TGiO5C64utRoAudvB7zZ2PuKX4aTIjOQOwmNVqWECTDxE41h0TAWsFmWr9cXmi+AXflqArSeQfxDuUkZeCn9O04sqjiHPkIeMesIPInqEr1syWpP2gOgR5+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aAdGW5AE; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aAdGW5AE"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779441177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IWAWh/3JIuSfqrJGjmUiaJGIuqZS/9EWg8ezwclaPgM=;
	b=aAdGW5AEqJua3OaLccwekXGBzAhtITNcdgh7299ysAkQY3slWHl8O4CVXSFQD3KftYvFuJ
	I6A2YoDTWVGC9snuPs5bnrCLsVSF7fNsgA6D/PkcliSsMBOIUeZ8vzhRPBUjdzSFCG2IWi
	lDE2TUkHrMGie4XLaHPaHXTbrc13Ojc=
From: Gang Yan <gang.yan@linux.dev>
Date: Fri, 22 May 2026 17:12:36 +0800
Subject: [PATCH mptcp-next v5 6/6] DO-NOT-MERGE: selftest: bpf: set mptcp
 sockopt in BPF context
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-sockopt_lock-v5-6-108629a46e98@kylinos.cn>
References: <20260522-sockopt_lock-v5-0-108629a46e98@kylinos.cn>
In-Reply-To: <20260522-sockopt_lock-v5-0-108629a46e98@kylinos.cn>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Gang Yan <yangang@kylinos.cn>, pabeni@redhat.com
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

Add a test to verify that bpf_setsockopt() called from a
cgroup/setsockopt BPF program on an MPTCP socket correctly returns
-EOPNOTSUPP when the target option requires subflow-level locking.

Assisted-by: Claude:glm-5.1
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c     | 64 +++++++++++++++++++
 .../testing/selftests/bpf/progs/mptcp_setsockopt.c | 71 ++++++++++++++++++++++
 2 files changed, 135 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 7f48fd9e94e1..e6b0f5ed3ff0 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -18,6 +18,7 @@
 #include "mptcp_bpf_rr.skel.h"
 #include "mptcp_bpf_red.skel.h"
 #include "mptcp_bpf_burst.skel.h"
+#include "mptcp_setsockopt.skel.h"
 
 #define NS_TEST "mptcp_ns"
 #define ADDR_1	"10.0.1.1"
@@ -813,6 +814,67 @@ static void test_burst(void)
 	mptcp_bpf_burst__destroy(skel);
 }
 
+static void test_setsockopt(void)
+{
+	struct mptcp_setsockopt *skel;
+	struct netns_obj *netns;
+	int cgroup_fd, server_fd, client_fd;
+	int map_fd, err;
+	__s32 val = 1024 * 1024, result;
+	__u32 key = 0;
+
+	cgroup_fd = test__join_cgroup("/mptcp_setsockopt");
+	if (!ASSERT_OK_FD(cgroup_fd, "join_cgroup"))
+		return;
+
+	skel = mptcp_setsockopt__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_load"))
+		goto close_cgroup;
+
+	err = bpf_prog_attach(bpf_program__fd(skel->progs.mptcp_setsockopt),
+			      cgroup_fd, BPF_CGROUP_SETSOCKOPT, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach"))
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
+	/* Trigger cgroup/setsockopt BPF program by calling setsockopt.
+	 * The BPF program calls bpf_setsockopt(sk, SO_RCVLOWAT, ...) which
+	 * reaches mptcp_set_rcvlowat(). There has_current_bpf_ctx() is true,
+	 * so it should return -EOPNOTSUPP.
+	 */
+	err = setsockopt(client_fd, SOL_SOCKET, SO_RCVLOWAT, &val, sizeof(val));
+	ASSERT_OK(err, "setsockopt(SO_RCVLOWAT)");
+
+	map_fd = bpf_map__fd(skel->maps.results);
+	err = bpf_map_lookup_elem(map_fd, &key, &result);
+	if (!ASSERT_OK(err, "bpf_map_lookup_elem"))
+		goto close_client;
+
+	ASSERT_EQ(result, -EOPNOTSUPP, "bpf_setsockopt(SO_RCVLOWAT)");
+
+close_client:
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
@@ -835,4 +897,6 @@ void test_mptcp(void)
 		test_red();
 	if (test__start_subtest("burst"))
 		test_burst();
+	if (test__start_subtest("setsockopt"))
+		test_setsockopt();
 }
diff --git a/tools/testing/selftests/bpf/progs/mptcp_setsockopt.c b/tools/testing/selftests/bpf/progs/mptcp_setsockopt.c
new file mode 100644
index 000000000000..4c14c59bd03d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_setsockopt.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025, SUSE. */
+
+/* Test that bpf_setsockopt() called from a cgroup/setsockopt BPF program
+ * on an MPTCP socket returns -EOPNOTSUPP when the target option requires
+ * subflow-level locking (e.g. SO_RCVLOWAT via mptcp_set_rcvlowat).
+ *
+ * Flow:
+ *   userspace: setsockopt(mptcp_fd, SOL_SOCKET, SO_RCVLOWAT, &large_val, ...)
+ *     -> do_sock_setsockopt()
+ *        -> BPF_CGROUP_RUN_PROG_SETSOCKOPT(sk)    // sk = MPTCP meta socket
+ *           BPF prog: read val from ctx->optval,
+ *                     bpf_setsockopt(sk, SOL_SOCKET, SO_RCVLOWAT, &val, 4)
+ *             -> sk_setsockopt()
+ *                -> ops->set_rcvlowat = mptcp_set_rcvlowat()
+ *                   -> has_current_bpf_ctx() == true
+ *                   -> return -EOPNOTSUPP
+ */
+
+#include "bpf_tracing_net.h"
+#include <bpf/bpf_helpers.h>
+
+#ifndef IPPROTO_MPTCP
+#define IPPROTO_MPTCP 262
+#endif
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __s32);
+} results SEC(".maps");
+
+SEC("cgroup/setsockopt")
+int mptcp_setsockopt(struct bpf_sockopt *ctx)
+{
+	struct bpf_sock *sk = ctx->sk;
+	__s32 val, ret;
+	__u32 key = 0;
+
+	/* Only interested in MPTCP + SO_RCVLOWAT */
+	if (!sk || sk->protocol != IPPROTO_MPTCP)
+		return 1;
+
+	if (ctx->level != SOL_SOCKET || ctx->optname != SO_RCVLOWAT)
+		return 1;
+
+	/* Read value from ctx, verifier needs bounds check.
+	 * Save optval pointer to local var so the verifier tracks
+	 * the same register through bounds check and dereference.
+	 */
+	void *optval = ctx->optval;
+
+	if (ctx->optlen < sizeof(val))
+		return 1;
+	if (optval + sizeof(val) > ctx->optval_end)
+		return 1;
+	val = *(__s32 *)optval;
+
+	/* Forward the setsockopt via bpf_setsockopt.
+	 * This reaches mptcp_set_rcvlowat() which checks has_current_bpf_ctx()
+	 * and should return -EOPNOTSUPP.
+	 */
+	ret = bpf_setsockopt(sk, SOL_SOCKET, SO_RCVLOWAT, &val, sizeof(val));
+	bpf_map_update_elem(&results, &key, &ret, BPF_ANY);
+
+	/* BPF handled this, don't invoke kernel handler */
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";

-- 
2.43.0


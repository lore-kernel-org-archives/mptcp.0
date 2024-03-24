Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DD718638
	for <mptcp@lists.linux.dev>; Sun, 24 Mar 2024 16:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711296130; cv=none; b=AwleRSreRf1pUy2YFVxf7n4PT1cPvdiXDZQXYoQTZDv9xW7f3ZCo6VAiXLvJEzPdmUSZVROBAtrOb+AYQAd2AbyHHyOZAEdFvedMQ6Ns0TBQ4EEU7PlfNwFIPmmzctvarjujQkJ3Cna8NIWL3ylVYDoHivS1ZwPcvBIsUATj3Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711296130; c=relaxed/simple;
	bh=S0+kctrHQgktXLmfRi63oj2s6hctBrghW6AsPgATIqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=srBZ/L5CWatx5omeEooAPjzKDQJbiCI5tAcXwe4ei2uMOtfU9WK4NPV1m0kiUzLD1CoDJ/hD3Lrm2qdVBnqDr85r7kkTzWR/kw63/gzVoqgCVlEKnksDKbKmVh0psXCCFA9eE4CiC6Y3nonEanCQr/+a6d8BvZEPfZ7u5/vFlFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7V4WotI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7V4WotI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A73C433C7;
	Sun, 24 Mar 2024 16:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711296129;
	bh=S0+kctrHQgktXLmfRi63oj2s6hctBrghW6AsPgATIqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k7V4WotIPL9rRxFtY/SsKg1zY3WyQ3bxMIMU1jPGXDNTpKDViHR3tCCloK2exVV3m
	 N1vgdOFAbhBJs2LlZKQhtfhuI15kne4NzDW0u5ixCR0GnGOi1/tyD6OVnB9HAbiwA2
	 EHDWBPkx1Z9RrAwREFwNtDTAMP5FAXbs9v7NX0X49FMqDxtdTSBRIOVjPloJrzuiVO
	 Nd2/eU/5yFJU3rovAdWDEUBBsNPrb6N6URRFVOxIxjMvJncq3cxlznNvRppWgYeaD4
	 Zl+43bCphrTj1CW3K0mXRcMzi4SGFooqOuNEe6MD/V1CNIEVt1zoKdUtRKuECNXrmU
	 N/GB2q0DNvMJA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 2/4] selftests/bpf: Add mptcp subflow example
Date: Mon, 25 Mar 2024 00:01:15 +0800
Message-Id: <4c1e2173c4890caeb2353dfb19fc1f281c0f303f.1711296000.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1711296000.git.tanggeliang@kylinos.cn>
References: <cover.1711296000.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Move Nicolas's patch into bpf selftests directory. This example added a
test that was adding a different mark (SO_MARK) on each subflow, and
changing the TCP CC only on the first subflow.

This example shows how it is possible to:

    Identify the parent msk of an MPTCP subflow.
    Put different sockopt for each subflow of a same MPTCP connection.

Here especially, we implemented two different behaviours:

    A socket mark (SOL_SOCKET SO_MARK) is put on each subflow of a same
    MPTCP connection. The order of creation of the current subflow defines
    its mark. The TCP CC algorithm of the very first subflow of an MPTCP
    connection is set to "reno".

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/76
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/progs/mptcp_subflow.c       | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_subflow.c

diff --git a/tools/testing/selftests/bpf/progs/mptcp_subflow.c b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
new file mode 100644
index 000000000000..9553099ffd5f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2020, Tessares SA. */
+/* Copyright (c) 2024, Kylin Software */
+/* Author: Nicolas Rybowski */
+
+#include <sys/socket.h> // SOL_SOCKET, SO_MARK, ...
+#include <linux/tcp.h>  // TCP_CONGESTION
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_tcp_helpers.h"
+
+char _license[] SEC("license") = "GPL";
+
+#ifndef SOL_TCP
+#define SOL_TCP 6
+#endif
+
+#ifndef TCP_CA_NAME_MAX
+#define TCP_CA_NAME_MAX 16
+#endif
+
+char cc[TCP_CA_NAME_MAX] = "reno";
+
+/* Associate a subflow counter to each token */
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+	__uint(max_entries, 100);
+} mptcp_sf SEC(".maps");
+
+SEC("sockops")
+int mptcp_subflow(struct bpf_sock_ops *skops)
+{
+	__u32 init = 1, key, mark, *cnt;
+	struct mptcp_sock *msk;
+	struct bpf_sock *sk;
+	int err;
+
+	if (skops->op != BPF_SOCK_OPS_TCP_CONNECT_CB)
+		return 1;
+
+	sk = skops->sk;
+	if (!sk)
+		return 1;
+
+	msk = bpf_skc_to_mptcp_sock(sk);
+	if (!msk)
+		return 1;
+
+	key = msk->token;
+	cnt = bpf_map_lookup_elem(&mptcp_sf, &key);
+	if (cnt) {
+		/* A new subflow is added to an existing MPTCP connection */
+		__sync_fetch_and_add(cnt, 1);
+		mark = *cnt;
+	} else {
+		/* A new MPTCP connection is just initiated and this is its primary
+		 *  subflow
+		 */
+		bpf_map_update_elem(&mptcp_sf, &key, &init, BPF_ANY);
+		mark = init;
+	}
+
+	/* Set the mark of the subflow's socket to its apparition order */
+	err = bpf_setsockopt(skops, SOL_SOCKET, SO_MARK, &mark, sizeof(mark));
+	if (err < 0)
+		return 1;
+	if (mark == 1)
+		err = bpf_setsockopt(skops, SOL_TCP, TCP_CONGESTION, cc, TCP_CA_NAME_MAX);
+
+	return 1;
+}
-- 
2.40.1


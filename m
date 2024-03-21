Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED08B641
	for <mptcp@lists.linux.dev>; Thu, 21 Mar 2024 03:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710992568; cv=none; b=b+nazr44Xnk1w6DkZlIKOckO++oJx4o7AsVrqXHFkCo0MZxP6fc2B5aCJCsWUzIusJnKJ64JdbnJ91ZFFklT6lGVwTIuDDSVlivqmnpo2pIOhlvikSZfIrjIxWfNJWzRRlBG64BH96qDnB0pAD1U6HQLyaKutkbRFUGZ9j7lk3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710992568; c=relaxed/simple;
	bh=S0+kctrHQgktXLmfRi63oj2s6hctBrghW6AsPgATIqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I1D4KMB2ZU69VFuH4Up9gBXA97bsVZOOPHxJSTrSDAOelhE27zxX4g+klxoAhl9e+hWCFr7urOK8oTNey4b/kMMcblhib1wqim0TCDuqyV4NvoOK4St+XKr7SCe5tE9dA2Sz98/IAgpwrO6ZW2BbtvjivhIRmlq2lYVS1QyU8R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KntEtgiu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KntEtgiu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81778C433F1;
	Thu, 21 Mar 2024 03:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710992568;
	bh=S0+kctrHQgktXLmfRi63oj2s6hctBrghW6AsPgATIqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KntEtgiuNG4nYb5CvRbB0OUrDAx7mwVdhCSFE6Ob/rOoUJmEHn7NIeAuw16tAqPA/
	 wvCK5YOMJx2kEj3j7x0BdNKupehMsWkD2k0pvsgwW0zFhiHx/PlDmyuOeoySCDtVzW
	 hK6T8TxgOa6kwrAIzmUMXmmD/hFyTdfPR1/HQRNUFuk4wCzd5RM/hgez2FfWefhfc5
	 JtKv+rhrxNEFMj4fw3+KqR5F8i65P0eNrAz9FDHcOjC/4ukVDC7hpt1SYU2nm8xJDt
	 yyoYmOOJBnBE0HRf5GhJn7ZGrXZNGSfvXZJB/FxFr9xEfK/ms9D+6VjPLmDsJOHrAl
	 5nI4v4oRoOt+Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 2/4] selftests/bpf: Add mptcp subflow example
Date: Thu, 21 Mar 2024 11:42:38 +0800
Message-Id: <5b081724283edb8925d92b5f6c8754eaa1ea85d5.1710992399.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1710992399.git.tanggeliang@kylinos.cn>
References: <cover.1710992399.git.tanggeliang@kylinos.cn>
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


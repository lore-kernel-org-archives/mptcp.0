Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12752C689
	for <mptcp@lists.linux.dev>; Tue,  2 Apr 2024 07:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712042683; cv=none; b=LHCsKh+qSDyqDtreLhzLwz3TZqLxLG3DgpMCWIWJz4ZJeg077eS9mw5xxQg2ZjqZRaBbZbT6Ps6eFtms5UUMUf0/mdTOZyFHdvs0eMUXyaOpSy9O2ShfyTt/GXXXMKN2S68g2nK28mSUnY8CKlPNhvHWlA03klRl3Bo7eXSIrQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712042683; c=relaxed/simple;
	bh=S0+kctrHQgktXLmfRi63oj2s6hctBrghW6AsPgATIqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uV3GBk6/RCYebSpEtVH2iTwXO5XN2gg9mMluALRLck+cMKPY7vOYm08E1vJCWp+DTyugQksb5Q8EpoAuqciHsU8YN239AM/74i4UNoRgLAqB55A+F55uAZHpE1PqVKTHRwkRP9ZG8IZq11ZNgXtQf5e/3qZjVsyZFxU5435WMes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQiDcaZE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQiDcaZE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A896EC433F1;
	Tue,  2 Apr 2024 07:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712042682;
	bh=S0+kctrHQgktXLmfRi63oj2s6hctBrghW6AsPgATIqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hQiDcaZEoxGQDqU/JbO8YWk175BD2QwdkDXeGF0hWCwcK4B9A0FBzK+mTMWmOJ9XJ
	 Yi14Wep9yKmjvZkrw9PDr04Spm4dr1FikRp3qI/NSfsZNfYxRgkHvY0yuzLjwPlUSe
	 g+f1bKg8MfPuZyAttLTdgPQWYD8JMDXWmXMK7ko0TR0di7oDAyZ3sq3pjF2XG6UItq
	 jr5NGgMhW/VV3sSFTVdGYiShBYf7qItRX5IjUxWV2whMj/XNYDQgV+9gM8EQDZlp3x
	 ClPyGrhrH53LqZQVFQYxRdJ1+u9aYPC8/g22T+cNmKk/chg7ONoahz8dw852HCujoN
	 +Sz8dKKMtGxow==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 6/8] selftests/bpf: Add mptcp subflow example
Date: Tue,  2 Apr 2024 15:24:26 +0800
Message-Id: <1d61922711dc017c4cd323199fc5341908a40b69.1712042529.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712042529.git.tanggeliang@kylinos.cn>
References: <cover.1712042529.git.tanggeliang@kylinos.cn>
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


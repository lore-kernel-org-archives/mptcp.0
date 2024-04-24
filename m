Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7B86FCA
	for <mptcp@lists.linux.dev>; Wed, 24 Apr 2024 01:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713921245; cv=none; b=YyFrcDCrmjvuOFYvLFZ6b1v8seQLLzyrgVcJ6IND7LXchiLRPzkTFlM89fUAhhcPydroqxe7gByv8AZWwAdoD1l8gJ22zHV67opt4weYON6swRkXEXz2iXk2VTkDdtwFt7a6uh5/a+W0sAWygBDht17tySPanV2ixEXQeaNvI2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713921245; c=relaxed/simple;
	bh=7P7QJPWTeWLAxseSS0mBucNx7SkCqdF5PIlnB7gMfYI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ntcMFLwm6iYWRYw5tKuuppLg7Owo0u3eUPafjLJhMHRtONN/MQa3pYP187j9clSLu4IDXNFYLbeBVwKaiG3/3d/KoirF/cky+lxHv+v/usUQFaTEm0KRrHrl/NfUIg40lZK+HLB+3lbIdyMiGuPf2NE2dkRJT+50UQwFhrHIQI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c68zhbXM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c68zhbXM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC9CCC4AF0A;
	Wed, 24 Apr 2024 01:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713921244;
	bh=7P7QJPWTeWLAxseSS0mBucNx7SkCqdF5PIlnB7gMfYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c68zhbXMsq+wmkY7REw5+V90pL4L94OGrKP7JUA8cjPehy896LB4KEqcyJ9Co9ip1
	 jwIF1L2WSBqAy4bZN+Wr9DGQqq5ZHqNRNVhRln3vYbj4r6GRGuS39wvFL8sLC6ST5N
	 aV2+wLz05ezYa3PacX5xbRzKBMzbUyMldb906DewPsuM1F1rYczAjj/Y0qt163+J7/
	 jZ31EQD99yU8U0kfzybiTro3uZP57rOpWdJuWi4CWwPIxlRthESge9RDfK4m4x01ei
	 JsZzwX3yY/z8dgYwl4qWaPzy968+dM8pYf+eUshpHhjE5R3EUpwBcWSXC3lNGz4SQ7
	 ev0l/dPCcNvhg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Nicolas Rybowski <nicolas.rybowski@tessares.net>,
	Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 1/4] selftests/bpf: Add mptcp subflow example
Date: Wed, 24 Apr 2024 09:13:51 +0800
Message-Id: <8f31e2ee253f2325e622048eca243c011e758501.1713920939.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1713920939.git.tanggeliang@kylinos.cn>
References: <cover.1713920939.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolas Rybowski <nicolas.rybowski@tessares.net>

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

The code comes from

    commit 4d120186e4d6 ("bpf:examples: update mptcp_set_mark_kern.c")

in MPTCP repo https://github.com/multipath-tcp/mptcp_net-next (the
"scripts" branch).

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/76
Co-developed-by: Geliang Tang <tanggeliang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Signed-off-by: Nicolas Rybowski <nicolas.rybowski@tessares.net>
---
 .../selftests/bpf/progs/mptcp_subflow.c       | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_subflow.c

diff --git a/tools/testing/selftests/bpf/progs/mptcp_subflow.c b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
new file mode 100644
index 000000000000..de9dbba37133
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2020, Tessares SA. */
+/* Copyright (c) 2024, Kylin Software */
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
+		/* A new MPTCP connection is just initiated and this is its primary subflow */
+		bpf_map_update_elem(&mptcp_sf, &key, &init, BPF_ANY);
+		mark = init;
+	}
+
+	/* Set the mark of the subflow's socket based on appearance order */
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


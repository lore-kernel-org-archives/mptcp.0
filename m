Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B63D3BD242
	for <mptcp@lists.linux.dev>; Thu, 19 Mar 2026 10:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773914964; cv=none; b=WG9xbEOAE+j68prrNK8DhiyQbS8xYOXOVYs5WnHYLpOgysYsi6MjLYLmSzn7qcEk0C2lJuStZ9o3zWSZ6IBHBbGpGGuBM/2VB6H2ZBFhMhk19/602ZIOJ0i7x6PqyLQBRisDzx27AgjvpHqfscUPKxqxh12i3mgOLRAqeknV/3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773914964; c=relaxed/simple;
	bh=P/VbPc6nzXHUtnt2XJ9fN+R9cJSxqarYu7inTXRT6qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VlnRXTCEPjJjYi2lSXiZGTzdimURv2brQm0QUGNpTUVnMQCgaxd3ov6jKzh60u/1SwnVO4s/jBPVd+1WPo+vC1esyaeKYrTAMKDlO2YFY476vQ7S+XD0I1SWAsr8hf/uKp+R1U64qdpzx00Bo84nnSTwmdN6INPyjh61OHc3HKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pjc+35j5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pjc+35j5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1212C2BC87;
	Thu, 19 Mar 2026 10:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773914964;
	bh=P/VbPc6nzXHUtnt2XJ9fN+R9cJSxqarYu7inTXRT6qs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pjc+35j5Ehm27oCG1836hzLQeLBPKa0IrKqWNtY5ToBHXI4UTzh9GRbkyET9+odcf
	 SNnJkmgUFg5cCJbPXYGCwK+k9GCCeknnKruo93yoU+8anbuG/o0sNnmEXof22Qx7M5
	 t2aMelRh73O4Pspv5PQd6k6ERjldR0GWWcNM0YrwLOy/XBUunFwuKckPYq6dXbfw2c
	 R5BMMInXdwsKU0pdHRZVCzqgHpUqTaCaUMGL3KxuB4moDPXwn32MbYSJXIu17C74Qn
	 YWlut/ADJiyN6nahdwzlf+ZJziIH6f6IEPEbLwvH0ZOXqOhECot0ukmYqbLwS6qdz9
	 q/mXprbSe7QBw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v11 15/15] selftests: mptcp: cover mptcp tls tests
Date: Thu, 19 Mar 2026 18:08:48 +0800
Message-ID: <7dfdc9c184b8f96cb4a808e1022ef5a6af15099e.1773911536.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773911536.git.tanggeliang@kylinos.cn>
References: <cover.1773911536.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The mptcp tests for tls.c is available now, this patch adds mptcp_tls.sh
to test it in the MPTCP CI by default.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/Makefile    |  2 +
 tools/testing/selftests/net/mptcp/config      |  3 ++
 .../testing/selftests/net/mptcp/mptcp_tls.sh  | 53 +++++++++++++++++++
 tools/testing/selftests/net/mptcp/tls.c       |  1 +
 4 files changed, 59 insertions(+)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_tls.sh
 create mode 120000 tools/testing/selftests/net/mptcp/tls.c

diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index 22ba0da2adb8..f7c959a25b3b 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -14,6 +14,7 @@ TEST_PROGS := \
 	mptcp_connect_splice.sh \
 	mptcp_join.sh \
 	mptcp_sockopt.sh \
+	mptcp_tls.sh \
 	pm_netlink.sh \
 	simult_flows.sh \
 	userspace_pm.sh \
@@ -25,6 +26,7 @@ TEST_GEN_FILES := \
 	mptcp_inq \
 	mptcp_sockopt \
 	pm_nl_ctl \
+	tls \
 # end of TEST_GEN_FILES
 
 TEST_FILES := \
diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
index 18bd29ac5b24..471c7e0ba2be 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -35,3 +35,6 @@ CONFIG_NFT_TPROXY=m
 CONFIG_SYN_COOKIES=y
 CONFIG_VETH=y
 CONFIG_TLS=y
+CONFIG_CRYPTO_ARIA=y
+CONFIG_CRYPTO_CHACHA20POLY1305=m
+CONFIG_CRYPTO_SM4_GENERIC=y
diff --git a/tools/testing/selftests/net/mptcp/mptcp_tls.sh b/tools/testing/selftests/net/mptcp/mptcp_tls.sh
new file mode 100755
index 000000000000..9d928a3a5ed4
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_tls.sh
@@ -0,0 +1,53 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(dirname "${0}")/mptcp_lib.sh"
+
+ret=0
+ns1=""
+
+cleanup()
+{
+	if [ -n "$pid" ] && kill -0 "$pid" 2>/dev/null; then
+		kill "$pid" 2>/dev/null
+		wait "$pid" 2>/dev/null
+	fi
+
+        mptcp_lib_ns_exit "$ns1"
+}
+
+init()
+{
+        mptcp_lib_ns_init ns1
+
+        mptcp_lib_pm_nl_set_limits "$ns1" 8 8
+
+        local i
+        for i in $(seq 1 4); do
+                mptcp_lib_pm_nl_add_endpoint "$ns1" \
+			"127.0.0.1" flags signal port 1000"$i"
+        done
+}
+
+init
+trap cleanup EXIT
+
+ip netns exec "$ns1" ./tls -v 12_aes_gcm_mptcp \
+			   -v 13_aes_gcm_mptcp \
+			   -v 12_chacha_mptcp \
+			   -v 13_chacha_mptcp \
+			   -v 13_sm4_gcm_mptcp \
+			   -v 13_sm4_ccm_mptcp \
+			   -v 12_aes_ccm_mptcp \
+			   -v 13_aes_ccm_mptcp \
+			   -v 12_aes_gcm_256_mptcp \
+			   -v 13_aes_gcm_256_mptcp \
+			   -v 13_nopad_mptcp \
+			   -v 12_aria_gcm_mptcp \
+			   -v 12_aria_gcm_256_mptcp &
+pid=$!
+wait $pid
+ret=$?
+
+mptcp_lib_result_print_all_tap
+exit $ret
diff --git a/tools/testing/selftests/net/mptcp/tls.c b/tools/testing/selftests/net/mptcp/tls.c
new file mode 120000
index 000000000000..724b1f047c89
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/tls.c
@@ -0,0 +1 @@
+../tls.c
\ No newline at end of file
-- 
2.53.0


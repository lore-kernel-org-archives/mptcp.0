Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614A2318EF6
	for <mptcp@lists.linux.dev>; Mon,  6 Apr 2026 12:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775478028; cv=none; b=Pu4mDeOS9Sa6eOgCPvwxac5yl9nJsHWAUtprYvPxRQdfY+2NWTb5sxxsU5L9ZitS9ZomPYjQ9roImlbNijWqQLq3NMIyMdGNA+Of1sYpH1xxpG7d3Yh1t5w7DDxIfTdbfwiuq82CXiMZnwVYTk7BzOJKy1sGQzW2blEaDBkakP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775478028; c=relaxed/simple;
	bh=IYmzj3X50jh3wdEINOsNrgDyrehEPz9IfS4ohbE91QQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dGGPmSlfjdQrR+Lxpwi5k9CnZhlwOlCKtMni8QWk1KviJTHaHCay/Pymp5Hjw9XqWOeCgvvHVBRmfjB6jvEjRoPeCRKpYYnggDVXwgEdvSZhInSXrds5/VCDix1X9cwV72RajG6PZc0jGZUIYDlu3fYqyVq4L/C9jtxe5sj6g90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXFf24pd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXFf24pd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E97C19425;
	Mon,  6 Apr 2026 12:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775478028;
	bh=IYmzj3X50jh3wdEINOsNrgDyrehEPz9IfS4ohbE91QQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DXFf24pd+nGLqdAq0yhMkX84B1rkY8OL8ggmK/o5GpcPY2gH9f89z6T3DqxXv2hTx
	 KjasqIK+JdWZV1PfUQeRWWv25QS/SNcFRxeqCz2sFOd/5Z2V6XLRyPIKFrzZHg14kj
	 Kh01m76W5DFsgn3qhLNNY3TP0H3/Vx0ONNwhl0yeQkVjhONA56Y+oqItaBfSQU47mG
	 bxAWnhQwxapHHVNaaDQUIlXOUsouqs8uqJQoWacdUKJJSeKe3L71KoMvTtraWK7Dho
	 cwwmoEiXov6xAhJk+rv5VbYhpyg+P67pbgszXmX5Jrrrf66IfXhOM+7XPRaHun3EOv
	 jgwIgbTvksvsg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v14 15/15] selftests: mptcp: cover mptcp tls tests
Date: Mon,  6 Apr 2026 20:18:55 +0800
Message-ID: <54ffb0da9a47faeb55317017dee8ce1d3eef0b01.1775476921.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1775476921.git.tanggeliang@kylinos.cn>
References: <cover.1775476921.git.tanggeliang@kylinos.cn>
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
 tools/testing/selftests/net/mptcp/.gitignore  |  1 +
 tools/testing/selftests/net/mptcp/Makefile    |  2 +
 tools/testing/selftests/net/mptcp/config      |  5 ++
 .../testing/selftests/net/mptcp/mptcp_tls.sh  | 62 +++++++++++++++++++
 tools/testing/selftests/net/mptcp/tls.c       |  1 +
 5 files changed, 71 insertions(+)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_tls.sh
 create mode 120000 tools/testing/selftests/net/mptcp/tls.c

diff --git a/tools/testing/selftests/net/mptcp/.gitignore b/tools/testing/selftests/net/mptcp/.gitignore
index 833279fb34e2..f6defec6eeb5 100644
--- a/tools/testing/selftests/net/mptcp/.gitignore
+++ b/tools/testing/selftests/net/mptcp/.gitignore
@@ -4,4 +4,5 @@ mptcp_diag
 mptcp_inq
 mptcp_sockopt
 pm_nl_ctl
+tls
 *.pcap
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
index 59051ee2a986..e8e852e0a842 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -34,3 +34,8 @@ CONFIG_NFT_SOCKET=m
 CONFIG_NFT_TPROXY=m
 CONFIG_SYN_COOKIES=y
 CONFIG_VETH=y
+CONFIG_TLS=m
+CONFIG_CRYPTO_ARIA=m
+CONFIG_CRYPTO_CCM=m
+CONFIG_CRYPTO_CHACHA20POLY1305=m
+CONFIG_CRYPTO_SM4_GENERIC=m
diff --git a/tools/testing/selftests/net/mptcp/mptcp_tls.sh b/tools/testing/selftests/net/mptcp/mptcp_tls.sh
new file mode 100755
index 000000000000..ea366d149a20
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_tls.sh
@@ -0,0 +1,62 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(dirname "${0}")/mptcp_lib.sh"
+
+ret=0
+ns1=""
+
+# This function is used in the cleanup trap
+#shellcheck disable=SC2317,SC2329
+cleanup()
+{
+	if [ -n "$pid" ] && kill -0 "$pid" 2>/dev/null; then
+		kill "$pid" 2>/dev/null
+		wait "$pid" 2>/dev/null
+	fi
+
+	mptcp_lib_ns_exit "$ns1"
+}
+
+init()
+{
+	local max="${1:-4}"
+
+	mptcp_lib_ns_init ns1
+
+	mptcp_lib_pm_nl_set_limits "$ns1" "$max" "$max"
+
+	local i
+	for i in $(seq 1 "$max"); do
+		mptcp_lib_pm_nl_add_endpoint "$ns1" \
+			"127.0.0.1" flags signal port 1000"$i"
+	done
+}
+
+trap cleanup EXIT
+
+mptcp_lib_check_mptcp
+# Temporarily set max to '0' to disable multipath testing,
+# as it depends on "mptcp: fix stall because of data_ready" series of fixes.
+# It will be re-enabled together with that series later as a squash-to patch.
+init 0
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
2.51.0


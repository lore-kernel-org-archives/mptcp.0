Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBB73A0B3F
	for <mptcp@lists.linux.dev>; Tue, 26 May 2026 09:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779788836; cv=none; b=CAKblTrXhXSoZ7m4HSTbrPvjvjIl7+J2B2BT0imOurfVqh1PbNv2lB3QZVXCJBn8Rh+tSxCgSJxQKu0PWO+nwFBytBlwLrG5PbT+288IM3qRskUw3DYiKqmOWlLCviW/itZFEcaz+kIWRChMoDaLBE3QctUZnNDAtE4Disrur20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779788836; c=relaxed/simple;
	bh=PhY3qPROuBdMTe1mar1KsTe9/5NIW6utDlbwPTZG1zw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ajocsR/0qqtAqMctq9nBU9Z9S+/tQASLWSedQr9SVmI6tgOQCiD+D2aV8cErs8lXv36XHG5Pi+6hI3BX1fp3okCp1Gzp6J6W9c+aUCZkTx58VPPKKb/kVpjr+nq8kZOlcFULUiqcIh0w41wJGmzZmAyBsd0t/AI2Me4vPUac0ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bgWFR0RQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgWFR0RQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 083C21F00A3A;
	Tue, 26 May 2026 09:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779788834;
	bh=sWJEjWDeKaIU9OOSzE2K4YtJUgEwYbriDt4DkdnV7u0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bgWFR0RQF3Dxz4yNig6mdwwxsGau0FaktDDefBJO3jA9n0SfoOheBugEKxJReU7Zq
	 U4DFZj8YgGQlsCqBUmdrc/yHYP461KHatueeX5c2OrKl9et18GCOoGF0LkJYlx9kJj
	 MaEoE6TBExBAVf7HlWhkPqnBP073HqOXrYoo4aPl5Drv6md+dR7zcPyvE7jbfkTYyF
	 oJkYgFPMiW61rsYYBsR2cGFkvVyyee4kxvTsh/hLDex2BkcUUrZebVAbzUOGWgRChm
	 FX/zWmAHuuAfldbwsx39sbYyUOITmfPL3dEVjWV+GuQuNNnKOhzK8QjgmftXMwFJ0Q
	 V2OAyTVcIX1xg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v20 15/15] selftests: mptcp: cover mptcp tls tests
Date: Tue, 26 May 2026 17:46:33 +0800
Message-ID: <f3b725705b84c43aa9432227fc636f04f182375f.1779788090.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779788090.git.tanggeliang@kylinos.cn>
References: <cover.1779788090.git.tanggeliang@kylinos.cn>
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
 .../testing/selftests/net/mptcp/mptcp_tls.sh  | 64 +++++++++++++++++++
 tools/testing/selftests/net/mptcp/tls.c       |  1 +
 5 files changed, 73 insertions(+)
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
index b9960f227796..395f1d5b020a 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -35,3 +35,8 @@ CONFIG_NFT_TPROXY=m
 CONFIG_SYN_COOKIES=y
 CONFIG_VETH=y
 CONFIG_XFRM_ESPINTCP=m
+CONFIG_TLS=m
+CONFIG_CRYPTO_ARIA=m
+CONFIG_CRYPTO_CCM=m
+CONFIG_CRYPTO_CHACHA20POLY1305=m
+CONFIG_CRYPTO_SM4_GENERIC=m
diff --git a/tools/testing/selftests/net/mptcp/mptcp_tls.sh b/tools/testing/selftests/net/mptcp/mptcp_tls.sh
new file mode 100755
index 000000000000..04a0cb6ab0f3
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_tls.sh
@@ -0,0 +1,64 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(dirname "${0}")/mptcp_lib.sh"
+
+ret=0
+ns1=""
+pid=""
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
+mptcp_lib_check_mptcp
+
+trap cleanup EXIT
+
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
2.53.0


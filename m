Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F595360EEA
	for <mptcp@lists.linux.dev>; Tue,  2 Jun 2026 02:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780367623; cv=none; b=hmbIEoEXcrTe3h2eCBEI3lsH5Kxh+Fo3ESnTAvWl/BJaArYMhzb0y7Htew+MZnhnY59TTiqZGUHC9FpmTlLElkGoLrrOrfmiMcSnkS+xWhvKDHeejDUV9HaE8otLNlI1q4GZbonuEnjGjGvqWxPitjeEPAexom4wcFbcMBRB3bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780367623; c=relaxed/simple;
	bh=92H9x9yFNkbJgJjQ0eKxqkSzeLXxSN34dHUm+ZBI/Ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BtmNSVNyEvlgCbUZC1uIUNVEllXvgBNM7fcDFik+0QhZMP08skPUnG+Dl7y5i8LJbOo2if5QT4227dFdyyQ73DzGyH2vIhpA5iP6+oBrR+HuWpFcZp+ciDyc8FCUecFq+uakt/UbWElUOoOAzn7iKXJAfBcRV17xVjHJ/TXE+Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fL77tvE3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fL77tvE3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842E71F00893;
	Tue,  2 Jun 2026 02:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780367622;
	bh=EToo3lVyscBNTbcRYQRhh2LBDC9LSekOmA85iyM/VrY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fL77tvE3XmmgO7YUJA9jf2MSL0R+nZGqDFbO9IsZafytBAE5FNmsOjlUfwnvMkwCt
	 ZsP6Kg3qtExQM5sd9P7cIiYiOFaN1Vt6udh7YB8RDhp4Y2hqMflKOxspzR+AXPmCfF
	 gPSviMaHkCpnVVNXKrn/QezkaaDO7Oq2anEoh+nswH85lamcs1giQhSoC5gTxufc3o
	 D4I4Bw3BjuEC7zSRr6n85MpJyGwGio47T6WAka11t6r9ZiRdcRwQWOZS2r7ZBBiUav
	 t/biOR6wNlerYXn4K6OjsLKXx+W3/83rg575sDHf0vK5HZ6JD90k/U0dFFKm2wytX0
	 V+FVDh7mAQxVQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v23 16/16] selftests: mptcp: cover mptcp tls tests
Date: Tue,  2 Jun 2026 10:32:57 +0800
Message-ID: <5f95903d2649119f41745951ac586e5c58d416d5.1780362942.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780362942.git.tanggeliang@kylinos.cn>
References: <cover.1780362942.git.tanggeliang@kylinos.cn>
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
 .../testing/selftests/net/mptcp/mptcp_tls.sh  | 61 +++++++++++++++++++
 tools/testing/selftests/net/mptcp/tls.c       |  1 +
 5 files changed, 70 insertions(+)
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
index f48bd5183fb3..bfc26bde0501 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -38,3 +38,8 @@ CONFIG_INET_ESP=y
 CONFIG_INET_ESPINTCP=y
 CONFIG_INET6_ESP=y
 CONFIG_INET6_ESPINTCP=y
+CONFIG_TLS=m
+CONFIG_CRYPTO_ARIA=m
+CONFIG_CRYPTO_CCM=m
+CONFIG_CRYPTO_CHACHA20POLY1305=m
+CONFIG_CRYPTO_SM4_GENERIC=m
diff --git a/tools/testing/selftests/net/mptcp/mptcp_tls.sh b/tools/testing/selftests/net/mptcp/mptcp_tls.sh
new file mode 100755
index 000000000000..79d120cd4b16
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_tls.sh
@@ -0,0 +1,61 @@
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
+init
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


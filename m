Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB03928690
	for <mptcp@lists.linux.dev>; Thu,  2 Apr 2026 07:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775116106; cv=none; b=OSEYgpZvVNJA5dCCUjj9bqUK5LsHlc66tpq0aofxJ5sriFOT07MOiOFZQDQNC7VQMQWLnb0k8sOJBFdgivPZVu/M6J5ach4fX6fE//piYcsZiwP1LJ8too2JVmiJ12ka1mu53UB+d9NKODYi75jznVgWGRVU970PdQyIh30r0EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775116106; c=relaxed/simple;
	bh=jxO0rKZKX21hgLtBr/ebVlNpts7QVcm316lo50AUX9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e3uMhQ4oz5yhWvem/xraYxHd069wd3WkQioj5KwcRsbAQaJ2hAqJb+BQQXoqKE6JKr+0scBmBDop0/uTHSXqOea0sWXA1NG/eUTOjMT/WC9kzOmFrcE37YpVXtBfujh/S5XV2iL+UMhuAjKjyXta+eZztaQirXiEBAlIkrWHY54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ewy5soNq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ewy5soNq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF5C0C2BC9E;
	Thu,  2 Apr 2026 07:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775116106;
	bh=jxO0rKZKX21hgLtBr/ebVlNpts7QVcm316lo50AUX9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ewy5soNqxPwdtHN20KYX7LGyXGrE4ythnDZ7yp9f8MVJHDjDa2hB4tT81+WAlzNQq
	 jQy1WDlY1vPgY6dVbfmaAoJnvlsC63WlmmQ0ke4cN6opMV4Btuu/JkJAzwKiHsa0Ch
	 8vCR7+MFyKKpYbEzOO31X3ohYOS1vvifYmKYAkrvxpTdEQmtcJJK82HI6S7OUk7XDb
	 eG/ZR8Uybyc4dIQmZk7RCyoh+grr3eS6Puxo1lK4Yrnen8TqlB70IRbQ97WNsdnIdt
	 ULq2fnH/cah1DN8nV4+V4i9EzC9a2vZF13N7cq3Z97dqex4Ysq9blXTw72JtqPcHsD
	 fMj90kLYbz/ZA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v12 15/15] selftests: mptcp: cover mptcp tls tests
Date: Thu,  2 Apr 2026 15:47:50 +0800
Message-ID: <c21c892446c92ba582bc22d5cfce22129fca72ac.1775115102.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1775115102.git.tanggeliang@kylinos.cn>
References: <cover.1775115102.git.tanggeliang@kylinos.cn>
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
 tools/testing/selftests/net/mptcp/config      |  4 ++
 .../testing/selftests/net/mptcp/mptcp_tls.sh  | 55 +++++++++++++++++++
 tools/testing/selftests/net/mptcp/tls.c       |  1 +
 4 files changed, 62 insertions(+)
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
index 59051ee2a986..471c7e0ba2be 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -34,3 +34,7 @@ CONFIG_NFT_SOCKET=m
 CONFIG_NFT_TPROXY=m
 CONFIG_SYN_COOKIES=y
 CONFIG_VETH=y
+CONFIG_TLS=y
+CONFIG_CRYPTO_ARIA=y
+CONFIG_CRYPTO_CHACHA20POLY1305=m
+CONFIG_CRYPTO_SM4_GENERIC=y
diff --git a/tools/testing/selftests/net/mptcp/mptcp_tls.sh b/tools/testing/selftests/net/mptcp/mptcp_tls.sh
new file mode 100755
index 000000000000..b35d17857393
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_tls.sh
@@ -0,0 +1,55 @@
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
2.51.0


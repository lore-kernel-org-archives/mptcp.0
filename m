Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1902222C5
	for <mptcp@lists.linux.dev>; Tue, 17 Mar 2026 09:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773738836; cv=none; b=RgQbxWrTIQ65CMgMzHMMviX8GTdVeASfLZitBUxnSSNz3nBMF7hr3eAca62G882L6yXOGfcOoIYzCzoDWYJo/2R+h9yjSpm0+gjOsN+e/UhwE4vCz4SgoVrk8FH5CrmOqqtC5jevvl3AxMaqIlulqnqE3YtZcnYywYNM/dqcj0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773738836; c=relaxed/simple;
	bh=s4hYwr7J4oysu97lIHiAPdaBs/2LesW9OkezYRV4JeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UZ64cjCs5XI8/rhncyiJwM+dPUi24dA9W2Uu5usuzSYLop7NBygB9X1OqFjCXkXqbIE1Lm5CcPbG8LwRxhPIY65p3puytU6lszEbx+b0N8y+N83IUZ7AnEAjTQT7/3J3S88NGbV8vtylXKHBWTenUPcp4lAMmPam4nedFDJBZ0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZFPBj8s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZFPBj8s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F2DC2BCAF;
	Tue, 17 Mar 2026 09:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773738836;
	bh=s4hYwr7J4oysu97lIHiAPdaBs/2LesW9OkezYRV4JeQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jZFPBj8suxxg8vVRj1JTTz39oZbp/V/jFKbB36MryyaACEE75xH30p8WzeT2Ojb+e
	 63kHdeUQklrQTknhmn1mvLIqvkdj9BDp07qj7hHmdGwYmbI0htq8egY2076ZzJ3mM5
	 dkm0A2ZmZfO8eMYnlL0ZC3hF52RRfyyYrUc70+ZEKt+RMWpKNdqdGwwJVUq/tC/jNA
	 X7rw4+aFrP/jdLcx7wapdmLv5D4oqLqNokA9A71Upz2gwPp5cFdzhj4i+HY57pppgC
	 TVEcRzVFbI02ztSqCI5xw9/DbZlOfz5OcCbDQAlf2zg5/HZ1Ql8kh9y4W6Pg4izwjF
	 9cBhCzneMvcmg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v10 14/14] selftests: mptcp: add TLS tests to CI
Date: Tue, 17 Mar 2026 17:12:50 +0800
Message-ID: <24e730917f3990af772106132857e63c73c0f05c.1773737371.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773737371.git.tanggeliang@kylinos.cn>
References: <cover.1773737371.git.tanggeliang@kylinos.cn>
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
 .../testing/selftests/net/mptcp/mptcp_tls.sh  | 49 +++++++++++++++++++
 tools/testing/selftests/net/mptcp/tls.c       |  1 +
 4 files changed, 55 insertions(+)
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
index 000000000000..b91be338ad0b
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_tls.sh
@@ -0,0 +1,49 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(dirname "${0}")/mptcp_lib.sh"
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
+        local i
+        for i in $(seq 1 4); do
+                mptcp_lib_pm_nl_add_endpoint "$ns1" \
+			"127.0.0.1" flags signal port 1000"$i"
+        done
+
+        mptcp_lib_pm_nl_set_limits "$ns1" 8 8
+
+	ip netns exec "$ns1" ip mptcp endpoint show
+	ip netns exec "$ns1" ip mptcp limits
+}
+
+init
+trap cleanup EXIT
+
+ip netns exec "$ns1" ./tls -v 12_aes_gcm_mptcp \
+			 -v 13_aes_gcm_mptcp \
+			 -v 12_chacha_mptcp \
+			 -v 13_chacha_mptcp \
+			 -v 13_sm4_gcm_mptcp \
+			 -v 13_sm4_ccm_mptcp \
+			 -v 12_aes_ccm_mptcp \
+			 -v 13_aes_ccm_mptcp \
+			 -v 12_aes_gcm_256_mptcp \
+			 -v 13_aes_gcm_256_mptcp \
+			 -v 13_nopad_mptcp \
+			 -v 12_aria_gcm_mptcp \
+			 -v 12_aria_gcm_256_mptcp &
+pid=$!
+wait $pid
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


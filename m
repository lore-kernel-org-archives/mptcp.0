Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795783563;
	b=YJ+tEKHpESHhjMnIb7E03E5NjaswrFXquIckum1MP7lnQeAXklnUEIYLNoLTels4ZqbH
	 YQgb64ZfPt8FCRPcBZ/im0mn+elaIcW9+Xh0OqW8JIThAYI3b5DuEKfYNdlKmJd/7iOOX
	 BWMvecLswKy6b9oRb03aC2SGlgg/QfHL2bPsrIBw57nf40xyIXND55FKzNdB5fnnIvZ+2
	 KdRvi43p08DtRZSpMvT9IhkseZvAW75BnqQnEQ77xd9VFO38lB1jKNlksOpWOCm7pnNKw
	 yeedzvAT0al4SAzZjzbqmCsUWrGzPoN1W2sXc5dkU1LOJgGc9uVhQXhXPPCOTg1sCFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795783563;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PI9rz6q7sDMfLzucfM0el/mPeVp37lkTW6DeJCxNFek=;
	b=lIKv1qxi5J6o0DIhfyI5ymVNzUZ0/sxxqRkfliMCW3+KHTKvcCYDgckv6QmZPYxUbrCF
	 AbW+bziXFYDooTA5EY5oxezRc9EErbIqJMMVOR6810fdhWCtSbgZa49U/giVfVI60kWk7
	 eyx/+qQngDd5qsVOX01A1oJwqam+olH0kdWJGS+DQvMa9iYICJUGEdjtk5qUZzNWJwxl0
	 43yseQ8bkqkbwFd07VRmfFdCwrWRznGN5McxIyPs2obfQHGDRhvKeM9CiIKvCGoIj03+n
	 eFrxf7k0iPEkmcrYRXxZBhrjIARRHV5AOdjClpajO2G7WrQEJ7EXjSlscZDxZlyFarQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eRg37jf0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B36606A326
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 12:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eRg37jf0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD021F00923
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 12:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795783562;
	bh=PI9rz6q7sDMfLzucfM0el/mPeVp37lkTW6DeJCxNFek=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=eRg37jf0GydasFqVkk5MzdI+9fnQOROp8/vOcJbjTJF5cbDwneDWka4RX5QU6M4vl
	 iq2ppRgsrTuYJu2YONTW7grCYmxdLchUJ7fhc2qpxqDGcpITf9XbocyMgWh1AoztWH
	 VMJMd8Z9xYqm5RwEoZHz8WQ5ECYbEnkm5a9LbxJ2o1okPzhhXwlWazbuzg8U928zBd
	 t/Dd8xNVMXdAnE34N6CyqBzdzubj9NwmsPqjIcV7wVi6KlyifwSxHX98WzUmBEltI7
	 plx+oizWfQDnugjM3xf98tx/NJ2javDGzhQqamCQKirivcUnu/afqij75YW+GEA2yr
	 i6IiSOieJY9Sw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v11 7/7] selftests: mptcp: cover msg_zerocopy test
Date: Fri, 27 Nov 2026 20:45:27 +0800
Message-ID: <52f67bef0305ff81d900244811035f639a16bd05.1795783388.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795783388.git.tanggeliang@kylinos.cn>
References: <cover.1795783388.git.tanggeliang@kylinos.cn>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add the msg_zerocopy test to the MPTCP selftest suite by creating a
wrapper script that checks for MPTCP zerocopy support before executing
the existing msg_zerocopy.sh script in the net selftests directory.

Update the Makefile to add msg_zerocopy.sh to TEST_PROGS, add
msg_zerocopy binary to TEST_GEN_FILES, add build rule to compile
msg_zerocopy from ../msg_zerocopy.c, and add ../msg_zerocopy.sh to
TEST_INCLUDES for out-of-tree builds. Also add msg_zerocopy binary
to .gitignore and CONFIG_DUMMY=y to the config file.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/.gitignore      |  1 +
 tools/testing/selftests/net/mptcp/Makefile        |  7 ++++++-
 tools/testing/selftests/net/mptcp/config          |  1 +
 tools/testing/selftests/net/mptcp/msg_zerocopy.sh | 15 +++++++++++++++
 4 files changed, 23 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/net/mptcp/msg_zerocopy.sh

diff --git a/tools/testing/selftests/net/mptcp/.gitignore b/tools/testing/selftests/net/mptcp/.gitignore
index 833279fb34e2..1f318a297f70 100644
--- a/tools/testing/selftests/net/mptcp/.gitignore
+++ b/tools/testing/selftests/net/mptcp/.gitignore
@@ -3,5 +3,6 @@ mptcp_connect
 mptcp_diag
 mptcp_inq
 mptcp_sockopt
+msg_zerocopy
 pm_nl_ctl
 *.pcap
diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index 22ba0da2adb8..c23e36482194 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -14,6 +14,7 @@ TEST_PROGS := \
 	mptcp_connect_splice.sh \
 	mptcp_join.sh \
 	mptcp_sockopt.sh \
+	msg_zerocopy.sh \
 	pm_netlink.sh \
 	simult_flows.sh \
 	userspace_pm.sh \
@@ -24,6 +25,7 @@ TEST_GEN_FILES := \
 	mptcp_diag \
 	mptcp_inq \
 	mptcp_sockopt \
+	msg_zerocopy \
 	pm_nl_ctl \
 # end of TEST_GEN_FILES
 
@@ -32,8 +34,11 @@ TEST_FILES := \
 	settings \
 # end of TEST_FILES
 
-TEST_INCLUDES := ../lib.sh $(wildcard ../lib/sh/*.sh)
+TEST_INCLUDES := ../lib.sh ../msg_zerocopy.sh $(wildcard ../lib/sh/*.sh)
 
 EXTRA_CLEAN := *.pcap
 
 include ../../lib.mk
+
+$(OUTPUT)/msg_zerocopy: ../msg_zerocopy.c
+	$(LINK.c) $^ $(LDLIBS) -o $@
diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
index 6a96cfbbc461..b44358c178af 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -1,3 +1,4 @@
+CONFIG_DUMMY=y
 CONFIG_INET_DIAG=m
 CONFIG_INET_MPTCP_DIAG=m
 CONFIG_IP_ADVANCED_ROUTER=y
diff --git a/tools/testing/selftests/net/mptcp/msg_zerocopy.sh b/tools/testing/selftests/net/mptcp/msg_zerocopy.sh
new file mode 100755
index 000000000000..de2807df225a
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/msg_zerocopy.sh
@@ -0,0 +1,15 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(dirname "${0}")/mptcp_lib.sh"
+
+mptcp_lib_check_mptcp
+
+BIN="$(dirname "${0}")/msg_zerocopy"
+if ! "${BIN}" -4 -t 1 check || ! "${BIN}" -4 -t 1 check -z; then
+	mptcp_lib_pr_skip "MPTCP zerocopy not supported"
+	mptcp_lib_fail_if_expected_feature "MPTCP zerocopy"
+	exit "${KSFT_SKIP}"
+fi
+
+exec "$(dirname "${0}")/../msg_zerocopy.sh" "$@"
-- 
2.55.0


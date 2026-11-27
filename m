Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795754233;
	b=NNhPLkxHNhEqE5MPP0EVOocJyiUB+lMuO00eJcAysXzezS2mfmSO2mjv7vI9bgjicvy0
	 jKNEUEjxsz1luVTmsBW/iyMf3UMxXMsdSZ2uqJXwcF10IhNhNo8zpF/H2y3DekYAtf6wB
	 H6pvIfMSei0Vbqpo5xNARSRj9X1Qw5rnqlvtp5GwbBU+ESCDPkYk1iQXkCJQuq0twEM0W
	 7//T/loFWavddcqfTzyVx0JpE3XN0rjuSYroKp85ziUavcaLJgL69O/Cx6LlS9N/JiKHu
	 VMVMFlZ69KTAgGT1QGnxIcqgUAmgOe6cmLa90GNtNlcHI49gET60qA3tOdUUDAXi2Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795754233;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1myo6oKI/iSXUk0TUl0wM7wt1TFX1OvBp04FLwjcDGY=;
	b=kY9/tCaDrH6RA2fk6fXsw7jcAe01SE0sE5T0w2BcHZnKMgcM85J0CE83/jAh5oSyDMgp
	 ZWWqBIlifZq34lngCaDyZnS13s3EsjmQK2JR9FMIp5ecHlyVhtI6JSoeDg/UeU+28GUdI
	 km+acBw5ALoipvPbsHof7ekvHjt4/DE8HKJFwFpYEwCoOqVVt+M+Uh9VskwHwcG4Bn2Zl
	 KB+P9w2dFzlIq7ltDuZKxzWIrFriugaN0Cu8CSoj32WfNLOCorl9Lo7Txa8N2QSXg2t1r
	 QzFUXeA+oo8t99Tbh0fn5Ffx3qRJ9esnBrUBTOeBPU4qjagCXtG+CAEudXx+5r4QP+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OHfnvzIi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53EB606A31C
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 04:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OHfnvzIi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E2C1F0089A
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 04:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795754233;
	bh=1myo6oKI/iSXUk0TUl0wM7wt1TFX1OvBp04FLwjcDGY=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=OHfnvzIiWeDUkVFrbjksMIERUGWKKPMb1i8lTzAxdlkjZnWUmsGT9JpSMVoPjaQtU
	 3QtHldAaF/5uwTym8KsWRYHJwnXNiuGAyN615kkfzyiab3ixJZtD8B06Gku7lYApyb
	 cawNqX9Tbwe7szWgoKaw6YDc6PCIC27+618tW84a8F6auvjPJgXQZtpYqIjrhVDdCe
	 riGBAt5AVnj25vsXpYhNS3RufrdV3Pky4vSnZpY0Ck2jxOnEtHnJQ4NZSRjV4Ifn7t
	 biHAU8X5VCjr7CcmlH0kDhlmTXs4Jjdv9gWd6OlH2TdWep3CZlPHBY4xyuRqXbjbYu
	 +oIxW/uTOu0aA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v10 7/7] selftests: mptcp: cover msg_zerocopy test
Date: Fri, 27 Nov 2026 12:36:20 +0800
Message-ID: <00df42f4717147821e9d1d9481389aa3f7c9a842.1795753727.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795753727.git.tanggeliang@kylinos.cn>
References: <cover.1795753727.git.tanggeliang@kylinos.cn>
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
symlink to the existing msg_zerocopy.sh script in the net selftests
directory.

Update the Makefile to add msg_zerocopy.sh to TEST_PROGS, add
msg_zerocopy binary to TEST_GEN_FILES, and add build rule to compile
msg_zerocopy from ../msg_zerocopy.c. Also add msg_zerocopy binary
to .gitignore.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/.gitignore      | 1 +
 tools/testing/selftests/net/mptcp/Makefile        | 5 +++++
 tools/testing/selftests/net/mptcp/config          | 1 +
 tools/testing/selftests/net/mptcp/msg_zerocopy.sh | 8 ++++++++
 4 files changed, 15 insertions(+)
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
index 22ba0da2adb8..ec243e400f4b 100644
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
 
@@ -37,3 +39,6 @@ TEST_INCLUDES := ../lib.sh $(wildcard ../lib/sh/*.sh)
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
index 000000000000..118fff27dc5c
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/msg_zerocopy.sh
@@ -0,0 +1,8 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(dirname "${0}")/mptcp_lib.sh"
+
+mptcp_lib_check_mptcp
+
+exec "$(dirname "${0}")/../msg_zerocopy.sh" "$@"
-- 
2.55.0


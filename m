Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179B733EB17
	for <mptcp@lists.linux.dev>; Fri, 17 Jul 2026 04:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784263839; cv=none; b=EbxLVgx4IrTWxFrWKJ/v6tZ0Q6aMP5oSl3HPsvKeeFtG9B4BJbBd2AkEeFJX8KjxI4Kftqpu/Ul9j6EhL26iUATecIYoMbOfuJOQppbtUgTGDZDSxcwm9X+i/prtiyW3r+HNOGZ3kYJxmD9Xv5mFlZ6IAQWeVvHv9iV3njxaQ+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784263839; c=relaxed/simple;
	bh=gXWmEM4LFpuxOAMuCUM6NaMQDK0W28QcsZPP0A7MkB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FK0yl+zdLv9acqDUbJgxc2UBdEHq69Fn96Va2nYtgQ6jqWZJTFjmMmhtO4quvOovvVSX57dsCF9niLUuuBBPvrEwd0DZeRcEqfXQjPfSZJbWhe/+saewfmSdWd4mCwnhDkkZR/TlidhlWFITJL+JOY5YeAwSjku6kWioiPAdAl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nk/yTJ9N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nk/yTJ9N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8826A1F000E9;
	Fri, 17 Jul 2026 04:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784263837;
	bh=BV7dLguDmKvmHGtOUgdSiWteNsUaNM1pfyH4C0rn6ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nk/yTJ9NOkUTYVdquOF/bY5A9ljj5FpUqpGrfigloB/ORKtkTrnt+hEeqeRCXVAK9
	 QgRybS73zqRoloFRlyMxl8b8pMD3PCSirlbeqCQ4KQ1n+53a059W8hO9UpSW/nvolE
	 BsDFqVM1mEY5VCz99RCPqgxGV/YwF/5+1oy9PECEANXfBYB/j4okvicy5N6avZziaY
	 AJp0jW56Mi93rtdj+xQSbfGxHghxWSONDZLFcjtUbl236hDVcG4AM6jpL9M7ENC2UU
	 RhbnDAO8naYhvo710ht5+Z5b+TiaCrlnRHlUNikqq2PiRKio9PfqJseZVtaszdt/5f
	 0HVJLKjk0dozA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 8/9] selftests: mptcp: connect: cover zerocopy mode
Date: Fri, 17 Jul 2026 12:50:17 +0800
Message-ID: <7b6b01cfc1b60740c52aaf25a37fbf22e1ce0e75.1784260668.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1784260668.git.tanggeliang@kylinos.cn>
References: <cover.1784260668.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add a new test script mptcp_connect_zerocopy.sh to run the mptcp_connect
selftest with the zerocopy I/O mode. This ensures the MSG_ZEROCOPY path
is exercised in the regular test suite.

The script follows the same pattern as the existing mmap, sendfile, and
splice test wrappers, invoking mptcp_connect.sh with the -m zerocopy
option.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/Makefile                  | 1 +
 tools/testing/selftests/net/mptcp/mptcp_connect_zerocopy.sh | 5 +++++
 2 files changed, 6 insertions(+)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_connect_zerocopy.sh

diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index 22ba0da2adb8..9e47ecfe58e2 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -12,6 +12,7 @@ TEST_PROGS := \
 	mptcp_connect_mmap.sh \
 	mptcp_connect_sendfile.sh \
 	mptcp_connect_splice.sh \
+	mptcp_connect_zerocopy.sh \
 	mptcp_join.sh \
 	mptcp_sockopt.sh \
 	pm_netlink.sh \
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect_zerocopy.sh b/tools/testing/selftests/net/mptcp/mptcp_connect_zerocopy.sh
new file mode 100755
index 000000000000..0220d29ad68e
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect_zerocopy.sh
@@ -0,0 +1,5 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+MPTCP_LIB_KSFT_TEST="$(basename "${0}" .sh)" \
+	"$(dirname "${0}")/mptcp_connect.sh" -m zerocopy "${@}"
-- 
2.53.0


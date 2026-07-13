Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298F129D267
	for <mptcp@lists.linux.dev>; Mon, 13 Jul 2026 03:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783913550; cv=none; b=B8RWZ8YwbngtUepGv5MBDabt+Z29JQo10yC+MBrUG3HmwMaRSWtH2f9pFOfA+8ne+e+zEl87WEPde8QqRlNY1N+hvVMbNBsD0tSkuAlhXvbzlMbuDSgO40AUxpL/7uyrxJLmigZlNVdaYQLDRuCT3RQDZbX9RjD3Ck1tjg0j1DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783913550; c=relaxed/simple;
	bh=gXWmEM4LFpuxOAMuCUM6NaMQDK0W28QcsZPP0A7MkB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M387Gb0nSxxRWdnJZtZ6KXhVIC1QAsw4NaTuzGbVvzqkGLYmD21lTYLec7QirKczErymv7mNmc4y1va4S/iQRceov4Ms5ZNRZJHkFNNrWqsZFsIM4rO2HOhJP1nCmOvKdSXqSBecRkdvO1lkF8z4S8Jw35i8yQolpYmPypfnbbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WoW0tf5R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WoW0tf5R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31EDF1F00A3E;
	Mon, 13 Jul 2026 03:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783913549;
	bh=BV7dLguDmKvmHGtOUgdSiWteNsUaNM1pfyH4C0rn6ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WoW0tf5RZUnfZ4y+jQdYhJ5Lzpo2X4zt8NkyISjZni5R0ni0ZKwo8+zfA4/Gnr9yN
	 3H8TF5tK6jcqPyzigzeOLZVJ6din5oYpmfTizMHjAq6qtvAcmcnytQnhwO/Zs8yWm0
	 278d7vDIpYs1/RDsiKApKUBEysy6rhyjzSBUvyZrIpwqxh88Rh1arHrUrl7rBLBTzm
	 M0bi2/ci3SJvvluudh1WWgzrG10F8MAk8zqUpg/jExtR4Ir5HcWmHwm6zAPSJ486Ul
	 nd2SmCG3I3H3jZaRvFiPM6VjefzSKyKad2z7TzkFpJtRLUvDxuT82moSRh2ypw3L/u
	 YjQVJQ6D/BOFg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 5/5] selftests: mptcp: connect: cover zerocopy mode
Date: Mon, 13 Jul 2026 11:32:13 +0800
Message-ID: <8e7e498b1c1e29d540570aaace8bf1fcb3caf079.1783913332.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783913332.git.tanggeliang@kylinos.cn>
References: <cover.1783913332.git.tanggeliang@kylinos.cn>
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


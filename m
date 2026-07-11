Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09A6372EE9
	for <mptcp@lists.linux.dev>; Sat, 11 Jul 2026 13:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783775309; cv=none; b=SJ+XzP1jPsgcM/uw87Id9OCNYe9HJbR5nHj51y5Bneuz0GIBabmPHF+N2ukgcxITaqRQ0k++UrdS4cOSTxTJtKBgB2ckXl3CgniQxM+qSpSJC7brlbHnqfwNnyovwojLQAKwIVu4nB7LZgLbAiXlh+KMXUGqtRUSU7w6CPwUFgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783775309; c=relaxed/simple;
	bh=gXWmEM4LFpuxOAMuCUM6NaMQDK0W28QcsZPP0A7MkB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W/X6F2bzeAkloHDynX1p+idMhd3XOuZXDTJ/5AyxJhh+lQ6CyeT3jfM/kUqJD5WOv90VD3FXjw29ZIqGSsqT7qelF0SiEM7KRpTDtTtZaF3lMYoVjCaocqY8Co+zH+1S+GuQdidUH5OoIikelZGT3bdnB//MRTebNQtYvYuuWIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cks2Kn7Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cks2Kn7Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7211F000E9;
	Sat, 11 Jul 2026 13:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783775307;
	bh=BV7dLguDmKvmHGtOUgdSiWteNsUaNM1pfyH4C0rn6ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cks2Kn7YYhLQHMPLFBseY79QSEMVDHpZZbtA1P7CdjapOa+xxBKSaurI9SfKUcf0O
	 UXMN4oB3ZYq4eTC2pv7DRfKOJ57f73XoyyZfAv06Cd/2TrLTa4gXstY1PUS92g0Q+5
	 bRGLYiJB5PxVR/pZkuXCy1rRrD2QPAalwQEo5VkTyBR4OsYRqjIGkcLRGk6/buEN3U
	 1UgCaNgzi/5Ch3pl4gQ6s8xSqL4IGh063fAqkDYm/5Sf3sBQz/pgfOEDJ5fSz/kHmh
	 9AuYQs6OsQMUiIdFSQyJWt0st1lnU0fv/ncrEEje9FVWcOQAoPqwp8BxDPVNfg/S/6
	 sNl+FKuo5SzWQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 4/4] selftests: mptcp: connect: cover zerocopy mode
Date: Sat, 11 Jul 2026 21:07:52 +0800
Message-ID: <9b6de41980a5f2fc96644c62b77b4f6be4b18902.1783774784.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783774784.git.tanggeliang@kylinos.cn>
References: <cover.1783774784.git.tanggeliang@kylinos.cn>
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


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED6E1A6800
	for <mptcp@lists.linux.dev>; Sun, 12 Jul 2026 02:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783822563; cv=none; b=JnD6Nk+KX4vrcbG9TqCdRKeAT9Jf43uuKx/XJaxvg/fUAh8OexaZKn/gwqQ4gCHebjGbvpYI2w/esrPK2eWFq/TKDE5yY0uZtlIc0r06cjXLIcKEa+dp6hVq0DisP/QLp8111k2OegDnYSLtwUeu8/+vgJyAwuXqMZWsmRIb0zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783822563; c=relaxed/simple;
	bh=gXWmEM4LFpuxOAMuCUM6NaMQDK0W28QcsZPP0A7MkB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RyUK9caS9Obte7Fgk9+f+g25rIxC05PZ7ObOeUMn/FdKFatOZ9Ye7/x8gFry/TiRbjxCceUE2offlmVuRslAKPOscOSMTlgBB4nctgNMIh95yUVU83agPhjaLCYXKUeY0zyKq/tolHZQOAV3RsJ5Uxr8BO8yOwndXMUmXfachXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0RlLGFS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0RlLGFS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272CD1F000E9;
	Sun, 12 Jul 2026 02:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783822561;
	bh=BV7dLguDmKvmHGtOUgdSiWteNsUaNM1pfyH4C0rn6ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g0RlLGFS7PaSLs4WuByv18kcAEvxENA5qvf0JFHy/MtewackvhCrgpXIcu1HeFZ2X
	 yWX2c743g2PgiGHdo7MppV59LAhyl8+Al5ukz8O95QxCoshjIhx/vmd+Oenmzw6cQP
	 3xegnGUow0l8LorViM5PFCkGKABqbrOAYFiHcKecID6IGYLlHQN2jb/YgOn3pCB0JB
	 e4uA6K0E/xy02wbs6BM26vgAB61qVLBHNI60XVTxmWGVRWcyfwIFAne7XjltyysE9+
	 CzL2omjdLgp0jiFh3vLihYQtbubGKaD80r43pV2Oqm96fAosL9hKXzP+uzGLDGfUwT
	 YSk4JLeokvu6g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 5/5] selftests: mptcp: connect: cover zerocopy mode
Date: Sun, 12 Jul 2026 10:15:24 +0800
Message-ID: <c34de2bbc6fda4bfa8d7955f62938ed91d0d44da.1783821830.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783821830.git.tanggeliang@kylinos.cn>
References: <cover.1783821830.git.tanggeliang@kylinos.cn>
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


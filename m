Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FD9223DFA
	for <mptcp@lists.linux.dev>; Sun, 13 Jul 2025 09:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752399849; cv=none; b=a/EOh/rO0cI3zSdhY+Fmh65ptYe5WcN3wd4Um2nrgNwM1YZIpma8RF1fTdMNUVMW25S+ujJHjdQp8AjAriQp6DiT3lLf+sZFvGjxGJQ66RL8+i8WaMy0D4YSF81M8Zgcu1rV2e5DAvbb8YPNZizzKIh0KVPtXC10i7FtKBh5TrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752399849; c=relaxed/simple;
	bh=42XRcqhb6EAXpfbg2YbEHCA9C3OOusII/XO52cmvxfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LcKNS6pAwPTPjItE4E4kAiqjhvURxB/ic5jgad+NWYQYdnqVzCAbW8X/Xb4Lywq71Tu8kFtYyP87QTLbBL0rb2nAtUc950cKyZCmEUkPphx3mG6rconWxIDf4aUjaSx0iqmozcZi+Be3y0XDnFWY69k5ObxSr7IumBqkFBHzrhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rMcoKD/u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rMcoKD/u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609B7C4CEF5;
	Sun, 13 Jul 2025 09:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752399848;
	bh=42XRcqhb6EAXpfbg2YbEHCA9C3OOusII/XO52cmvxfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rMcoKD/uk1L/cjR7W6HJQXryb3fZEpODFL4/l7BdnjMXbdxhC6Nzqi0oxWTaB9Gmg
	 AsU+acuSFA7YERhNz0kmfr5eJN8Ytd2dGdsmraL3AVMukG1HN0lXloZpo8mApoLPj4
	 ZopQtGAnIilkNSWc6FVcxUQc5GMD0Kv0VPgMVVDlkd0X4aPWS1RfBbSTqnydeou/to
	 V+l6F8cjIPfcLKvf+NM8KXt6GO7Aq7BdcoLv8tqWzDT1WLmjktlKYPZ2PZ7fA+ElAI
	 F0dw9l+714IVaJ661iRtps7d5HnZdCRBjGYC+QOXF7Xp+HV8W5uHqX447qSdY6j3Vk
	 jjpZRu+yqrR7Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next v9 9/9] selftests: mptcp: connect: cover splice mode
Date: Sun, 13 Jul 2025 17:43:49 +0800
Message-ID: <67267f10b998cba6e49efa979bf7a5f7cab62519.1752399661.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1752399660.git.tanggeliang@kylinos.cn>
References: <cover.1752399660.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The "splice" alternate mode for mptcp_connect.sh/.c is available now,
this patch adds mptcp_connect_splice.sh to test it in the MPTCP CI by
default.

Suggested-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/Makefile                | 2 +-
 tools/testing/selftests/net/mptcp/mptcp_connect_splice.sh | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_connect_splice.sh

diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index 4c7e51336ab2..83c1602fb6bd 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -5,7 +5,7 @@ top_srcdir = ../../../../..
 CFLAGS += -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
 
 TEST_PROGS := mptcp_connect.sh mptcp_connect_mmap.sh mptcp_connect_sendfile.sh \
-	      mptcp_connect_checksum.sh pm_netlink.sh mptcp_join.sh diag.sh \
+	      mptcp_connect_splice.sh mptcp_connect_checksum.sh pm_netlink.sh mptcp_join.sh diag.sh \
 	      simult_flows.sh mptcp_sockopt.sh userspace_pm.sh
 
 TEST_GEN_FILES = mptcp_connect pm_nl_ctl mptcp_sockopt mptcp_inq mptcp_diag
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect_splice.sh b/tools/testing/selftests/net/mptcp/mptcp_connect_splice.sh
new file mode 100755
index 000000000000..77fe240ecf8c
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect_splice.sh
@@ -0,0 +1,4 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+"$(dirname "${0}")/mptcp_connect.sh" -m splice "${@}"
-- 
2.48.1


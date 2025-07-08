Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A4E14A60D
	for <mptcp@lists.linux.dev>; Tue,  8 Jul 2025 17:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751996309; cv=none; b=gyUHn3h2J8HsnV6hMsox4RAnUeWwbSPt33yXfNhiZZddHI0VZm6BVjz8cV+0jrh0U7kFQvNjOWFUZ4Z5TwjGlTYkkqn6/OsmennrXjHR+rx8XoRXfw0ShJGyp3OuX9jaoLxuP5amfp+jz8CvPI8O5MPoVJ8CB6Bc4RqhQRRcKMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751996309; c=relaxed/simple;
	bh=HzxR7hVoBbwUIp+tGuMaE6/9JvJFmiC6G2/cqNxHwQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ABE2FUNd4VFWzDB95rZLsd316XsWjVVFVDl+DtP10cn9hbQwOYNahEbPrQpgHVhVSP0QcBBswJh/CBTbyGYUKTIqvmYiKLFx4iuHS6VuXu1sIiMoLg/mYteMmdbwQbiOkRPTWrS5/yQQYqxrxX8to/rmloPn6E0LhJmYEH8S6PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQX4nvZb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQX4nvZb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C256C4CEF0;
	Tue,  8 Jul 2025 17:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751996308;
	bh=HzxR7hVoBbwUIp+tGuMaE6/9JvJFmiC6G2/cqNxHwQI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iQX4nvZbU1PhJAp+ulStNjchJM9NLE1y3hbi5LoAmXAfoBisrSL3ilhLCQNGc3Lpk
	 RzBLagkGwlHoGyT7ws1rEjlT5BWHZgGb+sjB20XsSoERL9RoQIDthnjpEnbX9/Mv3o
	 MxjbR1Z6fn4+ces6nJjKjsu+5pM2cS/c4OBeXmcBvbDNFxutXloN7ZTCNlHp5CDqK/
	 UnOP7fCeUcOHZhmDsnY+Xo/8Di0Mzvg7SYPLdIWQKPEWOKFnbutxOpmzxU0bl0CyPY
	 CI/v9kKWbICn3XRzvNxJImqgOmUajnykXbXOCi6YDzbKdMVjaGmZpo4HHvW+qL1k1h
	 /wf8xIuJq1e0g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 08 Jul 2025 19:38:00 +0200
Subject: [PATCH mptcp-net 2/2] selftests: mptcp: connect: also cover
 checksum
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-selftests-mptcp-connect-modes-v1-2-f8e6f9828fd8@kernel.org>
References: <20250708-selftests-mptcp-connect-modes-v1-0-f8e6f9828fd8@kernel.org>
In-Reply-To: <20250708-selftests-mptcp-connect-modes-v1-0-f8e6f9828fd8@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1899; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=HzxR7hVoBbwUIp+tGuMaE6/9JvJFmiC6G2/cqNxHwQI=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJywyfqLPjNpmd26YTDCc145uNz+kXjH97xuqevbpKxr
 nvt46uFHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABO5uYaR4fauSZ/CG2x5109R
 2Ma90Jb9dNRCsQVLA1LmVsvcWJ5rtYXhnw7PvIi7epw72vYZFn9jYL62TWDew9S7R2cKfv10V3/
 3YkYA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The checksum mode has been added a while ago, but it is only validated
when manually launching mptcp_connect.sh with "-C".

The different CIs were then not validating these MPTCP Connect tests
with checksum enabled. To make sure they do, add a new test program
executing mptcp_connect.sh with the checksum mode.

Fixes: 94d66ba1d8e4 ("selftests: mptcp: enable checksum in mptcp_connect.sh")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/Makefile                  | 2 +-
 tools/testing/selftests/net/mptcp/mptcp_connect_checksum.sh | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index c6b030babba8cf888101d6af44f3e56fe5ab831b..4c7e51336ab25c662f02719f1632fa2d27d148f1 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -5,7 +5,7 @@ top_srcdir = ../../../../..
 CFLAGS += -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
 
 TEST_PROGS := mptcp_connect.sh mptcp_connect_mmap.sh mptcp_connect_sendfile.sh \
-	      pm_netlink.sh mptcp_join.sh diag.sh \
+	      mptcp_connect_checksum.sh pm_netlink.sh mptcp_join.sh diag.sh \
 	      simult_flows.sh mptcp_sockopt.sh userspace_pm.sh
 
 TEST_GEN_FILES = mptcp_connect pm_nl_ctl mptcp_sockopt mptcp_inq mptcp_diag
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect_checksum.sh b/tools/testing/selftests/net/mptcp/mptcp_connect_checksum.sh
new file mode 100755
index 0000000000000000000000000000000000000000..569340d4f00ae2e4655b30220bcfce695549a686
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect_checksum.sh
@@ -0,0 +1,4 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+"$(dirname "${0}")/mptcp_connect.sh" -C "${@}"

-- 
2.48.1


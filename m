Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14A6381EBB
	for <mptcp@lists.linux.dev>; Thu, 16 Jul 2026 07:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188301; cv=none; b=AAgQEDdToVBVReWaJexnzuTOYzIJJL0j/GMmNF/zuqNdG6Be7s5fLRNgqzKAya+vVIwfOl4CusExgARKqqehh+ZwFsIVoTpAWtekofRTznmEOJcczemPglGYy4HAsxGhY99aUUbC6WYWZs9ISrw7u9gEeLIWCuNkx0gQq5ymG38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188301; c=relaxed/simple;
	bh=gXWmEM4LFpuxOAMuCUM6NaMQDK0W28QcsZPP0A7MkB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SzK5QKUmTAFuZooowU4xV7/GAMbgjhE/9ASVuPYwP+57V/R5nXVgvqmOKsGC8+4HuiPslLxiB6GCK5Bnx5O8TxfuOuEvvw06Tq0ooPw5YvOhzWDIQWjIA2LLDmURr9j4QteWwzTRU14lFa2qPoMlzehl9k8WmvN52uhe4BDvnJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJymLHeW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJymLHeW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E70DD1F000E9;
	Thu, 16 Jul 2026 07:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784188298;
	bh=BV7dLguDmKvmHGtOUgdSiWteNsUaNM1pfyH4C0rn6ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TJymLHeWxQTMhQwBC9rAO9PFQUDtVlujGnzl8mkHGoYitqMhndznRYmEiD/V4AuzH
	 di5EUyNTNjPFNs9TzLuG+UjIIh18elJA0ExDhZdE9wJF59z1xX1ipRBoYGr/W774E6
	 CemwTwMl8D1HBoAcskBchDCVS891JAizP0Zwv/ZoD7fgHVXZav61EPUh63Lpo8gr3s
	 ZzQfjBVpTvSeDhKPSopIvzuv/aLm+X5rXuE4iuqoF/jO3eJESk4B9AOZzHiFP9shYs
	 prs/CX0mASTAmWOMRxnZVSK2kTL2ntvolfC5caUqYeuX9WC+3AateeBDVo49WNwyTM
	 gw5O5BaRqfl2w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 09/10] selftests: mptcp: connect: cover zerocopy mode
Date: Thu, 16 Jul 2026 15:50:48 +0800
Message-ID: <eba3868cf54ce4c28ab5aa0fc4b6bce26e1fe5a4.1784188064.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1784188064.git.tanggeliang@kylinos.cn>
References: <cover.1784188064.git.tanggeliang@kylinos.cn>
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


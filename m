Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CBE41D63E
	for <mptcp@lists.linux.dev>; Wed, 15 Jul 2026 11:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784113453; cv=none; b=WV8GWazx5FuTpfIQvnj/el3zsUf4Hys/FTW9sN8sHj7qdRJ6uHOCAuVvq5QmM9DofJvow+yQJxLKsFPIdGeDoQMjUZpN0VV1zWF1k+Vy6ujv58DFY025mok0XVKqF6kGd0sAm2gfmqCC7Qw0sEuAdULGSKF1cT3eM1r/YHcWxiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784113453; c=relaxed/simple;
	bh=gXWmEM4LFpuxOAMuCUM6NaMQDK0W28QcsZPP0A7MkB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AFBDFWTdMX41vAzVN7ePab8aod8ZbqzuIEMPWNucFSnuYiAlYMXIjNr/+nMPnLMK3zmB299oDjI7RDnX1kw9Lzl8Zpk8ukUfS3X2E8bTO3ZIzqOBnS64wuvqhsuw2VEdrol253AaXVykXbmVZDHyyD3r6+dtPw8mRtYhoCxpy04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DuRf60co; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuRf60co"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058A31F00A3A;
	Wed, 15 Jul 2026 11:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784113451;
	bh=BV7dLguDmKvmHGtOUgdSiWteNsUaNM1pfyH4C0rn6ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DuRf60cohBC0lVTzE1BxVdX+msWfWJX70CSxnqUqZwBrDQdoE6jhqJeWii7CMuOwx
	 ZUoSOjrhNv/WxwMUV/mBjO9lEEKZ+yUArvFryL+1gDEbGhFaJ5LEQ2tWtWGQAXxPeM
	 qV1t1eQ2+J743R1mooC/BOE2v05/og4w+/AEptAQNSso0cpmuSz3Sk7ukf/Ii+Uuef
	 7qfEyHIx88KJU/HUIrhnc/0hyJNitDQALt8p1XpCtkLgFq4vLjijZtL3Uzlk8dU4Sp
	 td7hIBBK4fpBjI4o8kWsa+8FZ+r/Xxqx+mmtkWgoVpP+3/TushdlXGmHA6l4n0D+xp
	 BvvlHRAwA5w+A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 7/8] selftests: mptcp: connect: cover zerocopy mode
Date: Wed, 15 Jul 2026 19:03:52 +0800
Message-ID: <e882a387e24b968dc187d9b0c15ab655e489fb05.1784113088.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1784113088.git.tanggeliang@kylinos.cn>
References: <cover.1784113088.git.tanggeliang@kylinos.cn>
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


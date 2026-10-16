Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD00299959
	for <mptcp@lists.linux.dev>; Fri, 16 Oct 2026 01:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792114521; cv=none; b=TyrLiMRs9IQaGXw73yo+r1gmPgjDaaKv/xIYCtQrHvIAUVN91xh0Zrfy8O3NfHbPRD+Fsukh/34KDVkXCunAvOUgecy+dLq4ngDfqVngdNz3x4ytChMrJ7DHfE+GMOtrqbZmr55kETamQ1eOhT2ppA1vCh0mKxatNfzCiSaKq6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792114521; c=relaxed/simple;
	bh=lnIypH2Io2PTFt7py7Zsp+TjgeVJ81EZuCTR5Ygqwjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lWpuay4MpgRaDFFWeLPYN5nwJbisc7MzrXr94kwfZ0TaB/3UWLzvEB0FKqjgwuSfHjFrORC1pXkv8C/YjQJspfdm+pTJkaXfuSeVyEzzefYla4Mjt3nu2VX7HKMkzJXWCSDfDNxTrvkueX4PFLFBHzoWpqEicIBUoyge7SNB4tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RENXIlwh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RENXIlwh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508A21F000C4;
	Fri, 16 Oct 2026 01:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792114520;
	bh=m+vfMKaUcRud1N1RGkqa/CXZeSgASh1wKDhobW4FePY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RENXIlwhLeVcxHd23sGO8zH8lKRF+QT63LTZhUs71/j7ZgNJvCgtZBpBNPNe8svES
	 R9tO+nU9mPSZa1vfd9kbpA0dR3NFra/FqINiMNzefOxVZrFqzSESrAIr8KvPrc/c4d
	 SiE8s8XYMHO6QHCekIXl4zOAYxCRfJEQSauXhhnFu0hA2DgGcoXo/2+IrzLF7KQfXK
	 LS8ZPmZ2+k2+wQrH33kCT3RCkcsf78Y9eNV7EbVx/bPDW/VQgLEnVdc3JcEV8pdW/6
	 tSz624evwZpC3Pr8ArQRZdFkCmLBXgrBnwCVZzCgnCWtBAAEU3fVXA+YjS82BONIjv
	 xymWhouxWo+5w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 2/2] mptcp: kunit: add sockopt test for subflow socket locking
Date: Fri, 16 Oct 2026 09:35:10 +0800
Message-ID: <e32025457f5b30b3d859e85077752b761757a35f.1792114102.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1792114102.git.tanggeliang@kylinos.cn>
References: <cover.1792114102.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add a KUnit test to verify that MPTCP sockets have a distinct lockdep
class from their subflows. The test creates a kernel MPTCP socket and
sets SO_REUSEADDR, which triggers the code path where
mptcp_setsockopt_sol_socket() locks the MPTCP socket and then calls
sk_setsockopt() on the subflow.

Without the lockdep fix (distinct MPTCP socket class), this triggers a
"possible recursive locking" warning:

'''
  kunit_try_catch/355 is trying to acquire lock:
  ffff888115c99c58 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: \
					sk_setsockopt+0x1132/0x3b30

  but task is already holding lock:
  ffff88811ac80e98 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: \
				mptcp_setsockopt_sol_socket+0xed/0x910

  Possible unsafe locking scenario:
         CPU0
         ----
    lock(k-sk_lock-AF_INET);
    lock(k-sk_lock-AF_INET);

  *** DEADLOCK ***
'''

With the fix, the MPTCP socket has its own msk_lock-AF_INET class (or
msk_lock-AF_INET6 for IPv6) and no warning appears.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/Makefile       |  4 +++-
 net/mptcp/sockopt_test.c | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 1 deletion(-)
 create mode 100644 net/mptcp/sockopt_test.c

diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
index bd72b300a0f6..e9ae91cff940 100644
--- a/net/mptcp/Makefile
+++ b/net/mptcp/Makefile
@@ -10,7 +10,9 @@ obj-$(CONFIG_INET_MPTCP_DIAG) += mptcp_diag.o
 
 mptcp_crypto_test-objs := crypto_test.o
 mptcp_token_test-objs := token_test.o
-obj-$(CONFIG_MPTCP_KUNIT_TEST) += mptcp_crypto_test.o mptcp_token_test.o
+mptcp_sockopt_test-objs := sockopt_test.o
+obj-$(CONFIG_MPTCP_KUNIT_TEST) += mptcp_crypto_test.o mptcp_token_test.o \
+				  mptcp_sockopt_test.o
 
 obj-$(CONFIG_BPF_SYSCALL) += bpf.o
 
diff --git a/net/mptcp/sockopt_test.c b/net/mptcp/sockopt_test.c
new file mode 100644
index 000000000000..ebd43de02543
--- /dev/null
+++ b/net/mptcp/sockopt_test.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <kunit/test.h>
+
+#include "protocol.h"
+
+static void mptcp_sockopt_reuseaddr(struct kunit *test)
+{
+	struct socket *sock;
+	int err, reuse = 1;
+
+	err = sock_create_kern(&init_net, AF_INET, SOCK_STREAM, IPPROTO_MPTCP,
+			       &sock);
+	KUNIT_ASSERT_EQ(test, err, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sock);
+
+	err = sock_common_setsockopt(sock, SOL_SOCKET, SO_REUSEADDR,
+				     KERNEL_SOCKPTR(&reuse), sizeof(reuse));
+
+	KUNIT_EXPECT_EQ(test, err, 0);
+
+	sock_release(sock);
+}
+
+static struct kunit_case mptcp_sockopt_test_cases[] = {
+	KUNIT_CASE(mptcp_sockopt_reuseaddr),
+	{}
+};
+
+static struct kunit_suite mptcp_sockopt_suite = {
+	.name = "mptcp-sockopt",
+	.test_cases = mptcp_sockopt_test_cases,
+};
+
+kunit_test_suite(mptcp_sockopt_suite);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("KUnit tests for MPTCP sockopt");
-- 
2.55.0


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D8437F728
	for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 03:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792379090; cv=none; b=jzmoRrJwJgd3BjNpAa9UEYtwg6sWbHdR/EI51OUPdwX9xuz4Gx204b8SZAPEBs5UuS1KVn1u+PGkvlPgiaBuEqsaM92p7KzVWbbT7cqIuBm3EYjHfjshr99MGn9flXV6qEpSH1lT+c8IzAosVairYhsgyORJBhzsTOu+ytTzXfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792379090; c=relaxed/simple;
	bh=XHzEIETw6pjqnBBIuiQiu1YXvdCj5cbE/KbKcd8mS0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e80HKy4kP1MbaWNllWwOXIazauiogf1wPsxl+fw379CSED5JTnY2pweW6SSQ5K8s/eQvh55laN0UDcXL+NmQUGkCvMaGXgrzcKZ4xExA1PxxoS+UVcGjiV/gDsN/bc8NusN6JKp9Aj0ntmWJYhqgZXq2fLtGDiPz0SjB0OxnPuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKrnPm/s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKrnPm/s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC2D1F000C6;
	Mon, 19 Oct 2026 03:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792379085;
	bh=VTk1E68JxEUevrvfdOu4PHXagbnQii6otC5KbBjWiO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IKrnPm/s1QdqXABwtWiUgJ5Ep2Kj+mfzZjKmOeHO1fu6veW8eXeRz5D478BgM2Uz2
	 OuaKtWZNdVKqPo0FtIm/qunQ4biUpH256vVJy4vWZWCJipdVmdSnwl+WsELyOyH/yS
	 Fb+haCAS/oFqi6CSq3BzDDyIhyIh1ha4i9xo32XmYDXbUYz2eJba9T4MKHUakc4mxQ
	 8UMqMM5UqVqAEHNMNgnDc2u/YwG3JcQVFyxy+K4PxNksnzfRXuWXFJTVJI+N5s6/SP
	 iRqSWI1wdH4cM+lI5orwplZsrmLJwtmQ9oFEzLs0MQ9km7j8z46k+vRXPqu1xttNcm
	 JVFhltB/LwCfw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 2/2] mptcp: kunit: add sockopt test
Date: Mon, 19 Oct 2026 11:04:34 +0800
Message-ID: <398dbbf2562050831dae08e0a9058df6b91e575e.1792378794.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1792378794.git.tanggeliang@kylinos.cn>
References: <cover.1792378794.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add a KUnit test to verify MPTCP socket options and lockdep class
separation. The test creates kernel MPTCP sockets, sets SO_REUSEADDR,
establishes a connection (bind, listen, connect, accept), transfers
data, and verifies that MPTCP sockets have distinct lockdep classes
from their subflows.

The test covers both IPv4 and IPv6 address families, and checks both
actively created sockets (client) and passively cloned sockets
(accepted) to ensure proper lockdep class assignment in all paths.

When CONFIG_PROVE_LOCKING is enabled, the test directly compares
lockdep keys between MPTCP sockets and their subflows to detect any
regression in lock class assignment.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/Kconfig        |   2 +-
 net/mptcp/Makefile       |   4 +-
 net/mptcp/sockopt_test.c | 145 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 149 insertions(+), 2 deletions(-)
 create mode 100644 net/mptcp/sockopt_test.c

diff --git a/net/mptcp/Kconfig b/net/mptcp/Kconfig
index a9f58edc354c..cdae7be802fb 100644
--- a/net/mptcp/Kconfig
+++ b/net/mptcp/Kconfig
@@ -28,7 +28,7 @@ config MPTCP_KUNIT_TEST
 	depends on KUNIT
 	default KUNIT_ALL_TESTS
 	help
-	  Currently covers the MPTCP crypto and token helpers.
+	  Currently covers the MPTCP crypto and token helpers, and sockopt tests
 	  Only useful for kernel devs running KUnit test harness and are not
 	  for inclusion into a production build.
 
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
index 000000000000..b4b9c40be92f
--- /dev/null
+++ b/net/mptcp/sockopt_test.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <kunit/test.h>
+
+#include "protocol.h"
+
+#ifdef CONFIG_PROVE_LOCKING
+static void mptcp_check_lockdep_class(struct kunit *test, struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sock *ssk = msk->first;
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ssk);
+	KUNIT_EXPECT_PTR_NE(test,
+			    sk->sk_lock.dep_map.key,
+			    ssk->sk_lock.dep_map.key);
+}
+#endif
+
+static void mptcp_sockopt_test(struct kunit *test, sa_family_t family)
+{
+	struct socket *server_sock, *client_sock, *accepted_sock;
+	struct msghdr send_msg = { 0 }, recv_msg = { 0 };
+	struct sockaddr_storage server_addr;
+	struct kvec send_vec, recv_vec;
+	struct sockaddr_storage addr;
+	char send_buf[] = "MPTCP";
+	char recv_buf[32] = { 0 };
+	int err, reuse = 1;
+	int addrlen;
+
+	/* Initialize server address */
+	memset(&addr, 0, sizeof(addr));
+	if (family == AF_INET6) {
+		struct sockaddr_in6 *addr6 = (struct sockaddr_in6 *)&addr;
+
+		addr6->sin6_family = AF_INET6;
+		addr6->sin6_port = htons(0);
+		addr6->sin6_addr = in6addr_loopback;
+		addrlen = sizeof(struct sockaddr_in6);
+	} else {
+		struct sockaddr_in *addr4 = (struct sockaddr_in *)&addr;
+
+		addr4->sin_family = AF_INET;
+		addr4->sin_port = htons(0);
+		addr4->sin_addr.s_addr = htonl(INADDR_LOOPBACK);
+		addrlen = sizeof(struct sockaddr_in);
+	}
+
+	/* Create server socket and test SO_REUSEADDR */
+	err = sock_create_kern(&init_net, family, SOCK_STREAM, IPPROTO_MPTCP,
+			       &server_sock);
+	KUNIT_ASSERT_EQ(test, err, 0);
+
+	err = sock_common_setsockopt(server_sock, SOL_SOCKET, SO_REUSEADDR,
+				     KERNEL_SOCKPTR(&reuse), sizeof(reuse));
+	KUNIT_EXPECT_EQ(test, err, 0);
+	KUNIT_EXPECT_EQ(test, (int)server_sock->sk->sk_reuse, SK_CAN_REUSE);
+
+	err = kernel_bind(server_sock, (struct sockaddr_unsized *)&addr,
+			  addrlen);
+	KUNIT_ASSERT_EQ(test, err, 0);
+
+	/* Get the assigned port */
+	err = kernel_getsockname(server_sock, (struct sockaddr *)&server_addr);
+	KUNIT_ASSERT_EQ(test, err, addrlen);
+
+	err = kernel_listen(server_sock, 5);
+	KUNIT_ASSERT_EQ(test, err, 0);
+
+	/* Create client socket and test SO_REUSEADDR */
+	err = sock_create_kern(&init_net, family, SOCK_STREAM, IPPROTO_MPTCP,
+			       &client_sock);
+	KUNIT_ASSERT_EQ(test, err, 0);
+
+	err = sock_common_setsockopt(client_sock, SOL_SOCKET, SO_REUSEADDR,
+				     KERNEL_SOCKPTR(&reuse), sizeof(reuse));
+	KUNIT_EXPECT_EQ(test, err, 0);
+	KUNIT_EXPECT_EQ(test, (int)client_sock->sk->sk_reuse, SK_CAN_REUSE);
+
+	/* Connect to server */
+	err = kernel_connect(client_sock,
+			     (struct sockaddr_unsized *)&server_addr,
+			     addrlen, 0);
+	KUNIT_ASSERT_EQ(test, err, 0);
+
+	/* Accept connection on server */
+	err = kernel_accept(server_sock, &accepted_sock, 0);
+	KUNIT_ASSERT_EQ(test, err, 0);
+
+	/* Send data from client */
+	send_vec.iov_base = send_buf;
+	send_vec.iov_len = strlen(send_buf);
+	err = kernel_sendmsg(client_sock, &send_msg, &send_vec, 1,
+			     strlen(send_buf));
+	KUNIT_ASSERT_EQ(test, err, strlen(send_buf));
+
+	/* Receive data on server */
+	recv_vec.iov_base = recv_buf;
+	recv_vec.iov_len = sizeof(recv_buf);
+	err = kernel_recvmsg(accepted_sock, &recv_msg, &recv_vec, 1,
+			     sizeof(recv_buf), 0);
+	KUNIT_ASSERT_EQ(test, err, strlen(send_buf));
+
+	/* Verify data */
+	KUNIT_EXPECT_STREQ(test, recv_buf, send_buf);
+
+#ifdef CONFIG_PROVE_LOCKING
+	mptcp_check_lockdep_class(test, client_sock->sk);
+	mptcp_check_lockdep_class(test, accepted_sock->sk);
+#endif
+
+	sock_release(accepted_sock);
+	sock_release(client_sock);
+	sock_release(server_sock);
+}
+
+static void mptcp_sockopt_test_v4(struct kunit *test)
+{
+	mptcp_sockopt_test(test, AF_INET);
+}
+
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+static void mptcp_sockopt_test_v6(struct kunit *test)
+{
+	mptcp_sockopt_test(test, AF_INET6);
+}
+#endif
+
+static struct kunit_case mptcp_sockopt_test_cases[] = {
+	KUNIT_CASE(mptcp_sockopt_test_v4),
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	KUNIT_CASE(mptcp_sockopt_test_v6),
+#endif
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


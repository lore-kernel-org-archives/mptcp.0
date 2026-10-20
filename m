Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792470896;
	b=aXxafXiXMNnNvE6IQqMWJ/VE6N15b0TE/44HkUSUH0ieP3nuUd7LLgm197G4PjSZzRcm
	 QHyqmTNLI46xTii2wrbzj1cCSpUsv5/p+KFxZGO4X6ndlT/vFkEJ4LwrrJRDIADMbrBS3
	 J2jmdqABRBsb9g+NImT4yvWwhWcLU2wNvlDcyNu5TxulZd62L5I5eeMaqq+2M50nBynbc
	 Q0pWLfz5EXCnLxDxlUo7dZpb1W1Tu9H47kyVpK3PaGoaxDq6St8mSX0NcBdlV07d2xntO
	 35DgM0Mn0qKTiuQhS/hWW+t3U8Br38j05jYxalu2j2EK5NZcM6R4fmVPl9sWfvC6fIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792470896;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Gg5BWj2pzhU7yNFQC+AXn6aNAEg0r6JvCwrCw869QB0=;
	b=hjIvZngcMqS9CEjrijEfT7C2ihrBaYF5L+RdCmxgPminzI8pQpN5+WbOyHpzLB+fzoLM
	 LUpT7OMUFQpqIL5S+/5K5OV8tq/fAiDzFzpU/b6ZWz3aLVP4bgvT8KgDfcFP3YMNb9Wae
	 c6uxYlLwW/KnZRzZBcoAE75UA8msE1JjldAuzOl2vPCPEUDdfWc7fLIT0oKVIUn8qnfe9
	 khI4K6Fl318lcPMET5IH4FC7dHYDd5J3Bysc3WfNkpk80v3suWlPAeQY80D/HB+mSxIL6
	 0j21G7p1Q94PijjIE4YoUQi+mrojbJ07YG0s2SheTwTicG8dzISCLcgfgif+xReF0Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KARy6Gc4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E267606A319
	for <mptcp@lists.linux.dev>; Tue, 20 Oct 2026 04:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KARy6Gc4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84441F000C6;
	Tue, 20 Oct 2026 04:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792470895;
	bh=Gg5BWj2pzhU7yNFQC+AXn6aNAEg0r6JvCwrCw869QB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KARy6Gc4F0xBcu/CyrUOFmwF5861VEW24Ra71Rw1K6NVyV2FNRs4kSLFh1ZVYhmwI
	 F5H5HHs/MigUivxK+7vePtQdkJ2Q1Ntiaoe5dMTILRJKpSy+Fg8ifc3dnZdBC/2Mwd
	 TrNhU7vz8F711vZAf8URVqg4DQ2XVgCm81My2i2Fe8A/FLxehlpnsXFP9dpCkMav7K
	 5JvNs6BjHgdcA4d+70iSeHKNCknF+4waecg7DoWvmZwiTFn8U4S+bR2Ewq96wZVErI
	 tnUZVP7ETMS0TBlM/Le5HUI4oDiB5p7aGi+Z90yyMsp+GpdX8bccWGHhnwuIUNZ6hP
	 zfINQ5ssV0KCA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 3/3] mptcp: kunit: add sockopt test
Date: Tue, 20 Oct 2026 12:34:45 +0800
Message-ID: <fdd33ceda25e9c54bf9c38c999034af7d6a6f08e.1792470313.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1792470313.git.tanggeliang@kylinos.cn>
References: <cover.1792470313.git.tanggeliang@kylinos.cn>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add a KUnit test to verify MPTCP socket options and lockdep class
separation. The test creates kernel MPTCP sockets, sets SO_REUSEADDR,
SO_BINDTODEVICE, and SO_BINDTOIFINDEX options via helper functions
(mptcp_test_reuseaddr, mptcp_test_bindtodevice, mptcp_test_bindtoifindex),
establishes a connection (bind, listen, connect, accept), transfers data,
and verifies that MPTCP sockets have distinct lockdep classes from their
subflows.

The test covers both IPv4 and IPv6 address families, and checks both
actively created sockets (client) and passively cloned sockets
(accepted) to ensure proper lockdep class assignment in all paths.

When CONFIG_PROVE_LOCKING is enabled, the test directly compares
lockdep keys between MPTCP sockets and their subflows to detect any
regression in lock class assignment.

The test uses INADDR_ANY instead of INADDR_LOOPBACK to avoid binding
failures when running during early boot before loopback device is up.
Socket cleanup is handled via kunit_add_action_or_reset() to prevent
resource leaks on test failures.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/Kconfig        |   2 +-
 net/mptcp/Makefile       |   4 +-
 net/mptcp/sockopt_test.c | 184 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 188 insertions(+), 2 deletions(-)
 create mode 100644 net/mptcp/sockopt_test.c

diff --git a/net/mptcp/Kconfig b/net/mptcp/Kconfig
index a9f58edc354c..ee9e0a04d52a 100644
--- a/net/mptcp/Kconfig
+++ b/net/mptcp/Kconfig
@@ -28,7 +28,7 @@ config MPTCP_KUNIT_TEST
 	depends on KUNIT
 	default KUNIT_ALL_TESTS
 	help
-	  Currently covers the MPTCP crypto and token helpers.
+	  Currently covers the MPTCP crypto and token helpers, and sockopt tests.
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
index 000000000000..f8ce69911caf
--- /dev/null
+++ b/net/mptcp/sockopt_test.c
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <kunit/test.h>
+
+#include "protocol.h"
+
+#ifdef CONFIG_PROVE_LOCKING
+static void mptcp_check_lockdep_class(struct kunit *test, struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sock *ssk;
+
+	ssk = READ_ONCE(msk->first);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ssk);
+	KUNIT_EXPECT_PTR_NE(test, sk->sk_lock.dep_map.key,
+			    ssk->sk_lock.dep_map.key);
+}
+#endif
+
+static void sock_release_wrapper(void *sock)
+{
+	sock_release(sock);
+}
+
+static void mptcp_test_reuseaddr(struct kunit *test, struct socket *sock)
+{
+	int reuse = 1;
+	int err;
+
+	err = sock_common_setsockopt(sock, SOL_SOCKET, SO_REUSEADDR,
+				     KERNEL_SOCKPTR(&reuse), sizeof(reuse));
+	KUNIT_EXPECT_EQ(test, err, 0);
+	KUNIT_EXPECT_EQ(test, (int)sock->sk->sk_reuse, SK_CAN_REUSE);
+}
+
+static void mptcp_test_bindtodevice(struct kunit *test, struct socket *sock)
+{
+	struct net_device *lo = dev_get_by_name(&init_net, "lo");
+	char ifname[IFNAMSIZ];
+	int ifindex, err;
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, lo);
+	ifindex = lo->ifindex;
+	strscpy(ifname, lo->name, sizeof(ifname));
+	dev_put(lo);
+
+	err = sock_common_setsockopt(sock, SOL_SOCKET, SO_BINDTODEVICE,
+				     KERNEL_SOCKPTR(ifname),
+				     strlen(ifname) + 1);
+	KUNIT_EXPECT_EQ(test, err, 0);
+	KUNIT_EXPECT_EQ(test, sock->sk->sk_bound_dev_if, ifindex);
+}
+
+static void mptcp_test_bindtoifindex(struct kunit *test, struct socket *sock)
+{
+	struct net_device *lo = dev_get_by_name(&init_net, "lo");
+	int ifindex, err;
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, lo);
+	ifindex = lo->ifindex;
+	dev_put(lo);
+
+	err = sock_common_setsockopt(sock, SOL_SOCKET, SO_BINDTOIFINDEX,
+				     KERNEL_SOCKPTR(&ifindex), sizeof(ifindex));
+	KUNIT_EXPECT_EQ(test, err, 0);
+	KUNIT_EXPECT_EQ(test, sock->sk->sk_bound_dev_if, ifindex);
+}
+
+static void mptcp_sockopt_test(struct kunit *test, sa_family_t family)
+{
+	struct socket *server_sock, *client_sock, *accepted_sock;
+	struct msghdr send_msg = { 0 }, recv_msg = { 0 };
+	struct sockaddr_storage addr = { 0 };
+	struct kvec send_vec, recv_vec;
+	char send_buf[] = "MPTCP";
+	char recv_buf[32] = { 0 };
+	int err, addrlen;
+
+	if (family == AF_INET6) {
+		struct sockaddr_in6 *addr6 = (struct sockaddr_in6 *)&addr;
+
+		addr6->sin6_family = AF_INET6;
+		addr6->sin6_port = htons(0);
+		addr6->sin6_addr = in6addr_any;
+		addrlen = sizeof(struct sockaddr_in6);
+	} else {
+		struct sockaddr_in *addr4 = (struct sockaddr_in *)&addr;
+
+		addr4->sin_family = AF_INET;
+		addr4->sin_port = htons(0);
+		addr4->sin_addr.s_addr = htonl(INADDR_ANY);
+		addrlen = sizeof(struct sockaddr_in);
+	}
+
+	err = sock_create_kern(&init_net, family, SOCK_STREAM, IPPROTO_MPTCP,
+			       &server_sock);
+	KUNIT_ASSERT_EQ(test, err, 0);
+	err = kunit_add_action_or_reset(test, sock_release_wrapper,
+					server_sock);
+	KUNIT_ASSERT_EQ(test, err, 0);
+
+	mptcp_test_reuseaddr(test, server_sock);
+
+	mptcp_test_bindtodevice(test, server_sock);
+
+	err = kernel_bind(server_sock, (struct sockaddr_unsized *)&addr,
+			  addrlen);
+	KUNIT_ASSERT_EQ(test, err, 0);
+
+	err = kernel_getsockname(server_sock, (struct sockaddr *)&addr);
+	KUNIT_ASSERT_EQ(test, err, addrlen);
+
+	err = kernel_listen(server_sock, 5);
+	KUNIT_ASSERT_EQ(test, err, 0);
+
+	err = sock_create_kern(&init_net, family, SOCK_STREAM, IPPROTO_MPTCP,
+			       &client_sock);
+	KUNIT_ASSERT_EQ(test, err, 0);
+	err = kunit_add_action_or_reset(test, sock_release_wrapper,
+					client_sock);
+	KUNIT_ASSERT_EQ(test, err, 0);
+
+	mptcp_test_bindtoifindex(test, client_sock);
+
+	err = kernel_connect(client_sock,
+			     (struct sockaddr_unsized *)&addr,
+			     addrlen, 0);
+	KUNIT_ASSERT_EQ(test, err, 0);
+
+	err = kernel_accept(server_sock, &accepted_sock, 0);
+	KUNIT_ASSERT_EQ(test, err, 0);
+	err = kunit_add_action_or_reset(test, sock_release_wrapper,
+					accepted_sock);
+	KUNIT_ASSERT_EQ(test, err, 0);
+
+	send_vec.iov_base = send_buf;
+	send_vec.iov_len = strlen(send_buf);
+	err = kernel_sendmsg(client_sock, &send_msg, &send_vec, 1,
+			     strlen(send_buf));
+	KUNIT_ASSERT_EQ(test, err, (int)strlen(send_buf));
+
+	recv_vec.iov_base = recv_buf;
+	recv_vec.iov_len = sizeof(recv_buf);
+	err = kernel_recvmsg(accepted_sock, &recv_msg, &recv_vec, 1,
+			     sizeof(recv_buf), 0);
+	KUNIT_ASSERT_EQ(test, err, (int)strlen(send_buf));
+
+	KUNIT_EXPECT_STREQ(test, recv_buf, send_buf);
+
+#ifdef CONFIG_PROVE_LOCKING
+	mptcp_check_lockdep_class(test, client_sock->sk);
+	mptcp_check_lockdep_class(test, accepted_sock->sk);
+#endif
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


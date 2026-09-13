Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590F93E16A9
	for <mptcp@lists.linux.dev>; Sun, 13 Sep 2026 10:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789294523; cv=none; b=NpoT8QI5IGBPCoaekFPkH6PvlkxZrxX0VW6cZPgtq6aF/AywXFa0kcXLfWao3pOl4u8dYe+Bqzwnq41DwteCTTMI2Nzwdpt4AVw0DUUS0E1nx5tWQgq7sVxmEOTLj5f6/Y+cnwktLmBDqexanYTrrAMqb7QreC0CoimBC3yMgPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789294523; c=relaxed/simple;
	bh=M8i5Itm8HEYRMa8EmHeGu/lEUv6svLMMRkIxnYZASsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uA07tCv5a9WlDnsYBemGoGfk/4ubD2KSUsTbhC8itfXcdGnLQRoS2HwvsnRD65896OwSBICsAFkLBCJms4s1DqRQUh4JDSOSTrfXebN5HZa2DhcFsTu2FCENjzdyGdzTjXvsuvgs0Ch8YT7aDTOep7sHDWB9n8XKSH54t/j+1v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJWxMBOJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJWxMBOJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113851F00898;
	Sun, 13 Sep 2026 10:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789294520;
	bh=zaUslCg2NGFqGsTOCGPfuYrCUiPhrTkj78xHlnj1UuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PJWxMBOJ/dmypFRkzsY6VoOjoUXYVK7GhmgJB6lABMki0suIf7XtEoi9SMtE3mjAl
	 Rnjj6SzlUdfjtCj+Gyny9l48BzIk9yCRpBWszs7664SrNu8rGnmqMT2Uxo8erWDdVM
	 H7kYOngxGj2fNcyYbNrfXmJDQc+S0zB+ScsyDsZ4nNZQl/EA7EnWUkKwVOQmuAzHrq
	 at/4Z77CEK5pRbiLRkYqeKYnvqtT+TIvHbTCFZrP19K2N61bmXI2hzNS5lNTc6w1SA
	 +QGiWKFR0PXafEBT75FiP5c9382sHxS2yLDDOXoKdgPs5L+IqEOu/sVKgT5yaWXWaW
	 x7Jx4v1Q96KbQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 08/16] selftests/bpf: enable MPTCP support in sockmap tests
Date: Sun, 13 Sep 2026 18:14:47 +0800
Message-ID: <d41e0548d50abfaf2cee060e587889748e3a1f14.1789294365.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1789294365.git.tanggeliang@kylinos.cn>
References: <cover.1789294365.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Update sockmap tests to reflect new MPTCP support. MPTCP sockets are now
allowed in sockmap, so test expectations are adjusted accordingly.

Use a different key (1) for MPTCP client sockets to validate sockmap.

In test_sockmap_with_mptcp, client_fd1 is changed from TCP fallback to
MPTCP. The sockops program now uses bpf_mptcp_sock_map_update() to insert
the parent MPTCP socket into the sockmap, which succeeds (returns 0).
Since the server socket is already inserted by the sockops program, a
duplicate userspace insertion at the same key returns -EBUSY. The client
socket is additionally inserted at a different key (1) from userspace to
verify that MPTCP client sockets are allowed in sockmap.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 27 ++++++++++---------
 .../selftests/bpf/progs/mptcp_sockmap.c       |  8 ++++--
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index d77c9f8c53c7..59ea562882a0 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -552,11 +552,11 @@ static void test_sockmap_with_mptcp_fallback(struct mptcp_sockmap *skel)
 	close(listen_fd);
 }
 
-/* Test sockmap rejection of MPTCP sockets - both server and client sides. */
-static void test_sockmap_reject_mptcp(struct mptcp_sockmap *skel)
+/* Test sockmap on MPTCP sockets - both server and client sides. */
+static void test_sockmap_with_mptcp(struct mptcp_sockmap *skel)
 {
 	int listen_fd = -1, server_fd = -1, client_fd1 = -1;
-	int err, zero = 0;
+	int err, zero = 0, one = 1;
 
 	/* start server with MPTCP enabled */
 	listen_fd = start_mptcp_server(AF_INET, NULL, 0, 0);
@@ -570,20 +570,20 @@ static void test_sockmap_reject_mptcp(struct mptcp_sockmap *skel)
 	if (!ASSERT_OK_FD(client_fd1, "connect_to_fd client_fd1"))
 		goto end;
 
-	/* bpf_sock_map_update() called from sockops should reject MPTCP sk */
-	if (!ASSERT_EQ(skel->bss->helper_ret, -EOPNOTSUPP, "should reject"))
+	/* bpf_mptcp_sock_map_update() called from sockops should be allowed */
+	if (!ASSERT_EQ(skel->bss->helper_ret, 0, "should be allowed"))
 		goto end;
 
 	server_fd = accept(listen_fd, NULL, 0);
 	err = bpf_map_update_elem(bpf_map__fd(skel->maps.sock_map),
 				  &zero, &server_fd, BPF_NOEXIST);
-	if (!ASSERT_EQ(err, -EOPNOTSUPP, "server should be disallowed"))
+	if (!ASSERT_EQ(err, -EBUSY, "server should be allowed"))
 		goto end;
 
-	/* MPTCP client should also be disallowed */
+	/* MPTCP client should also be allowed */
 	err = bpf_map_update_elem(bpf_map__fd(skel->maps.sock_map),
-				  &zero, &client_fd1, BPF_NOEXIST);
-	if (!ASSERT_EQ(err, -EOPNOTSUPP, "client should be disallowed"))
+				  &one, &client_fd1, BPF_NOEXIST);
+	if (!ASSERT_EQ(err, 0, "client should be allowed"))
 		goto end;
 end:
 	if (client_fd1 >= 0)
@@ -607,9 +607,10 @@ static void test_mptcp_sockmap(void)
 	if (!ASSERT_OK_PTR(skel, "skel_open_load: mptcp_sockmap"))
 		goto close_cgroup;
 
-	skel->links.mptcp_sockmap_inject =
-		bpf_program__attach_cgroup(skel->progs.mptcp_sockmap_inject, cgroup_fd);
-	if (!ASSERT_OK_PTR(skel->links.mptcp_sockmap_inject, "attach sockmap"))
+	skel->links.mptcp_sockmap_update =
+		bpf_program__attach_cgroup(skel->progs.mptcp_sockmap_update,
+					   cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links.mptcp_sockmap_update, "attach sockmap"))
 		goto skel_destroy;
 
 	err = bpf_prog_attach(bpf_program__fd(skel->progs.mptcp_sockmap_redirect),
@@ -626,7 +627,7 @@ static void test_mptcp_sockmap(void)
 		goto close_netns;
 
 	test_sockmap_with_mptcp_fallback(skel);
-	test_sockmap_reject_mptcp(skel);
+	test_sockmap_with_mptcp(skel);
 
 close_netns:
 	netns_free(netns);
diff --git a/tools/testing/selftests/bpf/progs/mptcp_sockmap.c b/tools/testing/selftests/bpf/progs/mptcp_sockmap.c
index d4eef0cbadb9..085e14bea015 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_sockmap.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_sockmap.c
@@ -2,6 +2,9 @@
 
 #include "bpf_tracing_net.h"
 
+static long (*bpf_mptcp_sock_map_update)(struct bpf_sock_ops *, void *,
+					 void *, __u64) = (void *)212;
+
 char _license[] SEC("license") = "GPL";
 
 int sk_index;
@@ -16,7 +19,7 @@ struct {
 } sock_map SEC(".maps");
 
 SEC("sockops")
-int mptcp_sockmap_inject(struct bpf_sock_ops *skops)
+int mptcp_sockmap_update(struct bpf_sock_ops *skops)
 {
 	struct bpf_sock *sk;
 
@@ -30,7 +33,8 @@ int mptcp_sockmap_inject(struct bpf_sock_ops *skops)
 		return 1;
 
 	/* update sk handler */
-	helper_ret = bpf_sock_map_update(skops, &sock_map, &sk_index, BPF_NOEXIST);
+	helper_ret = bpf_mptcp_sock_map_update(skops, &sock_map, &sk_index,
+					       BPF_NOEXIST);
 
 	return 1;
 }
-- 
2.53.0


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1F13A9618
	for <mptcp@lists.linux.dev>; Wed, 18 Mar 2026 09:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773826860; cv=none; b=XwvnqBjlqNZWIN7QX58/EoPrZ7awef4wA1GpYcWisYKXeavaf6pWK9sgXYJaBo0qBWHjNI29zm8ka/R+1Aw2Dc5/syefvlODcLoST6bHLlVkLACatlvgHh7lRHimpH36kUBM+ibi1jh9qFA1XFZ9ZU3p7CDPKcg0ixAPTNXbK2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773826860; c=relaxed/simple;
	bh=wwtV46sjJuFK7MQZZ26BBqIKPtvlAmz4AtaoH8ab2K4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RyjcXYWcZSQg6NloqkN90Wd7miZAXO0OBVTxNTSNNTzv6P0oE5VWbiYGWw9rt51qXSI5vmk16U8eD8sbLYuc50fxut0SWxv4mAGnoVfoxrhSkETnI0C1p+08+8+ifnyWo07osG6oIAUw4sxIhb6sy02rvWbIlma8ohXZgEMX1Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cy6bcXZ3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cy6bcXZ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22EDAC2BC9E;
	Wed, 18 Mar 2026 09:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773826859;
	bh=wwtV46sjJuFK7MQZZ26BBqIKPtvlAmz4AtaoH8ab2K4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cy6bcXZ3SuNIfreSYzzstW1S1971sxMQfimemKQIGuKfbtjc8DubtiNqxeOcUc63J
	 6A4PW4wsRgPF5EFmwuPP/J/Zv58IZ+fc4zLpoK8RRKPvJm8MYZdyDqbkyiGz/JIszs
	 arHV2iKu4nUw6cvRqgUqh5a3NX0ayGOmrokf57MlD/v/ACm7s4/G6kXKPfN7P8Lqlu
	 IHr0QblpMQy015HahUhmlrGjmsfzQVspNkTudLe53fgSdn478kfgfwYw2+yR/QklyZ
	 cKQjQr49S904HO0k+z8ahKE2qaGLrrbp6Bb0OHAk8feFuD4ZJZP7kok40bUN1BN7iN
	 ZnMgZMdhsSthw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 2/2] selftests/bpf: Update sockmap tests for MPTCP
Date: Wed, 18 Mar 2026 17:40:50 +0800
Message-ID: <6ea1d998b51cf6cf68e08e6ae87c2e93888464ed.1773826662.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773826662.git.tanggeliang@kylinos.cn>
References: <cover.1773826662.git.tanggeliang@kylinos.cn>
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

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 7f48fd9e94e1..4806ccb6b502 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -545,11 +545,11 @@ static void test_sockmap_with_mptcp_fallback(struct mptcp_sockmap *skel)
 	close(listen_fd);
 }
 
-/* Test sockmap rejection of MPTCP sockets - both server and client sides. */
-static void test_sockmap_reject_mptcp(struct mptcp_sockmap *skel)
+/* Test sockmap of MPTCP sockets - both server and client sides. */
+static void test_sockmap_mptcp_support(struct mptcp_sockmap *skel)
 {
 	int listen_fd = -1, server_fd = -1, client_fd1 = -1;
-	int err, zero = 0;
+	int err, zero = 0, one = 1;
 
 	/* start server with MPTCP enabled */
 	listen_fd = start_mptcp_server(AF_INET, NULL, 0, 0);
@@ -570,13 +570,13 @@ static void test_sockmap_reject_mptcp(struct mptcp_sockmap *skel)
 	server_fd = accept(listen_fd, NULL, 0);
 	err = bpf_map_update_elem(bpf_map__fd(skel->maps.sock_map),
 				  &zero, &server_fd, BPF_NOEXIST);
-	if (!ASSERT_EQ(err, -EOPNOTSUPP, "server should be disallowed"))
+	if (!ASSERT_EQ(err, 0, "server should be allowed"))
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
@@ -619,7 +619,7 @@ static void test_mptcp_sockmap(void)
 		goto close_netns;
 
 	test_sockmap_with_mptcp_fallback(skel);
-	test_sockmap_reject_mptcp(skel);
+	test_sockmap_mptcp_support(skel);
 
 close_netns:
 	netns_free(netns);
-- 
2.51.0


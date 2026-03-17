Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFF43A2575
	for <mptcp@lists.linux.dev>; Tue, 17 Mar 2026 09:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773741519; cv=none; b=hHN+7YZhbIl+tKUWBBAR6VBYNPvBc3DZsUtfNSPDbqaH+daiaJTsOXvQReY5Y1NKxj9SfSN8w/FGKP1KxqKBmQNoLMArxp3qDPguY51CzmDcOhQmfcDgDwZooZ8gJf7OE0wP7mZfc3dTEJytwE5l1RMT/EDgl0+wVfFPkivBjbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773741519; c=relaxed/simple;
	bh=nO3Oub9XCvyrCQkSMOQazp/3q2KDqv7tz0oTAiZncbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eFJaHuVEgX6TFAbjE9INri4Fk3TwQx6P6c5ijEqsh4FDydFeCGIGjfuguUY37ZkBcdFCIOLGQ0XUPR2/azPdzl6bnHgZSqj8bQPcPEI30FWQBo1Oz5vcOCDI5axiREOa+NX9ssFr/CFOrI5hPSmGlv0c8eBfNSbYiZKJlHXEPLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lC4mtkS3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lC4mtkS3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F90C2BC9E;
	Tue, 17 Mar 2026 09:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773741518;
	bh=nO3Oub9XCvyrCQkSMOQazp/3q2KDqv7tz0oTAiZncbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lC4mtkS3UsmX2UaEhuceVAZ4T1baw3cYEki0YPKyPFyFWhbqjqDKrpFb8pfRUGIEB
	 KvBn7TcJNi8CU4HTPwVtu5RTkjaFENBPhf+70eG1Sm2btQ3otnTNvwqBRj9vR6AXyW
	 PpU6wN7uAInUO/xjpSQ6JOr2rZgIADxTuatxSqCCwMsS+hsPUV6GTPcnLITSbLRnai
	 txp7v0EHk3oUE9AVzUY+Pj192Gu4sPeYdAxGcoXZSnZwIlrl5VAC3VuXuOT1TWsNB3
	 wp7q7KMJS0H8htYhu2jfzJd5Lo1I9Yyns8orca1J3obQLUZ8hhd9ia5kSB0yePL2RA
	 sDgMvwAq3KiBA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RESEND PATCH mptcp-next v2 2/2] selftests/bpf: Update sockmap tests for MPTCP
Date: Tue, 17 Mar 2026 17:58:11 +0800
Message-ID: <a30ddad998e95dcd858fd2fa95bae3ee1bd14826.1773741427.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773741427.git.tanggeliang@kylinos.cn>
References: <cover.1773741427.git.tanggeliang@kylinos.cn>
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

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 7f48fd9e94e1..217ecc59c8a2 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -570,13 +570,13 @@ static void test_sockmap_reject_mptcp(struct mptcp_sockmap *skel)
 	server_fd = accept(listen_fd, NULL, 0);
 	err = bpf_map_update_elem(bpf_map__fd(skel->maps.sock_map),
 				  &zero, &server_fd, BPF_NOEXIST);
-	if (!ASSERT_EQ(err, -EOPNOTSUPP, "server should be disallowed"))
+	if (!ASSERT_EQ(err, 0, "server should be allowed"))
 		goto end;
 
 	/* MPTCP client should also be disallowed */
 	err = bpf_map_update_elem(bpf_map__fd(skel->maps.sock_map),
 				  &zero, &client_fd1, BPF_NOEXIST);
-	if (!ASSERT_EQ(err, -EOPNOTSUPP, "client should be disallowed"))
+	if (!ASSERT_EQ(err, -EEXIST, "client should be allowed"))
 		goto end;
 end:
 	if (client_fd1 >= 0)
-- 
2.53.0


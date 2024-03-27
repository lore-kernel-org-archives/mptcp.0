Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFA31EEFD
	for <mptcp@lists.linux.dev>; Wed, 27 Mar 2024 09:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711530137; cv=none; b=Eteq0tXSfBzy8V6JWvA8rzMSLdylS+W88VsbYm8nkIhzlcqYdpnL2XSUUSSldn0jWs/oTqnx1fa31Y04MulgT54YPPU78hoZ4yDs++CAZxHz2ICT4dtMiZOXN6BZGJ25I9Fmrp+xHihxG5MzmKCz0dbaDUyCabYBoKSg924zaZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711530137; c=relaxed/simple;
	bh=WbLFwpqbLlC6Tg4iBQ5y+wGhgYXsfekNXJg/HXZSxHE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n9UCd1+NeUQnl0e5fhxi/5di3Nf7ORFHY0utb6CXg7F44phQ5a2A2JZ4On79GTomoj4qVyWkmXbrJyPGvJ+WAr1QYwdxaOAEOOEcjuFprfXO3JhRgnF3VPmIIE9hhpQa3PUDNUHkYPw9P7pH5sXmIUzDz5JJvcYkc/Iiwe6Lp8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCl6jutp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCl6jutp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344DAC433F1;
	Wed, 27 Mar 2024 09:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711530137;
	bh=WbLFwpqbLlC6Tg4iBQ5y+wGhgYXsfekNXJg/HXZSxHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VCl6jutpwNw1PDpN6Y89uOEK73LzNp/rRaG1CLl9910TOVQ8oi9QC9H8mhFpThEzq
	 c7E2O4Y5ug0F8KDCgeAjrSmG8oh5xqfgygWDq79VvRji7g349i41sugMBm75yWFHW8
	 fIxdv1u73rqrmsM6aMB6fhDIDJoGBri4EJ/L+jE1r/WTj/aM/86LVudXKatVoyht0f
	 pzHCYcvoJFaYXwPhuPJBc+joJn+96P8j0022k1XPwVRPVHmeyYDcb/smyu+MTEK8Qc
	 qU0uJuYD0ItRNjgTIpciCyeiCBXahZAn1tXRZhLTTeEylMIFpjUmf9p1v72eeTNld6
	 /BDSRZeHE4gqA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 10/11] Squash to "selftests/bpf: Add bpf_red test"
Date: Wed, 27 Mar 2024 17:01:48 +0800
Message-Id: <4390947889df9abe8e22846c2807484eb6999f4a.1711529752.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1711529752.git.tanggeliang@kylinos.cn>
References: <cover.1711529752.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use SCHED_TEST and RUN_MPTCP_TEST.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 39 +------------------
 1 file changed, 2 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index f7afb5e4b687..04a46a41c964 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -606,41 +606,7 @@ fail:								\
 SCHED_TEST(first, 0);
 SCHED_TEST(bkup, 0);
 SCHED_TEST(rr, 1);
-
-static void test_red(void)
-{
-	struct mptcp_bpf_red *red_skel;
-	int server_fd, client_fd;
-	struct nstoken *nstoken;
-	struct bpf_link *link;
-
-	red_skel = mptcp_bpf_red__open_and_load();
-	if (!ASSERT_OK_PTR(red_skel, "bpf_red__open_and_load"))
-		return;
-
-	link = bpf_map__attach_struct_ops(red_skel->maps.red);
-	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
-		mptcp_bpf_red__destroy(red_skel);
-		return;
-	}
-
-	nstoken = sched_init("subflow", "bpf_red");
-	if (!ASSERT_OK_PTR(nstoken, "sched_init:bpf_red"))
-		goto fail;
-	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
-	client_fd = connect_to_fd(server_fd, 0);
-
-	send_data(server_fd, client_fd, "bpf_red");
-	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr 1");
-	ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr 2");
-
-	close(client_fd);
-	close(server_fd);
-fail:
-	cleanup_netns(nstoken);
-	bpf_link__destroy(link);
-	mptcp_bpf_red__destroy(red_skel);
-}
+SCHED_TEST(red, 1);
 
 static void test_burst(void)
 {
@@ -692,8 +658,7 @@ void test_mptcp(void)
 	RUN_MPTCP_TEST(first);
 	RUN_MPTCP_TEST(bkup);
 	RUN_MPTCP_TEST(rr);
-	if (test__start_subtest("red"))
-		test_red();
+	RUN_MPTCP_TEST(red);
 	if (test__start_subtest("burst"))
 		test_burst();
 }
-- 
2.40.1


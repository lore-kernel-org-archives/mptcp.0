Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F621851
	for <mptcp@lists.linux.dev>; Wed, 17 Apr 2024 02:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713321552; cv=none; b=FKG2ZLRNb2G7sh2/t/8A+6OyOTfu0BZa+nFyAJU4gj9jDaoEds74+1zZAle0yZczu1mbrHtsVR5CUj/oBlcfj+4bbPNS4vHn61yfmVJ+NSBd24tpDQWTs/38N7xM11BGOlpYu2OO61kSfsyVtKGHGtoPyZWi4/K3nInl3tvxkaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713321552; c=relaxed/simple;
	bh=LdN9GVi8LQa0l39uFlmMNzry325hNsiTYPcWUJJQVyw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nJ3GiYJHZpgy+KiU8mci5Tht+HXXLVVTSphTpjfPzddT3VHZCIxjfq6VaerNLEBZ0lV9Ucbe2VcTmksg2iRZAmwfJSP/BbPGAWjDrZYIaCFx+wjT5le5aP9fgsNTzrYKXR73SO0tW//oHBjTdRw9hIMOQymu9O3K8Pik8c3Tmvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjtHKTuT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjtHKTuT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84571C113CE;
	Wed, 17 Apr 2024 02:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713321551;
	bh=LdN9GVi8LQa0l39uFlmMNzry325hNsiTYPcWUJJQVyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cjtHKTuT9XwxUyt4aRTpDmO56PSCvJLNeOWlfNCl/Qk6DpSxOww0lh48yTJdnVP32
	 +dQcN0kr4f654Khviagof9jqDdtc9+SwSTJD3veA/40KuwG/HY9Vl+ozgiXpW0vsZU
	 fuoLuccumSzcqEfsty77w6rqgIsD5a9DpR4SNG1KHC368Wfl7reWga9YKfDCfxLc84
	 Kt6vk33hSBiruKV9JGZUmDMUi4F7uuOx7kfKc3Xxvnlt9Sb2lhol47UAE2BcnyeXNR
	 GRCY7tz5dp60GsFQg9Xrd6TynZX6J0uh2uvTqt4hTNmQRmrgzY6IBLjdyGcIYZiWNH
	 OaKSlwZrZc5fw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 2/8] Squash to "selftests/bpf: Add bpf scheduler test" 1 verify
Date: Wed, 17 Apr 2024 10:38:48 +0800
Message-Id: <2ba23b6666ee10685a29a1d167d6c3fae99ca80e.1713321357.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1713321357.git.tanggeliang@kylinos.cn>
References: <cover.1713321357.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add send_data_and_verify helper to avoid duplicated code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 42 ++++++++++++++-----
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index c29c81239603..d7ce28fd7809 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -17,6 +17,8 @@
 #include "mptcp_bpf_burst.skel.h"
 
 #define NS_TEST "mptcp_ns"
+#define WITH_DATA	true
+#define WITHOUT_DATA	false
 
 #ifndef IPPROTO_MPTCP
 #define IPPROTO_MPTCP 262
@@ -457,23 +459,44 @@ static int has_bytes_sent(char *addr)
 	return system(cmd);
 }
 
-static void test_default(void)
+static void send_data_and_verify(char *sched, bool addr1, bool addr2)
 {
 	int server_fd, client_fd;
-	struct nstoken *nstoken;
 
-	nstoken = sched_init("subflow", "default");
-	if (!ASSERT_OK_PTR(nstoken, "sched_init:default"))
-		goto fail;
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
+	if (CHECK(server_fd < 0, sched, "start_mptcp_server: %d\n", errno))
+		return;
+
 	client_fd = connect_to_fd(server_fd, 0);
+	if (CHECK(client_fd < 0, sched, "connect_to_fd: %d\n", errno))
+		goto fail;
 
-	send_data(server_fd, client_fd, "default");
-	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr_1");
-	ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr_2");
+	send_data(server_fd, client_fd, sched);
+
+	if (addr1)
+		CHECK(has_bytes_sent(ADDR_1), sched, "should have bytes_sent on addr1\n");
+	else
+		CHECK(!has_bytes_sent(ADDR_1), sched, "shouldn't have bytes_sent on addr1\n");
+	if (addr2)
+		CHECK(has_bytes_sent(ADDR_2), sched, "should have bytes_sent on addr2\n");
+	else
+		CHECK(!has_bytes_sent(ADDR_2), sched, "shouldn't have bytes_sent on addr2\n");
 
 	close(client_fd);
+fail:
 	close(server_fd);
+}
+
+static void test_default(void)
+{
+	struct nstoken *nstoken;
+
+	nstoken = sched_init("subflow", "default");
+	if (!ASSERT_OK_PTR(nstoken, "sched_init:default"))
+		goto fail;
+
+	send_data_and_verify("default", WITH_DATA, WITH_DATA);
+
 fail:
 	cleanup_netns(nstoken);
 }
@@ -663,8 +686,7 @@ void test_mptcp(void)
 {
 	RUN_MPTCP_TEST(base);
 	RUN_MPTCP_TEST(mptcpify);
-	if (test__start_subtest("default"))
-		test_default();
+	RUN_MPTCP_TEST(default);
 	if (test__start_subtest("first"))
 		test_first();
 	if (test__start_subtest("bkup"))
-- 
2.40.1


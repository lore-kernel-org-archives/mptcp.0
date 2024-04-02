Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030B018035
	for <mptcp@lists.linux.dev>; Tue,  2 Apr 2024 05:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712034769; cv=none; b=JN2IJZUKZhEoqM+b5tf9TiDjNIWk12a572wVjo4i1NFpInh54oT/Iz3h6hj9H2RyuoKIxTghRH6XpIVEdNM9JK2hPWEI5A1MKAHaEtYKQeek+hRhMv0tgcrd99C0IBdRMI33GZsvxAwWGKFy9BVLeJP9VyLxQIxc1Ca/z46HGN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712034769; c=relaxed/simple;
	bh=TPRtnBAfHRGn7o3WNsNMXSgoBCtfpj37FJy+N8b4zn0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jy0QlEntcVTrdDyj+TVy1gojek7sQ33F0+TTZnrcMUvrSigG/tkAA4a4O57w/2tJ2cseFG25WJudhFV1buKNzQDAgtxEBSwrEE7ZMRTsXArTw+Pkb5Z+4XBY7wUKf1L75IMIPTmgLn0g+ThKCcoeadPe5qfjoIG2plJjNty6jSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTmn3jfM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTmn3jfM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0A5C433C7;
	Tue,  2 Apr 2024 05:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712034768;
	bh=TPRtnBAfHRGn7o3WNsNMXSgoBCtfpj37FJy+N8b4zn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YTmn3jfMgWZ3eycRbR6cNlCbdAL88IFylfCGs1rsv3bCneK2STuac/ZPu2MXC72vM
	 OHfsT0WDjG7fAsGX9mwHYTvCYuQv8tALDClc6R+jVOh0leY7w0FtdzThDSHf0HYwWC
	 K2PGYlkWXfEkiJg4nKMvz7pfzwmMxZYbCtTh3a5wJ9agqg7hjt/WJpaOVyqW6yDX8S
	 QkTnJzMh71QKtyReWSixNZuaLDvjnNNRzF9aHudxf4/bhV38oEuWJ7I+NUdgeDyIgH
	 gLEBVDb6i0NWd3VLni+Pg0GXcmAXB9S2fmCuek/IPDI/lXxkCGNgRT2qyiUQpCQEmr
	 0Jb+xryTKnS5Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 03/11] Squash to "selftests/bpf: Add bpf scheduler test" 2 verify
Date: Tue,  2 Apr 2024 13:12:26 +0800
Message-Id: <7c9510bb53ca29f0e51c62a46de9e0a3ee6449d4.1712034575.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712034575.git.tanggeliang@kylinos.cn>
References: <cover.1712034575.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add send_data_and_verify helper.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 41 +++++++++++++++----
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index faa0dc37b78e..df105cd23c28 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -465,24 +465,47 @@ static int has_bytes_sent(char *addr)
 	return system(cmd);
 }
 
-static void test_default(void)
+static void send_data_and_verify(char *msg, int addr1, int addr2)
 {
 	int server_fd, client_fd;
-	struct nstoken *nstoken;
 
-	nstoken = sched_init("subflow", "default");
-	if (!ASSERT_OK_PTR(nstoken, "sched_init:default"))
-		goto fail;
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
+	if (!ASSERT_NEQ(server_fd, -1, "start_mptcp_server"))
+		return;
+
 	client_fd = connect_to_fd(server_fd, 0);
+	if (!ASSERT_NEQ(client_fd, -1, "connect_to_fd"))
+		goto close_server;
 
-	set_nonblock(server_fd);
-	send_data(server_fd, client_fd, "default");
-	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr_1");
-	ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr_2");
+	if (set_nonblock(server_fd))
+		goto close_server;
+
+	send_data(server_fd, client_fd, msg);
+
+	if (addr1)
+		ASSERT_OK(has_bytes_sent(ADDR_1), "Should have bytes_sent on addr1");
+	else
+		ASSERT_GT(has_bytes_sent(ADDR_1), 0, "Shouldn't have bytes_sent on addr1");
+	if (addr2)
+		ASSERT_OK(has_bytes_sent(ADDR_2), "Should have bytes_sent on addr2");
+	else
+		ASSERT_GT(has_bytes_sent(ADDR_2), 0, "Shouldn't have bytes_sent on addr2");
 
 	close(client_fd);
+close_server:
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
+	send_data_and_verify("default", 1, 1);
+
 fail:
 	cleanup_netns(nstoken);
 }
-- 
2.40.1


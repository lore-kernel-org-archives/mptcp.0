Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0E837149
	for <mptcp@lists.linux.dev>; Fri, 29 Mar 2024 04:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711688226; cv=none; b=rco/SOS5IvZXDjw+YZPo5LbTVyky+T9mUp8Q+FC4GgO2EOwbEMYAIdI9RnQtGsE5bNWIVbfGLm/MnRELyVxdIiMVgH1nkI5/hulgR7TtEKuo2j5u6jsofQg7JeEBO4N+Qgz3EF+qmEXAhmzE8iBxfsRwousekEhSZRmMq5ZPHgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711688226; c=relaxed/simple;
	bh=Rv9kPLAC0v3+HpqgV6QJTUsl1a4gbcK51l368S3nVGw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gGsJQl0eT3eRgQHl6hwzFVnVNYasPBdZtRhabIdN7VzSOQnIZOkXmsvU81mGt9sB9XbQcokqs8dwVR/GK4sVffhO3FCPBclOVN7rAq1KtAELV7P3PTs9IgseE3LlECcIeCDuWCh2s8WHeuBoTDTkXylfqWZDfgTUDlW3X5Iw914=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGSXBWvD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGSXBWvD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B86C43390;
	Fri, 29 Mar 2024 04:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711688226;
	bh=Rv9kPLAC0v3+HpqgV6QJTUsl1a4gbcK51l368S3nVGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nGSXBWvDzOzedcOBHs0bc062su04GHHE77BgMQqtUBlchRXI5BI5Kq/7lHZ8KEXxF
	 ocDGPqdXH8E7+QCJ+/TsiebF4zShyDQYWGcM83xcSPlGbqS8HQVZh90/OlTpDMlAN+
	 k9getbOK8uRLGqKhP7YpTQxkXfjT4lM972sI8cR54TVK3hUo1lJjUGcspU8LXaXn2j
	 L8haTecZGjFROXMVOeBD5xcCHxuk4bjbpbSf+/UlSAuRyVyYU3SxvnQ64cp+0UvYyI
	 LubXsk5qS2Ia2gucRJMMGBuNJLBwxMHhxXI7ZtLHAZCf3eypAIlUVt9J7rwtbI1lZM
	 +oDaKKkEdYolg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 06/15] selftests/bpf: Refactor mptcpify test
Date: Fri, 29 Mar 2024 12:56:02 +0800
Message-Id: <19edfecae92316cb70f4fd80838fb2e75a37d160.1711688054.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1711688054.git.tanggeliang@kylinos.cn>
References: <cover.1711688054.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch refactors mptcpify test, moves all test skeleton operations,
__open_and_load, __attach and __destroy from run_mptcpify() into
test_mptcpify().

This prepares for the later unification of all MPTCP tests using a macro.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 39 +++++++++----------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 39becf46dcfa..8c897e626a2b 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -272,61 +272,58 @@ static int verify_mptcpify(int server_fd, int client_fd)
 	return err;
 }
 
-static int run_mptcpify(int cgroup_fd)
+static void run_mptcpify(int cgroup_fd, struct mptcpify *skel)
 {
 	int server_fd, client_fd, err = 0;
-	struct mptcpify *mptcpify_skel;
-
-	mptcpify_skel = mptcpify__open_and_load();
-	if (!ASSERT_OK_PTR(mptcpify_skel, "skel_open_load"))
-		return libbpf_get_error(mptcpify_skel);
-
-	err = mptcpify__attach(mptcpify_skel);
-	if (!ASSERT_OK(err, "skel_attach"))
-		goto out;
 
 	/* without MPTCP */
 	server_fd = start_server(AF_INET, SOCK_STREAM, NULL, 0, 0);
-	if (!ASSERT_GE(server_fd, 0, "start_server")) {
-		err = -EIO;
-		goto out;
-	}
+	if (!ASSERT_GE(server_fd, 0, "start_server"))
+		return;
 
 	client_fd = connect_to_fd(server_fd, 0);
-	if (!ASSERT_GE(client_fd, 0, "connect to fd")) {
-		err = -EIO;
+	if (!ASSERT_GE(client_fd, 0, "connect to fd"))
 		goto close_server;
-	}
 
 	send_single_byte(client_fd);
 
 	err = verify_mptcpify(server_fd, client_fd);
+	ASSERT_OK(err, "verify_mptcpify");
 
 	close(client_fd);
 close_server:
 	close(server_fd);
-out:
-	mptcpify__destroy(mptcpify_skel);
-	return err;
 }
 
 static void test_mptcpify(void)
 {
 	struct nstoken *nstoken = NULL;
+	struct mptcpify *mptcpify_skel;
 	int cgroup_fd;
+	int err;
 
 	cgroup_fd = test__join_cgroup("/mptcpify");
 	if (!ASSERT_GE(cgroup_fd, 0, "test__join_cgroup"))
 		return;
 
+	mptcpify_skel = mptcpify__open_and_load();
+	if (!ASSERT_OK_PTR(mptcpify_skel, "skel_open_load"))
+		goto out;
+
+	err = mptcpify__attach(mptcpify_skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto out;
+
 	nstoken = create_netns();
 	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
 		goto fail;
 
-	ASSERT_OK(run_mptcpify(cgroup_fd), "run_mptcpify");
+	run_mptcpify(cgroup_fd, mptcpify_skel);
 
 fail:
 	cleanup_netns(nstoken);
+	mptcpify__destroy(mptcpify_skel);
+out:
 	close(cgroup_fd);
 }
 
-- 
2.40.1


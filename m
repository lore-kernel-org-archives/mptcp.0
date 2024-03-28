Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A98B548FC
	for <mptcp@lists.linux.dev>; Thu, 28 Mar 2024 08:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711613121; cv=none; b=ZhtbhsPRrOUn80mOEsdxJ3ZYwzcpFkswHV7hIclQFm9x8wxx4wTixPrMXE7Y/wn82D9SzdPeI0wdZqDzZASiYrznTjAAcg66kXqx5ceq61s3qp7ud0vepBYKTQF4i4/6d2615xdTKR77CmwqD/txVbsLIPYv+yhtVMmYnNUtZOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711613121; c=relaxed/simple;
	bh=D2/dUDwilVlONZOzEIq3iHFXfvbYTJY6JtkMNKB6g/s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PTO38uAOeyOmutXIX3kswO66pdx0pfwd6q0SCDPWkvh/ZcRxNamzDMWY4zpDIK/niCHocvKcAroBlJ+3/7zViZdKH1brV0MpAVdJxRbCCaaXeIOrHfQK55hyREdEv8X/b3jNHaMOEcpzENBsNSJjU4JJ8NiXfCpPSCcm/EAdtJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gT2/4rgj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gT2/4rgj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E29CC433F1;
	Thu, 28 Mar 2024 08:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711613121;
	bh=D2/dUDwilVlONZOzEIq3iHFXfvbYTJY6JtkMNKB6g/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gT2/4rgjDLZXzuQobyLTXmwTPOcHkSoK+Nzg8Uz5me3zIBD1LtKei0gPQFgCucbnu
	 ikS0d9zK07BQj0lDl88ZK5C9uDlKBvVp2E2s7UXVGvLqyc2kCaK0FsnFmJUI1Q0lwF
	 eEiVIfv+s5xicZAJyQw2kpxPTqU8f70jLECfNnf2eyFlQpZ6DLXpG3MyMCAR5g8ePJ
	 pacyrHIBozbHiLM1vzjzOJfoRa6PKG00E80hj5U+8ph2XldffVbmrtcKvByXsUFZ6Z
	 +r4t7++siwh9oijbrSgEuZUNgvVAhKEufEpH6qXpAQkAuJPOXCLrOZrfiiTauRB0Fg
	 4bhwVrFzY2mfg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 03/14] selftests/bpf: Refactor mptcpify test
Date: Thu, 28 Mar 2024 16:04:50 +0800
Message-Id: <6a192440f81845f7f8a42914a260e8df0c6b45b7.1711612876.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1711612876.git.tanggeliang@kylinos.cn>
References: <cover.1711612876.git.tanggeliang@kylinos.cn>
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
index 4f0bcaf39886..cc91acfa3e52 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -279,61 +279,58 @@ static int verify_mptcpify(int server_fd, int client_fd)
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
 
 	send_byte(client_fd);
 
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


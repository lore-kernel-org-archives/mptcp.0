Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1690241C62
	for <mptcp@lists.linux.dev>; Thu, 28 Mar 2024 09:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711619418; cv=none; b=i8V2D2q1A5PMHpNa420cqI273l89A2HYlNUYZh5xWWRwoKPkA+uro71BBNRexPfKeXmIqRc5eCmrImh/yXGOdZhCfvnxiWPYvQC2+zB80uoXX5fkA58xf2hpqJhwUVRbBRPDlNegDhPxwBCrRZoHO7aj7dLJpRdKu2z4eI/eM7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711619418; c=relaxed/simple;
	bh=D2/dUDwilVlONZOzEIq3iHFXfvbYTJY6JtkMNKB6g/s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TP1auJT6sjiYPv0ve56gBcpPuGsNfuvYq9hlJWq6ybNIVcn0uDLMhL4MEuuiGaj/tbd1hrhJjXNamP+/WjCbQMemTUqMrABSZM4b4ouNqJwlmzQ5QDIr4dyr7DgiGmbUjTqqQ88JoThmnSLc+nFtq9MnSqgdEUgz64sfzYWNq+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULS5xkeQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULS5xkeQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E3BC433C7;
	Thu, 28 Mar 2024 09:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711619418;
	bh=D2/dUDwilVlONZOzEIq3iHFXfvbYTJY6JtkMNKB6g/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ULS5xkeQZYpZUSi87vTEuTboEeC33DAxCH1PQC8IGX8EgbEBsd8T3f249IvKJNK12
	 qj84Vg1mBy+qCHCYO1iKvj4Dn31Ng4sKiQSLFELVvGcp/J+WUSW38WAe30EwBbCtU0
	 5Zk7x1N3Y9dIprsrHIqM/MRRp4UNo5pNzbso9pvbKuAZDZgDv3Jw9LNGcKe1pD/HC4
	 hPhHBcyvrmEn/GonLcYd5H0chry+i2Go2vB/rYBSdK1DtuUpEczvS4XPa6ZxTlOgr9
	 qumAk9JTiIKmpZJ28h75zipEY7AB45qXdF+5pv9AYzyqNxVT9VgLMB1FgpBbMsHNxT
	 tZm2qIM1Eg6VQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 03/11] selftests/bpf: Refactor mptcpify test
Date: Thu, 28 Mar 2024 17:50:00 +0800
Message-Id: <6a192440f81845f7f8a42914a260e8df0c6b45b7.1711619108.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1711619108.git.tanggeliang@kylinos.cn>
References: <cover.1711619108.git.tanggeliang@kylinos.cn>
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


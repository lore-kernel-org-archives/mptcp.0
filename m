Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B58139E
	for <mptcp@lists.linux.dev>; Sat,  7 Sep 2024 03:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725680763; cv=none; b=WqYjVtXt/YSFNHfXtmK2Pz4x8uYG+BZwkaIhiZ/8i1cLgiH1cIggrC9BWPZf2INcQDRmZx7dEtq46ShTj/17t7NyJKLIZLxK3vIdBnQqu8uQ1gwFrAyZvTsAuho5R3k1XZfM7+qnzzl3Nz5b/d6VM4nbnqo/ZFv0BzoVwT2JMIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725680763; c=relaxed/simple;
	bh=WKuNO3DJK8T2M0Ato5+aw4357ZWLYh9twwY0SMJGtqo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RAAFgpERmmEo0Xzl+DlSj4voXrfzh+5T+KsKjELc3ICM1n83pgoDvAYWdCdDQh4tsOSo05OkC1Wt3QvS1kwelU+5c4NiCw/HA4p83j1jxFCF5ckqJH420vAI/GMxd3Ui7OAPbarBb2a7swECCAe/NDvxukzrnLrDroDHtJG2a6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjBAGcKF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjBAGcKF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C24C4CEC2;
	Sat,  7 Sep 2024 03:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725680763;
	bh=WKuNO3DJK8T2M0Ato5+aw4357ZWLYh9twwY0SMJGtqo=;
	h=From:To:Cc:Subject:Date:From;
	b=EjBAGcKFozM436LkEl0VGg3zwWtuZD4x6erIyxW2Hjpn2sr8OL8xJhkYdvJtVvrev
	 IBlIuYhwY9NZ3bqIQQFByUD+dD4t5WOLWzGpmCzbGuHC8FJkUJXi4PaZyGbqCnC5cb
	 DRpMEXqmVTnpFa+jy9k1IHayNJvcSat36AcxnXA//K1bVP8YOaZG9JZ5TJ/ugE+mkk
	 03r8h/7a8ygc19EP/dXBNS8sW0SOCLl/2Y0TziaDiVD7dGJX2hChYQrlrYWz39RUyn
	 tIpx95YZ1lCz9ZxhXeNmoJzbQzeItM8S/GH+Kc5+Br3dGGqKtWGW5nnDEx38/B8FC6
	 T+nYq07oKg9xg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next] Squash to "selftests/bpf: Add mptcp subflow subtest"
Date: Sat,  7 Sep 2024 11:45:58 +0800
Message-ID: <d5598209aecfc8fe58f9a93dc802817b041785a9.1725680751.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Should use dedicated ASSERT_OK_FD() to check the fds.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 93869c873cad..987692863fde 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -394,11 +394,11 @@ static void run_subflow(void)
 	socklen_t len;
 
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
-	if (!ASSERT_GE(server_fd, 0, "start_mptcp_server"))
+	if (!ASSERT_OK_FD(server_fd, "start_mptcp_server"))
 		return;
 
 	client_fd = connect_to_fd(server_fd, 0);
-	if (!ASSERT_GE(client_fd, 0, "connect to fd"))
+	if (!ASSERT_OK_FD(client_fd, "connect_to_fd"))
 		goto close_server;
 
 	send_byte(client_fd);
@@ -429,7 +429,7 @@ static void test_subflow(void)
 	struct bpf_link *link;
 
 	cgroup_fd = test__join_cgroup("/mptcp_subflow");
-	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup: mptcp_subflow"))
+	if (!ASSERT_OK_FD(cgroup_fd, "join_cgroup: mptcp_subflow"))
 		return;
 
 	skel = mptcp_subflow__open_and_load();
-- 
2.43.0


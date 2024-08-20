Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BAE189F4B
	for <mptcp@lists.linux.dev>; Tue, 20 Aug 2024 09:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724145568; cv=none; b=qEbtA8fHawupyL8biyjhFPU2b/ZX8PdJEtGJDpa5ZY97Tj4HHLwWgQuUyB4mXS0yMmH6G+08F3zL5/dSXsnaKTOep8j8zFCw7Skdk7eMLpexqgQ14zW7Y/5DN2l9tQrkTzLMFFQPLPH9g+wJ0e0QOhIEAkNSP12s0/Hz/ek6Gp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724145568; c=relaxed/simple;
	bh=g/pFiQLjtoHAtJp+JYM5BoJu3cB81dD2pGA3PhyEMao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kb2G7bmJEAJnBjvm+zcZb9FF03b6p8HIxgZ7M4rIsbcUuQSpFd7vDo0nJ2FZYwg5zMKQA5GmhhQ/VKpiTwGp4R6+lFbFa8L89uLrrhgFLlhPdxMPO8qgqkCLO1SZv1Raukfgx8xcrH5su1KhgewLf57JNWnI9xIBYlyZQpJHFyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tn/XeGvA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tn/XeGvA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D6EC4AF09;
	Tue, 20 Aug 2024 09:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724145567;
	bh=g/pFiQLjtoHAtJp+JYM5BoJu3cB81dD2pGA3PhyEMao=;
	h=From:To:Cc:Subject:Date:From;
	b=tn/XeGvAxtZkkVrOWmjZacSntwtnX3DIWJRrNci8e728Pishxww29t+A5ERoyheBh
	 A9M+D2ymyFv0paXvgYuBqjLt8qUJh+cIh8N9gxmFBfGzQznsKrwXxz1c+1H3XbKvtX
	 qH+d+BtIcOujIPw9Z/Vw0/7IR6ixduqBE/2bMvYvjrqYjvV1z+Jgm269uRw9gu6TBH
	 lg/XiBbOemWkKoPK2urHfxwFbvaRdvnpNGbr7p6MOAfHboVo+LKjzx3jK0V/GrOYxc
	 1EmsZMBIyFAbPDOIhCHmcX8OKS+tke6aPW747isuUvvezc9+YQGGVw1rq8hjg4dLGH
	 kQYadaNyEqpmA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2] Squash to "selftests/bpf: Add mptcp subflow subtest"
Date: Tue, 20 Aug 2024 17:19:20 +0800
Message-ID: <d3b644bf82543591f2f59b37d1c1b26a2b9f88e0.1724145512.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Close client_fd as Martin suggested.

Please update my email address of this patch squashed to as:

  From: Geliang Tang <tanggeliang@kylinos.cn>

since BPF CI complained about it:

WARNING: From:/Signed-off-by: email address mismatch: 'From: Geliang Tang <geliang@kernel.org>' != 'Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>'

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
v2:
 - use close_client/close_server.
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 9d4e3c1d4e7b..73adc58cd776 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -383,7 +383,7 @@ static void run_subflow(char *new)
 {
 	int server_fd, client_fd, err;
 	char cc[TCP_CA_NAME_MAX];
-	socklen_t len = sizeof(cc);
+	socklen_t len;
 
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
 	if (!ASSERT_GE(server_fd, 0, "start_mptcp_server"))
@@ -391,11 +391,12 @@ static void run_subflow(char *new)
 
 	client_fd = connect_to_fd(server_fd, 0);
 	if (!ASSERT_GE(client_fd, 0, "connect to fd"))
-		goto fail;
+		goto close_server;
 
+	len = sizeof(cc);
 	err = getsockopt(server_fd, SOL_TCP, TCP_CONGESTION, cc, &len);
-	if (!ASSERT_OK(err, "getsockopt(srv_fd, TCP_CONGESTION)"))
-		goto fail;
+	if (!ASSERT_OK(err, "getsockopt(server_fd, TCP_CONGESTION)"))
+		goto close_client;
 
 	send_byte(client_fd);
 
@@ -404,8 +405,9 @@ static void run_subflow(char *new)
 	ASSERT_OK(ss_search(ADDR_1, new), "ss_search new cc");
 	ASSERT_OK(ss_search(ADDR_2, cc), "ss_search default cc");
 
+close_client:
 	close(client_fd);
-fail:
+close_server:
 	close(server_fd);
 }
 
-- 
2.43.0


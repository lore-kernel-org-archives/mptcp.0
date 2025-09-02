Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E1425394A
	for <mptcp@lists.linux.dev>; Tue,  2 Sep 2025 01:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756777213; cv=none; b=uae3PBesdi8BiSeOBMuTVORt+w5XK7GzBQHIRxecAlrcW7dPPBzxEXKvoLfLaW9QWsI8B14w+3OUkDBtoUg6gFrEMdJPZOlBlnJUDOHVeTMMMG+4lb6d+nP6N0Rcv4+GPo8YsMJB1rsDx5IWoweqzvD/yf10BaZxARWLTq4H5UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756777213; c=relaxed/simple;
	bh=qv/R6VlR0Ya235mdL8rMVlFg2qcCFoC70y+dlx/+/zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NA0MNsecrI2Kc7ue9XnLXnPL6kBfTdKcB5qPno+o21Rm69DByimK3ERNFE7jMNCvXbcB+iNbakH75XIUWgrs2LM6sperFaWnBKXGwLMGkHjto/r/4br5RGqoj55VqJhyrWE3sqMmkpW8JmDE/F8KctZ/Gnn8DbrHoNU2tFPXozY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GV8NeDdA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GV8NeDdA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD79C4CEF4;
	Tue,  2 Sep 2025 01:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756777212;
	bh=qv/R6VlR0Ya235mdL8rMVlFg2qcCFoC70y+dlx/+/zk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GV8NeDdApzYyeWv3tlQ4y+aE/iuuWl5EXuSfVbdBYHAVBWnNoKD/HAL1PwSLO736V
	 YyKSBQ3WRj8GY+hsd8e7f4G8njM4/gi8X+bBTcGl585DgcpY2dDRO5DdnMK9IMDnFE
	 BaaEiakt9XPhuV++N13ghQ6FtR68qilqN7MWgHW4D69mSu/DNI6dFQG1Zg8tle9tO6
	 12jHs7i4CWkrCf3KlvqamTIPAS0WOpnr9pm7uR2DKJh4eZ3kZGK1FQXmyzDetHhOpz
	 BtqLFf5iRglz9RH6eBh+tC8wbYYH2A1yzXjjIOnJ8xycAOhZ1CAHtuGke1ZeGvslIv
	 dZ1ISbE+EyXAA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net 2/3] selftests: mptcp: avoid double closing pipe descriptor
Date: Tue,  2 Sep 2025 09:38:35 +0800
Message-ID: <89eb6eb8c01d871fddbd38a457c13eda1a55eb9e.1756776801.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1756776801.git.tanggeliang@kylinos.cn>
References: <cover.1756776801.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The pipe descriptor (pipefds[0]) is already closed in main() after
the client() function completes, making the explicit close in
connect_one_server() redundant and potentially harmful.

This patch removes the unnecessary close operations in both the sockopt
and inq test cases to prevent double-closing of file descriptors, which
could lead to undefined behavior if the descriptor is reused.

Fixes: ce9979129a0b ("selftests: mptcp: add mptcp getsockopt test cases")
Fixes: b51880568f20 ("selftests: mptcp: add inq test case")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_inq.c     | 2 --
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 1 -
 2 files changed, 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_inq.c b/tools/testing/selftests/net/mptcp/mptcp_inq.c
index 40f2a1b24763..5e2b5913121f 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_inq.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_inq.c
@@ -314,8 +314,6 @@ static void connect_one_server(int fd, int unixfd)
 	close(fd);
 	ret = write(unixfd, "closed", 6);
 	assert(ret == 6);
-
-	close(unixfd);
 }
 
 static void get_tcp_inq(struct msghdr *msgh, unsigned int *inqv)
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index b44b6c9b0550..8d590629a8e9 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -593,7 +593,6 @@ static void connect_one_server(int fd, int pipefd)
 	/* un-block server */
 	ret = read(pipefd, buf2, 4);
 	assert(ret == 4);
-	close(pipefd);
 
 	assert(strncmp(buf2, "xmit", 4) == 0);
 
-- 
2.48.1


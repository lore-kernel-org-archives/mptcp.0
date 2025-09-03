Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBFA2745C
	for <mptcp@lists.linux.dev>; Wed,  3 Sep 2025 04:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756872500; cv=none; b=eZN5hC0mqvnD9wUWjtb3qp8H5Mn2SkKisvym00Lj+0RXnr4tpOwvnA32vBGT2Nr4Jte5gmmAFCKvosQ6fLNLmz6dSA8c668czIUmFQCaXTNN31B+BFDg8u876+4kS9S5p4Eijn915GgcP+6ujnmycVBuYvLXxalVdAKGcp0IPc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756872500; c=relaxed/simple;
	bh=aiXTTuw2UIb2y41v9oYjV4fdJ73E3L3TLpAB+zwsV4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QvtJpmxOHv3OEC4RVNBEkP0SMYcVn3PZ0/mWElRuF1b17BYf37Cv9ElTreOUUGuMPdwV7t+axjdxBCKc9e86+MwTiBAW35eCqxQ/jctGCIwJNUnm2bZArwPLnV3HzA3Sto2tgKoys6bRUKo5Ils0PO6F4Qpc0S23UyvmRb3wOWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHi/KP3b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHi/KP3b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A110BC4CEF1;
	Wed,  3 Sep 2025 04:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756872500;
	bh=aiXTTuw2UIb2y41v9oYjV4fdJ73E3L3TLpAB+zwsV4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VHi/KP3bxOF4NUPkhv/tIPsUUzmnqfdhfmw4PuNFVmnUzCZQ/pcartEP4Ftt0Dpv3
	 XJcnug5rIT2FQ63fdwZhClVjsWLYFHgmHKNeoZYj8ldAYSLRFDxJadVoTs4CWQ4S9L
	 hEO1+APdyMLiFiOswVnqgMIe5fFKjaOFqmXM6bgsPLG9lQcIuYXhFcFBw7nAHzVaab
	 cKQycRFvA0Sw9YIp0DmpnXhusHyNjW4VNe3BFafaXdXvCThqB2kQUt3mQbbUVvgNNH
	 amI3a5sTK50/bVBwkUE5Np2NaXYcckITcshjX9n8wVgg6MUu8TUG4IRQrpQ/dVALFk
	 NTR16as1Ow3gg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net v2 1/3] selftests: mptcp: close server file descriptor
Date: Wed,  3 Sep 2025 12:08:05 +0800
Message-ID: <c53a738a9beac02ab5f43baff9a70a36be87eca8.1756872050.git.geliang@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1756872050.git.geliang@kernel.org>
References: <cover.1756872050.git.geliang@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The server file descriptor ('fd') is opened in server() but never closed.
While accepted connections are properly closed in process_one_client(),
the main listening socket remains open, causing a resource leak.

This patch ensures the server fd is properly closed after processing
clients, bringing the sockopt and inq test cases in line with proper
resource cleanup practices.

Fixes: ce9979129a0b ("selftests: mptcp: add mptcp getsockopt test cases")
Fixes: b51880568f20 ("selftests: mptcp: add inq test case")
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_inq.c     | 1 +
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_inq.c b/tools/testing/selftests/net/mptcp/mptcp_inq.c
index f3bcaa48df8f..40f2a1b24763 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_inq.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_inq.c
@@ -502,6 +502,7 @@ static int server(int unixfd)
 
 	process_one_client(r, unixfd);
 
+	close(fd);
 	return 0;
 }
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index e934dd26a59d..b44b6c9b0550 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -722,6 +722,7 @@ static int server(int pipefd)
 
 	process_one_client(r, pipefd);
 
+	close(fd);
 	return 0;
 }
 
-- 
2.48.1


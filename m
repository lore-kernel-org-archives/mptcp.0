Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F477494
	for <mptcp@lists.linux.dev>; Fri, 12 Sep 2025 03:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757648418; cv=none; b=u5kbhtWDQoD90ANQrRCgtVPRayobLzxlD7Ix6OapaG04d3rz9u5I7Y9OsoD6I17xWbBzX3vxzWRFkuavQm1w/zV9h3XXHKd4BUjVWBpAp5rvoBCdIFyDSKXGiPwURV3EC+PfoPhUzJDwIa+M1xxgbHS7ojFEHiEgz/WSOoyxbCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757648418; c=relaxed/simple;
	bh=D8RIPRZBGOqDjp1yVASIDLiMvJLKsG3GCUReBIPbOog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IElGDjR9UFoFmm3A55yPTs8p/PBv/EmNP3DfBmwyFCX6M55tYVR5ewBCUD3daB8Hi47CpH0AUm7NgnhQkMM+70yPfrw/XiST+p9Ltt0TF26SdytlnI6NAiXMhV+MFGKg4Y57Xt/51943nhvuYodLWf5/JmeoOrSEPAx4nQm/dyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K30iOp9V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K30iOp9V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFDE7C4CEF5;
	Fri, 12 Sep 2025 03:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757648417;
	bh=D8RIPRZBGOqDjp1yVASIDLiMvJLKsG3GCUReBIPbOog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K30iOp9VI+LGQ1v3+CCEI7GtRrcnzPFRG5SHcocqaTv3dFwDWHVyOgejXqbOw+KXs
	 RYm3X7AUZIBDTgHfq7utDjkrLimHbFhyjcyJtLj0Vo4FlL3N3G+3TPu+/StRUrCKEY
	 GCX7BxKuAwOd6myY8HUSVAGZnmPoErkmLs7p/yOHo6Li8bmcANPASL+OknrX7gjPPY
	 we60Tgt0VEodwgntPL01lLbAhgmTYpxe07dtoFiDlZeMokfo2k+i9qcC+G++zsEEgD
	 deupi6D7/FJL4QNo/iqZKgPlprR6bkdbyXjErqVC+a2MswJ2MZyl3JdVaQonYPOoUW
	 3d4VtO4iua8Gg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next v3 2/3] selftests: mptcp: close server file descriptors
Date: Fri, 12 Sep 2025 11:40:04 +0800
Message-ID: <2be1f94bbf834ad615333af818ed499d96d81805.1757647967.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1757647967.git.tanggeliang@kylinos.cn>
References: <cover.1757647967.git.tanggeliang@kylinos.cn>
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
index 112c07c4c37a..200f0942fb67 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -726,6 +726,7 @@ static int server(int pipefd)
 
 	process_one_client(r, pipefd);
 
+	close(fd);
 	return 0;
 }
 
-- 
2.48.1


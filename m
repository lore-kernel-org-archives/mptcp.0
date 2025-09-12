Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64F37494
	for <mptcp@lists.linux.dev>; Fri, 12 Sep 2025 03:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757648419; cv=none; b=bCuhQs56RkMgJWiCbVwuVDM+6057/rmwLwPJEXEWUgHMtK3Mr1fdcm7VZua2AiWGke7ElH24RubtfYuNqw1+eIIKK2u5J1R/8TIc7Bq8Hbm8Gvb66voN1tu0lE/F/ibIyPbz8Qpu2kr2HCYkMz1D5ieHDGNuZqYielt4v3uXSmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757648419; c=relaxed/simple;
	bh=e0gYAq+aaFLHErt15+GKOwNmGL8pidS3R8Xg1LEhsbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j8t82FwAHj4n+sEyWpWcWWiHPVh2T8BlK++uo2OTu+Y2zF/H0lANdNbMz+316AFzAb51wEFYlGGBi97Wf0ePJMdDogvlnOLdvhzTco7r3h8l2oIH47Zu6t+bnbkIpy5T/tRHJXqC3+Viwaag+MoDJ3Y7ZgCJr5sTUQKHSwUdovk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJvH8Wzc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJvH8Wzc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4B5C4CEF5;
	Fri, 12 Sep 2025 03:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757648419;
	bh=e0gYAq+aaFLHErt15+GKOwNmGL8pidS3R8Xg1LEhsbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fJvH8WzcwSTISbapU/Srrd3EgZU2ZPRmIcS2I4iWHApE5fw21I5hmrdr5dS1RH4Bw
	 sj+t+Rx57U+qVs0pztNiZGT2qHcFTMV1FZ2FgpED7dI350UHF9IQiXyyHY8DE1M2I5
	 4IaNnbd9PzYFcbN8jc16+WJ9sjuWhT6zokTWkhP9MDGmbUCwutOTUnyEXpA5IgLFwj
	 Y7/J+b23D7V+Bs+D8/AgkMNl44Rr21IUlfZk0BdgcJlrTCFcS9hRSanG5+8vy6CkGb
	 mg61K8VUquEXVV7N9XUpMyWUPbOM+yZOebAtRGXw4AbnU1MVveJ1CViy38DDuUZ8B4
	 ftlw3N9nsRPyQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 3/3] selftests: mptcp: close server IPC descriptors
Date: Fri, 12 Sep 2025 11:40:05 +0800
Message-ID: <2727c1367577504c5a1c4fad62578d0c2b3a8f9f.1757647967.git.tanggeliang@kylinos.cn>
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

The client-side function connect_one_server() properly closes its IPC
descriptor after use, but the server-side code in both mptcp_sockopt.c
and mptcp_inq.c was missing corresponding close() calls for their IPC
descriptors, leaving file descriptors open unnecessarily.

This change ensures proper cleanup by:
1. Adding missing close(pipefds[0]/unixfds[0]) in server processes
2. Adding close(pipefds[1]/unixfds[1]) after server() function calls

This ensures both ends of the IPC pipe are properly closed in their
respective processes, preventing file descriptor leaks.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_inq.c     | 8 ++++++--
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 8 ++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_inq.c b/tools/testing/selftests/net/mptcp/mptcp_inq.c
index 40f2a1b24763..8e8f6441ad8b 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_inq.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_inq.c
@@ -581,8 +581,12 @@ int main(int argc, char *argv[])
 		die_perror("pipe");
 
 	s = xfork();
-	if (s == 0)
-		return server(unixfds[1]);
+	if (s == 0) {
+		close(unixfds[0]);
+		ret = server(unixfds[1]);
+		close(unixfds[1]);
+		return ret;
+	}
 
 	close(unixfds[1]);
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 200f0942fb67..286164f7246e 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -852,8 +852,12 @@ int main(int argc, char *argv[])
 		die_perror("pipe");
 
 	s = xfork();
-	if (s == 0)
-		return server(pipefds[1]);
+	if (s == 0) {
+		close(pipefds[0]);
+		ret = server(pipefds[1]);
+		close(pipefds[1]);
+		return ret;
+	}
 
 	close(pipefds[1]);
 
-- 
2.48.1


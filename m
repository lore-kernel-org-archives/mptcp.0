Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C5031B101
	for <mptcp@lists.linux.dev>; Tue, 11 Aug 2026 13:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786454340; cv=none; b=luwW9xC7KdQMZjVCigdAa2krd3mj0zgkOjPJPI67hBhf0rI9Pz27eH90MLZ/x3xYQpZV+cE9rp1XMfyxnKWS5g2GMlccTGTI4+byv3bn4GhFM6XhmoocZRf0CVfZ5jC8WRaiBv+Sle9JrOPqWI9jnzZNAolQca85ISPZew3T4KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786454340; c=relaxed/simple;
	bh=JxT3qeiSHuBS12KtGnTPLFRzVxKd0fvCXwqrRkI3nnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VbrAbWZzvbIxInLn+J8sFkq0J4IDyLGt49aw47rFUUf+MEzNVjglp3hELAWtQ4T4SV5bQjW0ED5ztLG/jBvaZ1WWvavjeFsCf/mVJ17I7ERBVgRXuhtRiEBBjL7e9h1XFLDQgEzpInZo7r0+U8EpCLt3+W5WXTc1lu6kqmBbjIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJFJNpIx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJFJNpIx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 318931F000E9;
	Tue, 11 Aug 2026 13:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786454339;
	bh=xNNDwMcimuhvgxiiYj/oGzahS6NB1VtBfCB7+LyvfjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VJFJNpIxlfWRxQXEucNW8AdQxJWpU55OZqheE4jBh8soaMFaCVSGS4hdJG41slDSE
	 7qB24RNlHMDbDOcLeWmQa68/I6dKzcx+DFQCI39uHjlVLgIqxYv8jnDcRiQC++scjW
	 9q5hsHkfwS+/+YXjQv6LfZxtKajFONrife8G6YpGPZdQvVhTRsvimlPH/hpmOQU3C2
	 RZZ+IBSHu1c0doNH4RiVWd/dN+v+VRTsk2GLMjlij4BpBW/2SuR8SCoEeyfYH6kLCC
	 5domU18NKL8szVvNBQs6GNmTBKSJRZrnelH/Br6iCdRy3iXg8224hzzBp8Epit2Z5U
	 33OX0+m0qXthw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 7/7] selftests: mptcp: sockopt: check app_limited
Date: Tue, 11 Aug 2026 21:18:26 +0800
Message-ID: <5165597df8c31ac60b767cbbdffc4aec206b5b32.1786445142.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1786445142.git.tanggeliang@kylinos.cn>
References: <cover.1786445142.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

connect_one_server() in mptcp_sockopt exchanges only a few packets between
the client and server, then closes the socket. After such a small transfer
the application has nothing further to send, so the connection is, by
definition, application-limited.

Extend the TCP_INFO readback at the end of the function to assert
s.tcp_info.tcpi_delivery_rate_app_limited == 1.

Without the preceding commit, mptcp_sendmsg() never updates the per-subflow
app-limited state, and this field stays at 0 - the assertion would fail.
With it in place, the value is forced to 1, turning this into a regression
guard for the subflow-side application-limited accounting.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index d68515b7903b..8d712bdb4325 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -640,6 +640,7 @@ static void connect_one_server(int fd, int pipefd)
 		total += 1; /* sequence advances due to FIN */
 
 	assert(s.mptcpi_rcv_delta == (uint64_t)total);
+	assert(s.tcp_info.tcpi_delivery_rate_app_limited == 1);
 	close(fd);
 }
 
-- 
2.53.0


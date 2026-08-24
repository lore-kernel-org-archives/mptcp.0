Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF00282F0A
	for <mptcp@lists.linux.dev>; Mon, 24 Aug 2026 02:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787538075; cv=none; b=TPkAnEbaeJLJBXNG9shab52zjw4VM/clzmxLi9Vn+aPtEJ08RFgC222yJv7G7YLoKeG9HtcyN+jWdKAXVheEVQJI5ElvJWtzRGsoITBeihNoyY8pYaovzYgoRIXcZfUXdLaV3141zk/WS1WGIaqyC5lV/3GJYXhjipm6g6mlKl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787538075; c=relaxed/simple;
	bh=JxT3qeiSHuBS12KtGnTPLFRzVxKd0fvCXwqrRkI3nnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+9vRDpoJWypfOp7dM6d2FVYfFCXhn0RBcHHWLhig03RuTg5BDA02J6DG4RULI4ZTicBgJZ+suuBgDlzqXYwbkYH7VTSXFp5gndW6v7HR0S+Kt0pP9M/Pq+UiSAp74rYjcM88xZb4D31TpX6lLuCwaBN2O8crsj+kxx3mM6FlY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IomZVF8m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IomZVF8m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D8FD1F000E9;
	Mon, 24 Aug 2026 02:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787538074;
	bh=xNNDwMcimuhvgxiiYj/oGzahS6NB1VtBfCB7+LyvfjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IomZVF8mJC6HHj7K5Os7pOl6opMUZZ07bCt//7g5suSakfPa7otDNd+Qi2uXbFAQ1
	 KN4oEURul09YlxWIFZhctT7/bGDjzFJI0QBIbub/4LRloM7IdYbJivff5k9uyUHXs/
	 zFl5YFhz1JXlljHXaDnoJ6jWbTKm4reni0vZHY42jmgoh4ANN0WwmzbdIgU3wcCzZT
	 zjCvhkUGYbwgUxkTqk/7yR10tjKOkOA1qj8Z5Itm0Z0HK81yKk71FzCCSrI2BexkhX
	 lwliY4SXyQPhMD6/eeAz46xQdlScYcGeIlH+jEOBmGiTqEEGU8I4ZZZXnUd/jkRtix
	 yNdnxryXqM5qg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 8/8] selftests: mptcp: sockopt: check app_limited
Date: Mon, 24 Aug 2026 10:20:43 +0800
Message-ID: <c442941ea5f631e3cec65c32adc04ab6c4151eee.1787537436.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1787537436.git.tanggeliang@kylinos.cn>
References: <cover.1787537436.git.tanggeliang@kylinos.cn>
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


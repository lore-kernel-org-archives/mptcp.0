Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9C74CCDD5
	for <mptcp@lists.linux.dev>; Tue,  1 Sep 2026 06:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788245369; cv=none; b=ngVHTdACL4hyy+rRhlJ8mbSb0U+q2co1zJtf8h1ydtXlZKDNzEDgnq9gGCGsvHkB+RNFd11+zxaRQkdMOnmd6xRcUO6iAcHd0TSpdd+y70AS19p8WE6oslgSjVy/ctr77ASy8YqOp3tz8TS/L4sKIBrYfK0IBnuLjFR2PDehV8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788245369; c=relaxed/simple;
	bh=JxT3qeiSHuBS12KtGnTPLFRzVxKd0fvCXwqrRkI3nnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CBDiqVb9fNH330I+f0JAVtrv+66iabYOPnmHCYo2OQ8s7LoQVthggvrxC87dhH/ufqFtS1NTVBVYeARr9C8cpC0ov5IA/lS3A6oJdv32J4UVuQuY0TE7vAcUA3z8T2vo9YqsjYPgA2NnBUA5MK0NhfGDdsIZ7mb6Tb3xrcN7k4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kymqUGxI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kymqUGxI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF7FA1F00A3F;
	Tue,  1 Sep 2026 06:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788245367;
	bh=xNNDwMcimuhvgxiiYj/oGzahS6NB1VtBfCB7+LyvfjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kymqUGxIrMaS72pqft9Sxzf363HmYbbRagV2HQidtcEC8B4iLaxtTCW+f9HfP4aRX
	 umlK0TEENyhggupmXNdHvNlfDs3H8y5s4A3uiALrkvupwbZdyb3J1r7Eqv24sUVpj/
	 EURfVG6crFF5i6QtEtaRWHen7Hss42Lf5pSBmSEr0btkLNWr6QnQVFswiS9nVIlYZa
	 8wh5H787EE9VGxuV4vlxg9r6/fj0S1CaKGPg7H8rv/+NSUYDZgWcRxNKa1JSI+gULG
	 FuzoXmWoZiDs0qbf2J+WvU06DWK9eJIdUVbiJlOjSHtcO+iE6pyM3BwNgTllzmNF6H
	 dznl6Kyfq6RWw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v13 10/10] selftests: mptcp: sockopt: check app_limited
Date: Tue,  1 Sep 2026 14:49:03 +0800
Message-ID: <aa06681420ca47827891e12ab108f213696a5756.1788245079.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788245079.git.tanggeliang@kylinos.cn>
References: <cover.1788245079.git.tanggeliang@kylinos.cn>
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


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B2E39F168
	for <mptcp@lists.linux.dev>; Sun, 13 Sep 2026 10:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789294516; cv=none; b=qS+RCQaTx8LztWHjJTwwvowBDw+KmCRrCZnJ0h94tPz3fU0f/vUcuj5iDSPfwjzYDPbO7ckrGI0d9/T/GzZvXPlVDMhcEgXP/NijKe5PLd3OJ0fHPkfrR/C4093OlpPgr9btr1ujXKIz93Fo9WE0JGfZ0cAlpBQNqnhu9Gg7UdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789294516; c=relaxed/simple;
	bh=JxT3qeiSHuBS12KtGnTPLFRzVxKd0fvCXwqrRkI3nnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQt2m2/6PdfBai+JgGVphntv16Xsyw64t0lLvIs7K4ILFpxBMu4KawjeMx7lA8pHMpBDCNI6nGJBbV1fS8kYYKZOr4fEjthA+rYrsGmFPtq7pImTvmWvZyVXn7TJ6lIFNaxJJ3A7bELkgenAkXSvY8o6RZbXAefOzpfixBfvSyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXo1iZSw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXo1iZSw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4391F00898;
	Sun, 13 Sep 2026 10:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789294515;
	bh=xNNDwMcimuhvgxiiYj/oGzahS6NB1VtBfCB7+LyvfjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nXo1iZSw1ankJJ4Zdk6shXxP2fsfThzNkCmUYJU/a8RsEPawE/evSiARxFURcBQ2h
	 mks/3S1O32Yq3Duh620wocUmBo2OxJb/bM7ywjfacJ9fzItX0BgZwBf9J4Oj9G3Zb6
	 GSpJ8De3je6zP7Ana5yVSQVdHCB5mPXsd+vI2YK9FNXX0wuUUwpR4HJuohyYBolgAV
	 /ZZgnKmQyf/XnsLBV0h4lnFTw7TK/Gp950JTAA6o+QPwRtodWPlneJjt+a4dIm77ck
	 30faRsAQKUT17fQpmrJk8kkmWpq0R5EW4cB3aIFecAfWLhzxLwG8rbfNhP3iPaDXuw
	 F+VvgYgwH5MlA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 04/16] selftests: mptcp: sockopt: check app_limited
Date: Sun, 13 Sep 2026 18:14:43 +0800
Message-ID: <413428cff69bac9db9fb42c04897810f3c4fba10.1789294365.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1789294365.git.tanggeliang@kylinos.cn>
References: <cover.1789294365.git.tanggeliang@kylinos.cn>
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


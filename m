Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D460E30B53E
	for <mptcp@lists.linux.dev>; Sat, 22 Aug 2026 03:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787368787; cv=none; b=k0Bn7OZHcvFNQIrng4PYRrYLGYCv8psoBCTDMvOVIEO/3KheBOC3q1ztozDRofL5kVaaAn0LzUemmYHIxTnrq6hU8wWka46Qnx6jp6c2ddvm08BU4Us1flbaT4F9epdZ8w5mdcQ8Vl+WZNYPFvwjQLInQ1IFG2FIPCmcIzeoTjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787368787; c=relaxed/simple;
	bh=JxT3qeiSHuBS12KtGnTPLFRzVxKd0fvCXwqrRkI3nnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P5zDuCo+5r36jMSgkGnrQhDbhPti9d3AM1LH5GopjmU11OQHnNg+WtTUArHZVhIKXBdb7V+FXCc9aniyvJHLk/MZJDWP+EFxG0C1CygWwhU1LfS03TLR8Exoe801l0t1R5ciOewzUAsufe7Pd5wvZQNyMjUB25IzZHioTVTwdr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbZQLf6R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbZQLf6R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020C11F00A3A;
	Sat, 22 Aug 2026 03:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787368785;
	bh=xNNDwMcimuhvgxiiYj/oGzahS6NB1VtBfCB7+LyvfjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AbZQLf6RWJtn4s5m8F8n/pyUJfIxjBTJ2PdMKR6eYlkN8dEtV0WjyXBZCjQ+0IgJ0
	 kMfcz9BOhljKRP5Nw9dHDeDF45oemT/yU+fqsPZTZNRKTRQTz0Ru2J3RJ983Kf8Y8S
	 VnUxSDzDh6f9HkLcKnHdZx0gdAVw0RFmHwGzaBCFtZpoqw7dZuArK03VkSKSuJIg3E
	 rpfP21JH4NA51REU0WTmYGWRLEhJbszYl9AmeCkaYWrV9WlZvcwbbh/6Uix8egfXZ3
	 j93vcmj2QrnFL5Lww7i9HTszzACdBtpxlImW/MfoABxWh1QAl1v8pP1d9ECLq/4nv7
	 JnmrvBHHVqYLg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 7/7] selftests: mptcp: sockopt: check app_limited
Date: Sat, 22 Aug 2026 11:19:07 +0800
Message-ID: <042accc680dfd0dc617222ee601cfdf4255e67cb.1787368526.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1787368526.git.tanggeliang@kylinos.cn>
References: <cover.1787368526.git.tanggeliang@kylinos.cn>
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


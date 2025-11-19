Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA460346790
	for <mptcp@lists.linux.dev>; Wed, 19 Nov 2025 10:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763546740; cv=none; b=AepZyFjUPDPW+mwI1gCaWyOenDKgtJIEaEIBji3J45dhbM0aHBusKk417FcCY7ECsjswmSTPMtFrtnxVGCAYwOd/F2FPfcurc3xJSVq4TtvzsuqufXJBvXGZEcChW0U+qwjN430K1rXMlr73oig/Oc8Wcl025Urc9MLzYXhw8YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763546740; c=relaxed/simple;
	bh=qyFKIDIWadRIL7qHqTNHoDu9Bua1Wu4TocWIR0mYghg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GU8OXqDP9Y0ky7jYx6AZr9KGwKwcjE0y6i1AEakTq8d7tQpTmTSr/NbcAbCyL6Slv9N3AWWi6yS/DVBTsVg2zDXD+1gnZY0QJYDPG1xbW8uZq9izXfPUMASh/WIbE0d72ssmD94oJslzAWiO7WbfvOUpA5CCf3K2kQa/2xYb2L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wmzb7JMx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wmzb7JMx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80AB6C116B1;
	Wed, 19 Nov 2025 10:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763546740;
	bh=qyFKIDIWadRIL7qHqTNHoDu9Bua1Wu4TocWIR0mYghg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wmzb7JMxntBhpkWEyqisPlyLPB3EQwzkTJXIHOdjKHgCl9ZRcRWIUhU3L6HuMI4zA
	 9B+jPQlAtNnlRAn7rO2WHh1YJuHW0evE6TIJOigDi19qiDMA9i7WxQ/XQlkakGp459
	 8q6uBky3t0tBLgsaEHJKecLkzxf93Zr4u3vXYepq+DXVFcF2I+L+Oor9SVpr0wsKv8
	 EZCNCc+iYeABIP93v2xOnAQsleF9eeXBgBGlAFDK28AngvPimR1B1BtU5BaoafRyXj
	 8r7CkWajPdAkAD/lPd6g3zK1GL0ysyxbcK1RYwaItmxcsBhOvWr8m0ShUEOh0IxZ5T
	 sbPv01g/zMp0g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org,
	hare@suse.com
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next v2 5/8] selftests: mptcp: connect: fix uninitialized peer warning
Date: Wed, 19 Nov 2025 18:05:04 +0800
Message-ID: <43931d38bed6e47b1b68d3bdf0a13916a926d190.1763546473.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763546473.git.tanggeliang@kylinos.cn>
References: <cover.1763546473.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Initialize 'peer' addrinfo pointer to NULL in main_loop() to fix the
following compiler warning:

1415:37: warning: 'peer' may be used uninitialized [-Wmaybe-uninitialized]
 1415 |                 if (connect(fd, peer->ai_addr, peer->ai_addrlen))
      |                                 ~~~~^~~~~~~~~
1368:26: note: 'peer' was declared here
 1368 |         struct addrinfo *peer;
      |                          ^~~~

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index badb04b58a64..4d7016475218 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -1376,7 +1376,7 @@ void xdisconnect(int fd)
 int main_loop(void)
 {
 	int fd = 0, ret, fd_in = 0;
-	struct addrinfo *peer;
+	struct addrinfo *peer = NULL;
 	struct wstate winfo;
 
 	if (cfg_input && cfg_sockopt_types.mptfo) {
@@ -1414,7 +1414,7 @@ int main_loop(void)
 
 	if (cfg_truncate > 0) {
 		shutdown(fd, SHUT_WR);
-	} else if (--cfg_repeat > 0) {
+	} else if (--cfg_repeat > 0 && peer) {
 		xdisconnect(fd);
 
 		/* the socket could be unblocking at this point, we need the
-- 
2.51.0


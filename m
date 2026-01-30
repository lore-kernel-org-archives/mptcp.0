Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F58369980
	for <mptcp@lists.linux.dev>; Fri, 30 Jan 2026 10:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769769799; cv=none; b=BsDbrpz6fNVVVQz4wjDl7/G14SRrvxfJljb7MmuWP7DieJ/IDCcOGiD9T6CAC5JHlCh4QRtLlNUKbJxqepPcXtORRyM4soER/Ysk+hIQ9TZxjSOxLKRvJZMhJFYMQdtFYXYSCdOdfUpndCHWgkW0QWDKV+XMfY4VwaxBAWMqUg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769769799; c=relaxed/simple;
	bh=BI+h+xFYnGQe/6p7JwmYZmJXqgwXc8nMyzoeio9UZ/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NzxZFP94YAqt9g/Yr2n9UVJjfyr3uCVxbQVDeINqmYVmxBQOOkkV/VzlMztllQJLaxaKhuruoYaj1avOHsXuC+YZ9nnLHecJS3AgacFZjok/OVGUFBT/oOURRSHNlJOTaVXlaLZ+6soMwJzrnOFWRbgrDou+zN0uZHkLQrzXQgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozkH0mex; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozkH0mex"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3938EC4CEF7;
	Fri, 30 Jan 2026 10:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769769798;
	bh=BI+h+xFYnGQe/6p7JwmYZmJXqgwXc8nMyzoeio9UZ/I=;
	h=From:To:Cc:Subject:Date:From;
	b=ozkH0mexRJLMZ5ivBr/p3gCmjz6l3kQNlkmq6iIzoRM/A3HSTZM+whBbtU8spIZWp
	 oDRc83lY1NetPnphsgYMOAk/aNMsi5+g+lIANq0l2vdgVTlnxaWsud/+Cz8V/E+9mz
	 pFOd8u5ltcDM5bpsRGELOTHCxpTsn4EEo3idg8DFk9g1fh4YklS0r2bTXpF/Weo4TM
	 eZlgBGVyE7r0q2a6v2C73iw2Up5qiHasGzPLuAJ6x4ydzTcw71/kFERZbl1p/mFnrN
	 UUo6EzymlemYYhpU6zcvHBIX3qwrEL9q5jb45LESMyJwc5FzeNo3UOpLRlwc6uZOLg
	 DXmZgf7EYyxGA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: add splice io mode"
Date: Fri, 30 Jan 2026 18:43:13 +0800
Message-ID: <c24b6414ed2ec128f8ed00be9aa84e0a33c484e8.1769769757.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Check the return value of splice().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index ff1a298d3469..aaa2248ac76e 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -947,14 +947,16 @@ static int do_splice(const int infd, const int outfd, const size_t len,
 	while ((bytes = splice(infd, NULL, pipefd[1], NULL,
 			       len - winfo->total_len,
 			       SPLICE_F_MOVE | SPLICE_F_MORE)) > 0) {
-		splice(pipefd[0], NULL, outfd, NULL, bytes,
-		       SPLICE_F_MOVE | SPLICE_F_MORE);
+		bytes = splice(pipefd[0], NULL, outfd, NULL, bytes,
+			       SPLICE_F_MOVE | SPLICE_F_MORE);
+		if (bytes <= 0)
+			break;
 	}
 
 	close(pipefd[0]);
 	close(pipefd[1]);
 
-	return 0;
+	return bytes < 0 ? bytes : 0;
 }
 
 static int copyfd_io_splice(int infd, int peerfd, int outfd, unsigned int size,
-- 
2.51.0


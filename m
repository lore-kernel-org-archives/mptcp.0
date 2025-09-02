Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFBE25394A
	for <mptcp@lists.linux.dev>; Tue,  2 Sep 2025 01:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756777215; cv=none; b=J1jN9itnFFHkiXiOy/QZ9HxmzfokNSHvIx5pxL3n1VfKyXD368bxpMZ828JPQKRQcILDOs2NG/b8Afc90r+xiowGyzIlqDHdy19nu/pNfkeHa7V3rMOPKTb/pV67t6oGE5ex2yeQ2LfWTjzaMo8AG7sIYuFlXId1Xfc0U5CoKOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756777215; c=relaxed/simple;
	bh=N0PpTmwHLu+Em/S81z+ucoyuCaiVgNCgR1UacoKaWKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDK42NswxixcJLshQMkp1I0DwAKSY1cOqkHovRQQ08dtIt3iP9lbHuWOkZ5hudqAT3Uj0CTERWtXMch03MznZhBZAleq/jN6f2d+mwUm7vDAGS3iEhBkWJAsV/PL4koexTcVxF5KkStMWzoBS29CoN12QBtHkYqed3wHM08od/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4eOFrSI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4eOFrSI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F36C4CEF7;
	Tue,  2 Sep 2025 01:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756777214;
	bh=N0PpTmwHLu+Em/S81z+ucoyuCaiVgNCgR1UacoKaWKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y4eOFrSIouefxPvoVVvFK7DuRiYoHbmbWxtKbHFtflRmZTCAGtInBtT0flNXNRvnH
	 yV1UXXvGXo0Lw5DKEQE4aFZFxx8aNvFQAhKy/z5sAENYO/6Oe/BTx2yApMrR9CZd/i
	 5Kz9Vg+6wbpHv8wbPY8BHNZhxUFpOrGALRJAY2lAxHpH61/LgPPYUr62ShbOwX2oZe
	 tZznpy03NLTxsF2GYR1TDi9mgSLIrH1E1t41K0S9EngfjZ/6j1BTFyXevGffsY6ojC
	 z6RRbyky2odUF81aWkDkixHV2Vzj3EouN1prnwWQzpL7CW2IWdHWngMwL/jhBd97X1
	 PDWTm4On8IJ0g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net 3/3] selftests: mptcp: sockopt: fix variable check in error reporting
Date: Tue,  2 Sep 2025 09:38:36 +0800
Message-ID: <f4b4c993422545c2301ab38175e2788bd489ba8e.1756776801.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1756776801.git.tanggeliang@kylinos.cn>
References: <cover.1756776801.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The error message for mptcpi_bytes_acked comparison incorrectly
references 'ret2' instead of 'ret'. Since the comparison is between
mptcpi_bytes_acked and 'ret', the error output should consistently
use 'ret' for both the expected value and difference calculation.

This patch corrects the variable usage in the error output to ensure
accurate debugging information when the assertion fails.

Fixes: 5dcff89e1455 ("selftests: mptcp: explicitly tests aggregate counters")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 8d590629a8e9..a61508270a5c 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -680,8 +680,8 @@ static void process_one_client(int fd, int pipefd)
 			       s.last_sample.mptcpi_bytes_received - ret);
 		if (s.last_sample.mptcpi_bytes_acked != ret)
 			xerror("mptcpi_bytes_acked %" PRIu64 ", expect %" PRIu64,
-			       s.last_sample.mptcpi_bytes_acked, ret2,
-			       s.last_sample.mptcpi_bytes_acked - ret2);
+			       s.last_sample.mptcpi_bytes_acked, ret,
+			       s.last_sample.mptcpi_bytes_acked - ret);
 	}
 
 	close(fd);
-- 
2.48.1


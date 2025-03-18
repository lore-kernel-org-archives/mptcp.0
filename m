Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D921EF372
	for <mptcp@lists.linux.dev>; Tue, 18 Mar 2025 11:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742296522; cv=none; b=Xp1I0dnKYXQkY1fIf/4M2uzcGGIhdmRV5HjpTDWrLarSlBIcNPlQFTUA3k1BhP4V4qDNIT5ncukANzb4s+mgYuVrmMv+UGgvjxr5sz6deeK23sW1eGHKVPlXjNKjCTtQ/UV0zozNfQfWhocA7K66sjedugpJOaq+cQofvAtXB3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742296522; c=relaxed/simple;
	bh=5V3ApdhItgLRSH60AKzqrweBoMOl154nMmxZONoNHlk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MEyCUm7fNmBZgr+4S667bC4WnIRzncvAGGCh49aAYeZ4axU9zLa+4wcNgxRdPLTzatzKDH4D7r6MVD4mOc+oA5QQEdclwhuzRdznbChoQdcDiLD7uDcblv6TDxYYfcykzXdtAvzbGMqi0IWQD1wRwydCbAvHLu95/nOvJnloxD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAlz8JKw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAlz8JKw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0CD5C4CEF5;
	Tue, 18 Mar 2025 11:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742296522;
	bh=5V3ApdhItgLRSH60AKzqrweBoMOl154nMmxZONoNHlk=;
	h=From:To:Cc:Subject:Date:From;
	b=lAlz8JKwadGeLowq6quoELZcLDuKb6nUUhHxZugr1kN6cEG7r3QdnWP4qnsIJRHGV
	 y151RWZQzJ3LP+h/lG+RkX3b8QTOtfJPOu2DSmJkiiKxs75T/Co7EpY/a8emrH/DMG
	 6iGD6sbcaHmWL6euJ59g4nJ0evmuluqNJdEiw9S0Sf4nyq+dYphp9UeeL1xuW3NAgb
	 zP9IqrMT0BtADJWdvG24U6vl7eF0EalvGjT1ayfutonjKrCskyrGqxphItAsuBfw39
	 EClTeu2vmq37Grm9kaBjSvF3n8Zn23+r+Uh+vJQyHJt8ofQfurGb3fFAaXO4BYv4Pv
	 YaDq6mgsgX/vw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Cong Liu <liucong2@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next v3] selftests: mptcp: fix incorrect fd checks in main_loop
Date: Tue, 18 Mar 2025 19:15:15 +0800
Message-ID: <59caf78b9d67a0a61a19a46f7820456f6ced3d6e.1742296236.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Liu <liucong2@kylinos.cn>

Fix a bug where the code was checking the wrong file descriptors
when opening the input files. The code was checking 'fd' instead
of 'fd_in', which could lead to incorrect error handling.

Fixes: 05be5e273c84 ("selftests: mptcp: add disconnect tests")
Fixes: ca7ae8916043 ("selftests: mptcp: mptfo Initiator/Listener")
Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Cong Liu <liucong2@kylinos.cn>
---

v3:
 - resend the pending patch from Cong Liu, he said to me that he has
   no time to deal with this recently.
 - add another "Fixes" tag as Matt suggested.
 - update the subject and commit log.

v2:
 - https://patchwork.kernel.org/project/mptcp/patch/20250116085459.31419-1-liucong2@kylinos.cn/
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index d240d02fa443..893dc36b12f6 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -1270,7 +1270,7 @@ int main_loop(void)
 
 	if (cfg_input && cfg_sockopt_types.mptfo) {
 		fd_in = open(cfg_input, O_RDONLY);
-		if (fd < 0)
+		if (fd_in < 0)
 			xerror("can't open %s:%d", cfg_input, errno);
 	}
 
@@ -1293,7 +1293,7 @@ int main_loop(void)
 
 	if (cfg_input && !cfg_sockopt_types.mptfo) {
 		fd_in = open(cfg_input, O_RDONLY);
-		if (fd < 0)
+		if (fd_in < 0)
 			xerror("can't open %s:%d", cfg_input, errno);
 	}
 
-- 
2.43.0


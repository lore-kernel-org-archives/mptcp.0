Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702042AD25
	for <mptcp@lists.linux.dev>; Tue, 23 Sep 2025 01:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758591775; cv=none; b=Z3tKvEA7WneQruYXfF51Upr7qHerxWbvnYrlYjO133GLf04Ck3t+NPcxBRAGxIw3IpNza4Wx5hPzDbxpjMnSzq3crbwUE6rGKRpXRNwQpiSEhzQDVx3eVqOXPKXVTEcImY5XzrhIJtZaY90oKvPJMp2/fp+eugpndDbtSZIVYP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758591775; c=relaxed/simple;
	bh=Px1HcSpSP7+xwVvb8ceknu7la/E7PBiB44GbyMUdG9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cGXnk4tg+fttZbwRVdSNGYcNz/CJQEphhtACTJjNZKShKrjrZIC3+/3ex/ChI+aN8/6ymdasZReKgu6Y4xrRxptSnjeGrowHCr6djW+D1mnw7WHxGEnf2LpmEfyzIS28lRgP5SfghlkQ9fu5LFbGXIFXGx5gjEVORNPuLIG8cq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HoUSnT9b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HoUSnT9b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC4FC4CEF0;
	Tue, 23 Sep 2025 01:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758591775;
	bh=Px1HcSpSP7+xwVvb8ceknu7la/E7PBiB44GbyMUdG9o=;
	h=From:To:Cc:Subject:Date:From;
	b=HoUSnT9boEQjYar6JqFjldbzX2tRUZy5nfNZsMw4Iif99rn2m1RyuaHeRQAGsj/nd
	 apWVwhT8/EpEAW99RWIT4YETW8NGH4saBkdwVpDFNbjvmEmbvWuonuQteDESrEG/10
	 eLw3g8WnuoURoIseJU4BvAw7/4XB+JSq4zwxtn1YWfibLFofwAIKUnUIB3tgML40qc
	 DVDPmLHLidGC2d4V5eihORfFDf7SPYVGvppwdl/xF3jAk5UIUZQeNPDhfSsNyqSBUs
	 RTGdUlJgMLjFLFqOk3b3tT3jb672EizjIoNttqiL4SXIlUpPeXtv7zNft/BCSLxh4H
	 xZu1RAob43pMw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next] selftests: mptcp: pm: fix pm_nl_ctl build errors with old glibc
Date: Tue, 23 Sep 2025 09:42:48 +0800
Message-ID: <092fc76415deb1b45da5bb691ef6069fbab7dd09.1758591744.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Compiling pm_nl_ctl on older versions of glibc will report the following
errors:

'''
  CC       pm_nl_ctl
pm_nl_ctl.c: In function 'capture_events':
pm_nl_ctl.c:204:53: error: 'MPTCP_PM_EV_FLAG_DENY_JOIN_ID0' undeclared (first use in this function)
  204 |                                         if (flags & MPTCP_PM_EV_FLAG_DENY_JOIN_ID0)
      |                                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
pm_nl_ctl.c:204:53: note: each undeclared identifier is reported only once for each function it appears in
pm_nl_ctl.c:206:53: error: 'MPTCP_PM_EV_FLAG_SERVER_SIDE' undeclared (first use in this function); did you mean 'MPTCP_ATTR_SERVER_SIDE'?
  206 |                                         if (flags & MPTCP_PM_EV_FLAG_SERVER_SIDE)
      |                                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                                                     MPTCP_ATTR_SERVER_SIDE
'''

To fix this, this patch redefines MPTCP_PM_EV_FLAG_DENY_JOIN_ID0 and
MPTCP_PM_EV_FLAG_SERVER_SIDE in pm_nl_ctl.c.

Fixes: 24733e193a0d ("selftests: mptcp: userspace pm: validate deny-join-id0 flag")
Fixes: 198c12e28b51 ("selftests: mptcp: pm: get server-side flag")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index d4981b76693b..409af973d2ef 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -23,6 +23,12 @@
 #ifndef IPPROTO_MPTCP
 #define IPPROTO_MPTCP 262
 #endif
+#ifndef MPTCP_PM_EV_FLAG_DENY_JOIN_ID0
+#define MPTCP_PM_EV_FLAG_DENY_JOIN_ID0	(1 << 0)
+#endif
+#ifndef MPTCP_PM_EV_FLAG_SERVER_SIDE
+#define MPTCP_PM_EV_FLAG_SERVER_SIDE	(1 << 1)
+#endif
 
 static void syntax(char *argv[])
 {
-- 
2.48.1


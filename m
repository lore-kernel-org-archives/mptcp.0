Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D243A2E92CA
	for <mptcp@lists.linux.dev>; Fri, 27 Jun 2025 16:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751040775; cv=none; b=rVOc1rTnft8A04PLV3RURTrrxBqT1j1Mz2dVtkqLT8O6WrzWeJlCd2Wi8P8GKZww2V0dT5eSlfp+0QOJo1R7w3nRHHjvNBNE3NOAgCC+zMNactz4X1mp5WKiHC9gaYJOzb1Jk/VtAy1dvaDQlijatxJrFrOcUF6UDbs1Dplbgag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751040775; c=relaxed/simple;
	bh=Ti+RoDGtiZAzcLbCYB0dwqRCNe+NcOgfhyRPgSgM0Vk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N5IK2lEPadE7Xaql8FOAdWIrjY+RMx0eZWEMa5gYMislMdGTrSI4AgtJLmavNTKuP0DeIPKW6ralCKz8J87up5LV8gvR6l9uhAvDhoMnQnPM+xqBO20WlQ3zxaBJ9QvBwgXRphBnWqS8pVXwYQ29TBbzFkaPYjhOYdFX4O2Yc0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIbm5tI+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIbm5tI+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B429C4CEE3;
	Fri, 27 Jun 2025 16:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751040775;
	bh=Ti+RoDGtiZAzcLbCYB0dwqRCNe+NcOgfhyRPgSgM0Vk=;
	h=From:To:Cc:Subject:Date:From;
	b=dIbm5tI+8fwjnRrqGeMkMb/myiqura7XlAgC2k919YNJUMBu55NCBykLL2I4HbTKV
	 OtaziN/VEVJGqoti+Q6iY6goQLHiIJypvZfnVqcqyadRVfJHBYIAOs/62VUdVWmrCt
	 BDUy/p0Rdgx5w2nnwJlIiLPvHA3XAFwGu0Q1D5GAfLtYiB+1T2wD2rgf3hOkfxZKEs
	 gs3eMsvLcdzzFtl05IF0jd4uz7rqCAN+NNqqsSBaXzl2KiIQyNhmodwNl6mWgjuGfW
	 xdGhPPU9DTZ7TGACaoBI09drSOeekg2DMZ+xy9VgfGySYzA7h4781+yxPXipCf3pR8
	 guGECmfHmb9Mw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>
Subject: [PATCH 1/2] mptcp: add splice test
Date: Sat, 28 Jun 2025 00:12:08 +0800
Message-ID: <38650719788d8f17f9f935a7fcedc82f850cd138.1750926127.git.geliang@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds splice test for MPTCP.

Signed-off-by: Geliang Tang <geliang@kernel.org>
---
 .../mptcp/splice/mptcp_splice_loop_test.pkt   | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 gtests/net/mptcp/splice/mptcp_splice_loop_test.pkt

diff --git a/gtests/net/mptcp/splice/mptcp_splice_loop_test.pkt b/gtests/net/mptcp/splice/mptcp_splice_loop_test.pkt
new file mode 100644
index 0000000..7f394c1
--- /dev/null
+++ b/gtests/net/mptcp/splice/mptcp_splice_loop_test.pkt
@@ -0,0 +1,23 @@
+--tolerance_usecs=100000
+`../common/defaults.sh`
+
++0    `../common/multi-ep.sh -e 0`
+
+// Initialize a server socket
+    0 socket(..., SOCK_STREAM, IPPROTO_MPTCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 setsockopt(3, SOL_IP, IP_FREEBIND, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+// Connection should get accepted
+   +0   <  addr[caddr0] > addr[saddr0]  S   0:0(0)         win 65535  <mss 1460, sackOK, TS val 4074410674 ecr 0,          nop, wscale 8, mpcapable v1 flags[flag_h] nokey>
+   +0   >                               S.  0:0(0)  ack 1             <mss 1460, sackOK, TS val 4074410674 ecr 4074410674, nop, wscale 8, mpcapable v1 flags[flag_h] key[skey]>
+   +0.1 <                                .  1:1(0)  ack 1  win 256    <nop, nop,         TS val 4074410674 ecr 4074410674,                mpcapable v1 flags[flag_h] key[ckey=2, skey]>
+   +0 accept(3, ..., ...) = 4
+
+   +0 pipe([5, 6]) = 0
+
+   +0 < P. 1:101(100) ack 1 win 257
+   +0 splice(4, NULL, 6, NULL, 99, 0) = 99
+   +0 splice(4, NULL, 6, NULL, 1, 0) = 1
-- 
2.48.1


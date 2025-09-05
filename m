Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D8B26D4D4
	for <mptcp@lists.linux.dev>; Fri,  5 Sep 2025 18:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757096359; cv=none; b=NiS4TBSX00gxun5xi6eOYk3Mz5wbZ9fSt6Q3kQOPDTxzES56SZaY+S276KcRD7qJkwNj02+MMXUkVegpWDtM7nFe033bshZG3Br7LPEg1druiREllndMSBFD4lWEHttWJ2Tp5kGKnG0E1ptuZzYfY0lN3rx0XM3fRDUxFqHMzTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757096359; c=relaxed/simple;
	bh=CpqysZ4TSbonzKkp7K8mn9RwCefzafxGdXLwreHBCA8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tk9uLFSJAVt00EtZqPTb/ytsaAE5rV4k+4w2cHMx91l57rm6RoIz6pbnbHhGFR/SIyRFGoc4Kqmne+OR+cnM7i8vGPOhSCh0Sd8NUVdM6S98XjP7jyv+NnaOdHns/y3ZKgZgUTmsvrcVDSKy4wir8ioJJuw/dLNdsdjJlp2MB4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sw7LNKDl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sw7LNKDl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 192D6C4CEF7;
	Fri,  5 Sep 2025 18:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757096358;
	bh=CpqysZ4TSbonzKkp7K8mn9RwCefzafxGdXLwreHBCA8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Sw7LNKDlr2zlJqXeL2+pvUOtFFpQwQWeH7kvMRaARcSCIh9NMxNRjZVHE/eNDVOuD
	 eK7GNG/vCPIt/nBppkLK+ga1+Vof+HlqsbWRk/zCCpb2JvqQvnikNTTQn4+dLrA4tv
	 7g96pQjatRTPRq/VsjNWjy9g40LuP5qL0JZM0RQn9eleiDQwZN4Vz9+b8BGe9g4U8D
	 i4J/JT2M8dkJQb/rkwrm6dRf60rHMPR9SeQ/XwYkDZBacWyScj+ndVE93v1MEKxwiY
	 TJGEABDMCBkYeeu+IfIJcvCEZYWpeytQPF7MIXSP80DqtEPf1YYAK9KI70pkSddvvA
	 AFxh6GPWEOShQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 05 Sep 2025 20:18:52 +0200
Subject: [PATCH mptcp-net v2 3/5] selftests: mptcp: avoid spurious errors
 on TCP disconnect
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-sft-mptcp-disc-err-v2-3-dfb3b6b4a877@kernel.org>
References: <20250905-sft-mptcp-disc-err-v2-0-dfb3b6b4a877@kernel.org>
In-Reply-To: <20250905-sft-mptcp-disc-err-v2-0-dfb3b6b4a877@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3925; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=CpqysZ4TSbonzKkp7K8mn9RwCefzafxGdXLwreHBCA8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJ2ay4Qn3Rl1dsW132Ms4pXzo0+FP9rzZ2JJ7ntv8+V3
 bIjuuyAQUcpC4MYF4OsmCKLdFtk/sznVbwlXn4WMHNYmUCGMHBxCsBEuA4y/K+7ssE4YuEyA6a9
 ex51xD+o1Q4RPJVyasqFJYFrsuRXXuBh+J8gPXnCg4CW771zeuVsS7RvvmITUGBPyfo0U+nUj/k
 lyfwA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The disconnect test-case, with 'plain' TCP sockets generates spurious
errors, e.g.

  07 ns1 TCP   -> ns1 (dead:beef:1::1:10006) MPTCP
  read: Connection reset by peer
  read: Connection reset by peer
  (duration   155ms) [FAIL] client exit code 3, server 3

  netns ns1-FloSdv (listener) socket stat for 10006:
  TcpActiveOpens                  2                  0.0
  TcpPassiveOpens                 2                  0.0
  TcpEstabResets                  2                  0.0
  TcpInSegs                       274                0.0
  TcpOutSegs                      276                0.0
  TcpOutRsts                      3                  0.0
  TcpExtPruneCalled               2                  0.0
  TcpExtRcvPruned                 1                  0.0
  TcpExtTCPPureAcks               104                0.0
  TcpExtTCPRcvCollapsed           2                  0.0
  TcpExtTCPBacklogCoalesce        42                 0.0
  TcpExtTCPRcvCoalesce            43                 0.0
  TcpExtTCPChallengeACK           1                  0.0
  TcpExtTCPFromZeroWindowAdv      42                 0.0
  TcpExtTCPToZeroWindowAdv        41                 0.0
  TcpExtTCPWantZeroWindowAdv      13                 0.0
  TcpExtTCPOrigDataSent           164                0.0
  TcpExtTCPDelivered              165                0.0
  TcpExtTCPRcvQDrop               1                  0.0

In the failing scenarios (TCP -> MPTCP), the involved sockets are
actually plain TCP ones, as fallbacks for passive sockets at 2WHS time
cause the MPTCP listeners to actually create 'plain' TCP sockets.

Similar to commit 218cc166321f ("selftests: mptcp: avoid spurious errors
on disconnect"), the root cause is in the user-space bits: the test
program tries to disconnect as soon as all the pending data has been
spooled, generating an RST. If such option reaches the peer before the
connection has reached the closed status, the TCP socket will report an
error to the user-space, as per protocol specification, causing the
above failure. Note that it looks like this issue got more visible since
the "tcp: receiver changes" series from commit 06baf9bfa6ca ("Merge
branch 'tcp-receiver-changes'").

Address the issue by explicitly waiting for the TCP sockets (-t) to
reach a closed status before performing the disconnect. More precisely,
the test program now waits for plain TCP sockets or TCP subflows in
addition to the MPTCP sockets that were already monitored.

While at it, use 'ss' with '-n' to avoid resolving service names, which
is not needed here.

Fixes: 218cc166321f ("selftests: mptcp: avoid spurious errors on disconnect")
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
- v2: no more state filtering needed, thanks to the fix in the kernel
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index c1586a7286123a509495ac319fd624b98f0bfd18..130f6348ce042514a156bf63c6f8cd0fe1d7be4a 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -1251,7 +1251,7 @@ void xdisconnect(int fd)
 	else
 		xerror("bad family");
 
-	strcpy(cmd, "ss -M | grep -q ");
+	strcpy(cmd, "ss -Mnt | grep -q ");
 	cmdlen = strlen(cmd);
 	if (!inet_ntop(addr.ss_family, raw_addr, &cmd[cmdlen],
 		       sizeof(cmd) - cmdlen))
@@ -1261,7 +1261,7 @@ void xdisconnect(int fd)
 
 	/*
 	 * wait until the pending data is completely flushed and all
-	 * the MPTCP sockets reached the closed status.
+	 * the sockets reached the closed status.
 	 * disconnect will bypass/ignore/drop any pending data.
 	 */
 	for (i = 0; ; i += msec_sleep) {

-- 
2.51.0


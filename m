Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9732BE02B
	for <mptcp@lists.linux.dev>; Wed, 10 Sep 2025 08:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757494636; cv=none; b=bedPWcP9QNAqUMpGgKOM+rspoLT3lqNTpT1uiwGRqAXZYYcY8sK2ooSd48n0rS5LpfnxnQL1O12iubhZ4HG0a4J1KmAZCUKdzGBXNbiOON5G4WBhFAIkGm29YyZ5U6UCU7Mc4y6EUVPMxEozc4633+AzeInGLOXaYVeoVRm6bPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757494636; c=relaxed/simple;
	bh=2TuCSot+tgof1qm88VFRk5On/QBtwO1fQNg3xtP6bSc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TipAdKQ++9If6wHZEClaHGGXXfQt21Pb0lcG0J6kh/eAR7nm7IruKg6tDc8D8EFDRmWYZW7rdlgqgNvRRDikqhrrOqHKoFx6kd2JMjGwbXW2jo++opln5Zqv8luArmc8N/SRrcQw1Jo03RtFlpiVaV2CwycS/njh4C6xoGcqe58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=quAuISlb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="quAuISlb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 949A9C4CEF0;
	Wed, 10 Sep 2025 08:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757494636;
	bh=2TuCSot+tgof1qm88VFRk5On/QBtwO1fQNg3xtP6bSc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=quAuISlbKXE6z/lN39276sOX71+I+2Z6Nb3ceMem4s2+1IORaZzjj3wG/7hkhQNeF
	 A5FwEpm6QqOnw2ycKrp4FfjWOSQ3EqfdwmUzQb+6WDWCc6LZE+EMa57k+uJNNoqMFX
	 3fskXTo3GH69IVcOXU4Ff2MZo6NdWXVq4jrZj3jlEU7AxFQq54bcxdU7oyr5qisuze
	 /19rAVtNAgTEQQaWVivtEWyTnwHGMQ5r34P8GwwtGvZV7FG7/UbHpwK4pbLbQFSn5K
	 04t3uZdwSDgCKjbZ2WqmWvWIxugTGysLH2KKV85X8tybTjmt5CliyzjRNpsQQp3Di4
	 K42djxjloXE7g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 10 Sep 2025 10:55:49 +0200
Subject: [PATCH mptcp-net v3 3/5] selftests: mptcp: avoid spurious errors
 on TCP disconnect
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-sft-mptcp-disc-err-v3-3-6799fa467d77@kernel.org>
References: <20250910-sft-mptcp-disc-err-v3-0-6799fa467d77@kernel.org>
In-Reply-To: <20250910-sft-mptcp-disc-err-v3-0-6799fa467d77@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3925; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=2TuCSot+tgof1qm88VFRk5On/QBtwO1fQNg3xtP6bSc=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIO2qZtniV3ZVJHia3Sx4KNLZHK7Xlup0O1pZfveqLIu
 /NWuX94RykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwERiRRkZepPVEthOnsp2WKT2
 S+/UqyXeE9rVNKaHhjfnOCa+9F+wiJFh5neej9MvHjHSrAyvfmQZaLEoUzKw7dGUxxN4g3p9+M6
 wAwA=
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
index 1408698df0999730d9a9a4ad6a6362a4ab122d54..b148cadb96d0b735901c92a1e4417f29c263dd90 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -1248,7 +1248,7 @@ void xdisconnect(int fd)
 	else
 		xerror("bad family");
 
-	strcpy(cmd, "ss -M | grep -q ");
+	strcpy(cmd, "ss -Mnt | grep -q ");
 	cmdlen = strlen(cmd);
 	if (!inet_ntop(addr.ss_family, raw_addr, &cmd[cmdlen],
 		       sizeof(cmd) - cmdlen))
@@ -1258,7 +1258,7 @@ void xdisconnect(int fd)
 
 	/*
 	 * wait until the pending data is completely flushed and all
-	 * the MPTCP sockets reached the closed status.
+	 * the sockets reached the closed status.
 	 * disconnect will bypass/ignore/drop any pending data.
 	 */
 	for (i = 0; ; i += msec_sleep) {

-- 
2.51.0


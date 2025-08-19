Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C01424167B
	for <mptcp@lists.linux.dev>; Tue, 19 Aug 2025 18:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755626738; cv=none; b=FnG0y+VvJ1rvThkMxPFPJ+Uppt5aJpg/whS7xyZhs41ES0J5aLF01Qk5Eol41TI4FbVskXsOuV895lOEq2EJ9Lzhh5L+vjA7J5E6P+QgSn/QacdSO2jyuvgnTDIKj/otoFSt4EYyOfsUdvf/taPKNIT0riXEhaizyWmIzrgTnUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755626738; c=relaxed/simple;
	bh=kII41+dM+vQtQ5Kg9K89T0gp87e86s2kbSzYvsqn4bE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=kf2k6sDgmbm/GS8O2t9gjgJWwT6Y0jkNrmuBWgjJQsCsDOmX33Tc+mpEm2sW6oMHv01QUQajQTOrcPuXefPb1kdBFeQ28tj90aQwat44fyx+FoJG+ujEa4oQkcq/RiK2ADgeEybBkSraV6nsih3R9YO+Qpq0Fs5SwqvhMqfpWbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CtQvtT8a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CtQvtT8a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3CEC116B1
	for <mptcp@lists.linux.dev>; Tue, 19 Aug 2025 18:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755626737;
	bh=kII41+dM+vQtQ5Kg9K89T0gp87e86s2kbSzYvsqn4bE=;
	h=From:Date:Subject:References:In-Reply-To:To:From;
	b=CtQvtT8aflDvXBPtSGrn2rQeB8gtU17/EOH3gBDuJIjmWZGOwY+3Li/p6zvd+xmSu
	 I/2a28fO5vzmDyt8roLe4s8sBnwVeGVjYykKPOhj9HRx+kS/NQqLlSwF5czpnZaINx
	 6tMaf7cS0Yt6288xZBw4VlfBSEnZCh1Ov+5CPhneoAAgiscas76tXG1Aj0s1GaBgHm
	 3PYg/taBF/kYMirGQmGJicsCs4FNgnCn1gb6rOVBGJ7GEeREfw164lyvx9uGe37Jtu
	 4WJBQbFnd90n3H5/rYLBN5H41a1v7GQu3UbAiknHw2iMiuG/Mmo7CuuTeZS6Tr60yC
	 Zij6gWSXahi5w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 19 Aug 2025 20:05:22 +0200
Subject: [PATCH mptcp-net 2/3] selftests: mptcp: avoid spurious errors on
 TCP disconnect
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-sft-mptcp-disc-err-v1-2-9d0cf296bc13@kernel.org>
References: <20250819-sft-mptcp-disc-err-v1-0-9d0cf296bc13@kernel.org>
In-Reply-To: <20250819-sft-mptcp-disc-err-v1-0-9d0cf296bc13@kernel.org>
To: mptcp@lists.linux.dev
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3994; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=kII41+dM+vQtQ5Kg9K89T0gp87e86s2kbSzYvsqn4bE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKW7HnrFjVTo5Vlytdr/d9uqbQ07mY5sLzZ8vypNsvOP
 1z2LdkOHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABNZuorhv19D24v5C4Nb9tzK
 W7HGYldZwse63nMXerJrAqsvHpWw3cLwz0S2X2vht2X2v+bJ9jXefTBJ9OyFdX5+T8UPh50qO/F
 tMg8A
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
latter has reached the closed status, the TCP socket will report an
error to the user-space, as per protocol specification, causing the
above failure. Note that it looks like this issue got more visible since
the "tcp: receiver changes" series from commit 06baf9bfa6ca ("Merge
branch 'tcp-receiver-changes'").

Address the issue by explicitly waiting for all the relevant TCP sockets
to reach a closed status before performing the disconnect. More
precisely, the test program now waits if there are still some sockets in
ESTABLISHED, FIN_WAIT_1, LAST_ACK, or CLOSING. So there is a reconnect
only in case of FIN_WAIT_2, CLOSE_WAIT, TIME_WAIT, and CLOSED sockets.

While at it, use 'ss' with '-n' to avoid resolving service names which
is not needed here.

Fixes: 218cc166321f ("selftests: mptcp: avoid spurious errors on disconnect")
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index c1586a7286123a509495ac319fd624b98f0bfd18..00b0307b7da2236fd3ba4ec4b6cec91b6b4b2538 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -1251,7 +1251,7 @@ void xdisconnect(int fd)
 	else
 		xerror("bad family");
 
-	strcpy(cmd, "ss -M | grep -q ");
+	strcpy(cmd, "ss -Mnt state established state fin-wait-1 state last-ack state closing | grep -q ");
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
2.50.0


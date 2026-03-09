Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E8936B074;
	Mon,  9 Mar 2026 08:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773043426; cv=none; b=QWzOP1ei5PPCrec4JbGBq0KD1Wxj2nd3PDkqeNxL67Ev6kPWsp7CoKQ6Z0w398Ai47gAe9DULMrk4KOWIwgozAiTRwSZrGjIidMLiRGoLVo6z+6vBu3Qx0aPrAMNqLO5dU3csUjOvxrLClWQOdGfZ2hnZJAVsP5++XAk5LgEdrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773043426; c=relaxed/simple;
	bh=wm3+FPgt/onbzQ/osNpSD8KFc26/gyxoBmdvkSWqouY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hOZpGf1HktQ56tFy5seW1FUJoQachqE7wYOd83xrk1eoTJug7Kx0DHCzWlj7EMIykFzemRNDars1X/R7j6BmhflJDjc7su1IxVPKIgZcIh54bAVi0dDKyHizi/3bsFgeoDPgduUHO7BygahDex5D2oyXlNLvnvbmsjQcg5ED7IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ts9DMZy9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ts9DMZy9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B412C2BCB2;
	Mon,  9 Mar 2026 08:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773043426;
	bh=wm3+FPgt/onbzQ/osNpSD8KFc26/gyxoBmdvkSWqouY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ts9DMZy9wNVrpbIARzo1Yeqcfd3twYqEa09HQ8z/6Ny8+FUTZTSZ/k740vX1Brf8L
	 U0NXv6Qq0gMGt7g5P39nDciJvLZUt5IoJClBfG7F3Z2RE3S/AG7WV9c1nzISIJ+LvZ
	 O0w5lAD7TIgEIw3YjgSeyoxmociN2dGZto6qFScxN/utozOp6NcP5xyPALR8lxVBW4
	 CvJ/zY7jSD+vCaj+OwEueEJB3ezV/EyQw5lOhxKMdk4luDMNVn5igsAvTcb+277uAH
	 1Tf2aJgtW0Awinx/GXzaQ0VRLpPToF8G5n8yYwf+/Rk/sfqUiHDl0JdGmJqGr+XxYI
	 Qy8ATBFUB5i3A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92632EF36FB;
	Mon,  9 Mar 2026 08:03:46 +0000 (UTC)
From: Simon Baatz via B4 Relay <devnull+gmbnomis.gmail.com@kernel.org>
Date: Mon, 09 Mar 2026 09:02:30 +0100
Subject: [PATCH net-next v3 5/6] selftests/net: packetdrill: add
 tcp_rcv_wnd_shrink_allowed.pkt
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-5-4c7f96b1ec69@gmail.com>
References: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-0-4c7f96b1ec69@gmail.com>
In-Reply-To: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-0-4c7f96b1ec69@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 David Ahern <dsahern@kernel.org>, Jon Maloy <jmaloy@redhat.com>, 
 Jason Xing <kerneljasonxing@gmail.com>, mfreemon@cloudflare.com, 
 Shuah Khan <shuah@kernel.org>, Stefano Brivio <sbrivio@redhat.com>, 
 Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 mptcp@lists.linux.dev, Simon Baatz <gmbnomis@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773043425; l=1920;
 i=gmbnomis@gmail.com; s=20260220; h=from:subject:message-id;
 bh=arhqPRPG3bbk8HOp2tIbu0W9lKz7uQEcs1MV+6YcVmE=;
 b=6U+j8jI9mgxnmmfYsnaaiZNjL8QRLggJ1951sCepfaA2tkHuxov6XCT4OHnCKQWsWXDnqejCy
 +lRkxVzNpKNCPod8a/Qokehmuhh9tjMcUe9QmnSmEI2sAX04fEQMQU8
X-Developer-Key: i=gmbnomis@gmail.com; a=ed25519;
 pk=T/JIz/6F5bf1uQJr69lmyi7czVG+F9TVZ/8x5z9Wtqw=
X-Endpoint-Received: by B4 Relay for gmbnomis@gmail.com/20260220 with
 auth_id=641
X-Original-From: Simon Baatz <gmbnomis@gmail.com>
Reply-To: gmbnomis@gmail.com

From: Simon Baatz <gmbnomis@gmail.com>

This test verifies the sequence number checks using the maximum
advertised window sequence number when net.ipv4.tcp_shrink_window
is enabled.

Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
---
 .../net/packetdrill/tcp_rcv_wnd_shrink_allowed.pkt | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/net/packetdrill/tcp_rcv_wnd_shrink_allowed.pkt b/tools/testing/selftests/net/packetdrill/tcp_rcv_wnd_shrink_allowed.pkt
new file mode 100644
index 0000000000000000000000000000000000000000..6af0e0eb183a0d2fa474c304d969ce6ddeb2a1e1
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_rcv_wnd_shrink_allowed.pkt
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+
+--mss=1000
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_shrink_window=1
+sysctl -q net.ipv4.tcp_rmem="4096 32768 $((32*1024*1024))"`
+
+   0 `nstat -n`
+
+// Establish a connection.
+  +0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+  +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+  +0 bind(3, ..., ...) = 0
+  +0 listen(3, 1) = 0
+
+  +0 < S 0:0(0) win 32792 <mss 1000,nop,wscale 7>
+  +0 > S. 0:0(0) ack 1 <mss 1460,nop,wscale 10>
+  +0 < . 1:1(0) ack 1 win 257
+
+  +0 accept(3, ..., ...) = 4
+
+  +0 < P. 1:10001(10000) ack 1 win 257
+   * > .  1:1(0) ack 10001 win 15
+
+  +0 < P. 10001:11024(1023) ack 1 win 257
+   * > .  1:1(0) ack 11024 win 13
+
+// Max window seq advertised 10001 + 15*1024 = 25361, last advertised: 11024 + 13*1024 = 24336
+
+// Segment beyond the max window is dropped
+  +0 < P. 11024:25362(14338) ack 1 win 257
+   * > .  1:1(0) ack 11024 win 13
+
+// Segment using the max window is accepted
+  +0 < P. 11024:25361(14337) ack 1 win 257
+   * > .  1:1(0) ack 25361 win 0
+
+// Check LINUX_MIB_BEYOND_WINDOW has been incremented once
+  +0 `nstat | grep TcpExtBeyondWindow | grep -q " 1 "`

-- 
2.53.0



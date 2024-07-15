Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCE83B7A8
	for <mptcp@lists.linux.dev>; Mon, 15 Jul 2024 19:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721070618; cv=none; b=qXnUXXR/4pC3+4GY3iYKYuM3NZ94XOT7kDPLdAg4z0CRsugDrh5ciN5onJ4ZuIhTe3+I23KRD57cq6E6Wd/+S7QBKhU3EZHp+Vjxi17BRWgLPMBbKJXNVdSJa4EareOkVur7JxLxORqB5P9zCG5kst43OKs/D63/5InQtTw3a8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721070618; c=relaxed/simple;
	bh=v1/YMU24+cCPnSD9irYUpAfHM9Z4xgUAPTe4+spP350=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=n4gIxr9S/ZIVry8X3bZcRu5yqld3tWlQAEz0AYD7PM+i6OcMeP+iw3wVXJsJee8VpKu0grEL+jdvDPxLgw/2I18J5Jt5YQAcOditBlwUnsuetYOL1lXy21lFVfeUEe6Qjz5Vb8Dj4UE6+RujvUfYIfFUdaLm9s/PJtznEVosPOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5taSOZ7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5taSOZ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A0E8C32782;
	Mon, 15 Jul 2024 19:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721070618;
	bh=v1/YMU24+cCPnSD9irYUpAfHM9Z4xgUAPTe4+spP350=;
	h=From:Date:Subject:To:Cc:From;
	b=N5taSOZ7PHhmKO1zai930KlD3kqYFEI/83moP/DZYh0TKjUw6SQpBemqMGwCHzpaS
	 brBDmGhbKSVdEikMu7t1aX/8dDCPlLChZn0QeHpPBQcybKjsJ6w0ijgJe9ZFUZTe2Y
	 X/SSjBd3UqNtsgocxv7ciAIVt+15vgX7McUJ8SAf2lVBnMx7WgK7VPGbu35c6bvItj
	 683l1L8Q7AcHb2epfATfkqJ2tUTbkFB13W6jqXOMCnTgoeoAsRQk3DZnzYE+uljJyN
	 yUZWRpGp8BAtV+pg4Kg+lhECA+/lPEHqtu4tYLM6jqrHPySEuhCb+EPgfrpwcM0SV1
	 FP7Vqmmjv0rKg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 15 Jul 2024 21:09:57 +0200
Subject: [PATCH RFC mptcp-next fixes] mptcp: process MP_JOIN's 4th ACK
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-mptcp-process-4th-ack-mpj-v1-1-d44fc90245e2@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAR0lWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDc0NT3dyCkuQC3YKi/OTU4mJdk5IM3cTkbKBolm6aqYFFkqlBiomBmYU
 SUH9BUWpaZgXY7GilIDdnBYjWvNSKEgWIRGxtLQBxj0jDgQAAAA==
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2879; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=v1/YMU24+cCPnSD9irYUpAfHM9Z4xgUAPTe4+spP350=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmlXQYIdo0WSjMsO0Xx0oMQbXHz++qgvHJXa1+i
 Wf+RNGxQ9SJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZpV0GAAKCRD2t4JPQmmg
 c895EAC+jx/UmqB/haX0Zba2SGA2UTwdU/mRgANnP88+5UVIpB6c71a3ruNU8pgfYnYUq9FlW/Z
 88mWrwbcRxe7X5hLQAKqL8ch6bBiz16cgN+T0dlyLvBd6JmfMBwX6kGv9m5DexekEy6g7DhdoBQ
 caqLopLr0quEAC+841/8XES54Q3jnJTbaqFvwhyO1pr1C03A/b4oXRmAgo/IByvNRCiBEP0VD4D
 kLAKXtLFCrrgxtq1z+68MkzEJSlk2013ZJu2XW7pzswU5HimexL7CNz53kWJkgA+FiXLog2dl1i
 /r1Vka/l58pPLNzhtIN547FsoX/WzFQWtsx4gkM7SeK8JMHYW4QGRZWyOZq12X0zKLZacp5sCDv
 6XPfssOQHXnk97VDKRkJXC51G9If4W08Ln1vRFRHmoy/MJ8oUpMaw3YOvNO6oyWLqO+2YR8tGPB
 rVwo1crvc94WfahTpvNyjIcsDEKq6jWG1Vt2kxV9PzQbQLap/oTBte6qk0ncbAWqjJsGuD/JdBj
 qCqJJj1KiBS23oVA4/8ou9a1/2Qu54fWqVsGzwMMil+SIeYoqfA5nBMD1+MBDk7YOjtpsvKgMqD
 J+vy3632lSUydEbiX1mJdcb+1ef99zEQfqZNGgaQQqDiEqMSYPx9T8oPQFrrRD7schw1txjvKH0
 Yxn8VglK4v1pjaA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The 'Fixes' commit recently changed the behaviour for MPTCP Join
requests for listening sockets: when receiving the 3rd ACK of a request
adding a new path (MP_JOIN), sk->sk_socket will be set, and point to the
MPTCP sock that has been created when the MPTCP connection got created
before with the first path. The newly added 'goto' will then skip the
process of the segment text (step 7) and not go through tcp_data_queue()
where the MPTCP options are validated, and some actions are triggered,
e.g. sending the MPJ 4th ACK [1].

This doesn't fully break MPTCP, mainly the 4th MPJ ACK that will be
delayed, but it looks like it affects the MPTFO feature as well --
probably in case of retransmissions I suppose -- and being the reason
why the selftests started to be unstable the last few days [2].

TODO: it is not clear to me if we need to fix something for MPTCP. The
following packetdrill test doesn't seem to be failing with the following
patch, we can see a fallback to TCP, which seems OK in this case, no?

  `../common/defaults.sh`

   0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_MPTCP) = 3
  +0 connect(3, ..., ...) = -1 EINPROGRESS (Operation now in progress)

  +0 > S  0:0(0)                 <mss 1460, sackOK, TS val 100 ecr 0,   nop, wscale 8, mpcapable v1 flags[flag_h] nokey>
  +0 < S  0:0(0) win 1000        <mss 1460, sackOK, TS val 407 ecr 0,   nop, wscale 8, mpcapable v1 flags[flag_h] nokey>
  +0 > S. 0:0(0) ack 1           <mss 1460, sackOK, TS val 330 ecr 0,   nop, wscale 8, mpcapable v1 flags[flag_h] nokey>
  +0 < S. 0:0(0) ack 1 win 65535 <mss 1460, sackOK, TS val 700 ecr 100, nop, wscale 8, mpcapable v1 flags[flag_h] key[skey=2]>

  +0 write(3, ..., 100) = 100
  +0 >  . 1:1(0)     ack 1 <nop, nop, TS val 845707014 ecr 700, nop, nop, sack 0:1>
  +0 > P. 1:101(100) ack 1 <nop, nop, TS val 845958933 ecr 700>

Link: https://datatracker.ietf.org/doc/html/rfc8684#fig_tokens [1]
Link: https://netdev.bots.linux.dev/contest.html?executor=vmksft-mptcp-dbg&test=mptcp-connect-sh [2]
Fixes: 23e89e8ee7be ("tcp: Don't drop SYN+ACK for simultaneous connect().")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/ipv4/tcp_input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index ff9ab3d01ced..ff981d7776c3 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6820,7 +6820,7 @@ tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 		if (sk->sk_shutdown & SEND_SHUTDOWN)
 			tcp_shutdown(sk, SEND_SHUTDOWN);
 
-		if (sk->sk_socket)
+		if (sk->sk_socket && !sk_is_mptcp(sk))
 			goto consume;
 		break;
 

---
base-commit: 6cad12b229c1b550b9be002f364632fd0f120b24
change-id: 20240715-mptcp-process-4th-ack-mpj-f508b50d4068

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


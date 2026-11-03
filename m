Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793676626;
	b=kG+LafvEyaiAvCla+mz7noo/8ppFx1Osjqf1hoD95/qRI6iBAovbuOG0N6gN1VGIM886
	 EBIDrhhBB61RiMR58HLVGvm3loXeUWn4PRkEkUFDgnMj0vF4d/3cJ0k/Qci05e3vuuZsn
	 q3w+90Zp5OFJXUWhyhcnXiLoRWo1bJeZcBJcZjZ9lBzhbJnRb084a7M7G/Rl3cFcJt4RS
	 MGSm9YVtQs60B5h3wNJmFGBQBtcJdDvnoY6Y+2c+5bn1nHk3cmCh1frMPv4msygeYaPDD
	 suglTmjhFK7NMucg6WY9gzdq3SRnjlDmvJLY0Assf+3OAZ1l9G83NY24hvCWTUjM+0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793676626;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=tmoAdzwj29KU6V05GPs/kWh7gb1ozKF2dUQMQmJSD8E=;
	b=byHpSQAqBbByzeKKKpyV+CWYhrJfOzzCc0Hp7vyHKhLrDaoVkf64r2EBRmnVh1paeazK
	 25L4JlNDIPA2shjLtfMYBJQCZb2eNNGrFidEHAwqdl3lyUm2xU+kWtaf5u/zWaZtylcyg
	 9FaqVjsZp+Wh6OY90HBFszJSwlIoEkEI5NYX4NOmJL1DhDgctHy71TI4FKFG6o/VXc7F0
	 UStH3AyrSZPx/5rFSpcMDKO51FFGRqPpc/ArA/OdbKXR2eC5E5dy2cdWYPvsy6r9J4GS8
	 lVz6nRYqOKg6zHtg+YFrJc6qYK2+bqzqHdaSx2Oipz+sPgIJst6w4Tryn4ZoB3MVmbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fkYXcMWS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEACB606A33E
	for <mptcp@lists.linux.dev>; Tue,  3 Nov 2026 03:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fkYXcMWS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841AF1F00A02;
	Tue,  3 Nov 2026 03:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793676625;
	bh=tmoAdzwj29KU6V05GPs/kWh7gb1ozKF2dUQMQmJSD8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fkYXcMWSmThguSL95bu78V1lqoBOWnr03DWDwlhKdFGpxIwl12QWqM2xQ33/Qo2cO
	 x54bB5n6V/titdiMrw+wk4tZR3elNWANc0rXD15JY+mpHIZpQ9NwZN7jlv0+5cIhJ8
	 9RtGRMZ5aD+r8wC5/ymgmo484DxWWnFxgkBJcU3KORzECy64ttXiZmL2zKbQ3NIwPC
	 PEd+u/Pdrn7J4n2zMTO36JSntBMnYPxMGrqSXfQcGhogxu587Hy0PkKkB0p/HJhujs
	 UmruI8VAqj2stUFB/PQjgrOJmj6X9AP5EWG33LsGYxEYK7BKOpjtpuQcD+gO+dQwnt
	 3Fk1jXkpWQE0Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 3/7] selftests: mptcp: connect: check TFO SIOCINQ overflow
Date: Tue,  3 Nov 2026 11:29:52 +0800
Message-ID: <b56df4ffba6a0af45ccda5d6be2da1d74acad265.1793676064.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793676064.git.tanggeliang@kylinos.cn>
References: <cover.1793676064.git.tanggeliang@kylinos.cn>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add a check in mptcp_connect's server mode to detect TFO SIOCINQ overflow.
When a TFO connection is accepted, wait for data to arrive using poll(),
then check if SIOCINQ returns INT_MAX. This detects the overflow bug
where mptcp_inq_hint() incorrectly returns INT_MAX for TFO connections
due to map_seq sign extension issues.

The check is performed immediately after accept() and before opening
cfg_input, ensuring we catch the overflow in the initial TFO state.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 178d98d91fea..b12afca2ce30 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -1207,6 +1207,21 @@ int main_loop_s(int listensock)
 		check_sockaddr(pf, &ss, salen);
 		check_getpeername(remotesock, &ss, salen);
 
+		if (cfg_sockopt_types.mptfo) {
+			int avail;
+
+			/* Wait for TFO data to arrive */
+			polls.fd = remotesock;
+			polls.events = POLLIN;
+			poll(&polls, 1, 1000);
+			if (ioctl(remotesock, SIOCINQ, &avail) == 0 &&
+			    avail == INT_MAX) {
+				fprintf(stderr, "TFO SIOCINQ overflow\n");
+				close(remotesock);
+				return 1;
+			}
+		}
+
 		if (cfg_input) {
 			fd = open(cfg_input, O_RDONLY);
 			if (fd < 0)
-- 
2.55.0


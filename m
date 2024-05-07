Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AAF3EA68
	for <mptcp@lists.linux.dev>; Tue,  7 May 2024 03:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715053600; cv=none; b=ZF6WJ9XSt9OKcPWWnIEGd+yBAGOIqO1pqDn0zOvYI0Id5/BINvx5Od7Lo/vpzJkXczpECIE9gTT8H+YPKYt55X4K1VzvftzSs8dwsIIe3vy4HnIZbLwcHHm9AloDt4ET1Lue3XmBxthBhaJTRE+Sxt2mRywGPD9pCuV6cQjU+Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715053600; c=relaxed/simple;
	bh=g+Er0AdLMsQcgks1R5iTIY7vyyW4SVJ1sPNccj9Y9Ac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rY3TWl8UhAx6eycWw66HIzO3xX6pQrjgUTgfm3GeTz3ZEZrXeJxTgTylu0jO118WWSkQ+qMxCBDGgy9VphY8Qls6eq8KNxtXevUxdxsax1Lcxg1IMwX0gPfyJCcS/FEbWj93N3CfPFsduh2y6N1gHeeJw+iKeWSF6VhrBO1VwT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItK7eAW3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItK7eAW3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9170BC2BBFC;
	Tue,  7 May 2024 03:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715053599;
	bh=g+Er0AdLMsQcgks1R5iTIY7vyyW4SVJ1sPNccj9Y9Ac=;
	h=From:To:Cc:Subject:Date:From;
	b=ItK7eAW3OnvSPxRetpahxWUa1bUuZZkqCPjqBh6sN8S7tRZw2i2VBF5hR3AxgfDDQ
	 Vv/u1krxrnhGpa30iiNG5oOefeSwSDry2SJHJEd8B4MznOW3pIzW0sT59FW0SNsAS5
	 duA7NP7L7qlnOGoaMgwuF4S79M8nOPf+tZmj31pU+rLEo1GelnnCye88rwZ8AYInJA
	 t+qjBmuwcln6h6ly2wQ6aOGZUgLXJWm+LjojltnUmSFa5Y4T4QpnqM+Yvcdc8lnWhM
	 2xIC95AUHg1m1MCZ/OQCyi2w3g8M0F05qrknhZVCBNR/9Q5Wq10On9gWUl+EYIEx0B
	 mit3iDqNJk0Aw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: martin.lau@kernel.org,
	Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net v2] mptcp: fix the default value of scaling_ratio
Date: Tue,  7 May 2024 11:46:31 +0800
Message-ID: <0ccc1c26d27d6ee7be22806a97983d37c6ca548c.1715053270.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

BPF tests fail sometimes with "bytes != total_bytes" errors:

 test_default:PASS:sched_init:default 0 nsec
 send_data:PASS:pthread_create 0 nsec
 send_data:FAIL:recv 936000 != 10485760 nr_recv:-1 errno:11
 default: 3041 ms
 server:FAIL:send 7579500 != 10485760 nr_sent:-1 errno:11
 send_data:FAIL:pthread_join thread_ret:-11 test_default:PASS: \
				has_bytes_sent addr_1 0 nsec
 test_default:PASS:has_bytes_sent addr_2 0 nsec
 close_netns:PASS:setns 0 nsec

In this case mptcp_recvmsg() gets EAGAIN errors. This issue introduces
by commit b8dc6d6ce931 ("mptcp: fix rcv buffer auto-tuning"). The default
value of scaling_ratio should be TCP_DEFAULT_SCALING_RATIO, not U8_MAX.

Fixes: b8dc6d6ce931 ("mptcp: fix rcv buffer auto-tuning")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/487
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
v2:
 - I finally found the root cause of this issue.
 - cc Martin too.
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 579031c60937..d00cd21e8d3f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1981,9 +1981,9 @@ static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
  */
 static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 {
+	u8 scaling_ratio = TCP_DEFAULT_SCALING_RATIO;
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
-	u8 scaling_ratio = U8_MAX;
 	u32 time, advmss = 1;
 	u64 rtt_us, mstamp;
 
-- 
2.43.0


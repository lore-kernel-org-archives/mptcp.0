Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716783E47E
	for <mptcp@lists.linux.dev>; Thu,  2 May 2024 12:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714654719; cv=none; b=j62X4TENNPLbOEljOYaWiiA/i6OJBbfLD6HEWMtQ15WFGTo2B0+buGKhBsWhfntQmOW0ydUNtD+QJIm7JzVfuxbVie8SA6G1UEPBjeT8hT6SLL0iGYoICYkJSPI53sXITMFcTy32HhH32mDB0D/+Nxob71pC4FzTmscfxugFDI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714654719; c=relaxed/simple;
	bh=DyhC5++8zh72kmX2GwppWC95UEZPF4Mu4tPpDnsGmEU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B3flD8wHMs0wHnc18BLgabn/ZJ/3s6B6lBAHWTiBGvgUF6lm923Us93a8XppVAGaVVjboN59Zv6qxXGdGrjMCFttzGImUkE//XmrWz4akSEHEC6zAgQNn9VMh7dvrUrbztV34ymBxKmT68MqMGXpSd0nBXAjqixMWxN4/8zC/Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQn7/FP4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQn7/FP4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40711C4AF18;
	Thu,  2 May 2024 12:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714654719;
	bh=DyhC5++8zh72kmX2GwppWC95UEZPF4Mu4tPpDnsGmEU=;
	h=From:To:Cc:Subject:Date:From;
	b=hQn7/FP4GDZSqXH9TgGZu+Xse9R9m968k0SFw+gbodVyJa8Pcqea9VXElWjrCc6WB
	 1v5dyzBKQSCnFS467bB9x+5XGzTAGNwgIYT/rivReAc7mDQZ086aSyT7H+wVC4Wwbu
	 56txirQqNm5elIJ/X79DbvLcMn27TWWIMKUKBi5Aed+k4FfTZ9TVH2Wk2LlF4LzyDO
	 6YhYyiD9P+hQAAqqokNXeJKglxTu0y4Evpb7j6czisWS5jJbvZ0snODhLdl0ncTJfo
	 EZhg+ww7caBWbOkUYw7QTzYmoKlID6oosISPYbaDhaASLamylzuY2yEZVfGg4vxCJ1
	 41/UGoeyDYJmQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net] mptcp: fix EAGAIN errors in MPTCP BPF tests
Date: Thu,  2 May 2024 20:57:54 +0800
Message-ID: <4538e7bca21fdb7f997c026d74f886aedb547d39.1714654631.git.tanggeliang@kylinos.cn>
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

In this case mptcp_recvmsg gets EAGAIN errors. This issue introduces
by commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale").
This patch fixes it by adding sk_is_mptcp() check defore update
scaling_ratio in tcp_measure_rcv_mss(). Do not update scaling_ratio if
this is a MPTCP socket.

Fixes: dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/487
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/ipv4/tcp_input.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index ad8fa129fcfe..39237d6713ee 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -235,8 +235,10 @@ static void tcp_measure_rcv_mss(struct sock *sk, const struct sk_buff *skb)
 		/* Note: divides are still a bit expensive.
 		 * For the moment, only adjust scaling_ratio
 		 * when we update icsk_ack.rcv_mss.
+		 *
+		 * This breaks MPTCP BPF tests, skip it.
 		 */
-		if (unlikely(len != icsk->icsk_ack.rcv_mss)) {
+		if (unlikely(len != icsk->icsk_ack.rcv_mss && !sk_is_mptcp(sk))) {
 			u64 val = (u64)skb->len << TCP_RMEM_TO_WIN_SCALE;
 
 			do_div(val, skb->truesize);
-- 
2.43.0


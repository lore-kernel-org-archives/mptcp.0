Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36762219A65
	for <mptcp@lists.linux.dev>; Thu,  9 Jan 2025 13:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736429842; cv=none; b=Iw3OCcNUZuawG9FWx+ODPGShE33wHEIU78KlPwDjJi5OYROwCFzdOQqvytaoD0lBErtz5WXhfYQCE4ucv3HgM9WORTg5uUSqCHvLW8o54hOkxz8JiHvqmod2RBud5p83zqGqWxtHmB6qJ3KvDevX781epTZxRayo29QszjBFyUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736429842; c=relaxed/simple;
	bh=2WYEwCTss8IgkXwkP3iYLiWEWpLaLvJruKuGXe1mZRg=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=o9Oafz53gC2FlOAv1AfrguV2vnNDhX5oOrRLbhsoecDhWHFHxU2QTvnR3Wn05SYS+dKudFaIoM+X5H6kA29PwzBxHJzyMcYnJlt6mWyyQI/fDqMj7YjBLQe84USfuuSFFMUur8f1vVs91CW9g6PVfvMCrQ+qo7QRPpxOlR5ACio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=fsCpYvPH; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="fsCpYvPH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1736429532;
	bh=l+gd8rFXgSbheS046NCPtUqsQ+eGPlT8tsTk0+Ua+wo=;
	h=From:To:Cc:Subject:Date;
	b=fsCpYvPHM3RTjuBW21Cw3j+CUsnDpYZUjW4DU/3tlu9abHdQyjcwfTfF4uuOw/617
	 JFMg60cMvvC8cfMRQZ19O6VZq4dECqhg3YgyL+a9atqjaxANUtA/C9ZeSn2dH80KRQ
	 dFx581hsdsCdd2i00wrb63M7jF6ys6MKUCr9sgXY=
Received: from localhost.localdomain ([39.156.73.13])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 8099B655; Thu, 09 Jan 2025 21:32:09 +0800
X-QQ-mid: xmsmtpt1736429529ts9isz3u2
Message-ID: <tencent_28A52E260A59791DE3E6C44846805D812005@qq.com>
X-QQ-XMAILINFO: M/NR0wiIuy70cFDaHXkOliMT8eIjO0WXqk3Xyc1anHkiromAB2KchAEtCzXXpS
	 WIB1AkmvM4UlJBmbgRCR+EqEzXobmgJIX7U/7flXzjtCgsq0+g+FSYOui5ZCtpv5HPz3MTYlPXoE
	 hXAU1kMBXnhaHDJzjawxgcYKKuVjpLX3weJuGCA4qi5oV2xPbEaHU/p8nbVeqsoj4qEfOp2D69VI
	 zF1Vj/usmPuFP93PZM/BFKWrpYhW5RatmkAvJ5tBDjAc22fAuw87/B+qmFyj/Tp3XGAPF9fFLQws
	 f7YZhogViN6VxDBpLPgq9VCCpNb7IokWsvOrGENvBG8cmTn7UKGnMv0VA/2qbsheNNM1mxv0zGHl
	 q1Bdl/huhwq2N5jXt//xM2v8CEv1Ebom5n+A92HD4aklAJ26DGdCCiFK062FoUump2+Bp7VVkYvR
	 xcWXMV1G/RyupSSrviGE0GVe1IieXZybbqcbrc+aMjRLhGVGDojDktxLTBU7uOiWVfwKSDKm2JXn
	 FVbwvKFD50DDM4YpR4f8EMXVjIJjx2pSj/QAkolYkkB8C1cbZJQmhUQBZ7jKFx9g+aHULUzuyTW8
	 Q1hrefHaQBVdwV77/zWNCX9bNjIX3EfD+5UHX1yYGKGvwPb7+mfOoGJ8gB6AsFhjLYWLUj/csFc5
	 sdCU1dNl66eIsqJkH3Cu7WogiUs6AAaBTXxCZc9UMRjMpCkghQXWMwG73NoByfnDBDbzX7Efmoap
	 6SBmqzBUHcO5wkdlvMH3+toq90ZH1ykijg7JI/n6XAA96FckGIml3EqVEU/H/8P5G/f8AMTt5cfg
	 xClcAK+m6/eeTiIAwcT8hhRcQExBWcD+qp4Qt2IzERWKYTuPMCxUeg++1n+eL4VxLr3gEjCUpokS
	 CPr0GCKA9gb/k6w1vDQh1qTfoBJp5ngWKY21qmzC6m8chz+O0g+/eJ4v3lZYI6eRcH9q2eTC5oMa
	 X52zHAGspVUKaa8u8ZhmelMc/c9KBGQIvCStNVRW4=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Gang Yan <gang_yan@foxmail.com>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>
Cc: Gang Yan <yangang@kylinos.cn>,
	mptcp@lists.linux.dev
Subject: [PATCH 1/3] mptcp: fix invalid addr occupy 'add_addr_accepted'
Date: Thu,  9 Jan 2025 21:32:07 +0800
X-OQ-MSGID: <20250109133207.220361-1-gang_yan@foxmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gang Yan <yangang@kylinos.cn>

This patch fixes an issue where an invalid address is announced
as a signal, the 'add_addr_accepted' is incorrectly added twice.
If reach the limits, even the invalid connection is removed from
conn_list by mptcp_worker, the variable is not updated, so the
available address can not be added.

When 'ADD_ADDR' adds an invalid address in the LAN, it will trigger
the 'tcp_done_with_error' at the TCP level due to 'icmp_unreach'.
At this point, 'RETRANS_ADDR' will increment 'add_addr_accepted' again.
This patch is also helpful for issue#498.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/498
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/mptcp/pm_netlink.c | 25 +++++++++++++++++++++++++
 net/mptcp/protocol.c   |  3 +++
 net/mptcp/protocol.h   |  2 ++
 3 files changed, 30 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 618289aac0ab..63b5c1d6d87a 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -958,6 +958,31 @@ void mptcp_pm_nl_work(struct mptcp_sock *msk)
 	spin_unlock_bh(&msk->pm.lock);
 }
 
+void mptcp_pm_subflow_closed_external(struct mptcp_sock *msk,
+				      struct mptcp_subflow_context *subflow)
+{
+	u8 remote_id = READ_ONCE(subflow->remote_id);
+	s16 local_id = READ_ONCE(subflow->local_id);
+	struct mptcp_subflow_context *iter;
+
+	if (!subflow->request_join || !remote_id)
+		return;
+
+	mptcp_for_each_subflow(msk, iter) {
+		u8 iter_rmtid = READ_ONCE(iter->remote_id);
+		s16 iter_locid = READ_ONCE(iter->local_id);
+
+		if (remote_id == iter_rmtid && iter->request_join &&
+		    local_id != iter_locid)
+			return;
+	}
+
+	spin_lock_bh(&msk->pm.lock);
+	if (--msk->pm.add_addr_accepted < mptcp_pm_get_add_addr_accept_max(msk))
+		WRITE_ONCE(msk->pm.accept_addr, true);
+	spin_unlock_bh(&msk->pm.lock);
+}
+
 static bool address_use_port(struct mptcp_pm_addr_entry *entry)
 {
 	return (entry->flags &
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 21bc3586c33e..93c832d7feed 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2569,6 +2569,9 @@ static void __mptcp_close_subflow(struct sock *sk)
 			continue;
 
 		mptcp_close_ssk(sk, ssk, subflow);
+
+		if (mptcp_pm_is_kernel(msk))
+			mptcp_pm_subflow_closed_external(msk, subflow);
 	}
 
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b4c72a73594f..2923a8cafd91 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1148,6 +1148,8 @@ unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_local_addr_max(const struct mptcp_sock *msk);
+void mptcp_pm_subflow_closed_external(struct mptcp_sock *msk,
+				      struct mptcp_subflow_context *closed_subflow);
 
 /* called under PM lock */
 static inline void __mptcp_pm_close_subflow(struct mptcp_sock *msk)
-- 
2.25.1


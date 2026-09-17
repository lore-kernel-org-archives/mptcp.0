Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038CC519929
	for <mptcp@lists.linux.dev>; Thu, 17 Sep 2026 13:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789650829; cv=none; b=btbOMhWz+7hhFhacJCt5oj5bBvNNQSSMqIkHx7qpJlaG/CFy7ewS87aCoV6K7RpjMEhm/cG7RnPnJatuOaK3PCEuvmIJxZhdl9GatjcBEpbGHrm98KOgOn4ikxJlHaZ796bVWExh96nBuMCcVrp78/bm7cgUDjihX7ANoRH5EbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789650829; c=relaxed/simple;
	bh=DzrEyVcKMyjq/tvzTTERvzhiOd55bZGNzar2McnYtP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DEpBr3Pk0t1M3CBB/hvgBqVWFctvA6ZrLha9nK59glQKBM0m3rrJPidyQOzdMiLxP6Wu7VrqcG8INtGTJMdtl9m5WkNfbYI56GeurN9U2LuDbmHa0IcRaZ0V4YBo5n0k8MYcys7T+xtwN6JB70afTkqhjB83ZGlnK27acGFXCbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iod4yM09; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iod4yM09"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 534051F00893;
	Thu, 17 Sep 2026 13:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789650827;
	bh=wElvJ+VyxZWxC8zR3Di2mY1vJgC+FIqxiOB/ApQUYTQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Iod4yM09zCim7IE9sddzgGCJCYK59jYSsVkNAcDESpuirYV7fvHby2tneuo/shOWe
	 fHVvF2AuJ5tL8o/M8DeqBOYeqHUSzmAlhG8gAqFtBUjzAj1m2HGjj0Wr0rvyewFeFA
	 9NmaFooc5Zg+sT0BxI5NZ6rrc7LCV0UNtO/Wb4RoIpW1qIBgdyD/YRpohr2mmzO0ju
	 wUDk6IadvKL9PkCOvwxjvFToJfiiqtRhTeu1WVXoYkCi+9/9arvmS3/pAMpN2piTFB
	 3YgamkO2mh8V8hyByyZWUvwvHPR1fFxriDGZqpjacmssreK4uFeMGAEuObd/PxOQnB
	 p6RjvEeBfoijg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 17 Sep 2026 15:13:13 +0200
Subject: [PATCH mptcp-next 1/2] Squash-to: "mptcp: avoid unneeded actions
 on subflow reset"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-mptcp-fixes-7-3-rc4-v2-v1-1-1553391e7815@kernel.org>
References: <20260917-mptcp-fixes-7-3-rc4-v2-v1-0-1553391e7815@kernel.org>
In-Reply-To: <20260917-mptcp-fixes-7-3-rc4-v2-v1-0-1553391e7815@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1881; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Ud2xCl2QFZRzZC5Jx0DPitJO/yDdabweUCvsRkOUkeY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJWP+/4Kp5m9ScqICHpVfBVBs3OlfGrVv01uLj8iHXwy
 hrnhGMOHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABMpVmP4X7QjdvrfXY4F5x3m
 arEvLqn06zWU+WFvtrJyfXCVidftzQz/fa2ib0Vacd/6ZH3cuqpiq5KA5Zt695ZnF37G96r+6j7
 BAgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

explicitly flush the rx queue on reset, to please sashiko;

the changelog last paragraph become:

"""
Add a new flag instead of using an existing one like 'closing', to exit
early in subflow_state_change(), and explicitly flush the RX queue at
reset time.

This avoids unneeded processing to check for available data -- calling
get_mapping_status() and more on a dying subflow -- but also in error
reporting and worker scheduling.

Note that we must consume the currently peeked skb before invoking
mptcp_dss_corruption to avoid consuming it again after the eventual
reset has freed it.
"""

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 4 ++--
 net/mptcp/subflow.c  | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 296cf52d198c..01e37bfe4b7d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -857,12 +857,12 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 				mptcp_dss_corruption(msk, ssk);
 			}
 		} else {
+			sk_eat_skb(ssk, skb);
+
 			if (unlikely(!fin)) {
 				DEBUG_NET_WARN_ON_ONCE(1);
 				mptcp_dss_corruption(msk, ssk);
 			}
-
-			sk_eat_skb(ssk, skb);
 		}
 
 		WRITE_ONCE(tp->copied_seq, seq);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index c727e937f265..14aa82647c3d 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -440,6 +440,9 @@ void mptcp_subflow_reset(struct sock *ssk)
 	sock_hold(sk);
 
 	subflow->resetting = 1;
+
+	/* No need to delay the actual close for to-be discarded data. */
+	__skb_queue_purge(&ssk->sk_receive_queue);
 	mptcp_send_active_reset_reason(ssk);
 	tcp_done(ssk);
 	if (!test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &mptcp_sk(sk)->flags))

-- 
2.55.0


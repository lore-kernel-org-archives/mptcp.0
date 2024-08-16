Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B11D817
	for <mptcp@lists.linux.dev>; Fri, 16 Aug 2024 11:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806138; cv=none; b=CQsIjRuqWszbp3I3BsZAFJ9ddP6nXLK4rf86qaUEZpuhYcvSuJ6nUf3xmmBySwpuFCJNHX8OGt/V3d5RZysg6YFwkkgNIKmp7FzvcXugB8CNtTGeXWNo7b7BO/T7eDyxlxOToHd46pN7X1W+RyCZQSvPypmuGyjtLWVkSlhxC6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806138; c=relaxed/simple;
	bh=X3kingAe+MIqD04vcc6XOI2en1Bn6QN9uOtcfEzO/lM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EO8Ug5SGdF0McBWtSI2dw6Z+eLo5yMmeutjEeHhpDbRyntUNE71EEqzz1v0n2MOKyMCsLFn6az95hlqhwuoXlw8JCYwUElA2kwdyhiAkrnNlDVw+cHwOhegED0SDVhrt7HPISNBQjkrf5Krl3GD6NCPcOwdwrBW/+B+c6CockBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6usHlgE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6usHlgE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5B7C4AF0C;
	Fri, 16 Aug 2024 11:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723806138;
	bh=X3kingAe+MIqD04vcc6XOI2en1Bn6QN9uOtcfEzO/lM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=D6usHlgE5iIdT8alWH16dzOfbygJLHrWu06buf6AUmo96T/JXrGmLTHnGwClDt67I
	 8ZR+tAvdf5WB8v/ypUNJWq/i/ZUXPKnlj9Gry+cx63Vh+qBWuZAhv62CuRYByrhXLz
	 lNV4WOcFCbzMxE2R5K/JYEChBTDhZjgOL+K3QHbt639VKhAt6/Bs22mkAAf0GwHw1t
	 whGtOI+YuQ0YlI16o6CCy6JI0jwtbgXzwO/Vnp9qPEZpJa/rAwB1tvoGxzG2KHcfoI
	 8v8BDcd7To+7/YOIxud7Uo5+jg9620aiiGLggCIo738UZXnX3c+3ZJuBqCKAncHLem
	 eKL3p7QtBzJEg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 16 Aug 2024 13:02:03 +0200
Subject: [PATCH mptcp-net v2 09/12] mptcp: avoid duplicated SUB_CLOSED
 events
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-mptcp-dup-close-evt-v2-9-8a33f6617f5c@kernel.org>
References: <20240816-mptcp-dup-close-evt-v2-0-8a33f6617f5c@kernel.org>
In-Reply-To: <20240816-mptcp-dup-close-evt-v2-0-8a33f6617f5c@kernel.org>
To: mptcp@lists.linux.dev
Cc: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2613; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=X3kingAe+MIqD04vcc6XOI2en1Bn6QN9uOtcfEzO/lM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmvzGufM6qW/Q09ycZs8XdXxhIsTuB1VxBKBXwY
 aY3WhsraxSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZr8xrgAKCRD2t4JPQmmg
 c90NEACKJf41vlofx2gPegLrBHU03y4QA048B66j7Kx625ClHoOCNSAj1XXEMEoBoyoCcjUxNTj
 PG/LDVQq3fV6R2v2jHSXesj8jwOUsZ/gCn3mPn3hmnyxxxb9tIH71vRlV3JhB+qUvTztkB0RcjR
 M+XFJqN63kTCnLRkEWLzteBT0MSU5kabrXN5CJbG929FqQMiN69aE2A6sYC4FBR0DuZFBOoip91
 lmjvEadFr9BNCG0aWJ3DQG/tu6FEKzbld9eZRpWFPcRIrCUAbrdjCTPHU1WpxBInuyK0OuUNryR
 LDX7YYuRM96Qi7EKnmPeZHya6lr4zbzaPUSTpW2Txsna1A/hL78xzredPa0PPXp5JAN3zW15g7u
 nea8kznedtexUQdQFM6AECN4qdJN4cAZXwA3Lz3/FIlOo7tk/zJRpKvVeIzgJKrF9sG+beM6A13
 mFmkj/m4KjVPeS6GxUGKDHTBh2477we43hY65am8NxJ2R2X6Z6l46oHUhKrDkDZvi+d0ejlxvVv
 sPTewaZjeFHyKMIoEJ5112cPschI6y/HkccY899mUYEpwyR87UUMSd4W2SVSz4ZANyVaUpI2gXt
 l+PWo16zkoJzJSxPKZGEoDk7eDh6SblxRrI6fBG6/U4TmzOj2hSLO7METQKimQ+I7CdjlF+Jqos
 ws0VI3vVmtNb6qA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The initial subflow might have already been closed, but still in the
connection list. When the worker is instructed to close the subflows
that have been marked as closed, it might then try to close the initial
subflow again.

 A consequence of that is that the SUB_CLOSED event can be seen twice:

  # ip mptcp endpoint
  1.1.1.1 id 1 subflow dev eth0
  2.2.2.2 id 2 subflow dev eth1

  # ip mptcp monitor &
  [         CREATED] remid=0 locid=0 saddr4=1.1.1.1 daddr4=9.9.9.9
  [     ESTABLISHED] remid=0 locid=0 saddr4=1.1.1.1 daddr4=9.9.9.9
  [  SF_ESTABLISHED] remid=0 locid=2 saddr4=2.2.2.2 daddr4=9.9.9.9

  # ip mptcp endpoint delete id 1
  [       SF_CLOSED] remid=0 locid=0 saddr4=1.1.1.1 daddr4=9.9.9.9
  [       SF_CLOSED] remid=0 locid=0 saddr4=1.1.1.1 daddr4=9.9.9.9

The first one is coming from mptcp_pm_nl_rm_subflow_received(), and the
second one from __mptcp_close_subflow().

To avoid doing the post-closed processing twice, the subflow is now
marked as closed the first time.

Note that it is not enough to check if we are dealing with the first
subflow and check its sk_state: the subflow might have been reset or
closed before calling mptcp_close_ssk().

Fixes: b911c97c7dc7 ("mptcp: add netlink event support")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 6 ++++++
 net/mptcp/protocol.h | 3 ++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 13777c35496c..9d6ef94ca6ee 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2508,6 +2508,12 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		     struct mptcp_subflow_context *subflow)
 {
+	/* The first subflow can already be closed and still in the list */
+	if (subflow->closed)
+		return;
+
+	subflow->closed = true;
+
 	if (sk->sk_state == TCP_ESTABLISHED)
 		mptcp_event(MPTCP_EVENT_SUB_CLOSED, mptcp_sk(sk), ssk, GFP_KERNEL);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 22b7eff311f5..ce15e7db464b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -530,7 +530,8 @@ struct mptcp_subflow_context {
 		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
 		valid_csum_seen : 1,        /* at least one csum validated */
 		is_mptfo : 1,	    /* subflow is doing TFO */
-		__unused : 10;
+		closed : 1,	    /* has done the post-closed part */
+		__unused : 9;
 	bool	data_avail;
 	bool	scheduled;
 	u32	remote_nonce;

-- 
2.45.2


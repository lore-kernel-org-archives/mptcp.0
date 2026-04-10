Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934A630FC36
	for <mptcp@lists.linux.dev>; Fri, 10 Apr 2026 14:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775831531; cv=none; b=fvz7iqOgi0uV6fXUJP00lMQ6yfGwf2LRd9DO7uWKbksxvOjbLg2dbXpvkAtDcufzBw0wSafwCMECY/HmrdflH+ggOrWQ7Yw+AHF1qPQulY+kq5UTJHDCHcdI95+mWbB0wOhTe2jElnqSTIF4x4CPWg9r+b0cSf56DqDkYbtwECE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775831531; c=relaxed/simple;
	bh=lyCxKoLVqtnAg11scnTrNTCA/EopjmQrm2zuvMvrsdw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nWKZ+zu6kZ8iy4Iwzd44hmEkOX4Bo9M/+m3qxkjD1VrZ1iWPAaNml/amlHk68uqD57DrKVrFR8lzImfCHBWCn27VU6cTnFKnAkqVXR3TxXgRo0sJoRGFCKI+x903H28j5uH/JhlSPsja9BNESx/Y/MxkQRd/XodRaBLkN0U04Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrPymSfZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrPymSfZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 173BAC2BC9E;
	Fri, 10 Apr 2026 14:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775831531;
	bh=lyCxKoLVqtnAg11scnTrNTCA/EopjmQrm2zuvMvrsdw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nrPymSfZQ/PjbDECoII6iO0WbKrjX75i7ExJpTn/UOvhfo8Xg1p0YUkKRoyzvW5rZ
	 hEnHDU3EZOF28rSO/53+QMhcqz9QaBp/P/xiHdaAN597xGRn7oL00HOnbE9b4AbW/Q
	 KJacOs4PohUme3VND3HyZWms9LO2oUaY1oMBU9BKl2QjSOuxfttWSsJdIWv0Fg2v2b
	 jFLtnUM3ng7IutCHs5lWYOtdMR5q/gozHu4xc2MeMcitF3AxuAl0c5RSNxcNI74sse
	 XN5DKmoTjbNXmt0oJtrLdtO5KAM+lVxZQ1s7cAhrphnz7LkRLZU29zofztyk7iLPPC
	 GnuQZYgk+SNcQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 10 Apr 2026 16:31:44 +0200
Subject: [PATCH mptcp-next v2 06/17] mptcp: pm: ADD_ADDR rtx: skip inactive
 subflows
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-mptcp-inc-limits-v2-6-5402209f05d3@kernel.org>
References: <20260410-mptcp-inc-limits-v2-0-5402209f05d3@kernel.org>
In-Reply-To: <20260410-mptcp-inc-limits-v2-0-5402209f05d3@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1857; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=lyCxKoLVqtnAg11scnTrNTCA/EopjmQrm2zuvMvrsdw=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJvct75rCYzv5EvRt9i0jHFrbu7Ys9W/XHtyDlgPSWmu
 TcvN4Wxo5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCI8rgy/mDpyjmnd0F08l99z
 go+T+vPNulp5BtdU+6ZcZZnMcOhvKiNDB7P0t6+6Ajvu9+d/6JWf/Gfq+/5d9puUmesCbc+tnf2
 dDQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When looking at the maximum RTO amongst the subflows, inactive subflows
were taken into account: that includes stale ones, and the initial one
if it has been already been closed.

Unusable subflows are now simply skipped. Stale ones are used as an
alternative: if there are only stale ones, to take their maximum RTO and
avoid to eventually fallback to net.mptcp.add_addr_timeout, which is set
to 2 minutes by default.

Fixes: 30549eebc4d8 ("mptcp: make ADD_ADDR retransmission timeout adaptive")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: restore accidentally deleted icsk->icsk_rto > max check
---
 net/mptcp/pm.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index f296fa300efc..1c3376c01d70 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -305,20 +305,27 @@ static unsigned int mptcp_adjust_add_addr_timeout(struct mptcp_sock *msk)
 	const struct net *net = sock_net((struct sock *)msk);
 	unsigned int rto = mptcp_get_add_addr_timeout(net);
 	struct mptcp_subflow_context *subflow;
-	unsigned int max = 0;
+	unsigned int max = 0, max_stale = 0;
 
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		struct inet_connection_sock *icsk = inet_csk(ssk);
 
-		if (icsk->icsk_rto > max)
+		if (!__mptcp_subflow_active(subflow))
+			continue;
+
+		if (unlikely(subflow->stale)) {
+			if (icsk->icsk_rto > max_stale)
+				max_stale = icsk->icsk_rto;
+		} else if (icsk->icsk_rto > max) {
 			max = icsk->icsk_rto;
+		}
 	}
 
-	if (max && max < rto)
-		rto = max;
+	if (max)
+		return max < rto ? max : rto;
 
-	return rto;
+	return max_stale && max_stale < rto ? max_stale : rto;
 }
 
 static void mptcp_pm_add_timer(struct timer_list *timer)

-- 
2.53.0


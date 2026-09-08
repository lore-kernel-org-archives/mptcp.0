Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E865328AA;
	Tue,  8 Sep 2026 14:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788876883; cv=none; b=TPSRv8puZAtlSSUHc4WOqLqsXg09eQPop+3Rs+jFLmDJrHANfozh4rqzZ5tg9lZQyxttglHbAmok8ryT4pJC46nq9Dl0NG95LhKEWz/elf4DgusaxFLPMy74Mz5VVocNbnQjsDwbC5t1v0lb7GNw7y2nVkcKkzj+aufO42uMS54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788876883; c=relaxed/simple;
	bh=m5RufpM1iGzPPvtzkD1eeKoMvpDBVtPor9gzhjsGBTA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SxjDt2SXKTnkhPKG0whrerBZy0riHAeGlnF9sW0rQ99LxSZFV8hzikV76CfifKckRAIqSJKw/ZLmdpGGPWPi0OoImHyMSdZDqCDrihDtJV5GfwOf1EcjunHMjbC1yvWaVnpC4k3m+eWZcR2pf8+G4vUXIJlss6uJbLOOHKAPnOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a79RyTtH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a79RyTtH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B536F1F00ACF;
	Tue,  8 Sep 2026 14:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788876869;
	bh=krhneQzf+Kzuapre9jYZgnLcjei4TLyTo9eSa6exwl8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=a79RyTtHhqOg65iEaM9wJ5D1nDxKV8eCD/wRfqnHevWLFcvpo7cN6KbP0YSxOmUWy
	 +a/7JvY4jwR26hlycJl5wbegCKKdg9Hu/9Iwfz7Q4roo+xlnglXBqm4GVHt6msurSe
	 oAx5FyqeozkoD53HB2+x12Xy2imoVGFpuME7SZQlkbwqFtzMbl5rvIGp739/2IFKXI
	 p+xvUS5Vu28bPWRxWnPhLnHy0LT7x6QhLdKgzWZckzWMD6QPANxwiK1GNSrKx/RQFI
	 aK7vd7kTEM7uxX8HaM9p887xN6RPVivbeX8KwrgxzCowVGoPDRcQmDNEyB3o9zOz+g
	 DXDjgqSSMNATw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 08 Sep 2026 16:07:11 +0200
Subject: [PATCH net v2 06/15] mptcp: prevent race between disconnect() and
 rtx
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-6-df1de70348b6@kernel.org>
References: <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-0-df1de70348b6@kernel.org>
In-Reply-To: <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-0-df1de70348b6@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1509; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=o7fd5Gfi6MDOTSu1e2H4WVQGRPh7XaVrocJErKh//+8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIWSGjbrDUsdNGMOPiByfKg/Wx2rZUbNHOYD19fWVtc9
 OP1bZe6jlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIn8vMbw36l/oYFJ85ETG799
 f9m9lcP0/IMU86d/X3AkznJi8Fj5nZfhn17R0euuFye4s2vL7TkQ2HlazPNIkOHn/xscs3fHt9n
 kMQEA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

Sashiko noted that the two event can race, leading to inconsistent
status. Prevent the race using the synchronous timer stop operation.

Fixes: b29fcfb54cd7 ("mptcp: full disconnect implementation")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index be59651e708e..d611af2eb74f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3588,6 +3588,7 @@ static void mptcp_destroy_common(struct mptcp_sock *msk)
 
 static int mptcp_disconnect(struct sock *sk, int flags)
 {
+	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
 	/* We are on the fastopen error path. We can't call straight into the
@@ -3600,8 +3601,13 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	mptcp_check_listen_stop(sk);
 	mptcp_set_state(sk, TCP_CLOSE);
 
-	mptcp_stop_rtx_timer(sk);
-	mptcp_stop_tout_timer(sk);
+	/* The later subflow close can not kick again the tout timer,
+	 * as the msk is already in closed status.
+	 */
+	msk->timer_ival = icsk->icsk_rto_min;
+	sk_stop_timer_sync(sk, &sk->mptcp_retransmit_timer);
+	icsk->icsk_mtup.probe_timestamp = 0;
+	sk_stop_timer_sync(sk, &icsk->mptcp_tout_timer);
 
 	mptcp_pm_connection_closed(msk);
 

-- 
2.55.0


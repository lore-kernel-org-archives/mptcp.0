Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E77F38642A
	for <mptcp@lists.linux.dev>; Sat, 14 Mar 2026 20:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773519288; cv=none; b=JV4bJvKs7nQShWg3N5ZIrjA1IAEC3UWlTLMcxKj1qHsArv/YGmTAB/cWeynw5WNXXrU78uVmG6Cx5Fok17SDcRqn7wGl26te1myIArpyE1dFLE+gMj0UHbcsvY4xm4+SWfzrS70GNbdvRUTAwTaJn0HvYxagU6OyBRk7h8cCytM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773519288; c=relaxed/simple;
	bh=Ttxd17H5LIzMMzsw2TR13aHibCW2LBBebxMgXaknmMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s2Z0dI7YCijiDUJtKzs9m0ZV3M26hj7VK3HR0gy0YJX3Vx99q5HAoOgxX/+fcPzpNO/6LYtFve8FXKNQbAqugxI8ZCwVd4BFJv6lGqFkhTO68f9mk6dhf1IzMj3sc5qeXr+K8x0f30LZ7zUjGIogMdBM3QET7KGxummHB6/eCq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I8dk81ga; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8dk81ga"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-40946982a78so1278357fac.2
        for <mptcp@lists.linux.dev>; Sat, 14 Mar 2026 13:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773519286; x=1774124086; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMcuR3aCCM7PiXgftnIc+4nYAKR8gQqAUuswiZ7+FpY=;
        b=I8dk81gaBPAhCXtlZaTmkgxEbQ4eIXICQ9tuT9tHDc9MxvUU+ujDu7faZmShCeb1Fy
         hSjRqpDpmlTA0dH0Z7dRWzZBB2L1gSE05rUe3FNHaOYNkYijq7JNTZ9HkwpLgPWpNjwT
         WVo0C/vekFKf0b2ObXGGO8E6fG0t4jxTeEkwTjcfjSkyqiZ5+6wWggIt/7N8USy0k+/X
         o61veAY8roVSii8FdASxnnMaDGKk0g0tbhBSThIs1b01MGWL7/4HO72pO0FeCME9bE8K
         Um4+asqxB3gLhwrANYVRX4YyEHyiVbHxJK7QR7CYWAzj5LL8+k6v2DNPRWnmUKWH3H/a
         1YYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773519286; x=1774124086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zMcuR3aCCM7PiXgftnIc+4nYAKR8gQqAUuswiZ7+FpY=;
        b=NzzU9fQW3aziwXHkL4HsUumcD8reuTRTnnBX06HuuRKfKGiXCqCjb22fG+fbQDbzk8
         TKFgsPO1b7h7W4TfKoMzTGQyg1ievOgmzvIST/b0vOWUdlkgGNb00PLW5CkX8xeQPG8N
         5jTTGvrd8ExgEln3mNcqcHqUj/P0VSJJTkRL6dnvv9I+fwSV+L/jJVumirNNmxyNrJpM
         g6gGGyp7mBGEkaCsvtgKbGu9rzVdpObIfuJQhtzmkUR/+6yHEErna0Vwjax3fMu30fpH
         ehqMamc9NXWEN4Tr/+nYE2sQode9u9ooweAeOPUX8KAxulRJd9NI2LGAwExNyPngRylY
         2qSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkIrJnC9WPQ2+olVpBZavDRperudYMHi4X3p63TMHTZaErc9r0S46oW2uZbDHKKc5Fpg1PhA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwkGyRD8V6jSeXqNCwSpcrGJCuE8n5OaugThu1ZRJ9MKlR39D7e
	vH6rHBoYq9ZXB893uw3/FK9+N3WKxg1PrTv8dGTCoXGDOeNlapUVASrl
X-Gm-Gg: ATEYQzwQWmOeQ/6eTsRGYrFPAdTS9kZl8nEUurpBuhsQPH5c8H3iO5x2vAbSN5BEFO+
	p8zlM75l+Gv7old1f8JUziibix+NBITu6+jYiaffwdGZByIcpDOUArB71L0PEW2ota26XvHPsI2
	ezx5rPdeFmJLxS5dzd8yagYwqnBeR3JABc1/tcVc2bE3fX58vro43f5ZAHrX4Gwrf+LzteyIvGi
	51gjZaqO3YI6DC38CrrrWnjpc7b53iY4S9LPBFKsKT6KFRdKK0rPTOADSQSK1oz+kJ1IDwuFbQK
	9fybBOPDy5YdSg36qjEyQXf4pAqMoM0xTGHmRYyArSVB5wq2FhCmfxaRKhCcdlt5Jy39bdKX8c6
	kzB/PL4Osel4R5D2rDhole3u55qdDQBSUgUse5pK9jrur7eGX9Bu/A+LbJKpb6wa4SR/kJ13fEw
	mAM38/b2cml/3r3YhUTRmvscDI9P8fuD4+nYRamdpZ+0JAyke8YVGN9+iS54aG3Im7iqfBlxqSg
	wL6Gr8n63+a1B+Q5TexBnRN2xzHHXxljTBGxwnY
X-Received: by 2002:a05:6870:ebc9:b0:404:590:59dc with SMTP id 586e51a60fabf-417b938f328mr3924319fac.33.1773519285922;
        Sat, 14 Mar 2026 13:14:45 -0700 (PDT)
Received: from Atwell-Laptop.. (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e5e8185sm11914165fac.12.2026.03.14.13.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 13:14:45 -0700 (PDT)
From: atwellwea@gmail.com
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	ncardwell@google.com
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mptcp@lists.linux.dev,
	dsahern@kernel.org,
	horms@kernel.org,
	kuniyu@google.com,
	andrew+netdev@lunn.ch,
	willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	skhan@linuxfoundation.org,
	corbet@lwn.net,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	0x7f454c46@gmail.com
Subject: [PATCH net-next v2 03/14] tcp: refresh rcv_wnd snapshots at TCP write sites
Date: Sat, 14 Mar 2026 14:13:37 -0600
Message-ID: <20260314201348.1786972-4-atwellwea@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260314201348.1786972-1-atwellwea@gmail.com>
References: <20260314201348.1786972-1-atwellwea@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wesley Atwell <atwellwea@gmail.com>

Refresh the live rwnd snapshot whenever TCP updates tp->rcv_wnd at the
normal write sites, including child setup, tcp_select_window(), and the
initial connect-time window selection.

This keeps the live sender-visible window paired with the scaling basis
that was actually advertised.

Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
 net/ipv4/tcp_minisocks.c | 2 +-
 net/ipv4/tcp_output.c    | 8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index d350d794a959..1c02c9cd13fe 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -603,7 +603,7 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
 	newtp->rx_opt.sack_ok = ireq->sack_ok;
 	newtp->window_clamp = req->rsk_window_clamp;
 	newtp->rcv_ssthresh = req->rsk_rcv_wnd;
-	newtp->rcv_wnd = req->rsk_rcv_wnd;
+	tcp_set_rcv_wnd(newtp, req->rsk_rcv_wnd);
 	newtp->rcv_mwnd_seq = newtp->rcv_wup + req->rsk_rcv_wnd;
 	newtp->rx_opt.wscale_ok = ireq->wscale_ok;
 	if (newtp->rx_opt.wscale_ok) {
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 35c3b0ab5a0c..0b082726d7c4 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -291,7 +291,7 @@ static u16 tcp_select_window(struct sock *sk)
 	 */
 	if (unlikely(inet_csk(sk)->icsk_ack.pending & ICSK_ACK_NOMEM)) {
 		tp->pred_flags = 0;
-		tp->rcv_wnd = 0;
+		tcp_set_rcv_wnd(tp, 0);
 		tp->rcv_wup = tp->rcv_nxt;
 		tcp_update_max_rcv_wnd_seq(tp);
 		return 0;
@@ -315,7 +315,7 @@ static u16 tcp_select_window(struct sock *sk)
 		}
 	}
 
-	tp->rcv_wnd = new_win;
+	tcp_set_rcv_wnd(tp, new_win);
 	tp->rcv_wup = tp->rcv_nxt;
 	tcp_update_max_rcv_wnd_seq(tp);
 
@@ -4148,6 +4148,10 @@ static void tcp_connect_init(struct sock *sk)
 				  READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_window_scaling),
 				  &rcv_wscale,
 				  rcv_wnd);
+	/* tcp_select_initial_window() filled tp->rcv_wnd through its out-param,
+	 * so snapshot the scaling_ratio we will use for that initial rwnd.
+	 */
+	tcp_set_rcv_wnd(tp, tp->rcv_wnd);
 
 	tp->rx_opt.rcv_wscale = rcv_wscale;
 	tp->rcv_ssthresh = tp->rcv_wnd;
-- 
2.43.0


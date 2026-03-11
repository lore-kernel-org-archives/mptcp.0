Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ACA3BB9E3
	for <mptcp@lists.linux.dev>; Wed, 11 Mar 2026 07:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773215796; cv=none; b=tWejyNglhRv7bregv5o5ZOBuqENN9mQ/SzSPk6WSZ3EGv+Jk6unL4r8r79QfCVDPj3Aw3pW4ahfoShBymQUKkPY2ZyAtWynITWbuvswUYlAkWeFTpJRoeRc60OeeRgM5R65B366Wq7JbjBpvpT2mD+amAcY6//VwjZyj2QM6e6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773215796; c=relaxed/simple;
	bh=jPhrqcmDRhUMlM7YZP0Vfe8I9hineTPoN8bOhKWBAv0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t2VCKlbWtzqy1krMQ+23CP/CAkzcduvmDHUvndy8PNc0lNPxKoXVH6zQJBH00+2cPswZiS42bpgTdgYwldxCz2oECaSxPy9THmKHXnLFEGfagghNIpEU4Inm++he+xEVHZpHi+Z3jPFCjMOKIzJbpNXgmIAdPo/v5N5dzCQwmh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCiGjyK2; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCiGjyK2"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-4171451e89aso2203049fac.3
        for <mptcp@lists.linux.dev>; Wed, 11 Mar 2026 00:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773215791; x=1773820591; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wacSMrdd6YBSycXcvfypm/nD64eKKUdf2M/29BZscYc=;
        b=UCiGjyK2FObfVwM615kYaMBxn4n3EqOPJ1YPpO+e4bWYIIloM0rUv9tr3FGcnLcyaz
         s3gK+Zgc6JnsyCuSU4kgGcleuy4O/b0pUE20FDeAHANacMxleU0HbvJ2p95Xvid9Qnqi
         f12uP9UwS2pMmns3sJv+56uldD5bc6rqSuRUAjgv5sAt8rVso0bn/U7hxjV0InUPxt7a
         6qNOGf7bmWzgt0/R4U/y3vDaGsU+QWc3TDcw/6JNP2s4Ctfm02ya1AYnl/5+M9vqbu13
         NzWEhXnNP7IsFGG3f67YW0IJIJhrrSF7g/wRvR8AIoEL5i2PoUlolyhyfq5zNM6qKwry
         uifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773215791; x=1773820591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wacSMrdd6YBSycXcvfypm/nD64eKKUdf2M/29BZscYc=;
        b=rYPNEcFvFeDn1yFKh3ix0x4IX4i2dryLBZI0nwIzydkdmyQTxHTh0uT0BR0+RLUvkF
         0mo7K8TUstks6TzoJeAwnFGKQZgq0EVIY9bQol3s9eCySoJ+lRGUICvXLBUitLJYOPUk
         LiqcvStsnBnAXd71P30DMJn5O5zZmVDLWniBUe5my1WYo5PxDNT1z7HbrKrGWITR9NTi
         kuszpWOS3hYd4idYc5f5zjaAplW2pLNamEktJ+BEyqwxImiuOVVRGbZUB+GmJSGMb2vL
         7ie8jbEhOmB7eXhGkWefJXQa9q11/dMxG6k9hnVNbe6dws+vY2gTkyb0k1dL4MPQuO5w
         t2LQ==
X-Forwarded-Encrypted: i=1; AJvYcCV43sXEqVC1pU6FzmlVZhqOuTt8+pCdmGWXo4pozZe/A447fXWFhO5ObkNvaQLkB+YEKDuIyQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YySsOpekfI7T5gBkpKXObo7MUZiWkKIdlHSqPSJ72audNgb2ypB
	HfsA4H2KprPR2rgNG+NXaHlDy8wBhMvpIll7/uE8W5jpzg67Yg06LhCR
X-Gm-Gg: ATEYQzzMSA5WDnzMHoqty7OzyQ4ToyJcuLZv79gIK2leXBSq+LtbLSHaSEPBpM6xwUJ
	aFSwaP0742SdlRLrJqkA6WkuZRDmWob1X2yo92oZ0UZyLpM4jbPHhW/Armtilad/f4VIW3U5sSk
	0kiG9RZ2bg8HTLlyFFRWw/WY2R5+BiRo1CWYZxdBc2WFVkHHF2RIjkbTQ50oc3vxGfPTmOBv7BQ
	v1uKoarpQZ1J505ciSEt5dhv22AurlcvyCqoVcRBKSMnilfP0LKal0Vl2EUb6Ge6LxmHvSYd9Sn
	O+ToBSJyN0Si/Vq/UDZLaQADPGr/MzzL3UPEYii3kAuot12NEKXpZ+Wt+bF3IxYNj6ooT6/2Bba
	x8M6zSuY2bkqo8HnfminmrYPPDaUu2+ylaUr5Ok9IxVQojKF26TrnfXgT/WE/dFdBSBs5owG3HH
	FX5YPw2BNAFykDtnsvfeR7879W6GqqAFfxov6HUSVlV6z1mNSdepcshpwQBlAMxLAp+uZl4auVS
	f+YaCSMFvth0OCgpYIy3ZSkO2rDKlYM+05Q+Fnt81Hpn2vL
X-Received: by 2002:a05:6870:91cb:b0:3e8:8e56:674b with SMTP id 586e51a60fabf-4177ca09363mr1118957fac.53.1773215791030;
        Wed, 11 Mar 2026 00:56:31 -0700 (PDT)
Received: from localhost.localdomain (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e6ae0e3sm1568938fac.16.2026.03.11.00.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 00:56:30 -0700 (PDT)
From: Wesley Atwell <atwellwea@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	ncardwell@google.com,
	dsahern@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Cc: kuniyu@google.com,
	horms@kernel.org,
	geliang@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	0x7f454c46@gmail.com,
	linux-doc@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	atwellwea@gmail.com
Subject: [PATCH net 2/7] tcp: preserve rcv_wnd snapshot when updating advertised windows
Date: Wed, 11 Mar 2026 01:55:55 -0600
Message-Id: <20260311075600.948413-3-atwellwea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311075600.948413-1-atwellwea@gmail.com>
References: <20260311075600.948413-1-atwellwea@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Once tp->rcv_wnd carries paired snapshot semantics, every write of the
advertised window has to refresh the snapshot at the same time.

Convert the active-open, passive-open, and normal advertised-window
update sites to use tcp_set_rcv_wnd(). This keeps new sockets and later
window advertisements initialized with a valid advertise-time basis
before the receive-memory logic starts consuming it.

Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
 net/ipv4/tcp_minisocks.c | 2 +-
 net/ipv4/tcp_output.c    | 8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index dafb63b923d0..ae8a466b5298 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -603,7 +603,7 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
 	newtp->rx_opt.sack_ok = ireq->sack_ok;
 	newtp->window_clamp = req->rsk_window_clamp;
 	newtp->rcv_ssthresh = req->rsk_rcv_wnd;
-	newtp->rcv_wnd = req->rsk_rcv_wnd;
+	tcp_set_rcv_wnd(newtp, req->rsk_rcv_wnd);
 	newtp->rx_opt.wscale_ok = ireq->wscale_ok;
 	if (newtp->rx_opt.wscale_ok) {
 		newtp->rx_opt.snd_wscale = ireq->snd_wscale;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 326b58ff1118..c1b94d67d8fe 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -291,7 +291,7 @@ static u16 tcp_select_window(struct sock *sk)
 	 */
 	if (unlikely(inet_csk(sk)->icsk_ack.pending & ICSK_ACK_NOMEM)) {
 		tp->pred_flags = 0;
-		tp->rcv_wnd = 0;
+		tcp_set_rcv_wnd(tp, 0);
 		tp->rcv_wup = tp->rcv_nxt;
 		return 0;
 	}
@@ -314,7 +314,7 @@ static u16 tcp_select_window(struct sock *sk)
 		}
 	}
 
-	tp->rcv_wnd = new_win;
+	tcp_set_rcv_wnd(tp, new_win);
 	tp->rcv_wup = tp->rcv_nxt;
 
 	/* Make sure we do not exceed the maximum possible
@@ -4150,6 +4150,10 @@ static void tcp_connect_init(struct sock *sk)
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
2.34.1


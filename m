Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432FD443E4A
	for <mptcp@lists.linux.dev>; Thu,  3 Sep 2026 08:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788424530; cv=none; b=dEk7FArWlvBQGrDNP6qZU2k5nrBXoqgHFjU+gzhh+/aLyrYd0Nlq3nOa0hCUigu9COuSFf6aLKWep3d0/ny8sL6kiBrQabAlker6EuSUNEvfo3FmMPvb3mR+IiuAosEdZyLvcovU4mHsOpc+Dk/2eM1U9Ue6lhsXB6gv0J4e2Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788424530; c=relaxed/simple;
	bh=DjStITYR2s8Pxf0tCTvMNBrFzY7SIq7O1NXLlAuL/U8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q2MidGmCofNTjWT/aNbnnB0N4/hipCPEF0it1Iu1b+rfjMluW9gsUECe7h+oNr3YZQyKG41rrNMz2u62u4Yez7DYv4AMNP91LIfYZnzv820F/9cOAL3UNM5QUUxR1pz3sygiMH35kQ+eFi7CE15yeCKD1I2aaBHvNeN1ryXLnEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDMNGcmI; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDMNGcmI"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49b965570d7so19280495e9.0
        for <mptcp@lists.linux.dev>; Thu, 03 Sep 2026 01:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788424524; x=1789029324; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EYvbakm1Bwgdxf94CO815zX0bPm8KsoE2kOWQFAcVLk=;
        b=TDMNGcmIE/afFlgW0ydRJpT+ILcV9Io0G4iB+zLKNwSxWH+2oMXO3WW1RWrSyrzpZY
         bWFREw5GR93+YG7Bc60uaA6a5eKZRA9urzD6BUQ/eFlhT5d4t1sBz9AeT6pyB84Rmj30
         96YdOJ4BNNoGOpN0wL8pgbBt4V8NufTrIJz+s76c7w+IXCT/mCSJlrujtPULAi471V6N
         9xHsLKw1LMSyB7k+f4BJIgyf2t+5q79+WtozLS5q+Mgh1N3sQPFbYDsYbhvlOD36+U6S
         DWhrQCq95MjW1ZyUZP+6EShyBcBZ/hsPf1Jx2qbWH7irNAL069lHWKkGl3qM5oB1byNE
         X4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788424524; x=1789029324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EYvbakm1Bwgdxf94CO815zX0bPm8KsoE2kOWQFAcVLk=;
        b=ELVSQS9X3d7one2r7gnSF58he+QX0HC6MyE2v+ZA1YhzXEWg+swDuDNqck14t8Xoiv
         YORo0Au1RnByySndsmtIaYZjDPFrM22N6faEaJiu9gOh6X6F+QkPI6it/gxU90CS5/9s
         njGv4nQnjZDe1uBSRQkVRjVVQBJN0QtIC/ILALyZS0pZV/HDJrrshsyHOjQI9J8ALbWa
         NU8GOvtzmHulNNSz7mYDshy2mETfON+ZeT4p0hbHGVKM3IYGqApDouabl7ssgcnAtx/w
         Zf3MIMtIlap5WNRIzwtdAPiaMsJC1Hn6LMHmtkohEzXClJYHGLVmt9otkUXSR2rnjRpr
         Pz+Q==
X-Forwarded-Encrypted: i=1; AKwUvBwbwow6tIrMVgHY9z+tP5Y80Jwe+8JSyAAczwp2BHdv8wQgdy4BB1pptTAskZQoUTQGj5MfRg==@lists.linux.dev
X-Gm-Message-State: AFuF++lo/bbKH+2DuUs6YPt7tPUFR3glHUyFulLDu4sfwJUZrjJ1HcXo
	0oHwwt3qPucArCilrJlg15FNTIJSxRH4Hjo+hleERThRLHpyERG6S6zo
X-Gm-Gg: AYBFou2ca+FQJ4qx130YpdV+yn5IU+dLSS+eeUKW+JQoppwCEr3EfGpTFXC2BsL65PS
	VBNZiQ4ihD39erK6uoMrUyQq8V5hZQybyysHacOuGqNArNUGX3q2Xp4F2Za3YzpdLS20S+uSNxi
	FIM3bN90JL+9HSnG8rMp+jrgRIDmw4J6lEBKXZWf8OuO9Ik8YQJBE0Fo3v7xDQxCBMKuexRrKLs
	KxicZJ4zyWFbMG8bM3XhOeNa/yx8xCFZz2AsQfC79jgb/ucxKvb8NmiLl7Edi0PsGGtmvQEnpUq
	KM3J0G2N8TdHl7W706+Lvq/OUqr06y2yJT6c/26YzEkGg3f+CO+SbTdpjkjQWHbg2RdsF39jf2D
	ZNNfTdxgISpZC6UojN7OtAd2lb3qGH8OX5sBIYon8hRmI/+piV+Av22yfSOXHXGH778wcAkrF+c
	qDrWFTilYblRBWab6lcgTuUV0ihVT2alvTwwZGD02EzxdGyFlDduOEfpkto4DcBcczvWxPReN4Y
	+DgP46Xjux4b5H7/bQbfeuL3OZtOX6PeI7+mhRmItw07eToX7BBjgj4XSWwvAHDaHys0Wg9EAEE
	0aRa+18qVsa6bhoBIEANpp95sB2AK0uHr5tUe34iE6OPhOFzQxXmRvo6oloWqGMZ65cDKTOkKv5
	vFcF5
X-Received: by 2002:a05:600c:630e:b0:49c:e27c:6b10 with SMTP id 5b1f17b1804b1-49ce55ecea8mr189868675e9.3.1788424523511;
        Thu, 03 Sep 2026 01:35:23 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-a979-9501-3df6-d7fa-8a5a-06c5.310.pool.telefonica.de. [2a02:3100:a979:9501:3df6:d7fa:8a5a:6c5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce58da3acsm228357425e9.0.2026.09.03.01.35.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Sep 2026 01:35:23 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: stable@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5.10.y 2/2] mptcp: pm: ADD_ADDR rtx: free sk if last
Date: Thu,  3 Sep 2026 10:35:12 +0200
Message-Id: <20260903083512.99864-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260903083512.99864-1-kmehltretter@gmail.com>
References: <20260903083512.99864-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthieu Baerts (NGI0) <matttbe@kernel.org>

[ Upstream commit b7b9a461569734d33d3259d58d2507adfac107ed ]

When an ADD_ADDR is retransmitted, the sk is held in sk_reset_timer(),
and released at the end.

If at that moment, it was the last reference being held, the sk would
not be freed. sock_put() should then be called instead of __sock_put().

But that's not enough: if it is the last reference, sock_put() will call
sk_free(), which will end up calling sk_stop_timer_sync() on the same
timer, and waiting indefinitely to finish. So it is needed to mark that
the timer is done at the end of the timer handler when it has not been
rescheduled, not to call sk_stop_timer_sync() on "itself".

Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260505-net-mptcp-pm-fixes-7-1-rc3-v1-5-fca8091060a4@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Karl Mehltretter: applied to pm_netlink.c and retained v5.10's fixed
  retransmission delays while centralizing timer rearming. ]
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 net/mptcp/pm_netlink.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index aee3a8dd9287a..89570f83f96b0 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -34,6 +34,7 @@ struct mptcp_pm_add_entry {
 	struct timer_list	add_timer;
 	struct mptcp_sock	*sock;
 	u8			retrans_times;
+	bool			timer_done;
 	struct rcu_head		rcu;
 };
 
@@ -214,24 +215,25 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	struct mptcp_pm_add_entry *entry = from_timer(entry, timer, add_timer);
 	struct mptcp_sock *msk = entry->sock;
 	struct sock *sk = (struct sock *)msk;
+	unsigned int timeout = 0;
 
 	pr_debug("msk=%p\n", msk);
 
+	bh_lock_sock(sk);
 	if (unlikely(inet_sk_state_load(sk) == TCP_CLOSE))
-		goto exit;
+		goto out;
 
 	if (!entry->addr.id)
-		goto exit;
+		goto out;
 
-	bh_lock_sock(sk);
 	if (sock_owned_by_user(sk)) {
 		/* Try again later. */
-		sk_reset_timer(sk, timer, jiffies + HZ / 20);
+		timeout = HZ / 20;
 		goto out;
 	}
 
 	if (mptcp_pm_should_add_signal(msk)) {
-		sk_reset_timer(sk, timer, jiffies + TCP_RTO_MAX / 8);
+		timeout = TCP_RTO_MAX / 8;
 		goto out;
 	}
 
@@ -244,14 +246,18 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	}
 
 	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
-		sk_reset_timer(sk, timer, jiffies + TCP_RTO_MAX);
+		timeout = TCP_RTO_MAX;
 
 	spin_unlock_bh(&msk->pm.lock);
 
 out:
+	if (timeout)
+		sk_reset_timer(sk, timer, jiffies + timeout);
+	else
+		/* if sock_put calls sk_free: avoid waiting for this timer */
+		entry->timer_done = true;
 	bh_unlock_sock(sk);
-exit:
-	__sock_put(sk);
+	sock_put(sk);
 }
 
 struct mptcp_pm_add_entry *
@@ -304,6 +310,7 @@ static bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 	add_entry->retrans_times = 0;
 
 	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
+	add_entry->timer_done = false;
 	sk_reset_timer(sk, &add_entry->add_timer, jiffies + TCP_RTO_MAX);
 
 	return true;
@@ -322,7 +329,8 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 	spin_unlock_bh(&msk->pm.lock);
 
 	list_for_each_entry_safe(entry, tmp, &free_list, list) {
-		sk_stop_timer_sync(sk, &entry->add_timer);
+		if (!entry->timer_done)
+			sk_stop_timer_sync(sk, &entry->add_timer);
 		kfree_rcu(entry, rcu);
 	}
 }
-- 
2.53.0


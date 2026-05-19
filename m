Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530D83E7BCD
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 21:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779225942; cv=none; b=Y3lGp2ubBGabVbwyy1zYBpYWUgXWl6frHu45/n88aO+oYotgslwISiFi/+df0Tn56ARugDwjM7m1rd/texFCGmUGNcXk6CbYASJkFK6yGyO9cK7CQTs3T4bjxWh+2NYNwV76e0GRleSpnmeVl1cZiuVCRpt5wPHqy6h4pbAr+uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779225942; c=relaxed/simple;
	bh=gNApQefUnDpYq3GybcALHtLuaLoO4Lha+PfsT7614HA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NoRwwuxSIGDg0qs5nAKsbynXnCWaJit42WdRedmOHuXEIwhZCFK4E2U9Qmf95j12ZnoltzzHu4bSof3qLDK9yY7E39z+AheNFc2Och1/XwtD/nWuskok3u3z+oxaKwJvdfur476aZjlfWQgO9kaxbqhm2vidqhSm/fXZ/PNmJrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ao+BwxqH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ao+BwxqH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 582161F00893;
	Tue, 19 May 2026 21:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779225941;
	bh=IP28DG2SRVWJWls5ctZoXwr6XIKJ5LthOUI2ex7jVfQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ao+BwxqHIHrePIQDu6W76YV5S+Pir8yxuneHikiCnbGdUEx38kc0IDIysLshHbgto
	 +YydNhYhwyhe4taIcm0tdvws6BAoO9wGfASmTkmbtE85ZlljQ+A0TyGm8RP37ieHHY
	 tiLcsI775I2knFmH3q3AGzBXq5Dntyhi/6x0lIKDABkIb0yyzcbu/tEEAWQlAlczQn
	 JpN6yLXCtbmTnj3aGvr/6rzjJRO4rMsNXEykJguPaLJBGZluhqneAqOiJOR3z6LCYl
	 YZUnvo+7yj3uwhomLbDMrOCJVrFlbKCoRWfrm+mFBd0hPVZkTs9mWF6JTHtcLL1rRc
	 VsDVtW4PbYwHQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 20 May 2026 07:25:24 +1000
Subject: [PATCH mptcp-next v3 13/16] mptcp: pm: remove add_ prefix from
 timer
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-mptcp-add-addr6-port-ts-v3-13-bffa658a7678@kernel.org>
References: <20260520-mptcp-add-addr6-port-ts-v3-0-bffa658a7678@kernel.org>
In-Reply-To: <20260520-mptcp-add-addr6-port-ts-v3-0-bffa658a7678@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2718; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=gNApQefUnDpYq3GybcALHtLuaLoO4Lha+PfsT7614HA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqDNVBf51zYwo0ZTxI1Epoi5LyPyrqJIgP8FAA+
 cRSipTDrQ+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCagzVQQAKCRD2t4JPQmmg
 czx0EADxJ6Sw1/FnkUsjAo3CRElmcReFJQ35BmEiU0buwqQh5je3oFA/Set3SYoiZPHZCopTQrR
 iN5hbY7Hp0NTcTp6ab6KdIdsVIFuJlU2ab75KoAqzFcAIZpGnVCYFEKQz3QFicKRzkw+Rxd5tb7
 iOJvzroEzb/Fhya4EShF1xkjBzkyyetAdXyzVv0+ooQpJIiT/YhTbPL6IhTqz9IrMEpveCOpKO0
 Cc/Eck4Inqzs48U/wsvBMIHistHQrvAijdbuRNgpl6MmWrtetPca6XfA9gZ+lhMVY9FdbryQF1o
 GC7btLW4nTr/LnmtPP8A4Ug0yLLq5cP8o/MHJRd8OWzGUdtVtxNUA7rUWXDrvwCauk87rvSnrwU
 g8b0urrKNqOt8y2wulVPyHTk6uQiCGBFEcbgbtNCZ7jkQOSPuRtl0fO0Iq61Vbl3N70+XMKNlHt
 nsiBZSvJEPVbgLHavDMwiru+TqfctcT8jwfli09LZegWVFyNUpfR1Bpd1ynCsaPsl7PLRpya4vN
 gCHdx0q0NVFIekaJoUFfT5LZk12ZX/ODE6NmLUnuVif1rVtOR4MTasmJSr/wiWCTU+2tS/BZ51r
 Vwj90cPplD0BsuZ/MS3VLtjG24ueahrGa0zcTp5Gb09r4UsUUYhbB26lnGoAGll202oj7Ld00m/
 Qxm9vdwsRdaNuDA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Similar to the two previous commits, using the 'add' prefix is
confusing, also confirmed by [1].

Now that the structure has been renamed to include 'add_addr' in its
name, easier to know the timer is linked to the ADD_ADDR, no need to
add the confusing prefix, or an unneeded longer one.

While at it, also update the ADD_ADDR timer helper to clearly specify it
is linked to ADD_ADDR, and it is not there to add a new timer.

Link: https://lore.kernel.org/20251117100745.1913963-1-edumazet@google.com [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 05834e46bbc3..d3469d3b95c0 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -17,7 +17,7 @@ struct mptcp_pm_add_addr {
 	struct mptcp_addr_info	addr;
 	u8			retrans_times;
 	bool			timer_done;
-	struct timer_list	add_timer;
+	struct timer_list	timer;
 	struct mptcp_sock	*sock;
 	struct rcu_head		rcu;
 };
@@ -338,10 +338,10 @@ static unsigned int mptcp_adjust_add_addr_timeout(struct mptcp_sock *msk)
 	return rto;
 }
 
-static void mptcp_pm_add_timer(struct timer_list *timer)
+static void mptcp_pm_add_addr_timer(struct timer_list *timer)
 {
 	struct mptcp_pm_add_addr *entry = timer_container_of(entry, timer,
-							     add_timer);
+							     timer);
 	struct mptcp_sock *msk = entry->sock;
 	struct sock *sk = (struct sock *)msk;
 	unsigned int timeout = 0;
@@ -411,7 +411,7 @@ mptcp_pm_announced_del_timer(struct mptcp_sock *msk,
 	entry = mptcp_pm_announced_lookup(msk, addr);
 	if (entry && (!check_id || entry->addr.id == addr->id)) {
 		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
-		timer = &entry->add_timer;
+		timer = &entry->timer;
 	}
 	if (!check_id && entry)
 		list_del(&entry->list);
@@ -458,12 +458,12 @@ bool mptcp_pm_announced_alloc(struct mptcp_sock *msk,
 	add_entry->sock = msk;
 	add_entry->retrans_times = 0;
 
-	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
+	timer_setup(&add_entry->timer, mptcp_pm_add_addr_timer, 0);
 reset_timer:
 	add_entry->timer_done = false;
 	timeout = mptcp_adjust_add_addr_timeout(msk);
 	if (timeout)
-		sk_reset_timer(sk, &add_entry->add_timer, jiffies + timeout);
+		sk_reset_timer(sk, &add_entry->timer, jiffies + timeout);
 
 	return true;
 }
@@ -482,7 +482,7 @@ static void mptcp_pm_free_announced_list(struct mptcp_sock *msk)
 
 	list_for_each_entry_safe(entry, tmp, &free_list, list) {
 		if (!entry->timer_done)
-			sk_stop_timer_sync(sk, &entry->add_timer);
+			sk_stop_timer_sync(sk, &entry->timer);
 		kfree_rcu(entry, rcu);
 	}
 }

-- 
2.53.0


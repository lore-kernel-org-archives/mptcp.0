Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1266C366816
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 06:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780037052; cv=pass; b=X6qReBmHu37826SmRKpCI0GIawmooIRA+xq0LO9SqFOQlnqFsl6kSbpSUBRP+2kE72TR0/GJkYKeaeAJ5fc8alc6B045lPbO8zywiTIvbHEdiNE45+mR8VLoM6FjJfZl+lEJhzm1wK4/4MUt5q5ieRPl5vHgZLchV+3gfxsodLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780037052; c=relaxed/simple;
	bh=PV+NBken7fiIkLvl2IYb4xFr76iyoHgq9iHfFvqxZ8g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZiOZufwbAnAPPVG55GxgUj+yIXdknZrKXgECJHr2LEDmRnth1j8s0BEcDHnODWNz2ZGPM7/m/NAeabIXB/Xhkb4hSjUTPxZlG+NfEH2GLjgMCrkmbHuMMqENDbNvqgjYgxgsfI7LwrfFGC6lojkn0xe5J+2EPmc10ZSGJJJYoCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=pbDD8p7e reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="pbDD8p7e"
ARC-Seal: i=1; a=rsa-sha256; t=1780037046; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VkezwimBFdYvxadH/Hip95eMRghLuDENczLM7KCUihFh/nF0c8K3DSq7z2xNmmiERfXHllBwaLfoGTaLcmEY2B1Fkwr/yCI5nJHZ43bAZi1j3UJwKAukq1oK9WYZYRkYdrvxBi6ilTdidFms3xRo9eIf7ClVzUqmR0rvdbbVNks=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1780037046; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hP2looUtXqNa+VMHIavUWsbdWG6dngG9RsEjSvLtCls=; 
	b=CmmEoikW+poo8Ehe4s+I7m8zPlO48XIxtlx9bHTyDjwwkS+hS0SkR46t1vzKcZPsiWi8w58FnOymPAchFFgWqRiw50Dt5QlGsm8pvx9r2AdLAiSM794OMlo+4WccFsOSHyHBU8xOWRobaqRlNZ4prZJ2R27itoiVVxgeG6nRuow=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780037046;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=hP2looUtXqNa+VMHIavUWsbdWG6dngG9RsEjSvLtCls=;
	b=pbDD8p7e/WwjnxmTm49fytcGnpzMp5x/B4a4eOEVUtRR0Ii4rkKDeEzF4SZ6lXzv
	ykx90BbD4D8SzeDBLo3ZKo3qJDN/WEZKq2ULiKrljTWkk/4hqN0aCgHo9Nucs6k5Ygb
	D2KiNdT3HvlWONnGZkw3f2d7Q1yOq4Yo2hXbPSUw=
Received: by mx.zohomail.com with SMTPS id 1780037044913353.48869897971633;
	Thu, 28 May 2026 23:44:04 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	pabeni@redhat.com,
	shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	kalpanjani009@gmail.com,
	shardulsb08@gmail.com,
	syzbot+55c2a5c871441261ed14@syzkaller.appspotmail.com,
	Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Subject: [PATCH net v2] mptcp: pm: drop pending ADD_ADDR when removing id 0 endpoint
Date: Fri, 29 May 2026 12:13:55 +0530
Message-ID: <20260529064355.922763-1-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

syzkaller hit the WARN_ON_ONCE() in mptcp_pm_alloc_anno_list() with
the in-kernel path manager.

When a signal endpoint is removed, the pending ADD_ADDR has to be
cancelled: its retransmit timer stopped and the anno_list entry
unlinked and freed. For a non-zero id endpoint this is done via
mptcp_nl_remove_subflow_and_signal_addr() ->
mptcp_pm_remove_anno_addr() -> mptcp_remove_anno_list_by_saddr().

The id 0 removal path, mptcp_nl_remove_id_zero_address(), does not do
this: it only queues a RM_ADDR and marks the id available again, but
leaves any pending anno_list entry and its armed retransmit timer
alive.

So when the id 0 endpoint is removed and re-added while its previously
sent ADD_ADDR is still awaiting the echo, the stale entry survives.
The kernel PM reselects id 0, reaches mptcp_pm_alloc_anno_list() a
second time, finds the stale entry and hits the WARN.

Make the id 0 removal path symmetric with the non-zero one: drop the
pending ADD_ADDR before queuing the RM_ADDR, and decrement
add_addr_signaled if the address had been announced. This closes the
race at its source, so the WARN_ON_ONCE() stays a valid assertion.

Fixes: 740d798e8767 ("mptcp: remove id 0 address")
Reported-by: syzbot+55c2a5c871441261ed14@syzkaller.appspotmail.com
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/620
Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
---

v1 -> v2:
 - Do not drop the WARN_ON_ONCE(); it is a valid assertion.
   (Matthieu Baerts)
 - Fix mptcp_nl_remove_id_zero_address() to tear down the pending
   ADD_ADDR entry: call mptcp_remove_anno_list_by_saddr() and
   decrement add_addr_signaled, mirroring the non-zero id path.
   (Matthieu Baerts)
   
 net/mptcp/pm_kernel.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index fc818b63752e..ed0ad1c1b140 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1126,6 +1126,7 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
 		struct sock *sk = (struct sock *)msk;
 		struct mptcp_addr_info msk_local;
+		bool announced;
 
 		if (list_empty(&msk->conn_list) || mptcp_pm_is_userspace(msk))
 			goto next;
@@ -1135,7 +1136,16 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 			goto next;
 
 		lock_sock(sk);
+		/* Drop a possibly pending ADD_ADDR for this address: stop its
+		 * retransmit timer and unlink the anno_list entry, so a later
+		 * re-add cannot find a stale entry and hit the WARN_ON_ONCE()
+		 * in mptcp_pm_alloc_anno_list(). Mirrors the non-zero id path
+		 * in mptcp_pm_remove_anno_addr().
+		 */
+		announced = mptcp_remove_anno_list_by_saddr(msk, &msk_local);
 		spin_lock_bh(&msk->pm.lock);
+		if (announced)
+			msk->pm.add_addr_signaled--;
 		mptcp_pm_remove_addr(msk, &list);
 		mptcp_pm_rm_subflow(msk, &list);
 		__mark_subflow_endp_available(msk, 0);
-- 
2.43.0


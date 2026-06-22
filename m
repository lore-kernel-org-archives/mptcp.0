Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70176367B9E
	for <mptcp@lists.linux.dev>; Mon, 22 Jun 2026 09:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782120563; cv=pass; b=PuOwgGEy+WNlz7eaqh0qvEHpxuXtrdsPZCii5CZhB47CwZlblB4x3kv+kievDIxiA6HHIuQ3o1Y/isORLT9Yv4Yjv92ViO5UAAWrkjrB99F4fXM8BtWdBansBcAWJfD2WUZ8DtvY5Dp2xBmEdIW7an+Mwrofe0PPHY0KvgNiGG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782120563; c=relaxed/simple;
	bh=gTeLH937E+vtDyr3E2lM7yDx0tEfBHw8H5wvI+LSaR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GVpbhluYXdEGbKiow9RmaWcsyzAzlcv9mITYYUEio21S8irDU0j4Nrvp48yBLAcjLJuI0X+Hk/BHY1kh/YITndUE96yQO5iWEspfoJvY28rLeSIaGWwJB3DxbYiGJvuuNRdy0+9Tm1p5k1Euqmk7h8ndz5yxvkINmwWXUJtf01s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=iF9M1pdQ reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="iF9M1pdQ"
ARC-Seal: i=1; a=rsa-sha256; t=1782120546; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=V/AlMSDqKIdDpQY1brS6o+jnvjV5FGVDNc50m+q6f7Qpp0aVaNEb3CPLaWykBlNDKg9i3u4rRYurqKu5lfpd9bnH/s6DEKjs/HBcPzIhB+Id5XdT9e5kJ6XAzbmRxCD8VRDF3yudT93AxNpI8fDb/YoHxqpPjGv3llAZrQ2AilQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1782120546; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=a1gURWx/CNjOrN7LVAWrsbvq+4OkNm+wQY4IDK00swo=; 
	b=iN3vDfChZGtk5vESg7Cw+yJmprgo0TfXPMry2AQDqfHaqIOK4GOw0/a9wGnQ2A4EpouRtfef43APwfqQRd1vqGj3ZT9RCAYFWs9GNjggtYbLdW4EFPaTzJ8X6791DgTq9FgXeM63ymG5410p80rJ8IV5RovBPEykZyrWmxIP5YI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782120545;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=a1gURWx/CNjOrN7LVAWrsbvq+4OkNm+wQY4IDK00swo=;
	b=iF9M1pdQTcTJeRpmFF8aQMx1ONZx7Aj3ox7U/mhhkV4MlPdHwiheRUnkb/F1z0YI
	a0ZNmpc9jBUkb5FRtyuGx2LLIRix03Lf0jKIq4/kpd6tgHwUGL5qRqxIz+BOOiSgw3g
	Btwlsqlm/aW+Sopavtlh6hrdc8leSB0Mpbe0sV3g=
Received: by mx.zohomail.com with SMTPS id 1782120543254151.87993590959547;
	Mon, 22 Jun 2026 02:29:03 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	pabeni@redhat.com,
	cuitao@kylinos.cn,
	syzbot+55c2a5c871441261ed14@syzkaller.appspotmail.com,
	shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	kalpanjani009@gmail.com,
	shardulsb08@gmail.com,
	Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Subject: [PATCH net v4 1/2] mptcp: pm: drop pending ADD_ADDR when removing id 0 endpoint
Date: Mon, 22 Jun 2026 14:58:35 +0530
Message-ID: <20260622092838.1267134-2-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260622092838.1267134-1-kalpan.jani@mpiricsoftware.com>
References: <20260622092838.1267134-1-kalpan.jani@mpiricsoftware.com>
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

Signal endpoints added without an explicit port are stored in the
anno_list with port 0. mptcp_remove_anno_list_by_saddr() compares
addresses with use_port=true, and msk_local carries the connection's
actual local port, so passing msk_local directly misses the entry.
Clear the port before the lookup to match the stored key.

Fixes: 740d798e8767 ("mptcp: remove id 0 address")
Reported-by: syzbot+55c2a5c871441261ed14@syzkaller.appspotmail.com
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/620
Suggested-by: Tao Cui <cuitao@kylinos.cn>
Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
---
 net/mptcp/pm_kernel.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index fc818b63752e..4ab1a339e3e9 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1126,6 +1126,8 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
 		struct sock *sk = (struct sock *)msk;
 		struct mptcp_addr_info msk_local;
+		struct mptcp_addr_info anno_addr;
+		bool announced;
 
 		if (list_empty(&msk->conn_list) || mptcp_pm_is_userspace(msk))
 			goto next;
@@ -1135,7 +1137,13 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 			goto next;
 
 		lock_sock(sk);
+		/* Drop a possibly pending ADD_ADDR for this address. */
+		anno_addr = msk_local;
+		anno_addr.port = 0;
+		announced = mptcp_remove_anno_list_by_saddr(msk, &anno_addr);
 		spin_lock_bh(&msk->pm.lock);
+		if (announced)
+			msk->pm.add_addr_signaled--;
 		mptcp_pm_remove_addr(msk, &list);
 		mptcp_pm_rm_subflow(msk, &list);
 		__mark_subflow_endp_available(msk, 0);
-- 
2.43.0


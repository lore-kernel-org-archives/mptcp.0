Received: from sender4-of-o56.zoho.com (sender4-of-o56.zoho.com [136.143.188.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA56313E34
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 08:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780044873; cv=pass; b=oDsEUA3iK63YRMQyDRGizXSVxzmXZH9PELUwK7jVIeUfOwARvGYMWy6yUqC5mlSVDD88dxx6W1yKiUXtfgrbDPebOyRda0wAy8pqUmiroie76Ri17hNpQUMoFyVUYEVFgHiM9sVR7+E27lWarEnqMHDEChNDKZ56DW8187c1Bng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780044873; c=relaxed/simple;
	bh=MWirs52RAs2dz01gjLsK42W3ckzBKPP8lUEK5VDacG0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kp4OjIJvtEqXZ0lXf+NENJtnnJG4yieQQ0vvjZBGtPB3/fqA/fjiFzo9QiFKciZbognIW74fzffjWCqnacIQ+Ay9ch345bgGcszfhGGkLcP6Jtn9anEuwoHS85swx9tQQTBNksL2xDv8eHDTpRaFs/rMeSUHqBMa2+Lwy0klx0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=QqBCRPzY reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="QqBCRPzY"
ARC-Seal: i=1; a=rsa-sha256; t=1780044866; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hvVmcrhj9spg6ZQpiYiFiKZM8ULmuW1oF7AxT5Q9m/hxj5GN8qDsVv+Y4YsdOTXKTil3NBepK+d96w2C+TlEn8Cz/aZhXut0j8QjWA2w51y2H/22J0uH2/geK4tw+7eImZf28PjXiCsk0LE55HjsJeMkyXtYk1eom6Mz4C/SM5o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1780044866; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2BdxoeTDg8tsmuvg9MGapY91dx2IJJfk1j08G4zQnWk=; 
	b=ZC9XDpZD9nNZhxfG1/r/wqib+2Ug80Qh3baG+TN6UqC4Z0zrSU85H8bThapd2uYb6VXMrdHdcu8p/5zN8oW+KMmsmmUuZBEc6qJiFETL+w5TkOtPqzD94jCTki8V7H7a0jPt5Y9Up4WXsvUMS/S5eIkZrI9WdfNM9X8ogXQJWP0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780044866;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=2BdxoeTDg8tsmuvg9MGapY91dx2IJJfk1j08G4zQnWk=;
	b=QqBCRPzYl0rgTlnYq4IILtRj5/Lzq5257YnduZ4FCmVbnyIqOvH9z6ufwKtfVHDq
	39Cmtn7THV+RtW6Ql1DDZIQZoFay68l2dbzJt6+4SMjkcONxmIC26EC2XAqJ8l2oy/z
	FGCqdguZhHjmGji7GGk93Csew/dY8kYI+hBtr84Y=
Received: by mx.zohomail.com with SMTPS id 1780044863975158.53370371546418;
	Fri, 29 May 2026 01:54:23 -0700 (PDT)
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
Subject: [PATCH net v3] mptcp: pm: drop pending ADD_ADDR when removing id 0 endpoint
Date: Fri, 29 May 2026 14:24:15 +0530
Message-ID: <20260529085415.1562229-1-kalpan.jani@mpiricsoftware.com>
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
v2 -> v3:
 - Shorten the inline comment to one line; full context is in
   the commit message. (Matthieu Baerts)

 net/mptcp/pm_kernel.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index fc818b63752e..128a2e71c26e 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1126,6 +1126,7 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
 		struct sock *sk = (struct sock *)msk;
 		struct mptcp_addr_info msk_local;
+		bool announced;
 
 		if (list_empty(&msk->conn_list) || mptcp_pm_is_userspace(msk))
 			goto next;
@@ -1135,7 +1136,11 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 			goto next;
 
 		lock_sock(sk);
+		/* Drop a possibly pending ADD_ADDR for this address. */
+		announced = mptcp_remove_anno_list_by_saddr(msk, &msk_local);
 		spin_lock_bh(&msk->pm.lock);
+		if (announced)
+			msk->pm.add_addr_signaled--;
 		mptcp_pm_remove_addr(msk, &list);
 		mptcp_pm_rm_subflow(msk, &list);
 		__mark_subflow_endp_available(msk, 0);
-- 
2.43.0


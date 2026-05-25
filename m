Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA47175A7E
	for <mptcp@lists.linux.dev>; Mon, 25 May 2026 12:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779711848; cv=pass; b=CIzel5aDaQYeq5yeZ7iv6pF/FQbCWhjmngQMehYWZdG3RK+dzY+qRucKK6nx8ocvyN+RzUTB4aH1F5fJjbO88ADewZcELMuMYo9IPYqgXRohS4+nZ4JIlr/7mq+6UM+K0DGVT3KHRc4Mll+aP7dXJH/yugk31g+F/igfm402Jhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779711848; c=relaxed/simple;
	bh=Ogjgryenn+I/XtOzN8KODwEUSK2JAPOwWyVk8NQr6ds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=coR89LihRHfYKdi/va1b7/faDS9ulgpcthjkdcfUEHf0YqQIf75CLrSCA+ZBo5Mz/Yn1pxwVNDnTaCoIMn+3kTULbWUwCiaBjIqI2NgbKTKN3qbrkXtUpBqp6agvGseubt4F7XTCFYl2vT+nzO+L3Y0WTladW609IeSqDyGvBx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=enCnedFw reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="enCnedFw"
ARC-Seal: i=1; a=rsa-sha256; t=1779711841; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aOKYRdDS5IMaBqla7ARxE8mM4A0WKMgo0d+nzJnQSqyEqbEBnVw3IGjiKRDyUuw2meqAk5BguVQFenQJiV7FqCG5S2vt3dRat1gH6Yqppy7H00g/aKtY0LjFIa8R/uuCgUg/T39niI4XFk+HvZ7JbVNszRdUV7FLoA1GYk/2A9w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779711841; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TUQG4c97Pl9Vj7ccUPmblyJR1ivvwKqfTu5UPgQnGfY=; 
	b=WPp3qFMITitL0/PRPM3IWZtS4hqOz8/gdmBAV5td4pcTl4zywRDn3pWNMkCiMQCa8aO094BjW+yMnaAyexnXNHSKmQ+EUOnpjw4bM19HloqaLzVT3sYsP+uIAXwOdz3BJgtGbtKc5S9iYRxI9+CRf2qb1uj1oQhdNvGIgC2UJ14=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779711841;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=TUQG4c97Pl9Vj7ccUPmblyJR1ivvwKqfTu5UPgQnGfY=;
	b=enCnedFwkmx5WvDkMabx/ZzUmOuoHxY+AggrUmSSTmM1/fJxoX7x8pX+LKcYv+j9
	ZBIwKp5c9v5U2en86XbOpXfp9t4cUfbmf2GbValRVaT9zKtUMY7Gxm6B4SBS7lvzrym
	lOea6x4cIQxTIyeC01tQiXgo5AcuYhUdJn1/D8WY=
Received: by mx.zohomail.com with SMTPS id 1779711839926372.62457413414165;
	Mon, 25 May 2026 05:23:59 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	pabeni@redhat.com,
	janak@mpiric.us,
	shardul.b@mpiricsoftware.com,
	kalpanjani009@gmail.com,
	shardulsb08@gmail.com,
	Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Subject: [PATCH] mptcp: pm: don't WARN on re-announced addr in kernel PM
Date: Mon, 25 May 2026 17:49:11 +0530
Message-ID: <20260525121911.2410171-1-kalpan.jani@mpiricsoftware.com>
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
the in-kernel path manager, reached via
mptcp_pm_create_subflow_or_signal_addr().

The WARN assumes the kernel PM can never reselect an address that is
still in msk->pm.anno_list. That is not true: when an endpoint is
removed and re-added while a previously sent ADD_ADDR is still
awaiting its echo, the endpoint id becomes available again in
id_avail_bitmap, but the matching anno_list entry (with its
retransmit timer) is still alive. The in-progress guard in
mptcp_pm_create_subflow_or_signal_addr() only checks
BIT(MPTCP_ADD_ADDR_SIGNAL), which is already cleared once the option
has been transmitted, so the address gets reselected and reaches
mptcp_pm_alloc_anno_list() a second time.

This is a benign transient state, so drop the WARN. For the kernel
PM, just bail out: the ADD_ADDR is already in flight, and the PM will
be rescheduled once it completes (or once the stale entry's timer
expires).

Fixes: cd7c957f936f ("mptcp: pm: don't try to create sf if alloc failed")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/620
Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
---
 net/mptcp/pm.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 3e770c7407e1..e75c97c1f1f2 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -443,7 +443,14 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
 
 	if (add_entry) {
-		if (WARN_ON_ONCE(mptcp_pm_is_kernel(msk)))
+		/* The kernel PM can legitimately reselect an address whose
+		 * previous ADD_ADDR is still pending (option already sent,
+		 * echo not yet received) when the matching endpoint is
+		 * removed and re-added before the announcement completes.
+		 * Don't re-announce it: the in-flight ADD_ADDR will finish
+		 * on its own and the PM will be rescheduled afterwards.
+		 */
+		if (mptcp_pm_is_kernel(msk))
 			return false;
 
 		goto reset_timer;
-- 
2.43.0


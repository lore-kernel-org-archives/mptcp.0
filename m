Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2185B2DECCB
	for <mptcp@lists.linux.dev>; Tue, 30 Jun 2026 15:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782832028; cv=pass; b=bJ5klpX6golecgi8bTDFy+gMI2QWBK1RnENiFv4+1NUNvgOlyIHVgq+xVCbvmZ/kvYmShhd8TLRGuC8KPUg4AKiPyanhwgMavmCjIaxxJvICu5DTdNwBVkYHIhN4OHXHqPe9KnZX0L/M/1O4mL4kvsmBlZVHluILE0HntnYjiSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782832028; c=relaxed/simple;
	bh=Up3ZDwApkdxTgtbSeMmDIdRtnMrA+b19I3/+YDcmI4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qgXlgxcfQRA3Bhc29RDk+mnDPYM20xZyrNIY1jjrtGS/YvuquVJYBhFOSzSpOKN9I066qxYVMlaJHul3t0o1Hdvr8koIxvILn7n6Lrnd7JXxBBhxpN4n+yTrnMYg2xh2Qs4Oe9dj/6gBeGzR6UT/wuctBcDcyNc5hsumKoC2hUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=oFfb5jPo reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="oFfb5jPo"
ARC-Seal: i=1; a=rsa-sha256; t=1782832011; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EjdkKRagfKBKAOh2gKzzvlGcpHll9gyFb0YE5xSJP67AJ4JEpsMmguzOLlaO1ufq1i6k2/yVNbu874xF03OrYBHpElVsEgG6JhZS78Yt+ejH+fAI5YErGl40GvOJbeuDa96iegORA5zSe2NgeY48Ar0YfjoV5QE2HlHwYooUnak=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1782832011; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=s7yKRg9/9Oi9C3gzjcSZR+m8myxKY6EU5ULgRbIQpxI=; 
	b=HXVGHj4TRppZmBsHvD+U17m8pta5OObEleHoA+OkfTA6zR4y7mN+ZQVSSSxzExZeaZV0gHn0Z35xsLsk1RopYR37tu/5uu1xTHEIV7v9fw/srBcfbny3rEVkKAhsfLBG2787V07TypVtweMd8TVkWc9bCPlC61A1yJPwn79iwt0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782832011;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=s7yKRg9/9Oi9C3gzjcSZR+m8myxKY6EU5ULgRbIQpxI=;
	b=oFfb5jPoB1Cu0MYIPb3Uuwvdd6D7U4ZRXkokKCWNkkonN+UsHvdV8mqltqztgF/4
	HabRM6sYZpxt1Q9acCh+vHOU8NS/8cbQFYBbO5A10P4DO+JYN1RmU28bClaYFzJWac5
	HTS6w9A44oUBixi/XMRdncoJi7rIyLdlOXqW/Bkc=
Received: by mx.zohomail.com with SMTPS id 1782832008784984.89779295814;
	Tue, 30 Jun 2026 08:06:48 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	pabeni@redhat.com,
	shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	kalpanjani009@gmail.com,
	akshit@mpiricsoftware.com,
	Kalpan Jani <kalpan.jani@mpiricsoftware.com>,
	syzbot+55c2a5c871441261ed14@syzkaller.appspotmail.com,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH net v5 1/2] mptcp: pm: drop pending ADD_ADDR when removing id 0 endpoint
Date: Tue, 30 Jun 2026 20:36:31 +0530
Message-ID: <20260630150632.899750-2-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630150632.899750-1-kalpan.jani@mpiricsoftware.com>
References: <20260630150632.899750-1-kalpan.jani@mpiricsoftware.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The in-kernel MPTCP path manager can leave a stale ADD_ADDR announcement
entry alive when removing the id 0 endpoint. This happens because the id 0
removal path does not tear down pending announcements, unlike the non-zero
id path.

When the PM later reselects id 0 after adding another signal endpoint, it
finds the stale anno_list entry and hits WARN_ON_ONCE(mptcp_pm_is_kernel())
in mptcp_pm_alloc_anno_list().

Root cause: asymmetry between removal paths.
- Non-zero id path: mptcp_nl_remove_subflow_and_signal_addr() calls
  mptcp_pm_remove_anno_addr() to clean up.
- Id 0 path: mptcp_nl_remove_id_zero_address() skips cleanup entirely.

Fix by making the id 0 path symmetric: call mptcp_pm_announced_remove()
and decrement add_addr_signaled before queuing the RM_ADDR.

Subtle detail: signal endpoints are stored in anno_list with port 0, but
msk_local carries the connection's local port. mptcp_pm_announced_remove()
uses use_port=true for comparison, so clear the port before the lookup.

Fixes: 740d798e8767 ("mptcp: remove id 0 address")
Reported-by: syzbot+55c2a5c871441261ed14@syzkaller.appspotmail.com
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/620
Suggested-by: Tao Cui <cuitao@kylinos.cn>
Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
---
 net/mptcp/pm_kernel.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 331f6fa99014..d3014bf57bf3 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1138,6 +1138,8 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
 		struct sock *sk = (struct sock *)msk;
 		struct mptcp_addr_info msk_local;
+		struct mptcp_addr_info anno_addr;
+		bool announced;
 
 		if (list_empty(&msk->conn_list) || mptcp_pm_is_userspace(msk))
 			goto next;
@@ -1147,7 +1149,13 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 			goto next;
 
 		lock_sock(sk);
+		/* Drop a possibly pending ADD_ADDR for this address. */
+		anno_addr = msk_local;
+		anno_addr.port = 0;
+		announced = mptcp_pm_announced_remove(msk, &anno_addr);
 		spin_lock_bh(&msk->pm.lock);
+		if (announced)
+			msk->pm.add_addr_signaled--;
 		mptcp_pm_remove_addr(msk, &list);
 		mptcp_pm_rm_subflow(msk, &list);
 		__mark_subflow_endp_available(msk, 0);
-- 
2.43.0


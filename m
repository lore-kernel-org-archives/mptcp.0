Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793307137;
	b=sObiijJed258aXOBz1Bt7P8oIAzTj9Zzg4fY0XTiqi78sVG1ciTB87iLUM1dhWhM3PM8
	 h4A1vRYsKM2sd43Azk+X9fh35h4atq/AP2nQoHjrgQFU1FGrFEZk2wYTLL+bkPHTGY9FY
	 BBkx0RAgIQc23XnQN+Z6D6ukUXjUIHwSYfMdEFTraUbf2IjShYhkXePpzAKChq0IAiOVJ
	 KHgKo5M1R+lCjMJr12IxQu2zT3knOmPwF197P9xVuGLIablXczA/tvUx1KwMD4QMl8w+Q
	 nbrZZzDjC6pEwRi5xzZmoPZdsXEIT/91TA+SduMTBIRuO9dyb1/yfNZ8JfE+E0oy9pA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793307137;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=a9RkJMbkHS9N8fPi+22ZusZWtz3IGupp0hlhdsfrCJQ=;
	b=p721qJr/piBwR6Wp9q0GL+zEa2i1UaGGyag5gMI5nbdv16cZeKY18vhtX8bEeReZSjda
	 ycExrX8RzBEQVGSRatAQxX+MugMlkA9NPd1DJenFaiN8l2IGoV8UWaiTYGodvl7JOB5Gp
	 xHVrq5fmFLaoN4LV6EsPKXkL06x7usGSgWuNrGFZZhdQSeqMaB5kxHqXIG6cQE7UgnXl1
	 XvjBaOqDIOHM6P8T94PzbgtWenrPmqA5wjrBIPbyJEMfUfPTUFsGGfJckY/+t6auhBf+g
	 +z2+h/jRcgZp3H4Wo/ouFtl7F/5IxlW2LpLRq+zeZDhRqm7PuR6BUNmO/VVRZ+EV5tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jVFN+dHD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AA060A2609
	for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 20:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jVFN+dHD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C311F01816;
	Thu, 29 Oct 2026 20:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793307136;
	bh=a9RkJMbkHS9N8fPi+22ZusZWtz3IGupp0hlhdsfrCJQ=;
	h=From:Date:Subject:To:Cc;
	b=jVFN+dHDcYxXYJHhTX8vqYOFOHaLy/pyjtKyNV/ri11Vx1tr1XP260GLovld7gFpN
	 3x4M9onXBReyHc73Ax8qyEM0FhkymzvWShAVnEIDcnrGrQXl9uzkOGw2ekceqGVEMq
	 UO4YyCzMSZEUGzEDnfttuytj49eHTEx0x2r8NLiZfyO7uqqJjjcR7/91V2xJ3VFtow
	 XI1MuIqQg1QPBbxFgiD9k/nXdgRFHWUWcExhk1XAlxVcoMYgddarp4Ype1+S6ZT14u
	 wL7FcxWsSDcWFVXbM946ACh+ExeRSdvqF/n6vcNSs/Hzxt12KEukYn4njtmXWsDNXU
	 C3LRJMs6H07YQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 29 Oct 2026 21:43:53 +0100
Subject: [PATCH mptcp-net v3] mptcp: pm: kernel: c-flag: keep
 local_addr_used in sync
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-mptcp-pm-cflag-clear-when-used-v3-1-fa96c11f97b0@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WOyw6CMBREf8V07TW0QFFX/odxQcsAVSikBdQQ/
 l0eK1fG5WTunHNH5uEMPDvvRuYwGG8aO4dwv2O6TG0BMtmcmQiE5EEgqW473VJbk86rtCBdIXX
 0LGGp98gIOPJECZnGcchmSOuQm9cquLJta9Gx21b5Xt2hu0WwHJfGd417r88MfJ1sXiF+eQdOn
 GIudXBSESDjywPOojo0rlhtg/iPJ2beUSe5ApdSJdEXb5qmD41zCeA6AQAA
X-Change-ID: 20261006-mptcp-pm-cflag-clear-when-used-ee817b26a553
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Yiming Qian <yimingqian591@gmail.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3160; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=twD0CVuiFXFIfQbtKmiuVMcUBNt11GkeOP2CXfNt/Vc=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIeb/x/19u0PKT/iOtftdDtAa5lnV8eiuinpMfafuY3V
 1qkyczeUcrCIMbFICumyCLdFpk/83kVb4mXnwXMHFYmkCEMXJwCMJG/cxj+x+050bji0K9Q1z7J
 ZTW+5+d/ljjaepLv5LbsudxW5561MTMyPFwln246aXNCl/P/lmudol+5c7iO3LQ/GLL9Q4VWs5Y
 RDwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The ID was marked as used before incrementing local_addr_used counter
when the families were not matching.

Marking endpoints as used while they are not can have an impact on the
local_addr_used counter when endpoints not linked to the initial subflow
are removed -- CAP_NET_ADMIN is required -- and active connections have
such badly marked endpoints. In this case, the local counter will be
decremented while it shouldn't. If the counter was already at 0, this
warning will be emitted:

  WARNING: net/mptcp/pm_kernel.c:1080 at __mark_subflow_endp_available+0x46/0x50, CPU#0: a.out/149
  RIP: 0010:__mark_subflow_endp_available (net/mptcp/pm_kernel.c:1080 (discriminator 2) net/mptcp/pm_kernel.c:1076 (discriminator 2))
  Call Trace:
   mptcp_pm_nl_del_addr_doit (net/mptcp/pm_kernel.c:1112 net/mptcp/pm_kernel.c:1227)
   genl_family_rcv_msg_doit (net/netlink/genetlink.c:1114)

The fix is easy: increment local_addr_used similar to what is done in
mptcp_pm_create_subflow_or_signal_addr() for the non C-flag case.

Fixes: 4b1ff850e0c1 ("mptcp: pm: in-kernel: usable client side with C-flag")
Reported-by: Yiming Qian <yimingqian591@gmail.com>
Closes: https://lore.kernel.org/20261006114409.117190-1-yimingqian591@gmail.com
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v3:
- Reword commit message: the issue was only with mismatched families.
- Link to v2: https://patch.msgid.link/20261022-mptcp-pm-cflag-clear-when-used-v2-1-8c7fbe166b74@kernel.org

Changes in v2:
- Move the increment of local_addr_used before checking the family,
  similar to what is done for the non C-flag case.
- Link to v1: https://patch.msgid.link/20261022-mptcp-pm-cflag-clear-when-used-v1-1-516c09b4ee65@kernel.org
---
Note: this patch supersedes the patch mentioned above: the author
doesn't seem to be willing to send a v2. Because security@k.o was Cc'ed
on public ML, that's forcing us not to wait, even if this fix is just
about a counter that will be wrongly decremented when MPTCP endpoints
are removed (requiring CAP_NET_ADMIN). Put the original author as
"Reported-by" following the recommendations given to maintainers in such
cases.
---
 net/mptcp/pm_kernel.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index d3014bf57bf3..fb611c4b3eb8 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -584,13 +584,15 @@ fill_local_addresses_vec_c_flag(struct mptcp_sock *msk,
 
 		__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
 
-		if (!mptcp_pm_addr_families_match(sk, &local->addr, remote))
-			continue;
-
 		if (local->addr.id == msk->mpc_endpoint_id)
 			continue;
 
+		/* Increment before checking families, similar to non C-flag */
 		msk->pm.local_addr_used++;
+
+		if (!mptcp_pm_addr_families_match(sk, &local->addr, remote))
+			continue;
+
 		msk->pm.extra_subflows++;
 		i++;
 

---
base-commit: bcc5638fabf418e763621a432840cf55287e604d
change-id: 20261006-mptcp-pm-cflag-clear-when-used-ee817b26a553

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>


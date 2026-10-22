Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792666190;
	b=OfdsuPNDvGrH0Q8QR12RxHOsbHaZ4K3s0TIfqYSQirC97rFLyLGhSk+gby1x4X8gUZym
	 nixWZRMYgY4CQwsJf79u8zs9XXSe+994SLdPFzSDQQuov1j5Ru0kc3ssVk+1GvMjX+iRJ
	 Fl+CerJtAYwB9ISZiCuzSdcTvm24ie6ax6WOABLgDlAildxyq+Fha6UDhZgMmqeM4MIOW
	 2ypFag3hgZdHRUsrh5KOu8SDm2IuCh0ruCJ2gsvfNIlBJriV+VjgLSklerD9KX9aIHAoQ
	 ulv+ZBWYqU6wfTepzcADUCJ/bSKEJfOiCD8Xwa+E7Pk/SutMEoC13aHg8FM+ImfRiQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792666190;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=iRq9o8OxwV/We8U37RiDIMbZUlVEe98MYoWABT/xNrk=;
	b=CrxxReUt3Tp3OE97M6aBAizv35/bs92UUY9HjPXsts3wczOmJXgjcXeMTt67sv1Bc3P/
	 z8s+t1mvgjgfsQLsJCYcHAnDSpkUcOC4YiIzHg6ibDYDLnYo2mqNW7bFA98eXMoDRJB8d
	 QZnPzVkqKrjj1LV5fYXGY2MD0QuqNcKkf0FHWE0op0i7lNo2wpXXDzegWP2EjYHtOa5D4
	 eX1q8UdmSfpvisZ0QV+BlzDRnJn5LiBJY7LovdAQTk4Loi7LOUGRm8a+wzt1nmaNzJMD7
	 8SN1JXxiar8uyEBZZAOWrWPojdz6JAhm9qHmudY93iy2/y9ZgE0ly5ZkHysWjqoHhQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XpTC6LPP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AD8606A31D
	for <mptcp@lists.linux.dev>; Thu, 22 Oct 2026 10:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XpTC6LPP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1ECC1F000C1;
	Thu, 22 Oct 2026 10:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792666189;
	bh=iRq9o8OxwV/We8U37RiDIMbZUlVEe98MYoWABT/xNrk=;
	h=From:Date:Subject:To:Cc;
	b=XpTC6LPPqLkUwBiMzqwrXCZ61NY55knH6zhR4Vr9W94EnJuzMVqcNKDxsjlwr+a2b
	 tsR578tg0LPXLid80WfqbHJrLfG6NE5MOcMFsiSv+R1Ah1icdt1ZRF0cEGBuTyzV0K
	 4owSEBVlNnnhpcWxi3/TKoPJLrSrohqRYuMo1D0Aka88n5bSZSavmTCgekOcGA31rF
	 p4vVV17sr/TstWMbMTvVo57OhXtey+mSKKaB63lCWLJg75M/JTgpeQogJ4t7plefp6
	 3i2UbQjQ6nSKqOcghe4p9FY5hCzsbipODMUI8SEZR5XrlIA6xMU4vPS+lH/u5z6pfL
	 iIQreFRVq2sEA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 22 Oct 2026 12:49:42 +0200
Subject: [PATCH mptcp-net v2] mptcp: pm: kernel: c-flag: mark as used only
 when it is
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
Message-Id: <20261022-mptcp-pm-cflag-clear-when-used-v2-1-8c7fbe166b74@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WOSw6CMBRFt2Le2Gfaautn5D4Mg1IeUIXStAU1h
 L3LZwEOb+7n3BEiBUsRbrsRAg022s7NQux3YGrtKkJbzBoEE4ozprD1yXj0LZqy0RWahnTAd00
 O+0gFEl34ORdKS3mEecQHKu1nBTxg6zpKkG1W7PMnmbQAlnBtY+rCdz0z8LWycYX4xx04cpRcG
 XbNT0RK3l8UHDWHLlSQTdP0AwM5bwTqAAAA
X-Change-ID: 20261006-mptcp-pm-cflag-clear-when-used-ee817b26a553
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Yiming Qian <yimingqian591@gmail.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3003; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ubjxZVgLI7IIKXDyF4gvcSiow+ogkg8vDP2RZobvaa8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJuvvJRPP99GeeEx+rL411UrnpWaXOuTvjKsFtr7bvgM
 4VLi9and5SyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEzkSwzDX+HDn8NXq2nzvX/9
 P55JsHWf1dyW3ESLnqL5qu9eiNT/uMLIsGez/n3roKitqWUz+0/Fa0/85/jgsW3f+s7Die/Lb6c
 38AMA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The ID was marked as used before checking if it could actually be used
in all conditions: if the families match and the local endpoint is not
the one linked to the initial endpoint.

Marking endpoints as used while they are not can have an impact on the
local_addr_used counter when endpoints are removed -- CAP_NET_ADMIN is
required -- and active connections have such badly marked endpoints. In
this case, the local counter will be decremented while it shouldn't. If
the counter was already at 0, this warning will be emitted:

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
base-commit: 894c5749a6139dffd3687f165fb7119f9e572ed3
change-id: 20261006-mptcp-pm-cflag-clear-when-used-ee817b26a553

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>


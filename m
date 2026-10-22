Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660493;
	b=jrCKjoHXZ34eDL4Nqkp0jpkCBn+oDT7YeN7ObpFTtKL/ViaLLhpc6BpQ9wSlB/UFInOm
	 5ZjoV4K9UFe8rQgEkKDNHXUQeRqOwaiv5EXrxDhexhBJhOu3JGglFMIwaYeYd4MkmTJsF
	 36UOb5yRFaln663UsXu68n763uyBi0JXLmLkpXrRSnByQePiCbYw+Kun1ogtEGGGXVMOL
	 UrFGLGSLCwsLiwTeh1jbM3T1Oiu+w35YCFzQFoxwiO01YiTLpqNPi/bpn1jhkNgxN5Air
	 zEzzjhqmX+X1EVhA5puTiSVqNhpW63rkjqCuuXGvtkFnnupa48I4xPyHJt+JYlFan4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660493;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=zxxeofD+EPYO5ZsBWOUmC2qylsENThVP2MxjIRmX+vs=;
	b=Ah00kdeSOSskylnTbD9jnm80+VNRUzgZwzdaExmMnEMtTMqFmaxcVsjTOmgQrbi/Fgmb
	 d/+llEK7OtC9Yo18/leAHiS98BzKF/QJvO3NSoWXfMepaHGgItxkUw58KNF17VmTwvfpl
	 BwErLTub9EG846i+n8lzopckMSblfTMrYXffdOmBDibbqnj3pc+9phNhF6/fQ+hNZyMpH
	 o+OApBVC/vnL2/bcrXb5q0wrusMd8nEWL2A7Uo/sigN+2u/CUnrevVHgsN9yd6ilVZE2I
	 MfJK2t0QNMTiHsNtaODr7VrypxagmxYbt0i6AX2OhDbd5Ttl/rmAH5ryQsyI+8PLWuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iaXYTb+N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F61606A324
	for <mptcp@lists.linux.dev>; Thu, 22 Oct 2026 09:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iaXYTb+N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBECE1F000C3;
	Thu, 22 Oct 2026 09:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792660492;
	bh=zxxeofD+EPYO5ZsBWOUmC2qylsENThVP2MxjIRmX+vs=;
	h=From:Date:Subject:To:Cc;
	b=iaXYTb+NbMnYz5EsFWkyG0VNF1Ru2UzY7omepN3GjDYxpJ7C5ytRNicl70KsXA2kF
	 z47OhjeubqUKw73glRtkO1dSAiNIi0Wz1CBss1m38hy05EbpupPXQSKEkmZjZL/IW1
	 udHYuZb6hQ8bRN9wRifO+7dI8WwDa+3Q+Gb/wRPZlsj8Aw+w2BrUfaWFaYaeHC/M6t
	 IpqAcMoCgyfZRgY6IiCBN3ndjcCkg9kCvnQm1FBiTT1tOPLpkVDRRzJt8DJtsguAri
	 JAOVchTwByesVdeFggdhm9BBUhqdakER09XIEgvnIh5x2wwBhpZADMK4ocN6wCI7dv
	 b6GnpuBjWJQ7w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 22 Oct 2026 11:14:46 +0200
Subject: [PATCH mptcp-net] mptcp: pm: kernel: c-flag: mark as used only
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
Message-Id: <20261022-mptcp-pm-cflag-clear-when-used-v1-1-516c09b4ee65@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNQQqDMBQFryJ/3Q9JimnpVUoXMT41RdOQRCuId
 zety+HxZjZKiA6JHtVGEYtL7uMLyEtFdjC+B7u2MCmhtBRC8xSyDRwmtt1oerYjTOTvAM9zQsv
 AXd4apU1dX6lIQkTn1n/gSefXI9PrnNLcvGHzL0D7fgDD3jCjjQAAAA==
X-Change-ID: 20261006-mptcp-pm-cflag-clear-when-used-ee817b26a553
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Yiming Qian <yimingqian591@gmail.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2707; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ochH/O2ER4VQ5omCLwjdEiU2pn0c6k0KNoAAUDaLIng=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJuXuGetWjj8ZpJQryTLpf3CrY8Vlp+xkh+pw//y5U+G
 9MDv5qqdJSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEzk2WmG/1mLO5u1DF8UrFXu
 /1FVrBW5Zt3mjZ3Bzx9ObWuYuGridDtGhmdxj+9GNmQ9OP9qW9u/m4ELk7ZPXK8fP+3pNBlB5ly
 PGFYA
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

The fix is easy: simply moving the '__clear_bit' instruction after the
two checks that would cause the endpoint not to be used.

Fixes: 4b1ff850e0c1 ("mptcp: pm: in-kernel: usable client side with C-flag")
Reported-by: Yiming Qian <yimingqian591@gmail.com>
Closes: https://lore.kernel.org/20261006114409.117190-1-yimingqian591@gmail.com
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Note: this patch supersedes the patch mentioned above: the author
doesn't seem to be willing to send a v2. Because security@k.o was Cc'ed
on public ML, that's forcing us not to wait, even if this fix is just
about a counter that will be wrongly decremented when MPTCP endpoints
are removed (requiring CAP_NET_ADMIN). Put the original author as
"Reported-by" following the recommendations given to maintainers in such
cases.
---
 net/mptcp/pm_kernel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index d3014bf57bf3..3e473a81389d 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -582,14 +582,14 @@ fill_local_addresses_vec_c_flag(struct mptcp_sock *msk,
 		if (!select_local_address(pernet, msk, local))
 			break;
 
-		__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
-
 		if (!mptcp_pm_addr_families_match(sk, &local->addr, remote))
 			continue;
 
 		if (local->addr.id == msk->mpc_endpoint_id)
 			continue;
 
+		__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
+
 		msk->pm.local_addr_used++;
 		msk->pm.extra_subflows++;
 		i++;

---
base-commit: 1c36f79c9bd761bc3a41d246d7a4242b287d2fc7
change-id: 20261006-mptcp-pm-cflag-clear-when-used-ee817b26a553

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>


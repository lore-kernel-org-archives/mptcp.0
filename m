Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1DB1CEACB
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 09:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758272915; cv=none; b=YjmIkGxNrKkYtxegZAJ3Ao5hEDd3hoA7F+XoKjltP1I58RE+qA4xIYn2EQf0ahSdXDszlixU8HtXjep/Vlv51m3YUT7AIID6pOjoOgDM1A905hju6swVaYG8LVOquYmJzp/6apGy6F+3+qTFeNZF0gCoo66VxOQFw9sMBE2ok7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758272915; c=relaxed/simple;
	bh=orelVtxbTTbODrybUujIewTjgoHi5oj4VrIx+MJSw9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rqX0QoHaDDr1Iurx4Nh8vo6h11xyo+JS1GporEDAYsnI+5US+zfYIeeXkEhQCtTsauLddA+hEjDng8k1i2Hz+ZT8dNVmMAC24XgqIJd4sCScMpapA3PkovgKoN0wL1qyHvQ4drEWirq8Kv4C9DD9UCSRl+vYdS7bZyrhkTtthtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGZNPrIM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGZNPrIM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A58C4CEF1;
	Fri, 19 Sep 2025 09:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758272914;
	bh=orelVtxbTTbODrybUujIewTjgoHi5oj4VrIx+MJSw9g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CGZNPrIMivaaU3RCPs5NCsoZV/IYjPNO5OuhcaRXonpcavF7JLZd6W1SWuNR0E+Fj
	 yjIAKx7JzogjddOj1xk1LLG3MsG2LfliF9X6lqdKb+u29h9BPkUOavMPizfH2hC39c
	 dI4vtmtsmS6HWN2ATftSYXCMfW4eZoTl1zByOabmt8/EZHi083e0ikuyjoIep0YMLO
	 NStBD4JvSC8XcHYQPDIUxvsTbn03AY1IW/klvbRUerrHER4Tq/Nhnxfgf6BE02l2kF
	 swWJDauhzg1faepfwea6srKybTsMQ6X+cl6u8++k4lWex/5113KFBWz/FUvkfg/OKf
	 kRltbtdI71mTQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 19 Sep 2025 11:08:07 +0200
Subject: [PATCH mptcp-next v2 01/10] Squash to "mptcp: pm: in-kernel:
 usable client side with C-flag"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-pm-kern-endp-add_addr-v2-1-1f8f04f01914@kernel.org>
References: <20250919-pm-kern-endp-add_addr-v2-0-1f8f04f01914@kernel.org>
In-Reply-To: <20250919-pm-kern-endp-add_addr-v2-0-1f8f04f01914@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1802; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=orelVtxbTTbODrybUujIewTjgoHi5oj4VrIx+MJSw9g=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLOyja57Fxl+Sp/36fcg5J7z37aU37HzVTv7/q1i0UZ/
 jhen8yp2lHKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjARy6MM/yxCLFvdFQ/yND7c
 unVPLENuocTvCGM/NltO1RgB5ZXKFxkZzuVs7m6b4JcZJ8ci62GoMHPKp70eHdyeH7je6E6Q7I/
 iAAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The id_avail_bitmap is only used when either the 'subflow' or 'signal'
flag is used, but not with 'fullmesh' only. Here, it is replacing the
'subflow' action, so check if this flag is set.

Also, add the check for the max subflows upfront, so we avoid scheduling
the worker with MPTCP_PM_ADD_ADDR_RECEIVED if it is not needed.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: modify protocol.h here too (Geliang)
---
 net/mptcp/pm_kernel.c | 3 ++-
 net/mptcp/protocol.h  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index d7cd89fa6a11a1ea7703edbfbdf2bbe86a6a3054..277f81f38134d07918143331746a50bc316d81ca 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -411,7 +411,8 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 			locals[i].flags = entry->flags;
 			locals[i].ifindex = entry->ifindex;
 
-			if (c_flag_case)
+			if (c_flag_case &&
+			    (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
 				__clear_bit(locals[i].addr.id,
 					    msk->pm.id_avail_bitmap);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index dd0662defd41c84474e44c559c571e3594b85d9e..0d6dae37c9daf4ec8990b9a87036aa393add585c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1200,7 +1200,8 @@ static inline bool mptcp_pm_add_addr_c_flag_case(struct mptcp_sock *msk)
 {
 	return READ_ONCE(msk->pm.remote_deny_join_id0) &&
 	       msk->pm.local_addr_used == 0 &&
-	       mptcp_pm_get_add_addr_accept_max(msk) == 0;
+	       mptcp_pm_get_add_addr_accept_max(msk) == 0 &&
+	       msk->pm.subflows < mptcp_pm_get_subflows_max(msk);
 }
 
 void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk);

-- 
2.51.0


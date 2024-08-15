Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3325BA53
	for <mptcp@lists.linux.dev>; Thu, 15 Aug 2024 20:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723754766; cv=none; b=kfmbjNRpL1sUigCFLszVdPLNastooyHfSTX4GsB5OJmljh4wyAkyNBqyTt5XsK6WPasUjL7pL8HDBJSOe3KiUf//+ifnLyIVLBpcs1sTRjmmu1w8U2NQaOdqi+RYcF8yMUrALG4Oxh0GTNrTNpVrcWAiO1O3Yj3sb8p3HZrZvQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723754766; c=relaxed/simple;
	bh=7fYVhVSiDGBxhZaQ+j8WgFHVziAOkGMTgOJaJhC1Z2o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VwcRbnV5x3Vw+wimA54PLrAvo9IXVZJ74Yhag5LkKvwSyUCF7K7yCJlswmRP8HykueswL7WbqtI9KDHlAF3iTr8E0r+zfgl1nAiPrzJNEODHz/GLKelaFAwK4M284ODm8eSbbBAFetM/ZG+cyhnlfZdu+1JYuMNWmOayqP9fg/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNO3k7Ua; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNO3k7Ua"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8967C32786;
	Thu, 15 Aug 2024 20:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723754766;
	bh=7fYVhVSiDGBxhZaQ+j8WgFHVziAOkGMTgOJaJhC1Z2o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DNO3k7UaLJ78GCxKIxD5w7maVD6EcDBlk5DCs4Cp46r4EXMIReT8gDN/GUzrN7khj
	 p9RH9Ob9wI5XtTzdpDRNVS/Y0Etf1Uz/VBoCTeZ8h4qtNN+k1+v4lOw1S7D9N1iQ/C
	 X82ocxuRSFoByP23ef2tbmuQDpO9MpozI5xAHpE8Cc3UpIKsGGs+4yXjfaM7bXvz67
	 GNTQznQdYv7ji5yGkX+SXn2FZfSuKwAnUH0yDn4UsWGtM++NWK7JISgxbgMjJHZo+V
	 QE1VkmJYfejq/5IJvMfgNEYYsjwLHuSjrjlvCh9Uo974Yof7AHFbvgh8WhCVvWDv3i
	 OpdoDXF/umTbw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 15 Aug 2024 22:45:44 +0200
Subject: [PATCH mptcp-net 03/10] Squash to "mptcp: pm: reuse ID 0 after
 delete and re-add"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240815-mptcp-dup-close-evt-v1-3-5a551d3a66cc@kernel.org>
References: <20240815-mptcp-dup-close-evt-v1-0-5a551d3a66cc@kernel.org>
In-Reply-To: <20240815-mptcp-dup-close-evt-v1-0-5a551d3a66cc@kernel.org>
To: mptcp@lists.linux.dev
Cc: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1266; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=7fYVhVSiDGBxhZaQ+j8WgFHVziAOkGMTgOJaJhC1Z2o=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmvmkJAlNYVTs6lki+KKPM0FdeqMJuH0L3we8i7
 fqadLPNhiqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZr5pCQAKCRD2t4JPQmmg
 c9BGD/9n4jKzvP5Tojl4ILHICtK1qHolGc21TZCeeYvQF/wxaYTo7gSVqGGzyCeJSn7B8QWy1ev
 tzDabidUzcDlZA7IeNpq4suwHlPoddtkRMhVT/1Jks5nZTPOQfdrzsYwha2DZ12fAGt9aZgfz9V
 OQIR45/slCB9rIUcI0COMddn3viPb/ENaSXwHz/cR837NmjCvXBssdYBuzeLF/S9a75/teDRNmZ
 ItcF518Xsy4eiZExZudJb2gvHGtSeZ/l2FzIOWLG/fKXfu3wmgrCKS+Omzbbed8qBJPPkrEhj7A
 7EDFtKRRC3KRnF2v0oyG+Kq0f/Hrq0NJMVjNsqt5773DJf+8tiDTYwCvnwblcaqXcSIhi12ML/r
 uGimMpXYPWu4YuA2OfVKPi0jbnRCFPogVI2qYsZh2B/BIsrMNPci+T07sJNopFMjN1xXix/rvpq
 q9yEojcB0lkzE91ZHq08bn9BSYdhP7g3wMeHkFwH6Nuu1Oof1/OLGYNbFo/hFbutqFfx5rF3YMr
 rSYCuGqWy79yK1tDPLc6QU56NDCxluP2IrkvuSB6CHiPhEHF2vk4yHaVtma6VBYWndWD+AhhVH0
 RSDilVT6KhrSFJ1+Z/5L7yCCFSurP6a7YkO2Xw6ZRlLJaDKLmIDX8HtRNN50Tv0zu8ozQJEoD3h
 LR0+FUEtpruR2VA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Set the address ID to 0 before calling fill_remote_addresses_vec(): for
fullmesh cases, a bitmap will be created after having looked at all
subflow IDs matching the local one. The ID visible on the wire (e.g. 0)
should be compared to, not the one of the global endpoint (cannot be 0).

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 0881983f505d..b2d950e4d7a3 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -621,14 +621,15 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 		msk->pm.local_addr_used++;
 		__clear_bit(local.addr.id, msk->pm.id_avail_bitmap);
-		nr = fill_remote_addresses_vec(msk, &local.addr, fullmesh, addrs);
-		if (nr == 0)
-			continue;
 
 		/* Special case for ID0: set the correct ID */
 		if (local.addr.id == msk->mpc_endpoint_id)
 			local.addr.id = 0;
 
+		nr = fill_remote_addresses_vec(msk, &local.addr, fullmesh, addrs);
+		if (nr == 0)
+			continue;
+
 		spin_unlock_bh(&msk->pm.lock);
 		for (i = 0; i < nr; i++)
 			__mptcp_subflow_connect(sk, &local, &addrs[i]);

-- 
2.45.2


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D109817
	for <mptcp@lists.linux.dev>; Fri, 16 Aug 2024 11:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806136; cv=none; b=j1K4ZikuQJ1mkYmne+LafoNDjvZPA4i+4x64AKO1nTtTbSJW22ouM1fNfqvVLlxR7fNMi10AZPL175YPuUQU22ZhqXakxrDXj60S5iuoSkbP4VytBeE8RmxN17aQmocnTriL0NiKUi20P5IItzgZqVMA098jLJ2kMjNXc9BrHoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806136; c=relaxed/simple;
	bh=LTGbYf9O9GRqZOAxsvgV9QVTfJsxb96kEGOsOcJ1EeY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u+rjT/D33e2rP2xRhkFMEPG5US29DSwtQEMx1EF84RqdUQD0Z5yo9msWNJ/GVu2WKbaZQrQFsBf3+XX0tkk2CawczSIEO9gK+TB4J6stB+F8ZEdKsJRy3iDla3MarL9nB//s6goS32I8ZoQfNKkAIs/ATvtHpqx+1WeYHUJSkCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XyG/zCub; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XyG/zCub"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 306C1C32782;
	Fri, 16 Aug 2024 11:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723806135;
	bh=LTGbYf9O9GRqZOAxsvgV9QVTfJsxb96kEGOsOcJ1EeY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XyG/zCubQnUUdQ+cKbvA8wJUgUee6tS4m2M4FqmXIaLoWF+Aaf/pr4wV2W4G8OU24
	 +z/ac54DLpfB9G4ANAfdjY/otczJqS4f7E0Qzct6MOW9wS8/kiH+qfUsAPvotC76am
	 zEsjuhPM3MMk5q1ajbYiPAEMDCQVKT/sTVUqcR4Vnv8xEeFe7bb2NS9pGlldCojplY
	 KkrED9V3KYJ7R3oNKjkivRZUbWy4VfO1vsX1hFGdP3IpH4pCf7NIQVHcvzHvGjMTR/
	 Uo8pFGgarcCoaOiPJoV+Wop0WSEieDQN6ViPpIiN+MskN4khfFKTSHFfNlpJk7HeqK
	 2Mrp5uXHzOSmA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 16 Aug 2024 13:02:01 +0200
Subject: [PATCH mptcp-net v2 07/12] mptcp: pm: fix ID 0 endp usage after
 multiple re-creations
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240816-mptcp-dup-close-evt-v2-7-8a33f6617f5c@kernel.org>
References: <20240816-mptcp-dup-close-evt-v2-0-8a33f6617f5c@kernel.org>
In-Reply-To: <20240816-mptcp-dup-close-evt-v2-0-8a33f6617f5c@kernel.org>
To: mptcp@lists.linux.dev
Cc: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2038; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=LTGbYf9O9GRqZOAxsvgV9QVTfJsxb96kEGOsOcJ1EeY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmvzGuNYEY3tVSjCAhcl7e4opT/v9ORM5aWXAr4
 YnQAoe2PAGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZr8xrgAKCRD2t4JPQmmg
 c6KLEADEX10VWGT4nXxqF059nILmcsuOWB8B0E7yzMonFgat+4q0ujXLFDNOY84uQmWslVn7/kM
 e3i/3Ve/WBOTzAbyFWTceIG5bfw/AetDi5fmFPlx5sLtxGUM/w781eJ7VnGRFyQWwzBOWo+CKL8
 ewPv1VCLPrw51GxAurlMKVDgtXSOmCCqo9Ba7MeziXe+rVzLFj9Oth37UVbZvny5qPXLugIGf+G
 X62O4oCI8HICV7RLE1BkZLstxqY2sWJQxB1MVGQK7klGnut9U8oTnTf/pyoE+i1LsSLIaRshZSi
 TgfaAZXvNMS4oXRALAMSkDFi/RPTJ+4fsAcHK5ZpTazjN9LvqPreNbPnODNmvF/H4QEe+1pDHJh
 ebKfSuYK2rSPKpHJQghWDDpVWpm8jHCyztOaqXJh1+HxnHZChdb16MWoKR43oaa9Bih7BMoEd+L
 ug6TK5vhKMAsUcgzTTGKY4P9YL5z06LM4SlSfpGo0NClFeQR2is2Ken8SM+pThokG1tvfPm1XNX
 pK8lGlIr4anU8CLvMMD0g6kDY+XcX23eaAaFfAyalzziIuqCIjNqpnUYlczofo0JFWCqJRtbq/9
 8lbGMN3Ik0DtS7qARyBPAv1k/8Y6NBgMM/RtqrOSOUtclUHLt8GRaxMEAOZn2Mzi7ZvnpbkyojI
 wbdSfLZ2Th0muXA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

'local_addr_used' and 'add_addr_accepted' are decremented for addresses
not related to the initial subflow (ID0), because the source and
destination addresses of the initial subflows are known from the
beginning: they don't count as "additional local address being used" or
"ADD_ADDR being accepted".

It is then required not to increment them when the entrypoint used by
the initial subflow is removed and re-added during a connection. Without
this modification, this entrypoint cannot be removed and re-added more
than once.

Reported-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/512
Fixes: 3ad14f54bd74 ("mptcp: more accurate MPC endpoint tracking")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 952982ebac17..6a05eacd59b3 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -619,12 +619,13 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 		fullmesh = !!(local.flags & MPTCP_PM_ADDR_FLAG_FULLMESH);
 
-		msk->pm.local_addr_used++;
 		__clear_bit(local.addr.id, msk->pm.id_avail_bitmap);
 
 		/* Special case for ID0: set the correct ID */
 		if (local.addr.id == msk->mpc_endpoint_id)
 			local.addr.id = 0;
+		else /* local_addr_used is not decr for ID 0 */
+			msk->pm.local_addr_used++;
 
 		nr = fill_remote_addresses_vec(msk, &local.addr, fullmesh, addrs);
 		if (nr == 0)
@@ -754,7 +755,9 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	spin_lock_bh(&msk->pm.lock);
 
 	if (sf_created) {
-		msk->pm.add_addr_accepted++;
+		/* add_addr_accepted is not decr for ID 0 */
+		if (remote.id)
+			msk->pm.add_addr_accepted++;
 		if (msk->pm.add_addr_accepted >= add_addr_accept_max ||
 		    msk->pm.subflows >= subflows_max)
 			WRITE_ONCE(msk->pm.accept_addr, false);

-- 
2.45.2


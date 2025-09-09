Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD18233EB14
	for <mptcp@lists.linux.dev>; Tue,  9 Sep 2025 14:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757428432; cv=none; b=Rloq9mlsdO+SUEHZfslHluSIXt3t8P1UtE/R94sk1jD9Yc1SuxS5gcPfd3TPdCqs0IGp6s/3HpPuUj241CuOoy/Bz6s9XFztQJCx0cvb2lvd7V4whNZ84xSYp8zkV1z83YwpxyLedLGSGXSWRrjk1xobiQZfjEqZhjmgiJA6Td0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757428432; c=relaxed/simple;
	bh=5E12JAI4AyzRgMto71JfMTjnNF4ahYzAAEclg/PXuCI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U0c0IlNpzjZ78ZiccDtkjVIkvDqr+s5G0LedgFGB6mPL8a0AdRBZS2Skt0pTnaKgCQoj6jY8gN361ym1C57o3ywUZ+ZKjjJACXcUfzeeL+1Shb64qqiNjXfS7lnkLQ+l+FfPZ+977Vz7ladoR0tm57D+HBnoi9+L5H7CEUPhWYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMDTtiul; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMDTtiul"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2E4C4CEF7;
	Tue,  9 Sep 2025 14:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757428432;
	bh=5E12JAI4AyzRgMto71JfMTjnNF4ahYzAAEclg/PXuCI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fMDTtiulUU5h+gI9H0Du4jE4o8wXnasUWEspY/eF1+z5BDtPATm3ou87hcM4TOPvg
	 fqnzSRenBXuE2Tzgqi8m73wPq0CpinEGa1Vdvdtru3RH3zQsnEAfqpTxo/L8CTlUnv
	 l3X6fs7YZYniI226GQQeij70WmSYE8wK8U/U44g20tqqiWz+OQ55pLZ78P/CIsL/6Y
	 9hxOi4eeyvnkuOH91SoFPCD6LYHivM42H82w7XmheHWo46yprthtEE6dwGHbTY6p0L
	 CfoMzjZ48l4brvhBpA5sdSA4Kg2OVrYav7MGZrPuxQmeh3loZZu9qknMcWzySeMkng
	 ovEDhOvdbdWoA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 09 Sep 2025 16:33:31 +0200
Subject: [PATCH mptcp-net v2 2/5] mptcp: set remote_deny_join_id0 on SYN
 recv
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-mptcp-pm-user-c-flag-v2-2-a6f9542481c5@kernel.org>
References: <20250909-mptcp-pm-user-c-flag-v2-0-a6f9542481c5@kernel.org>
In-Reply-To: <20250909-mptcp-pm-user-c-flag-v2-0-a6f9542481c5@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1206; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=5E12JAI4AyzRgMto71JfMTjnNF4ahYzAAEclg/PXuCI=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIOWJ14ssjnzXPT9rNHcnY7L+C5ul5UIt70/Jsn+hc1T
 i+TX6x+v6OUhUGMi0FWTJFFui0yf+bzKt4SLz8LmDmsTCBDGLg4BWAiVx0Y/jvY3Spuen2VQ6og
 U7136rcN+qJTpFjMJFLa5qZ8+LTl5EGGX0wPHp/iFGY+ZDuTe1ElS/CKy8uUZ2p85eTcmLaej79
 bnhMA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When a SYN containing the 'C' flag (deny join id0) was received, this
piece of information was not propagated to the path-manager.

Even if this flag is mainly set on the server side, a client can also
tell the server it cannot try to establish new subflows to the client's
initial IP address and port. The server's PM should then record such
info when received, and before sending events about the new connection.

Fixes: df377be38725 ("mptcp: add deny_join_id0 in mptcp_options_received")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/subflow.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index c8a7e4b59db1150610f99d6e599a9d4cf7e137bc..e8325890a32238bd1fd558b955137a2fa32f66c2 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -883,6 +883,10 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 
 			ctx->subflow_id = 1;
 			owner = mptcp_sk(ctx->conn);
+
+			if (mp_opt.deny_join_id0)
+				WRITE_ONCE(owner->pm.remote_deny_join_id0, true);
+
 			mptcp_pm_new_connection(owner, child, 1);
 
 			/* with OoO packets we can reach here without ingress

-- 
2.51.0


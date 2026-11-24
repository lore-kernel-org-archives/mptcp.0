Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557715;
	b=IzRT7Viyz2bHrT0mMWOuQC7gcTvnf9sAkjLQotTrHwawfmOSgQlcHP2ITxoNwVC25WCq
	 a0dQEvSn7PVVqt34lzWDbuofZv7ND0/5wRswHP4vfCx6IaRG37c91vopc2jSvn+5c8zhz
	 9aJ83jFN6rGtTdUj0BMXVkGnR2VyrZ/s/NJzZ9yA/1alynmKmGPv8YBIfRe3AnSn+jjeE
	 qtWB1FR3wbHi2fbEHS4Jt2LhD3lCg2V5zstyMzGJnYOuTjjYEUSw84f0cL0K/Gl3YwRjq
	 p+9mon9ve5sFS4DOR49I2P2NWrP6eY/KYxDwnkHNSQzQbw80QfBkUrL5wUxQehAtL/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557715;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=EWoHBY+BB6ZCC1JySWSWV/hMjELII5E3R7ugWCGN40o=;
	b=db6IdXGqMG7smf8RORsPKMdDfQnnwYBAsK/nZ7gn4leOBzdM+2fIggMGJtWbEA42uCXR
	 PpIs4pyowi7BEbYzvEdXQFHS3ht8Z3RJ5yZpRCHRMEllvxGKoNIRDjWLl2rCcLJqqjRrT
	 AO85F3WOzYnZ/3TP6d9SIjuYrGCbD8X+S/p0JF1lTtFhAgpMM2J/xQAkdQCyYY2T95LdO
	 eAjOGvlDJ6ayKC0Zil2m7J9y8RV3+CIrAH3LpeOpdV8UWj/x8Al3KIl6/wVNV8fUirmRB
	 n8qu9VWlc0p+jOtQymtivBTK/zgaK0akOY/QgW2Ta/Poxd/TjHDnSv97elriRj1G40Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aZ0Tj9gb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60598606A31E
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aZ0Tj9gb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680F01F000CF;
	Tue, 24 Nov 2026 22:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795557714;
	bh=EWoHBY+BB6ZCC1JySWSWV/hMjELII5E3R7ugWCGN40o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=aZ0Tj9gbxq1pVILOgIO1nhxHJk21aHJfO+BrbGT7nYI2yagFj2WmmE2vY+/oRhPhL
	 wL3J0abgOhS/HQqY6F3mcicjHxFiqB2OqRIJE7owBuMK4sszUvLxx33xRFbV204nic
	 PSHy7QGVTzuOFLR0RyP6jQCEka6cUMs+y1dYhiolPdejH78uhSmkGLSw/hPnUB5DXC
	 wBZpGl68XXp/ruIrqA+CJWf7SShRfjJ2WUsrfx2AgvT+suN+XGad8OKRSIeXnW1XiA
	 GtEHQSh2bvIR+O7rUUmWFtZUxERRUCtRZcDQifh62/R13qOl0Pr608JWrESRi0TMtr
	 0nit5kZLiN9rg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 24 Nov 2026 23:00:03 +0100
Subject: [PATCH mptcp-net v3 46/50] Squash to "bpf: Export mptcp packet
 scheduler helpers"
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
Message-Id: <20261124-mptcp-cmason-fixes-v3-46-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2040; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=dsA0uoT5xLmopMB0Vy93rCGpv2MKessFV60gPVmJqv0=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLZOEXeP38jFnTrdI2rQWhzZLvTEQW25j/1JxP+Pe7a9
 jUtguFBRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwET+LWdk+J2Uv2zOl/mNcYp2
 P6c+O+3ynNmo5ZS0WHGc2pVNKn/WrWX4720yaXP0s4+OT7enbnp1V/FdwbfmU1sbKhQTm5tvBS9
 qZwEA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

With a BPF scheduler, the rtx timer interval, msk->timer_ival, is only
set if the scheduler calls the mptcp_set_timeout() kfunc: only the
burst one does. This interval is 0 once all the data has been acked, and
the rtx timer can then be armed with it, e.g. by the next push: it then
fires every jiffy, retransmitting the data in flight until it is acked.

Since "mptcp: arm the rtx timer if a push leaves data behind", this also
happens when a push sends nothing, e.g. in a memory shortage: the
timer then fires every jiffy, until a push succeeds.

Set this interval before calling a BPF scheduler, as the default one
does when picking a subflow, also when a subflow is already scheduled,
as the scheduler is then not called.

This issue has been found by Clashiko, while reviewing "mptcp: arm the
rtx timer if a push leaves data behind". Not reproduced.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, for an issue spotted by Clashiko
v3: also set the interval when a subflow is already scheduled (Clashiko)

Note: when squashing, the commit message could mention that
mptcp_sched_get_send() now sets the rtx timer interval with a BPF
scheduler, as the default one does.
---
 net/mptcp/sched.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 1e59072d478c..01500f9f9f8a 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -182,6 +182,10 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 		return -EINVAL;
 	}
 
+	/* as the default scheduler: the rtx timer needs an interval */
+	if (msk->sched && msk->sched != &mptcp_sched_default)
+		mptcp_set_timeout((struct sock *)msk);
+
 	mptcp_for_each_subflow(msk, subflow) {
 		if (READ_ONCE(subflow->scheduled))
 			return 0;
@@ -189,6 +193,7 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 
 	if (msk->sched == &mptcp_sched_default || !msk->sched)
 		return mptcp_sched_default_get_send(msk);
+
 	return msk->sched->get_send(msk);
 }
 

-- 
2.55.0


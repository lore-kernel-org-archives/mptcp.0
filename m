Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511961DFDB8
	for <mptcp@lists.linux.dev>; Fri, 26 Dec 2025 06:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766731240; cv=none; b=A9KyJieGjqlu4FdlwGdxnGQ0aOOrb1ptRHH1fVrMu8T/uJ1crl7CN8FOPhR7ftd/f5cdmIQl8sumTiZOPWKLL/WoBFBFP0U85635AsHERRuou81p+WtsxAP81/NiziAN5nqIDlCPNj/3kkPvKlOsaDWueMe1/w4gDW5VY/JSQvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766731240; c=relaxed/simple;
	bh=gtUybE9wszvo+9x8LDu2L+Gz8Vg2wf3Wvn6frsIYIjg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=olJG41EWI8RVitlfB9PsiP42F+TU8SHvuVOjXsiri8LLwY5dXAnv5qI9CYesi6N1ptUXFd40eEY8cUNxc5HTH21mKCTR+EPwVLGPuuXmGovO8c53fqVwtWfBk+hknRe4RKUgQrSUnGk2CMluvuLTb9PcEiE87ZkhuZrwSrBnm64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPousf47; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPousf47"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9ACAC113D0;
	Fri, 26 Dec 2025 06:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766731240;
	bh=gtUybE9wszvo+9x8LDu2L+Gz8Vg2wf3Wvn6frsIYIjg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OPousf47zbGRLSQzyD3IGBnTjXg16b//4ow7afQK/Nxuue9c+tsGC7Nm3EVLNF2SJ
	 IwoJ4xkCSYMipdKTvLcDEOeHScCksSDKyd0f7udyQC1ieZ1tjTqAKxE5rzQZju5qfh
	 2MVd2Tpj3NXDWQFhr9kW6Ovyf5XOzDHfnETxg4zeqV8xSImG3JzDNKdYX8Y9e46/Xj
	 AjvW4P2SzpYp5i5cfjIjhzDoKy1kAJEXekRqywIJW5cYrnT9LA+yVkiwruGJI/xUCl
	 RakUMdnvK7JDLynCyetpTapBu4Yhn30O7etVhXVBBfO1T6GhhZRCdlDGKsEw1ELU3L
	 dQPdkpXKCXdmQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 26 Dec 2025 07:40:17 +0100
Subject: [PATCH mptcp-next 03/11] mptcp: only reset subflow errors when
 propagated
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251226-mptcp-issue-603-v1-3-bb30e331b839@kernel.org>
References: <20251226-mptcp-issue-603-v1-0-bb30e331b839@kernel.org>
In-Reply-To: <20251226-mptcp-issue-603-v1-0-bb30e331b839@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1891; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=gtUybE9wszvo+9x8LDu2L+Gz8Vg2wf3Wvn6frsIYIjg=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDL9dO+IKJet+Lq96GRkbq3RGlGOh1VdfB/bzlg9u/7l9
 5Ww/kvGHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABMR0mP476lv1RXjeYzLYtnU
 7eunWvzmVk/3Tjg2uU6LU5z7++0GeUaG4y67uE0/fz1z5omK/ORL/J/zdfZ4iZy4x3XS0e1BfeR
 7LgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Some subflow socket errors need to be reported to the MPTCP socket: the
initial subflow connect (MP_CAPABLE), and the ones from the fallback
sockets. The others are not propagated.

The issue is that sock_error() was used to retrieve the error, which was
also resetting the sk_err field. Because of that, when notifying the
userspace about subflow close events later on from the MPTCP worker, the
ssk->sk_err field was always 0.

Now, the error (sk_err) is only reset when propagating it to the msk.

Fixes: 15cc10453398 ("mptcp: deliver ssk errors to msk")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Note: I guess we could also duplicate the error in mptcp_subflow_context
struct before scheduling the worker, and use this field in
mptcp_event_put_token_and_ssk(), but I don't see why we should always
reset ssk->sk_err in __mptcp_subflow_error_report() in all cases.
---
 net/mptcp/protocol.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1d68648b5194..5d6c987089c6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -817,10 +817,9 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 
 static bool __mptcp_subflow_error_report(struct sock *sk, struct sock *ssk)
 {
-	int err = sock_error(ssk);
 	int ssk_state;
 
-	if (!err)
+	if (!READ_ONCE(ssk->sk_err))
 		return false;
 
 	/* only propagate errors on fallen-back sockets or
@@ -837,7 +836,7 @@ static bool __mptcp_subflow_error_report(struct sock *sk, struct sock *ssk)
 	ssk_state = inet_sk_state_load(ssk);
 	if (ssk_state == TCP_CLOSE && !sock_flag(sk, SOCK_DEAD))
 		mptcp_set_state(sk, ssk_state);
-	WRITE_ONCE(sk->sk_err, -err);
+	WRITE_ONCE(sk->sk_err, -sock_error(ssk));
 
 	/* This barrier is coupled with smp_rmb() in mptcp_poll() */
 	smp_wmb();

-- 
2.51.0


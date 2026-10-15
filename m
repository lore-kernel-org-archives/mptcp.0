Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D7B52CCF1
	for <mptcp@lists.linux.dev>; Thu, 15 Oct 2026 13:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792072488; cv=none; b=izYPvTPaC0Jh0zSY+GUgo+kOBy5YwIcQ0QHhS/H8qql4o4SlOoUmlsIV7rdTReaUr6VF7HNg2GjSnqLcjQ9dheUqoPmSvSYfmZN3mqeUfaLJ/WwJ8i/uIAtfrizi4q+dKoy2oNWl9+EYqAJLse4VHFuqm2XRaj+uUZNxixO87YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792072488; c=relaxed/simple;
	bh=bWBwLMRjMtdsieKjcUpqdlITUV1oeMHSNjkho3jmviM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qymBKIlrLOfgCpy3uhh9KbAeXYlEtT0JxolpwkOD6ONpSj3plKx7N0zwSFEVT8uXaoQ15ZJ+SDlZFxdcn4Taz70Pote1ChHf24rSbRYs05HwV6oeqOiOVkbFbzH8jBsznPW9XWgIfYukPL1lt9joRwp0fvQ9cEtokjER0wyCgoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMXdFUpw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMXdFUpw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159971F000C6;
	Thu, 15 Oct 2026 13:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792072486;
	bh=vZko693fUxFgfHm/cXMXWZoeJtjZC4qaNeXG0WNgciM=;
	h=From:Date:Subject:To:Cc;
	b=JMXdFUpwdeDBOiQNiXuQwhXWa87Gtm5rIQ0BIpX/3Rb6hWNmwX+UjD3h5sNS7mMYW
	 u5cb9f0N9UQPXyRfdfaMcvTrQiIZNNcwkylzx5qCYW/Gl21PVcCHLhjbkwV/mJi5gp
	 cCRS5Qr0UeOPyLELXCpGo/b4F2fiszYIcFSfa+DZLS33k7HIcxPmLa7+XQVn9+9eMi
	 uyjx1b/rU6kkvSDqtAtdC2AnuyLa5SUYhUI3Ht0m+C1TwTmALlk9OCfjhykAaFzpjT
	 mlII1SYm9Mx1uoq8ZxeifmoB36WIqfndQCvqJYF0gVfuQeJKG89XgC/Dsixm9VCHDX
	 qTiI/MVGPT76A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 15 Oct 2026 15:54:40 +0200
Subject: [PATCH mptcp-net] mptcp: disconnect: reset first subflow's
 local_id
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-mptcp-first-disco-id-reset-v1-1-6ae41e8f02c6@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0QrCMAxFf2Xk2UA7sFN/RXyobTYj2JUkE2Hs3
 63u8XDvOSsoCZPCpVtB6M3Kc2ngDx2kRywTIefG0Ls+eOeP+KqWKo4saphZ09wOKKRkGN0phBy
 GfI4BWqAKjfz5x6+we4UMbvuky/1JyX5x2LYvPgZVRIkAAAA=
X-Change-ID: 20261015-mptcp-first-disco-id-reset-a0866d67d9a6
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2183; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=bWBwLMRjMtdsieKjcUpqdlITUV1oeMHSNjkho3jmviM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIu3FaNmbioUMph9p3PB+WT2vgebdP1c9S5u+h7ZLrVw
 jnht1YpdZSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEyk1YWR4dwE7m27dLW3LvzF
 HXDcV1Hm9b/lU/bPf3BQw/LQMomdVzQZGdZv9e6JV47jNrRSnD9NXN2g5sikHStCj3JJb1mxPLn
 oKA8A
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The first subflow can get disconnected for various reasons and
mptcp_subflow_ctx_reset() will reset most fields and set local_id to -1.
That's fine until the subflow is reused after a reconnect.

As mentioned by Clashiko [1]: on the retry, local_id is -1, so the
connect goes through:

  tcp_connect()
    subflow_rebuild_header()
      subflow_chk_local_id()
        mptcp_pm_get_local_id()

mptcp_pm_get_local_id() returns 0 only when the msk local address
matches the subflow's address. The addresses can change, but even if
they don't, for an unbound msk, the address is therefore still zero at
this point. (Note: in MPTCP disconnect selftests, the address is the
same, and mptcp_pm_get_local_id() will return 0.)

At this stage, the kernel PM might then give the MPC subflow a non-zero
ID, either from a matching endpoint or by adding an "implicit" endpoint.
The RFC 8684 says that the first subflow always has the ID 0, and the
PMs rely on that for special cases. So it is important to reset it to 0.

Note that we need to keep it to -1 in mptcp_subflow_ctx_reset() to avoid
a double closures in mptcp_close_ssk().

This issue was found by code analysis, and confirmed by looking at the
ID after a reconnection.

Fixes: a7cfe7766370 ("mptcp: fix data races on local_id")
Link: https://lore.kernel.org/179198834484.434549.4616694240552704738@kernel.org
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 60cbd91be632..4a6f16e0d809 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3654,6 +3654,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	 */
 	mptcp_do_fastclose(sk);
 	mptcp_destroy_common(msk);
+	WRITE_ONCE(mptcp_subflow_ctx(msk->first)->local_id, 0);
 
 	/* The first subflow is already in TCP_CLOSE status, the following
 	 * can't overlap with a fallback anymore

---
base-commit: 6a6728a8e881c12c984d104403ecaa0523d3b7e8
change-id: 20261015-mptcp-first-disco-id-reset-a0866d67d9a6

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>


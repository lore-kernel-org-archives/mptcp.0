Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6147138B7A7
	for <mptcp@lists.linux.dev>; Thu, 15 Oct 2026 16:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792080910; cv=none; b=B4vdJVgXYhu0zV2c0aSlw3eC+JVdpyPwRB2cynpMBBcUxuRjWxcJ9jUnRuHkBlr2JuCbH7Fry8/hRQwCvdHCpBwLrOtAwjXuZXvr7/KBL13d62FamS18JATSePGYQMCKz6hjiquxUPsQq7xDAPuL+tb++hClMJRHTFTjfhMj5YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792080910; c=relaxed/simple;
	bh=zf4lkAZ7pRiGT++3Xmbk/tFNc1Jxzk0kGKFpWbt3bho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iSlvLfCYiTOM39nYs78ulL/mN6XVc/efdZ1yu/LBA6j1KgIC+CyAr3mpxEYOqWjluAqMPBPUYxpcwXHRAUj/AtZAO/Lu9PLJntcL5u7AjH3hPqzc0BkrmIQoX6OaG6j8xsZzlIRFHRC9mHVPPcmaXSVfJh7TMlKBguTKTCSPSk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggD2PPIf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggD2PPIf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 425D91F000C4;
	Thu, 15 Oct 2026 16:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792080896;
	bh=OSUWr/nGPNN8TPwG7XowtKdTDJKxDbsIV7g2odnysV8=;
	h=From:Date:Subject:To:Cc;
	b=ggD2PPIfqNXOYXQI5jn0w0ua+fE8+meIlm83W6nw7TfwEEyHevf9Px1qMYYbC8uWp
	 U52sI+ycRipcyNLorKGA6abXQuD4oc96Wp3W1nZEtuxbIL+IX4kD1cHDoGkRfLIuiU
	 LD1Bw4Vo+pPqH5qoO5ThSxjCdz7zDZ+MPgX97bDhKKb8gczUrBDf3LIKDLWqP2cY6W
	 gn+cNe7gRiigTXatXnG07JCi1kE/ADXoSV7OGEZpFKvDXLUynop0DU3r1NeVOg5fPs
	 Iw9hhCCRhOjQQBElmYl0EUhIJQZHjfUoK1BnvB90fn9urlt4+bSWIOw+BT/U0L0Rba
	 BdyCnwPM+IBNA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 15 Oct 2026 18:14:51 +0200
Subject: [PATCH mptcp-net v2] mptcp: disconnect: reset first subflow's
 local_id
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-mptcp-first-disco-id-reset-v2-1-49b71541b059@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OzQ7CIBCEX8XsWQwQxerJ9zA9IGzb9QcaFhtN0
 3eXti/gcTIz38wIjImQ4bwZIeFATDEUobcbcJ0NLQryRYOW2iipDuLVZ9eLhhJn4YldLAGRkDE
 LKytjvDn6kzVQAH3Chj4L/AprL2CGerX4fbujyzN8DnfEOabvcmRQS+WfzUEJJYzFvcKqkdqZy
 wNTwOcuphbqaZp+uzK2fuIAAAA=
X-Change-ID: 20261015-mptcp-first-disco-id-reset-a0866d67d9a6
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2822; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=zf4lkAZ7pRiGT++3Xmbk/tFNc1Jxzk0kGKFpWbt3bho=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIu/P5/UOv+pf3XX929Ft2UoMw2f9O6c0pfUlatu3+kI
 bFgbZ767Y5SFgYxLgZZMUUW6bbI/JnPq3hLvPwsYOawMoEMYeDiFICJKFxhZOjpXrmvITth6SO7
 mm0Jvz4/+3ll7xUPl9gwQ2ONeUfjFBUZGeZ+6cjUeing7ezn5qGy84ss51zJPRMWXJ1Sq3DqglO
 dPhMA
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
PMs rely on that for special cases. So it is important to reset it to 0
when msk->first exists (which might not be the case in case of
connect(AF_UNSPEC) for an unconnected socket...).

While at it, fix the comment above: msk->subflow has been removed for a
long time: first is used instead.

Note that we need to keep it to -1 in mptcp_subflow_ctx_reset() to avoid
a double closures in mptcp_close_ssk().

This issue was found by code analysis, and confirmed by looking at the
ID after a reconnection.

Fixes: a7cfe7766370 ("mptcp: fix data races on local_id")
Link: https://lore.kernel.org/179198834484.434549.4616694240552704738@kernel.org
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v2:
- check msk->first is not NULL + fix comment
- Link to v1: https://patch.msgid.link/20261015-mptcp-first-disco-id-reset-v1-1-6ae41e8f02c6@kernel.org
---
 net/mptcp/protocol.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 60cbd91be632..a165e6683e6b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3649,11 +3649,13 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 
 	mptcp_pm_connection_closed(msk);
 
-	/* msk->subflow is still intact, the following will not free the first
+	/* msk->first is still intact, the following will not free the first
 	 * subflow
 	 */
 	mptcp_do_fastclose(sk);
 	mptcp_destroy_common(msk);
+	if (msk->first)
+		WRITE_ONCE(mptcp_subflow_ctx(msk->first)->local_id, 0);
 
 	/* The first subflow is already in TCP_CLOSE status, the following
 	 * can't overlap with a fallback anymore

---
base-commit: 6a6728a8e881c12c984d104403ecaa0523d3b7e8
change-id: 20261015-mptcp-first-disco-id-reset-a0866d67d9a6

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>


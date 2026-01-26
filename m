Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8243B27877D
	for <mptcp@lists.linux.dev>; Mon, 26 Jan 2026 19:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769455491; cv=none; b=m5GVLsdWKTA4fSlQV9J920D9RfsWoyMz5V7iBpbR31XWUXprVetVFX0Jf5/bmw3yQBJZilvbWMfcgN0a9CpNidLZRmLLTcPceNA0SXPwM8hIkagiFcX1buXtsVa1haIOVSt9LUveV7i4s0TxD4GosFJdixEJqGUL43+uPBoeHmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769455491; c=relaxed/simple;
	bh=Ngmr3wL7Ofuvts2jVIJXdbSdTuPi0mOLmHnscFsySJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VHgV+tYhrO2alEk8h1wurf28wErqHsPuYMPfglrlJ4fgu9MMiLhIfvmGyweTCEZMPLTZ4X7V+6XeNa9GM2Mb649c6eh/BqEQ1YsnoJtOHnLusFHUZVveYTunyM8rARlzgmNS+Lt23sJdgcqsnAqre5lqf5kJsIAxTmrjzQQRoBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0bBh2lq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0bBh2lq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC34BC116C6;
	Mon, 26 Jan 2026 19:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769455491;
	bh=Ngmr3wL7Ofuvts2jVIJXdbSdTuPi0mOLmHnscFsySJ4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=P0bBh2lqHZve5sl412lmjhTJ4aKZ0aNLqNjcUVEmxB4u7WETqSJJ0PubjTR6JUMOh
	 yqM8NjeXBapxtiXw4iUTyn6TpvRV8WIT6XpfuAiktgLNsiGCO/8BX2CtPkw9Br95CC
	 q1zswbxiTxW1x8B7iw8LKlCSk+CrxdKJ82KMBaS88ebz/FP6a8FDQ4zjKkvQ7WKV+3
	 KyfONciuthy49vwHT/es2Vdig8gPVDcPUhF9vx5XX4i0lQBGox85iftwgb/6GSUTXH
	 DLZGNEhK/0DK1BPRpm0zsp1HqOc9EYNx+meN4nqGrXZ337XOhaisDZD4RtVFr+Qg0i
	 psYNC8/syCpTw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 26 Jan 2026 20:18:40 +0100
Subject: [PATCH mptcp-net v2 03/11] mptcp: only reset subflow errors when
 propagated
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-mptcp-issue-603-v2-3-8393e7840b9e@kernel.org>
References: <20260126-mptcp-issue-603-v2-0-8393e7840b9e@kernel.org>
In-Reply-To: <20260126-mptcp-issue-603-v2-0-8393e7840b9e@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1979; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Ngmr3wL7Ofuvts2jVIJXdbSdTuPi0mOLmHnscFsySJ4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLL91c9OsT9UVNsQmzFMn3Ht2URnpJc1T+6pu55kJe+i
 +P9VJnejlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIl0fWH4pxdrtvNwuVm2jKFf
 6JWFdx8cn27Mq7Zg4tISnZchpk3TuhgZFn5OFYiv0ptTF3hBUXLR/fPbWUTOy1TWLe7+kWL08sd
 ydgA=
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
v2: keep 'err' variable (Geliang)
---
 net/mptcp/protocol.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 335a1723c1dc..1b87b3b0d089 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -817,11 +817,8 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 
 static bool __mptcp_subflow_error_report(struct sock *sk, struct sock *ssk)
 {
-	int err = sock_error(ssk);
 	int ssk_state;
-
-	if (!err)
-		return false;
+	int err;
 
 	/* only propagate errors on fallen-back sockets or
 	 * on MPC connect
@@ -829,6 +826,10 @@ static bool __mptcp_subflow_error_report(struct sock *sk, struct sock *ssk)
 	if (sk->sk_state != TCP_SYN_SENT && !__mptcp_check_fallback(mptcp_sk(sk)))
 		return false;
 
+	err = sock_error(ssk);
+	if (!err)
+		return false;
+
 	/* We need to propagate only transition to CLOSE state.
 	 * Orphaned socket will see such state change via
 	 * subflow_sched_work_if_closed() and that path will properly

-- 
2.51.0


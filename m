Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793316134;
	b=ebndOzdR/aa7yRj3xYXTxFG4NG0AuNWx8NCd+x/olUNOvqguzl0PXic8gNEHW5s1i/xA
	 W1S6FzxGNDK2pUdnmJY4L1FXC7vFB2yuiqj1fRcyDTQrf6hdpsUtL7q/Y6PROJoCqZ814
	 gvsmVQvVzZSsV7WrPWLa3ISgO8X+Iy8rJUCooBII8k6dOcRcx0Sm3WiAq57XmoVJ09LyA
	 OJmUUcUObXzuMajvz6QwijQflSoiP08dDzeEUXZ5gN0TALGSFuzepAnZ0gGgGJl/7178U
	 MQi6OQFQB/oiiBPWvRrv2k52K1J6Ge3ZHsybxK4u0KQQoAhJ0l1OBnLPqGqYp5/hqOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793316134;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=HyCkS8rRWl0pRzwjO6c4qhtJD8Oar1dl5moffglq0iE=;
	b=OlaY/pUxSexyrJVfsNhqSfFUqk4A0KzjMhUpQbB51Ucd7Pagj/fCXLr8/zBoBVAV9eej
	 1Z28dl1u9otd8IV76F0uIZvNRxbvwAzbm8ymm2ikO6KBsKfeLouzli0ucIwkO+NpERGGj
	 GJNnWWf9z0C7ReT2l58AQBfKXecNkMoYqFLOv8Y96rdK0+hAZ3hZw4f7Xeo8diw5zSvEj
	 vm97KptdGRk3JMxR9BayLvpQCMnU6PrVIyJwuafjul11PpsUZCEOG8Rwmvd8FMbnSQKE3
	 5KKAzfXtz6eS3coTy8wQz2IiUNxady3jm1dKDxvNi0JAWmjaqEojjFwg0bntfYq9KjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fambBQbL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A65606A31A
	for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 23:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fambBQbL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C27C81F01826;
	Thu, 29 Oct 2026 23:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793316133;
	bh=HyCkS8rRWl0pRzwjO6c4qhtJD8Oar1dl5moffglq0iE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fambBQbLUP6r1+u0TKLHUr03B7lM10zwl/9KOHeJy7hRS+iSaSIHhnRkq+8Mbbs+B
	 PsVgFSV9L+DiSafnO580M8KNEydqfHrJUJx8qJf0KDKTPMa0jjCMwlUb2HAUlKWlw/
	 V6uTzrjPsD3qtckefmple/DaDxjnJXPHVUeluYTim0F0LMV0D0Ntl5GMeJXh8qzGU6
	 jXPM8SPRERFEEzmNIGf1ewdcSEM7tFWe0/QTR2Sge17U2illcjvdwDORgXGb49hmkZ
	 QfgZ/hpmgRlE7L3R+BzITUwAk+zD9ua7eGTkzmnly7Nfb8hDxHlO+6u/sM4M2XlVnn
	 2bHP3mJiRM09A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 30 Oct 2026 00:21:43 +0100
Subject: [PATCH mptcp-next v2 5/5] mptcp: pm: kernel: avoid
 mptcp_pm_is_userspace checks
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
Message-Id: <20261030-mptcp-reset-mpj-early-v2-5-90f119392263@kernel.org>
References: <20261030-mptcp-reset-mpj-early-v2-0-90f119392263@kernel.org>
In-Reply-To: <20261030-mptcp-reset-mpj-early-v2-0-90f119392263@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Chenguang Zhao <chenguang.zhao@linux.dev>, Gang Yan <gang.yan@linux.dev>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2014; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=mKiqJx82yHSZxVlMvmsYjk/GQTMm/9kWzwXJL5d8PJg=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIeX5U1sTqX7hGY/mLWMpug6i/bGLff3N+uuT7pTCOT8
 /yqA6/6OkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACaykpfhf8aBaUv4ls+bO3+H
 rtZjt8r3DDavfxuvaF+5Yq7qfcmcLkeG/0kL7ByNz1m////PVjwjx0Ri+gPtUw5ltstiS4U+Hzq
 Xxw4A
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

It is strange to see them in the kernel code, plus it is more logical
that way: only do in-kernel PM specific for this PM.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new
---
 net/mptcp/pm_kernel.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 096ffea80f61..670db79ff4d3 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -970,7 +970,7 @@ static int mptcp_nl_add_subflow_or_signal_addr(struct net *net,
 		struct mptcp_addr_info mpc_addr;
 
 		if (!mptcp_is_fully_established(sk) ||
-		    mptcp_pm_is_userspace(msk))
+		    !mptcp_pm_is_kernel(msk))
 			goto next;
 
 		/* if the endp linked to the init sf is re-added with a != ID */
@@ -1096,7 +1096,7 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 		bool remove_subflow;
 
 		if (!READ_ONCE(msk->fully_established) ||
-		    mptcp_pm_is_userspace(msk))
+		    !mptcp_pm_is_kernel(msk))
 			goto next;
 
 		lock_sock(sk);
@@ -1144,7 +1144,7 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 
 		if (list_empty(&msk->conn_list) ||
 		    !READ_ONCE(msk->fully_established) ||
-		    mptcp_pm_is_userspace(msk))
+		    !mptcp_pm_is_kernel(msk))
 			goto next;
 
 		mptcp_local_address((struct sock_common *)msk, &msk_local);
@@ -1292,7 +1292,7 @@ static void mptcp_nl_flush_addrs_list(struct net *net,
 		struct sock *sk = (struct sock *)msk;
 
 		if (READ_ONCE(msk->fully_established) &&
-		    !mptcp_pm_is_userspace(msk)) {
+		    mptcp_pm_is_kernel(msk)) {
 			lock_sock(sk);
 			mptcp_pm_flush_addrs_and_subflows(msk, rm_list, NULL);
 			release_sock(sk);
@@ -1508,7 +1508,7 @@ static void mptcp_pm_nl_set_flags_all(struct net *net,
 
 		if (list_empty(&msk->conn_list) ||
 		    !READ_ONCE(msk->fully_established) ||
-		    mptcp_pm_is_userspace(msk))
+		    !mptcp_pm_is_kernel(msk))
 			goto next;
 
 		lock_sock(sk);

-- 
2.55.0


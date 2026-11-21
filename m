Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254190;
	b=eEJYSROqoghvDXO0uzSQO4jYymtoTnfvQMjAgARk/KmHox9Ehg4N4cMyr0uIic+TzqAM
	 p4kIclAWvO0LNMTAHhGJCw55EuZvIye6whNnL6+oMisygGEcbasgNt3iKUNmkk9U3259L
	 Nso0498c2P3Rqkieu8wTKDpX4q9qYcWykhuYN1vQ5NnsY76Pm4tpoaKRwJyufQBkh6yju
	 hzt/80MFsIHtawJmnxLPaM1RqyK/mF6sT0bCq8qm7gBZN1Abp/RPdr/JfOoT23cM35fiX
	 AWXYXOEs6vc9jVtNkSFTU67WDebKWH+bPc755eH4RKP9GEwRgdrtvMxejfS8+xVY23Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254190;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=CnyPPXu9xZXD65sCn/drhTNKznr0mI1PlU+C0MDNy6M=;
	b=s/1bUdUZdg4iPkPUwTnhoAHDLkWB5uRRqAjC3zsgcTZMxGBiK2bwsV5Lco2sSZYr9Eq3
	 kcIQwu8ZFXd22ZYwydzllmEZlnY/SXy+SZUU+JgCdZXO4/BIbnaN8VOqSh7JNP6/P++XN
	 rgHrXm1ddhMz9gCjPaYJ6dUePTIV2t/7hRDVMJXad29VveGWteV3H+rimFEhr7Xo1ltjV
	 JSm+TQDcAD/WL3JOBeCvWY3ft82wW4mPxFxhSvgF9fVpKGvV07tbGWD2fbnsWA2kHhiCA
	 pVw+VyQ3fIwXwY1PyY5M0bs7rfYxQ9QlqKTeBVuZ01fWHMZvEU8cOW9ZCxn5vmQvX8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V6ls7BVG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90DE606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V6ls7BVG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30AEA1F000C4;
	Sat, 21 Nov 2026 09:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254190;
	bh=CnyPPXu9xZXD65sCn/drhTNKznr0mI1PlU+C0MDNy6M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=V6ls7BVGyD+PkfuOaXcOg2+Em7QyQbAH+4MaYEArV7AR1qQV+MUM1b0ZQF8dpJJMK
	 XlidQx5ggBlHennUmuS7Mlq2imsNbI979wqqiESgAI7F55o5rIjaiicpbvkG3ccGeQ
	 cIOIT4jJi02WpFFgHUjTdIDNPG2nVosNwzzufcfFltjoFzvbZqRlQDlgp60Jo4UUe9
	 eLBKbUQlB7imDVX0lVmdEOAzGtpt2S/5cje75g0++rgMMi/uFSUsWp6duFCV85V6jC
	 TanwsYlvhgoGf69w+KDxkn08wCtGVr4vpWSDD8Y8t7KH4ZUXVBvJYUS2y0eafmVj6M
	 2E/p0WZEZYUkw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:57 +0100
Subject: [PATCH mptcp-net v2 59/62] Squash to "bpf: Export mptcp packet
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
Message-Id: <20261121-mptcp-cmason-fixes-v2-59-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1638; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=gj0zTt3FypZWjoOtRiu7MrcG+V+Ru9RhyDxMBsC3xOk=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ00tvMh6PVtd5/cJUaGnyucS+P7nJkU1LC3csTl3sr
 Jjw4DVnRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwERytzL8FflVcrtO6G3t5TNK
 q3bLi3jkiV6oOODy6q+x68sbRXdPtjAyHD7D9vHf0vqX1tMjvuw790Ts5DRlluWR6v+X1ypVW4f
 MZwIA
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
does when picking a subflow.

This issue has been found by Clashiko, while reviewing "mptcp: arm the
rtx timer if a push leaves data behind". Not reproduced.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, for an issue spotted by Clashiko

Note: when squashing, the commit message could mention that
mptcp_sched_get_send() now sets the rtx timer interval before calling a
BPF scheduler, as the default one does.
---
 net/mptcp/sched.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 1e59072d478c..2f685986698b 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -189,6 +189,9 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 
 	if (msk->sched == &mptcp_sched_default || !msk->sched)
 		return mptcp_sched_default_get_send(msk);
+
+	/* as the default scheduler: the rtx timer needs an interval */
+	mptcp_set_timeout((struct sock *)msk);
 	return msk->sched->get_send(msk);
 }
 

-- 
2.55.0


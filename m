Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795809739;
	b=u3CAfxKlt+f5fd4nPEEGqTWp8Ucezd92mN5MRoNc24+MbcJVqzDQysznq3WC3AhE97DQ
	 v0Upthri8gL/p4+ll4MghiX0GvL5Vi09GfskVW7lL7oSkP8LVScMnIqUSYcg3ZCdfGXlc
	 +RCuutuz/mIXuy89rwTLTKolhh32hmWCHEH5gu1G48Q/RECKEzyzy6O+Nv2U4O7Qydusd
	 h20FxGTnQdyuTVvO07HlaBG2QsVOrRZ1CDuBOWqQLN7Ggnr5z92MBaGFuvY+3uKDrbWOA
	 TBRGcO4xdHikhFD6yI5og00yPx4GUCCE9SVELBkVJrkn1HaETHyFZuBcGRmHnsQpCGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795809739;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=lruY+wQL9xM2fmu0XEDdPVXHTfL2Zw8q+DIgvImjJCM=;
	b=qpzFtKhV8kbpP5Tufclr9Omps6mewMOaO+Gnb3vglrL5VyCbWK3aBvWqc/fDTcobm+Eu
	 4oNRVoFUpcEbAnQbWboe1KDGkFvO1YXOmpIbseT1Gm+uoE/wYbVGrChtT3RIBS8OGSgyR
	 gw5ZvZLNmfEi6XP4I28BRxYnQb1RVoXU9Vi66DNMnOOSJRULwd+ANEcpzvvkTb7at047p
	 QteMMNLWbqPDaSY0FUfkiVaYpYrpp8A0D4kAfSn419kmxwvc1VZ1iy+KuNrqXW8TRIVXm
	 deg4k6NwD7bM3vQDpl3gXX7lNqMb+r9Mg2ivbUYUoy75uraMaQ6/KzCidhFqu3WjOwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eghskOFQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2800606A31C
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 20:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eghskOFQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED8011F008A0;
	Fri, 27 Nov 2026 20:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795809739;
	bh=lruY+wQL9xM2fmu0XEDdPVXHTfL2Zw8q+DIgvImjJCM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=eghskOFQSxGUJBFmhvQ9Mv4o0ZitLRVo8isTwP5OaSX/t3B+52KrQUzDjOXIN7e08
	 r/u7I8eOMeikdH47P0ITUZGfBzWqmSC1y/8jGMhP+BVGWvKFFgXZO0l7NdaKNsodbt
	 iRxQvl5vS+Zs+VYGEuQPhEVBlLsz/Tb+y9rTTLj3r7Qr2jtQXqGiq1GJT3tiEP8DN0
	 KCY8JHh30zEDjAvtGiMZmPdvXdO6YeFatkGOy2WDKUy2Hv96oHBSPsMZuGt59H+Umd
	 JW3bkl4ke7Mdapy39zM67tlmXfhJ2az8oKHUB6O/jixNcUYAqdzp2NqIPvX7ubeJDo
	 qrIjfuPlpV0tQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 27 Nov 2026 21:01:39 +0100
Subject: [PATCH mptcp-net v4 15/20] Squash to "bpf: Export mptcp packet
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
Message-Id: <20261127-mptcp-cmason-fixes-v4-15-3f393ea8c48d@kernel.org>
References: <20261127-mptcp-cmason-fixes-v4-0-3f393ea8c48d@kernel.org>
In-Reply-To: <20261127-mptcp-cmason-fixes-v4-0-3f393ea8c48d@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1923; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=fh0PqDon6abSfkKhSY5BYGApkpcuMzQnRw7KTx6M4Bw=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLI5H27p4j9inHzM37p+swiDeN0yLuFZqmsfaNTOW3qtx
 OVwh6ZqRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwEQuBTP8L9u7aenlzV/D40p6
 9/tO2tbu1Cu1e/3Vp1qdlZL+M251GTIy/Pr7MCdU7pqw1ncNqU+7P3tafxdNmfRr4gJj7wWz9Lm
 /8QMA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

With a BPF scheduler, the rtx timer interval, msk->timer_ival, is only
set if the scheduler calls the mptcp_set_timeout() kfunc: only the burst
one does. Otherwise, the rtx timer is armed with an interval not based
on the subflows' timeouts, e.g. the minimum RTO once all the data has
been acked, which can cause spurious retransmissions.

Set this interval before calling a BPF scheduler, as the default one
does when picking a subflow, also when a subflow is already scheduled,
as the scheduler is then not called.

This issue has been found by Clashiko, while reviewing "mptcp: arm the
rtx timer if a push leaves data behind". Not reproduced.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, for an issue spotted by Clashiko
v3: also set the interval when a subflow is already scheduled (Clashiko)
v4: msg: the interval is no longer 0 since "mptcp: reset the rtx
    interval to the min RTO"

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


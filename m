Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB76C3B05B4
	for <mptcp@lists.linux.dev>; Fri, 31 Jul 2026 09:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785489815; cv=none; b=duUSCjgAqX6Ssivs8UnkVmV+QTO0vOiGy2k/lr8PstGzEbV+7NaKZiR9ZDwAbzcrkbuLsKckacDxIS0n05uHqF/Ldwr7IrYw4JjJNXMmgDaRXd0JMZqn4+p0FJCnZ+NrMMFcnUldbtcjlUOjTd3rayRHInnI5qI4XTo+QKZGOUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785489815; c=relaxed/simple;
	bh=y6QOc2AV5MWdxtNqLPw2kgIHsN+h7OUQBYXxpJPSwZ4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gQVxVKpItoFOQX8TfxaE6i15cpTiOL+KPCX1uBPJb9Zqz401xjNT5U68BCB6rUEdhUm5CgPZ0bWjwbBw35DG1A1VmLUZtcOS+mEzkod3QzyLQ2eKD2t33l9QaI4nhZVp0UAfSUe9MViPLX6P1oIkdbLLxKbr3l/wZPPUDoToam4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdYg2cVl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdYg2cVl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277051F000E9;
	Fri, 31 Jul 2026 09:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785489814;
	bh=CBHmYUyHl5YHMqcGyV3kjNmWUskLqdjut+dOnH+wsAQ=;
	h=From:Subject:Date:To:Cc;
	b=OdYg2cVlRuN4Mjd2g+f7WE1L/UYcS13xRdnQO+aGvxxqMCdgXbUMHx2CKnB1uLW/6
	 bSMD7kxo8CySUcBqQAHTPTVNI7O/eQT+Y1WosgziuJXUGnr9qe4pGUp1Q4gKgM1RRt
	 /2y7PqVrUBkQGdwZrYgi8lZ6d39jtszLKel/ek8NOV6REBARfZMZpi+oEhH95pbbHL
	 DZDtCPSmHt7rLt1T6pBI9mzPwzOX4LBx2g+yC8PCsWbr40HD78wdp6YcU3EZk+ah/w
	 o0LrJbAxQFmMp8wxIyMX9xH4iqWm7ERFm8bJXaxGnAE5HXB69JugVqkHfCpgWB1Ja/
	 ldxXPaY010iZQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next 0/2] Squash to "mptcp: out-of-order queue
 pruning"
Date: Fri, 31 Jul 2026 11:23:15 +0200
Message-Id: <20260731-mptcp-squash-ooo-pruning-v1-0-a5f5115e1e24@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQ7CIBAAv9Ls2U2QVjR+xXigsLZrIiALpknTv
 4v2OJnMrCCUmQSu3QqZPiwcQ4PjoQM32zARsm8MWmmjzr3CVyouobyrlRljjJhyDRwmPPXemIs
 fnLYWWp4yPXj5r2+wV4GWAvfdSR2f5MrvDdv2BdKx81aIAAAA
X-Change-ID: 20260730-mptcp-squash-ooo-pruning-53d668d4c2aa
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2435; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=y6QOc2AV5MWdxtNqLPw2kgIHsN+h7OUQBYXxpJPSwZ4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJyMqesLuq6M3f78uSO0CpNrRafTQ6bI/+sk1v67/LSq
 ceFTm6b11HKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjCRmToM/8MTWsw4tts58Gzb
 r/boHtOHlUte50nlf7l6O1Bw0vyjs40Z/qc/c25z2B66+NzsxYHCHs/5yw+dX7ZTMX3O7MtnHNN
 1zvMAAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Addressing comments reported by Clashiko [1], but not detected before
with the AI review tools using a different model version.

Note: the last comment from the 3rd patch has not been addressed, as it
is not clear to me whether this comment is valid:

---------------------------------- 8< ----------------------------------

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 72b1fa3ca71c..5f7d8340a3d9 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -682,6 +693,16 @@ static void __mptcp_add_backlog(struct sock *sk,
>  		return;
>  	}
>
> +	/* Similar additional allowance as plain TCP. */
> +	limit = READ_ONCE(sk->sk_rcvbuf);
> +	limit += (limit >> 1) + 64 * 1024;
> +	limit = min_t(u64, limit, UINT_MAX);
> +	if (msk->backlog_len > limit && !__mptcp_check_fallback(msk)) {
> +		__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_BACKLOGDROP);
> +		kfree_skb_reason(skb, SKB_DROP_REASON_SOCKET_BACKLOG);
> +		return;
> +	}
> +

[Low]
The check compares the current backlog_len against limit before the
incoming skb's truesize is added (the truesize is folded in at the
account: label further down). Was that intentional?
TCP's sk_add_backlog() analog compares queue_size + skb->truesize
against the limit, so a single skb can push msk->backlog_len past
limit here and the drop only fires on the next admission. The overshoot
is bounded by one skb's truesize and the commit message already notes
"This is not a complete fix for the stall issue, as the drop strategy
needs refinements that will come in the next patches.", so perhaps this
is one of the follow-up items?

---------------------------------- 8< ----------------------------------

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260724-net-next-mptcp-oooq-pruning-v1-0-5dd4dec63a54%40kernel.org
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (2):
      Squash to "mptcp: explicitly drop over memory limits"
      Squash to "mptcp: implemented OoO queue pruning"

 net/mptcp/mib.c      | 2 +-
 net/mptcp/mib.h      | 4 ++--
 net/mptcp/options.c  | 6 +++++-
 net/mptcp/protocol.c | 2 +-
 4 files changed, 9 insertions(+), 5 deletions(-)
---
base-commit: 23c7cb4262d954b810468b0e661d48af82b418d5
change-id: 20260730-mptcp-squash-ooo-pruning-53d668d4c2aa

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>


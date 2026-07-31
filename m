Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774C439FCD8
	for <mptcp@lists.linux.dev>; Fri, 31 Jul 2026 10:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785493143; cv=none; b=GC7T22u1irRwWMdUmrvKNdhI7Exi+5JlZ7Z7Q/M1xuR3XHbvEe4pqfro0mwv8OUtZz56DAZh8lYPE9Q3Za0BrGU/ooQ7kvuI4JkZJdZK/4iGTS4Rfu1dAVOuC9IFK9La/A7dWT9+prqD2OWhy5ZS7TOyYdo7yrfq2MScSXzdppY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785493143; c=relaxed/simple;
	bh=Hp9/m6o3vT3e8QyeZJyRzCkNZ4e7XsR4I1ZF0OEB4y8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JNaxpp+8ClayaN4I5sIXsoR6TpCitWlO6EQtv4QraWpqW/hGsiCOO+Dkq1jBdOvrIuU3nHOXWFphZNyYMqoYhIoAa0sksYwm5nALI3e3UWPKlPbsZtABySWForg9PyhxPk6Bcxy6YJRa0t7rl7w/Q/auhE9sikwHpj8vwm6Y4b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKB0eqrJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKB0eqrJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BEDC1F00A3E;
	Fri, 31 Jul 2026 10:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785493130;
	bh=pNezEncCCAaL6mlsgE31fVSlLlBbCEa6QKEGdlUJglE=;
	h=From:Subject:Date:To:Cc;
	b=YKB0eqrJipY4GUTuaq8sqA4lKXZ1rJ2UbK3rGGaVMC4De3pZLgcpGEmfFuBIFNFZk
	 WuNMQbBPHlOO+8xaERdHPOxM/M9nVPacRJsEcjY+XAGxF62uWqvo2TUCxrPegyrveD
	 5oAuY6qWcTXs8i9TeWVQ3oDb7V3f7sE2+Xgvop2zGbpqs/aPBTRN3/5g0r5x0UUm+t
	 EJZ9BtdzzjQD2FV40ByeupHlEFk4puphbwzvPeQyxhXeBvVVeHNlYnmMGVcwMw2nwc
	 byWVPX18j0RX8p+Ysh49+dox35QbEHtXRXdtdnunoYdYvVdfLSu7FurVaOaqg+X1/q
	 keAUIPhz7vMIA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next v2 0/2] Squash to "mptcp: out-of-order queue
 pruning"
Date: Fri, 31 Jul 2026 12:18:42 +0200
Message-Id: <20260731-mptcp-squash-ooo-pruning-v2-0-499a523bbce3@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WOzQ6CMBCEX4Xs2TVtoWg8+R6GQy0L1J+2toVgC
 O8uoFePk5lvZiaIFAxFOGUTBBpMNM4uQuwy0J2yLaGpFw2CiZIdcoZPn7TH+OpV7NA5hz701tg
 WZV6X5bEutFAKFtwHasy4VV/gS1kaE1RfL/bXG+m0dq/pzsTkwnv7MfCN+U3y/5MDR4ZKNpJzS
 ZxEcb5TsPTYu9BCNc/zB4fQ8B7fAAAA
X-Change-ID: 20260730-mptcp-squash-ooo-pruning-53d668d4c2aa
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2606; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Hp9/m6o3vT3e8QyeZJyRzCkNZ4e7XsR4I1ZF0OEB4y8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJyyto5w3w6XqgZc96475oXHLLkfKjC5z8b5TYcusa0+
 OHas1W/O0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACbyp4GR4Z7yelOWY2cPlrfZ
 mAZqThTQ2WrmKM/K9lboifn+i4cC3Bn+R3qfPZ/1y/a9A+OPew4NU/7bTZ+223rTlV2GjOZKh3h
 0+QE=
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
Changes in v2:
- patch 1: s/MPTCP_INC_STATS/NET_INC_STATS/
- Link to v1: https://patch.msgid.link/20260731-mptcp-squash-ooo-pruning-v1-0-a5f5115e1e24@kernel.org

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


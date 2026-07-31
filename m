Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8435F3E0096
	for <mptcp@lists.linux.dev>; Fri, 31 Jul 2026 12:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785500567; cv=none; b=HmkxrdQx6/Kn0XFA5wa4fGr9Be1jUAMpB+KxXXvO26dJjkknlQuniMuMnKIASC0nerAxHYLZGt5EkTo75x5/IAnibFiCCF4gIC3lBNiezJMofjrrFHPQUn7PR48EmaAHbSAodLO8CJJfuXXxLye7B9moRIPmug2cGbuIZvjfG5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785500567; c=relaxed/simple;
	bh=7El/QHMw16UaJ8TY+MllDO1tR27pEiwWJv2y9Ou4wsg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=unsckgp/CB9MHSky3NxYzFPwYGUS9Nt4cjjGqVS1xzFIWgKB3jeWa/v6przxFKl6NE7jTYd7oa2WOb3juBjrK4rckE2uQVfS8UHJo9UW4lwd/KgBWHoOOCKLo0Qhb1HaPBccS5h4T1SDBzbS5LsUrK3kEANeKQu9mHkWduUeUn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5lKfrh4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5lKfrh4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620521F000E9;
	Fri, 31 Jul 2026 12:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785500566;
	bh=hbLUv+kqQTAYEiobE9ebKfm6Ns6b7Vgpfnodefio3UU=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=Y5lKfrh48OiR/ZjFRwqcZNTZXlSh+Zr2Y6Xy+pZDpF/HOhZN50/e1FbNc6Ey7bw90
	 GKGsK17O6LnGyARXJkSzBJcKoDbHMFl8XN3AvEuIj1DA99s5x/WJakgIi5gCrTGgWx
	 oKmRe99SNRHSCvUQVniZh/rZISh++TD0sAq25nK8p0cbfqzybm3/AUG4BRu13fNWGc
	 PPqOBUhEv2oKucrx4wiygd8c+P7kpVQ9DR6qgG5JHpkKDm7OhR+2NP/7JU9wZbOStp
	 IqXjiBsxh2YEAue3gPB5XCtwLTtu4RulR5aTCI0EFzcywaLHD0X3sf3RlmSqNF46Jo
	 Gu/lKhxB7zjww==
Message-ID: <c3d0f4627af20525fe951b6e6585302214c85f4e.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2 0/2] Squash to "mptcp: out-of-order queue
 pruning"
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Linux
	 <mptcp@lists.linux.dev>
Date: Fri, 31 Jul 2026 20:22:35 +0800
In-Reply-To: <20260731-mptcp-squash-ooo-pruning-v2-0-499a523bbce3@kernel.org>
References: <20260731-mptcp-squash-ooo-pruning-v2-0-499a523bbce3@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Fri, 2026-07-31 at 12:18 +0200, Matthieu Baerts (NGI0) wrote:
> Addressing comments reported by Clashiko [1], but not detected before
> with the AI review tools using a different model version.
> 
> Note: the last comment from the 3rd patch has not been addressed, as
> it
> is not clear to me whether this comment is valid:
> 
> ---------------------------------- 8< -------------------------------
> ---
> 
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 72b1fa3ca71c..5f7d8340a3d9 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> 
> [ ... ]
> 
> > @@ -682,6 +693,16 @@ static void __mptcp_add_backlog(struct sock
> > *sk,
> >  		return;
> >  	}
> > 
> > +	/* Similar additional allowance as plain TCP. */
> > +	limit = READ_ONCE(sk->sk_rcvbuf);
> > +	limit += (limit >> 1) + 64 * 1024;
> > +	limit = min_t(u64, limit, UINT_MAX);
> > +	if (msk->backlog_len > limit &&
> > !__mptcp_check_fallback(msk)) {
> > +		__MPTCP_INC_STATS(sock_net(sk),
> > MPTCP_MIB_BACKLOGDROP);
> > +		kfree_skb_reason(skb,
> > SKB_DROP_REASON_SOCKET_BACKLOG);
> > +		return;
> > +	}
> > +
> 
> [Low]
> The check compares the current backlog_len against limit before the
> incoming skb's truesize is added (the truesize is folded in at the
> account: label further down). Was that intentional?
> TCP's sk_add_backlog() analog compares queue_size + skb->truesize
> against the limit, so a single skb can push msk->backlog_len past
> limit here and the drop only fires on the next admission. The
> overshoot
> is bounded by one skb's truesize and the commit message already notes
> "This is not a complete fix for the stall issue, as the drop strategy
> needs refinements that will come in the next patches.", so perhaps
> this
> is one of the follow-up items?
> 
> ---------------------------------- 8< -------------------------------
> ---
> 
> Link:
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260724-net-next-mptcp-oooq-pruning-v1-0-5dd4dec63a54%40kernel.org
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

v2 looks good to me!

    Reviewed-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> ---
> Changes in v2:
> - patch 1: s/MPTCP_INC_STATS/NET_INC_STATS/
> - Link to v1:
> https://patch.msgid.link/20260731-mptcp-squash-ooo-pruning-v1-0-a5f5115e1e24@kernel.org
> 
> ---
> Matthieu Baerts (NGI0) (2):
>       Squash to "mptcp: explicitly drop over memory limits"
>       Squash to "mptcp: implemented OoO queue pruning"
> 
>  net/mptcp/mib.c      | 2 +-
>  net/mptcp/mib.h      | 4 ++--
>  net/mptcp/options.c  | 6 +++++-
>  net/mptcp/protocol.c | 2 +-
>  4 files changed, 9 insertions(+), 5 deletions(-)
> ---
> base-commit: 23c7cb4262d954b810468b0e661d48af82b418d5
> change-id: 20260730-mptcp-squash-ooo-pruning-53d668d4c2aa
> 
> Best regards,
> --  
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 

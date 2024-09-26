Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B723A322B
	for <mptcp@lists.linux.dev>; Thu, 26 Sep 2024 13:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727357834; cv=none; b=V/3DHmtSRBr36yRzL6LwQyvY5MjxMXafsjErsL5u7/sL045b0PDAA2U/pqI4oNrUcxrI6MhmQhaf4ekoDK0602FVlT6lV5ykEx3mv7luh5CmNhHsb2hmqfswegHANV70xTgxsz9LxsbmqfT4oJhqlmdRpW3h6nTtdSGmLSR4RUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727357834; c=relaxed/simple;
	bh=7bkb/2KbEnVyv16Ax1gwLsLQotf/GPNtQFmK2ygNYV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=oUc432IiGpeRLk+iaFXu4Fgi5S8ylfE7+BP8ORv+YoR9GHg7al2Bs5zuHphOg9vg9N+Nd5H2IkrriCs2QZmS4RZ7RLHuHvJKR1/y9qyjjWCbYkVA2BEvZbTYiuWJowdRFM9SGiMOadob8kaYMquPoTaV878MGAso/4KcttTEgAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CW6/WYAR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CW6/WYAR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B32C4CEC5;
	Thu, 26 Sep 2024 13:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727357834;
	bh=7bkb/2KbEnVyv16Ax1gwLsLQotf/GPNtQFmK2ygNYV4=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=CW6/WYARt5jr1wrIjbho35UqldqvM5RpbYGQ8ChGEQeHfzpVt+MVOxzz9utJr4k5B
	 XShiAYFZFo6WfBwHZyGoXpgQCNTNvqSGeRaa1vNnym7OTFZTdpIBPVlzyWlJPIIuGW
	 GJggiODl/LQbBgPhHxRwSUTD4sj+Czw42JedR/9oVMFc6Mv03Q2SKHgWbvV3jwRWi+
	 qBU2gOz0SDcGTIJfuspw4fwtfR/bCvI8VlGMavUx+nMR6CRpzFq6HebnABc0v7lCIK
	 0CXg5qfRrZ3GR6OnDgO/li4JI82QUh8zIuFQVW+d5pkm2tfpM65jgQwEXJwzCrCBjU
	 N8re+wVg6aG4w==
Message-ID: <4f35174d-db6f-43d7-a299-49d47c60267f@kernel.org>
Date: Thu, 26 Sep 2024 15:37:12 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net 1/2] mptcp: handle consistently DSS corruption.
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>
References: <e2c96390fa3980d3aca9c41671b90f645eab6523.1727254866.git.pabeni@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
Cc: mptcp@lists.linux.dev
In-Reply-To: <e2c96390fa3980d3aca9c41671b90f645eab6523.1727254866.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 25/09/2024 11:01, Paolo Abeni wrote:
> Bugged peer implementation can send corrupted DSS options, consistently
> hitting a few warning in the data path. Use DEBUG_NET assertions, to
> avoid the splat on some builds and handle consistently the error, dumping
> related MIBs and performing fallback and/or reset according to the
> subflow type.

Thank you for this fix!

> 
> Fixes: 6771bfd9ee24 ("mptcp: update mptcp ack sequence from work queue")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/mptcp/mib.c      |  2 ++
>  net/mptcp/mib.h      |  2 ++
>  net/mptcp/protocol.c | 24 +++++++++++++++++++++---
>  net/mptcp/subflow.c  |  4 +++-
>  4 files changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
> index 38c2efc82b94..3168cde41593 100644
> --- a/net/mptcp/mib.c
> +++ b/net/mptcp/mib.c
> @@ -76,6 +76,8 @@ static const struct snmp_mib mptcp_snmp_list[] = {
>  	SNMP_MIB_ITEM("RcvWndConflict", MPTCP_MIB_RCVWNDCONFLICT),
>  	SNMP_MIB_ITEM("MPCurrEstab", MPTCP_MIB_CURRESTAB),
>  	SNMP_MIB_ITEM("Blackhole", MPTCP_MIB_BLACKHOLE),
> +	SNMP_MIB_ITEM("DssCorruptionFallaback", MPTCP_MIB_DSSCORRUPTIONFALLBACK),

Small typo: Fall*a*back.

While at it, I suggest placing these two new entries after
DSSNotMatching to ease the backports, and write "DSS" with capital
letters, like the others.

> +	SNMP_MIB_ITEM("DssCorruptionReset", MPTCP_MIB_DSSCORRUPTIONRESET),
>  	SNMP_MIB_SENTINEL
>  };
>  
> diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
> index c8ffe18a8722..40f66556297a 100644
> --- a/net/mptcp/mib.h
> +++ b/net/mptcp/mib.h
> @@ -77,6 +77,8 @@ enum linux_mptcp_mib_field {
>  	MPTCP_MIB_RCVWNDCONFLICT,	/* Conflict with while updating msk rcv wnd */
>  	MPTCP_MIB_CURRESTAB,		/* Current established MPTCP connections */
>  	MPTCP_MIB_BLACKHOLE,		/* A blackhole has been detected */
> +	MPTCP_MIB_DSSCORRUPTIONFALLBACK,/* DSS corruption detected, fallback */
> +	MPTCP_MIB_DSSCORRUPTIONRESET,	/* DSS corruption detected, MPJ subflow reset */

Same here: moving them after MPTCP_MIB_DSSNOMATCH to ease the backports.

>  	__MPTCP_MIB_MAX
>  };
>  
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index c2317919fc14..23231c758ee0 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -620,6 +620,18 @@ static bool mptcp_check_data_fin(struct sock *sk)
>  	return ret;
>  }
>  
> +static void mptcp_dss_corruption(struct mptcp_sock *msk, struct sock *ssk)
> +{
> +	if (msk->first == ssk) {

Is this condition enough to do a fallback? Should we not do a fallback
only if there are no other subflows? Or enough to consider only having
the first subflow:

  list_is_singular(&msk->conn_list) && msk->first == ssk

> +		MPTCP_INC_STATS(sock_net(ssk),
> +				MPTCP_MIB_DSSCORRUPTIONFALLBACK);
> +		mptcp_do_fallback(ssk);
> +	} else {
> +		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSCORRUPTIONRESET);
> +		mptcp_subflow_reset(ssk);
> +	}
> +}
> +
>  static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
>  					   struct sock *ssk,
>  					   unsigned int *bytes)
The rest of this patch and patch 2/2 look good to me!

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


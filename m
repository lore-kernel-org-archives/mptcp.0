Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3A42E6CD5
	for <mptcp@lists.linux.dev>; Tue, 27 Jan 2026 06:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769496899; cv=none; b=dfKH6D1uenmHB4Q2V1/EzdLfGhd5atVorS7neAbtq/v1q3MIQFEE6s65iMEXxwL+ppi2R0CD8biv4m4iYUCCUoIfvEFASlxh6L9XHTTNZfLvFVJKIEgCp2hJWuzTU+33Ab0+myTrWVs6ZvNRnMbGhKkYaC6eGhuiTgIyuHOa72A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769496899; c=relaxed/simple;
	bh=kv8bNiTzwV658+RNVfBh7QEjEUmkey89QPJgHcsaVkQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BMuNjO+IEz7FQaf2DjZEl+hjC7nr2fp/jgZqR+YihEVW2D09AAN8rKtTCqhl4e0PjgHo8c54XTSpKeT7ENKOc+30zYM8+Z3FjFAvN2duisQWXgMIH7J9GbEdjHF+rXtBMW4Qje0VuaWwEsqnMmTwqiRgynrvMTJ2t4RkXojaSR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uvP9gSdq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uvP9gSdq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8889DC116C6;
	Tue, 27 Jan 2026 06:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769496899;
	bh=kv8bNiTzwV658+RNVfBh7QEjEUmkey89QPJgHcsaVkQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=uvP9gSdqUTVUA2bV7ekGgpK3j/Ul+6M58IUsC5x5lmNhRJdDqyE9EhM3tG968JYNt
	 OScjfzTDPuIYj6MCTjZUTNW3MV3mNLJXJHE0u2y/Kao+WzxEzGt/gFyvrgkNzOKFqI
	 S4Dlt/f4oSQNekM8hamfN0OoYKOtNFFLJq30z4iYQGEQgP1A2GPngs00r0gPKVxxHb
	 t9EPdztrkDSUYKCs8jT1voEVDY+IOZSPCXcuewChF9H9FXpKsR/Zwmt/wokjbeoJ6K
	 haDKAM4WNcF/4GX/s7VpsIsNdkRpEITlniiLrWMbj/WK/Ho+kmlWe5d9DsAR2oyKty
	 htFaSBUAF8f3w==
Message-ID: <48222a07ad8d4d11668e293527a354640bdafec5.camel@kernel.org>
Subject: Re: [PATCH mptcp-next] selftests: mptcp: join: no SKIP mark for
 group checks
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
Date: Tue, 27 Jan 2026 14:54:50 +0800
In-Reply-To: <db374b02-06fd-4be8-96d8-e6be55d522ea@kernel.org>
References: <20251211-sft-no-skip-new-cnt-v1-1-6dd6d70f8242@kernel.org>
	 <c24cd268dc2f6797425e022a515776a006eaded6.camel@kernel.org>
	 <db374b02-06fd-4be8-96d8-e6be55d522ea@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-4 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Mon, 2026-01-26 at 19:42 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> Thank you for the review! (and sorry for the late reply)
> 
> On 28/12/2025 04:06, Geliang Tang wrote:
> > Hi Matt,
> > 
> > Thanks for this patch.
> > 
> > On Thu, 2025-12-11 at 19:09 +0100, Matthieu Baerts (NGI0) wrote:
> > > When executing the last MPTCP selftests on older kernels, this
> > > output
> > > is
> > > printed:
> > > 
> > >   # 001 no JOIN
> > >   #       join Rx                             [SKIP]
> > >   #       join Tx                             [SKIP]
> > >   #       fallback                            [SKIP]
> > > 
> > > In fact, behind each line, a few counters are checked, and likely
> > > not
> > > all of them have been skipped because the they are not available
> > > on
> > > these kernels. Instead, "new" and unsupported counters for these
> > > groups
> > > are now ignored, and [ OK ] will be printed instead of [SKIP].
> > > 
> > > Note that on the MPTCP CI, when validating the dev versions, any
> > > unsupported counter will cause the tests to fail. So this is safe
> > > not
> > > to
> > > print 'SKIP' for these group checks.
> > > 
> > > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > > ---
> > >  tools/testing/selftests/net/mptcp/mptcp_join.sh | 30
> > > ++++++++++++---
> > > ----------
> > >  1 file changed, 15 insertions(+), 15 deletions(-)
> > > 
> > > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > b/tools/test[ -z "$count" ]ing/selftests/net/mptcp/mptcp_join.sh
> > > index b2e6e548f796..77370b10651a 100755
> > > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > @@ -1407,7 +1407,7 @@ chk_join_tx_nr()
> > >  
> > >  	count=$(mptcp_lib_get_counter ${ns2}
> > > "MPTcpExtMPJoinSynTxCreatSkErr")
> > >  	if [ -z "$count" ]; then
> > > -		rc=${KSFT_SKIP}
> > > +		: # ignore skip
> > >  	elif [ "$count" != "$create" ]; then
> > 
> > In that case, wouldn't it be better to remove 'if [ -z "$count" ];
> > then' and directly check with 'if [ "$count" != "$create" ]; then'?
> 
> No, we cannot: if $count is empty, then "$count" != "$create", and
> the
> test will be marked as failed instead of being ignored.
> 
> We could have:
> 
>   if [ -n "$count" ] && [ "$count" != "$create" ]
> 
> But I think it is clearer to have an explicit comment for this
> special
> case than multiple conditions. WDYT?

Thanks for the explanation.

This patch looks good to me.

Reviewed-by: Geliang Tang <geliang@kernel.org>

-Geliang

> 
> Cheers,
> Matt

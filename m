Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500FB26B771
	for <mptcp@lists.linux.dev>; Wed, 10 Sep 2025 03:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757476603; cv=none; b=P2HgeAYGvIv84Uq/Q4xHo67qhYdxkKejjtL36SCRqC4U1kJBO6Sevj4kiQbbw/JOtt7O0mj9KBdfo9xoY/4FdJV9ltGElTlvKdoAdqW3YKaJp5rINa49eEnovThNaBK5u5egQazHfhnOLPYjnSX95wYFhT9u9f4CRoVR8mcTXns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757476603; c=relaxed/simple;
	bh=ZI9cBdgTYTm4kj44sJ3F9LEDzRjHhNBPBB2EPBHMokI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OMpnJ/T0lf7qmVPfeOkYIu2XV+8JR6EItR1SmPD5IS1VtJew9wc0ofW/NPFC19QjTs4dlapQ4RLQCcmsNsFqwIbsfQi1Y8gXCR0O67Wrzy9aUECmmpDLGcVZ4SIZgrtSqKzF6ivaSlrMIxTaxrbHM5RweYJx6I5s+1CmE8t9w4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOFwkQJQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOFwkQJQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E72C4CEF0;
	Wed, 10 Sep 2025 03:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757476602;
	bh=ZI9cBdgTYTm4kj44sJ3F9LEDzRjHhNBPBB2EPBHMokI=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=WOFwkQJQPAQ4ATxCXXyyN20nnkahtiyyON8zW5XuoDVpyc0MxIicM6Fs/sxsfutZD
	 NK9rjTfo49y4Rr31Hxo8zEjOWf3Ezy76CZ8hV9mTbDDV9D6Gd1dF3GYGljqbfUfQ7a
	 Z5DbnQdV4tkoTaUVmjVQuLB5TYUGfmnfKnx9CJ6J5QxvIRTVJ95ByTxDeQWgLSKhYR
	 aSgevf+8SKA6QXYiSZdTAKvkfb5KYpEEAkuHtslnfcWjmTrO7q/YDsZWjtwrZi0m1C
	 KwF4eWZ6HSl0z6E/SC9BcwBt9bLILFvahCoX4EjwknD16h2nnw9Qnco6EpZgkoSKLx
	 9e2bG8CuWEc5Q==
Message-ID: <300d5659bd0c4ba39d2c298476979b88d5e0fa24.camel@kernel.org>
Subject: Re: [PATCH mptcp-net 3/7] mptcp: tfo: record 'deny join id0' info
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Wed, 10 Sep 2025 11:56:39 +0800
In-Reply-To: <570aca1d-3c15-4b75-a55a-61396a74eaa0@kernel.org>
References: <20250829-mptcp-pm-user-c-flag-v1-0-78b25dda7708@kernel.org>
	 <20250829-mptcp-pm-user-c-flag-v1-3-78b25dda7708@kernel.org>
	 <1cdace482b0f833e68c95fad171e4323c1d1925e.camel@kernel.org>
	 <570aca1d-3c15-4b75-a55a-61396a74eaa0@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 2025-09-06 at 16:19 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 06/09/2025 16:05, Geliang Tang wrote:
> > Hi Matt,
> > 
> > Thanks for this fix.
> > 
> > On Fri, 2025-08-29 at 22:33 +0200, Matthieu Baerts (NGI0) wrote:
> > > When TFO is used, the check to see if the 'C' flag (deny join
> > > id0)
> > > was
> > > set was bypassed.
> > > 
> > > This flag can be set when TFO is used, so the check should also
> > > be
> > > done
> > > when TFO is used.
> > > 
> > > Fixes: dfc8d0603033 ("mptcp: implement delayed seq generation for
> > > passive fastopen")
> > > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > > ---
> > >  net/mptcp/options.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> > > index
> > > d47b8a9bc2df2f14645b1b3d3e10fea1b38567b1..cf531f2d815cdfbc772b837
> > > def6
> > > e7d558e64d558 100644
> > > --- a/net/mptcp/options.c
> > > +++ b/net/mptcp/options.c
> > > @@ -985,14 +985,14 @@ static bool check_fully_established(struct
> > > mptcp_sock *msk, struct sock *ssk,
> > >  		return false;
> > >  	}
> > >  
> > > -	if (mp_opt->deny_join_id0)
> > > -		WRITE_ONCE(msk->pm.remote_deny_join_id0, true);
> > > -
> > >  	if (unlikely(!READ_ONCE(msk->pm.server_side)))
> > >  		/* DO-NOT-MERGE: use WARN i/o pr_warn: only for
> > > MPTCP export */
> > >  		WARN_ONCE(1, "bogus mpc option on established
> > > client
> > > sk");
> > >  
> > >  set_fully_established:
> > > +	if (mp_opt->deny_join_id0)
> > > +		WRITE_ONCE(msk->pm.remote_deny_join_id0, true);
> > > +
> > 
> > This set_fully_established label is not only jumped to during TFO
> > but
> > also in several other scenarios. I think maybe instead of
> > relocating
> > the deny_join_id0 check code after this label, we should add a new
> > label before the deny_join_id0 check and jump to the new label only
> > in
> > the case of TFO.
> 
> I don't think that's needed: if I'm not mistaken, the only other
> scenario is when a 4th ACK is received. In this case, deny_join_id0
> will
> not be set.
> 
> I don't think we need to add another branch: it is then fine to add
> this
> extra check in the slow path. No?

Sure, thanks for your explanation.

-Geliang

> 
> Cheers,
> Matt

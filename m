Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA2010E9
	for <mptcp@lists.linux.dev>; Tue, 30 Jul 2024 02:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722305207; cv=none; b=K7x3TMYEkp8Wn7NwRRrm0qMXV/ngUJKn+X20egJpFtC8HdonkXw9erjJIJ3B/za/xQkZyP/CEM1tCeW2DO1zKi/EaXTj491/irf8x43Z68hEHpt+2Fn4hg4T+ffYbDbGaAiQQOS3gtXLy+71gafhYl1Zlpmpt3Do8CEekunjYSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722305207; c=relaxed/simple;
	bh=8BfUb+7EQIqumL12WkhdpdpjywGZHQRgdxpZhih5RM4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UoufQrAhz8Fkvab8xXc26E/azLN+wfFvzuq8h3sOfnK2aiC3pMq+NkynMcIZ2vLtgy1ckeZ+XacLNXIryjrJLH2acta9yIJ4w51ynGko9qXXTyvkLp5UO2pkP3lKad9DSumFZ9gvk4sMxuQlvwCYIZdn5wh+kVo0ldz19e33oXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvzuVBh9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvzuVBh9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 279D6C4AF07;
	Tue, 30 Jul 2024 02:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722305206;
	bh=8BfUb+7EQIqumL12WkhdpdpjywGZHQRgdxpZhih5RM4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=pvzuVBh9IF8hIJznyhoT0qQ7leLphCaEnWnA+Dx9xX3SXUboOg3ppDPZXhFc4lMeJ
	 qVbu3zBkfbfB2yTMT+POpQdBYAQ5srOgKjA9vXyNTvdRjTiob3arLj4g+L4ksJfhPZ
	 EGMdcEF8slx+z30VNPzReSeTij4MCqCOaagqeR4dzsekjNLca2akLZzQUQxY9q4ecx
	 CLVLewoAG7lBF5TXIZCrhpyJv8aQA07jThN8kAyZz8oK4izSRoaPAzFJmiXmJL+Z83
	 LKQ7KkpQ67fL8RacXDldEjLZacTgvgqukloi6J1JS4dFf1Bz9CIn9JxmC1qxJkPJek
	 5bAg2KAmRU2AA==
Message-ID: <891ada5a5a0d03e58ed81e57ab6aa13c71279db8.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v5 07/13] mptcp: pm: only in-kernel cannot
 have entries with ID 0
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, Mat Martineau <martineau@kernel.org>
Date: Tue, 30 Jul 2024 10:06:40 +0800
In-Reply-To: <09f0fffc-8101-4ffa-869c-a7f63d12c181@kernel.org>
References: <20240726-mptcp-pm-avail-v5-0-fb1117ddeef6@kernel.org>
	 <20240726-mptcp-pm-avail-v5-7-fb1117ddeef6@kernel.org>
	 <bc65dcccc3569ba5de9930ae47e634912cf3efbe.camel@kernel.org>
	 <09f0fffc-8101-4ffa-869c-a7f63d12c181@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 TO0tfEdfAX7IENcV87h2yAFBZkaA==
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.0-1build2 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2024-07-29 at 11:29 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 29/07/2024 03:12, Geliang Tang wrote:
> > On Fri, 2024-07-26 at 16:28 +0200, Matthieu Baerts (NGI0) wrote:
> > > The ID 0 is specific per MPTCP connections. The per netns entries
> > > cannot
> > > have this special ID 0 then.
> > > 
> > > But that's different for the userspace PM where the entries are
> > > per
> > > connection, they can then use this special ID 0.
> > > 
> > > Fixes: f40be0db0b76 ("mptcp: unify pm
> > > get_flags_and_ifindex_by_id")
> > > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > > ---
> > >  net/mptcp/pm.c         | 3 ---
> > >  net/mptcp/pm_netlink.c | 4 ++++
> > >  2 files changed, 4 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> > > index 925123e99889..3e6e0f5510bb 100644
> > > --- a/net/mptcp/pm.c
> > > +++ b/net/mptcp/pm.c
> > > @@ -434,9 +434,6 @@ int
> > > mptcp_pm_get_flags_and_ifindex_by_id(struct
> > > mptcp_sock *msk, unsigned int id
> > >  	*flags = 0;
> > >  	*ifindex = 0;
> > >  
> > > -	if (!id)
> > > -		return 0;
> > > -
> > >  	if (mptcp_pm_is_userspace(msk))
> > >  		return
> > > mptcp_userspace_pm_get_flags_and_ifindex_by_id(msk, id, flags,
> > > ifindex);
> > >  	return mptcp_pm_nl_get_flags_and_ifindex_by_id(msk, id,
> > > flags, ifindex);
> > > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > > index 3cb02fe359c0..6a1495fec7ae 100644
> > > --- a/net/mptcp/pm_netlink.c
> > > +++ b/net/mptcp/pm_netlink.c
> > > @@ -1395,6 +1395,10 @@ int
> > > mptcp_pm_nl_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
> > > unsigned int
> > >  	struct sock *sk = (struct sock *)msk;
> > >  	struct net *net = sock_net(sk);
> > >  
> > > +	/* No entries with ID 0 */
> > > +	if (id == 0)
> > > +		return 0;
> > > +
> > 
> > I think this check needs to be added in
> > mptcp_userspace_pm_get_flags_and_ifindex_by_id() too.
> 
> We don't need it for the userspace PM, because the endpoints are
> managed
> per MPTCP connection, they can have an ID 0. On the other hand, the
> in-kernel PM manages the endpoints globally, they cannot have the ID
> 0
> because it is reserved to the address used by the initial subflow,
> which
> can be different per MPTCP connection.
> 
> Please see the commit message for more details.

Thanks for your explanation.

Acked-by: Geliang Tang <geliang@kernel.org>

> 
> > 
> > >  	rcu_read_lock();
> > >  	entry = __lookup_addr_by_id(pm_nl_get_pernet(net), id);
> > >  	if (entry) {
> > > 
> > 
> 
> Cheers,
> Matt


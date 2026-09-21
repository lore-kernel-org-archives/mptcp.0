Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5F8429CF3
	for <mptcp@lists.linux.dev>; Mon, 21 Sep 2026 10:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789986055; cv=none; b=I/t2t0bflNdNwp0eh1yg02perIEKT5pGd4E5qHsR5dWFzUw+l7VjWCxoQoZOX5+Vpl9VZ9KIkNL65oltmg2RFBK65dzMaFbsE+Ql3DIT1WCJ/pgXmzoRoiRliZcIXu/M55WHha9wGXOPxBaWnXXd12GY0cP4ar2J1OI+hYjAoXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789986055; c=relaxed/simple;
	bh=JcuWyXw0b1VxJk6Nt21e0KZ7V3ExZPrBtKocUjj6T1M=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pBjxFLByWbT5Kw/0B5p5eYLHQZL0oHbEaYE8tG6t0pUp5ce1SvPVGFDakASh3hVa0iJypq4YPxYi//jYGQh547R1o64BtOrKoU9L02ABI0/MLqr/HgkJhCbEc2ChE5v17lOofGqN4uTK4s04gJc9wv2QAq6ky0xakW4wfDNp+bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjvCdndR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjvCdndR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 362B81F00898;
	Mon, 21 Sep 2026 10:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789986047;
	bh=pQRWiKu4jPRmnd4IE1KQjoiODnzdhihFoq+EGJY5dT4=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=FjvCdndR8dTSxNkxBXlE0tKgV859uJzpeBv4BKhrtLP/yNWIdXcBwBUoQef9yqUkZ
	 m1YJFnw5Tz+gANQMQl3wsRW00YzDf6xMEL40dhvDOuW43J831G5j6lnFNZK5Cikcev
	 sApShsedyB9rJNzb7b7GfZ3iWbsysaJwe8cAA9v0xnb2+6nIhdplsadNVAij4LPzdk
	 15BUfYAl+HhRfmAEaig0u2K7eeWJpb+ojO6FZdVdWJZdWJfmiADFcyUE+ffrhNWKd0
	 bqd2wKCzjzyObuTLkkS9AUmxAxN2TMsFyiKVQi9Y+JlPcH/+MLs8mUx1+TtrhktskW
	 YmcP9z0q+h1vA==
Message-ID: <88eb6824e4fb9c14cb6fd975ee947bc450581135.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v3 2/8] mptcp: pm: userspace: lookup: match
 port in priority
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, MPTCP Linux <mptcp@lists.linux.dev>
Date: Mon, 21 Sep 2026 18:20:38 +0800
In-Reply-To: <987ee3fe-6533-4739-8181-4367302cac63@kernel.org>
References: 
	<20260807-mptcp-pm-userspace-id0-case-v3-0-de9088549924@kernel.org>
	 <20260807-mptcp-pm-userspace-id0-case-v3-2-de9088549924@kernel.org>
	 <7bf7a43655610da952266aa7bfbec76a1dcb5f22.camel@kernel.org>
	 <b1710700-0755-4f74-a6db-cfaa7f28a057@kernel.org>
	 <bb74f942d14b1335bd5be83ca8b2c750cc8063b5.camel@kernel.org>
	 <987ee3fe-6533-4739-8181-4367302cac63@kernel.org>
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

On Sun, 2026-08-30 at 23:00 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 30/08/2026 06:43, Geliang Tang wrote:
> > Hi Matt,
> > 
> > On Wed, 2026-08-19 at 09:56 +0200, Matthieu Baerts wrote:
> > > Hi Geliang,
> > > 
> > > Thank you for the review and suggestion!
> > > 
> > > On 19/08/2026 09:23, Geliang Tang wrote:
> > > > Hi Matt,
> > > > 
> > > > On Fri, 2026-08-07 at 10:41 +0200, Matthieu Baerts (NGI0)
> > > > wrote:
> > > > > In the local address list, there can be entries with the port
> > > > > set
> > > > > to
> > > > > 0
> > > > > -- corresponding to the source port used by the initial
> > > > > subflow -
> > > > > -
> > > > > and
> > > > > others with a specific port.
> > > > > 
> > > > > When performing a lookup, it is important to compare the
> > > > > ports to
> > > > > pick
> > > > > the right entry: when a specific port is given, then try to
> > > > > match
> > > > > it
> > > > > first. If no match is found, try to find entries with the
> > > > > port
> > > > > set to
> > > > > 0.
> > > > > 
> > > > > Fixes: 24430f8bf516 ("mptcp: add address into userspace pm
> > > > > list")
> > > > > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > > > > ---
> > > > > v3: new (Sashiko)
> > > > > ---
> > > > >  net/mptcp/pm_userspace.c | 14 +++++++++++++-
> > > > >  1 file changed, 13 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/net/mptcp/pm_userspace.c
> > > > > b/net/mptcp/pm_userspace.c
> > > > > index 663cbeb79548..3f1471ec3fc7 100644
> > > > > --- a/net/mptcp/pm_userspace.c
> > > > > +++ b/net/mptcp/pm_userspace.c
> > > > > @@ -33,10 +33,22 @@ mptcp_userspace_pm_lookup_addr(struct
> > > > > mptcp_sock
> > > > > *msk,
> > > > >  {
> > > > >  	struct mptcp_pm_addr_entry *entry;
> > > > >  
> > > > > +	/* Compare ports when set in addr */
> > > > >  	mptcp_for_each_userspace_pm_addr(msk, entry) {
> > > > > -		if (mptcp_addresses_equal(&entry->addr,
> > > > > addr,
> > > > > false))
> > > > > +		if (mptcp_addresses_equal(&entry->addr,
> > > > > addr,
> > > > > addr-
> > > > > > port != 0))
> > > > >  			return entry;
> > > > >  	}
> > > > > +
> > > > > +	if (addr->port == 0)
> > > > > +		return NULL;
> > > > > +
> > > > > +	/* Check only wildcard ports if no exact match with
> > > > > the
> > > > > port
> > > > > */
> > > > > +	mptcp_for_each_userspace_pm_addr(msk, entry) {
> > > > > +		if (entry->addr.port == 0 &&
> > > > > +		    mptcp_addresses_equal(&entry->addr,
> > > > > addr,
> > > > > false))
> > > > > +			return entry;
> > > > > +	}
> > > > > +
> > > > >  	return NULL;
> > > > >  }
> > > > 
> > > > Personally, I think a single-pass lookup is better than a two-
> > > > pass
> > > > one.
> > > 
> > > Indeed, I initially thought the code wouldn't be very readable,
> > > but
> > > maybe worth it.
> > > 
> > > > I've implemented a version and it passed the tests:
> > > > 
> > > > static struct mptcp_pm_addr_entry *
> > > > mptcp_userspace_pm_lookup_addr(struct mptcp_sock *msk,
> > > >                                const struct mptcp_addr_info
> > > > *addr)
> > > > {
> > > >     struct mptcp_pm_addr_entry *entry, *wildcard = NULL;
> > > >     struct mptcp_addr_info match;
> > > > 
> > > >     mptcp_for_each_userspace_pm_addr(msk, entry) {
> > > >         match = entry->addr;
> > > 
> > > Mmh, but now there is a copy for each entry. Not sure what's
> > > better.
> > > 
> > > >         if (match.port == 0 && addr->port != 0)
> > > 
> > > (Would it not work to add this condition to the last argument of
> > > mptcp_addresses_equal()? → EDIT: no, see below)
> > > 
> > > >             match.port = addr->port;
> > > 
> > > It feels wrong: entry->addr.port == 0 should mean "same port as
> > > the
> > > msk"
> > > (inet_sk((struct sock *)msk)->inet_sport). But this "addr->port"
> > > is
> > > possibly yet another port.
> > > 
> > > In other words, I think doing that here means accepting the first
> > > wildcard one. An example: ID0 is now the first entry, if there is
> > > another IP with another specific port, it should be picked in
> > > priority.
> > > With this code here, I don't think that will be the case: the ID0
> > > entry
> > > will be picked instead, no?
> > > 
> > > (I think we should have a test with the userspace PM announcing
> > > the
> > > same
> > > address but with another port + doing the listen for this port
> > > manually,
> > > and checking the IDs being used: shouldn't be 0)
> > > 
> > > >         if (mptcp_addresses_equal(&match, addr, addr->port !=
> > > > 0)) {
> > > 
> > > What if we always call mptcp_addresses_equal without the port
> > > check,
> > > and
> > > do that "manually" here below?
> > > 
> > > -> Return if the port is the same, then save it as wildcard if
> > > one of
> > > them has no port set.
> > > 
> > > Even there, it feels like the comparison should be stricter: if
> > > one
> > > port
> > > is 0, either the other one is 0 (port is the same, already
> > > checked
> > > then)
> > > or equal to the msk one. I think I quickly tried this at some
> > > points,
> > > and it was causing issues, but I didn't investigate. Maybe the
> > > tests
> > > are
> > > wrong (mixing up IDs) or there is another bug somewhere... Do you
> > > mind
> > > looking at this if you have the opportunity, please?
> > 
> > Apologies for the delayed response.
> 
> No need to apologies, it's still way quicker than most of my replies
> :)
> 
> > I've revised the implementation to the following version:
> > 
> > static struct mptcp_pm_addr_entry *
> > mptcp_userspace_pm_lookup_addr(struct mptcp_sock *msk,
> >                                const struct mptcp_addr_info *addr)
> > {
> >         struct mptcp_pm_addr_entry *entry, *wildcard = NULL;
> > 
> >         mptcp_for_each_userspace_pm_addr(msk, entry) {
> >                 if (mptcp_addresses_equal(&entry->addr, addr,
> > false)) {
> >                         if (!addr->port)
> >                                 return entry;
> 
> Even if that's similar to what I did in my patch, should this not be
> a
> wildcard either?
> 
> It seems that it should be:
> 
>   if (addr->port == entry->addr.port)
>       return entry;
> 
>   if (!wildcard && (!addr->port || !entry->addr.port))
>       wildcard = entry;
> 
> No?
> 
> 
> It feels that it should even be without the "wildcard":
> 
>   __be16 msk_sport = inet_sk((struct sock *)msk)->inet_sport;
>   struct mptcp_pm_addr_entry *entry;
> 
>   mptcp_for_each_userspace_pm_addr(msk, entry) {
>       if (mptcp_addresses_equal(&entry->addr, addr, false)) {
>           if (addr->port == entry->addr.port)
>               return entry;
> 
>           if (!addr->port && entry->addr.port == msk_sport)
>               return entry;
> 
>           if (!entry->addr.port && addr->port == msk_sport)
>               return entry;
>       }
>   }
> 
>   return NULL;
> 
> But I just remembered we need to handle the case where a subflow got
> created without forcing the source port: we used the same ID as
> another
> subflow, and we still need to match it, even if here the source port
> is
> likely not the same as the msk one, but that's OK. So we need this
> "wildcard".

Yes, that's exactly right. The wildcard fallback is necessary.

> 
> So thank you for the new suggestion, I will take it with the
> modification I mentioned, if that's OK for you.

I have no further comments.

Thanks,
-Geliang

> 
> Cheers,
> Matt

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC6EBA3D
	for <mptcp@lists.linux.dev>; Sun, 30 Aug 2026 04:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788065006; cv=none; b=n2ZTCSSFHaRwTvZnyyNWNjEDIQ4EhJkUF02E8kLBhSQz9f4wOm4iCCkE59RBSlZdcCe6CSzp0O8ih0rnSFxGxzcPE2Zh/SuQISoG3KLAzie+pvtAK5yf3kVCpRmHVINgAxHA4RuWkkgYye5jzLs5eL4JehX1Phj2DEgPmUXjEe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788065006; c=relaxed/simple;
	bh=+17EsqY0p9IGe1piQZOaL5/KA2DWvURbqNClaaxhF3k=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oKnCtuMm9J9N3a7vlRKxdoxPgwo44xK62XpEfI1q61y8QQBcKnCGp8XE75H4QP8IklwwysfwA7z6TKTPIXHlcH3+h1Au0Pcm1rNpA06g8cRmogDFl6XxieoykmPQQm5mlsw62Tj/wormVcIn4pePC6nTAZl/Mp3XRSPVW1qtvuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BT+I0Rb2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BT+I0Rb2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B0A1F000E9;
	Sun, 30 Aug 2026 04:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788065004;
	bh=mbXK6NE1nbadDp/cIhz/6KXMhhhbUe+hViyoOv+oU5s=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=BT+I0Rb2if2si0uodp7zRdh8TmwyUDyk9PbBc0UcT1vEj7+oQWMrhcWv/OPPROMT+
	 qMF2TS8LHY5pYvBvNsk4dsg40mqhCZMqkf55NXq7ZGhFTi1eQ3XTJe0+AWEwK9FVht
	 egsGj8mJh8dE7KgESFrOHbMfj5rUIv680hBYx09lHqEgg3E658JQnZD6LFzS5waSyb
	 xmR3Y4442M9rN2SR/hJQbJz2De0nnUKUnvD/7m9fAEQOo0NTjyI5J/OnVH4Gb/kx9I
	 Gx/iQvh6fZM/B/s/uIujb/IfS9Z822JJWxuE1SeodpYApEHg1y1seFdTh3coHi5aFE
	 hW7r2gAdj6U9A==
Message-ID: <bb74f942d14b1335bd5be83ca8b2c750cc8063b5.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v3 2/8] mptcp: pm: userspace: lookup: match
 port in priority
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, MPTCP Linux <mptcp@lists.linux.dev>
Date: Sun, 30 Aug 2026 12:43:21 +0800
In-Reply-To: <b1710700-0755-4f74-a6db-cfaa7f28a057@kernel.org>
References: 
	<20260807-mptcp-pm-userspace-id0-case-v3-0-de9088549924@kernel.org>
	 <20260807-mptcp-pm-userspace-id0-case-v3-2-de9088549924@kernel.org>
	 <7bf7a43655610da952266aa7bfbec76a1dcb5f22.camel@kernel.org>
	 <b1710700-0755-4f74-a6db-cfaa7f28a057@kernel.org>
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

On Wed, 2026-08-19 at 09:56 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> Thank you for the review and suggestion!
> 
> On 19/08/2026 09:23, Geliang Tang wrote:
> > Hi Matt,
> > 
> > On Fri, 2026-08-07 at 10:41 +0200, Matthieu Baerts (NGI0) wrote:
> > > In the local address list, there can be entries with the port set
> > > to
> > > 0
> > > -- corresponding to the source port used by the initial subflow -
> > > -
> > > and
> > > others with a specific port.
> > > 
> > > When performing a lookup, it is important to compare the ports to
> > > pick
> > > the right entry: when a specific port is given, then try to match
> > > it
> > > first. If no match is found, try to find entries with the port
> > > set to
> > > 0.
> > > 
> > > Fixes: 24430f8bf516 ("mptcp: add address into userspace pm list")
> > > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > > ---
> > > v3: new (Sashiko)
> > > ---
> > >  net/mptcp/pm_userspace.c | 14 +++++++++++++-
> > >  1 file changed, 13 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> > > index 663cbeb79548..3f1471ec3fc7 100644
> > > --- a/net/mptcp/pm_userspace.c
> > > +++ b/net/mptcp/pm_userspace.c
> > > @@ -33,10 +33,22 @@ mptcp_userspace_pm_lookup_addr(struct
> > > mptcp_sock
> > > *msk,
> > >  {
> > >  	struct mptcp_pm_addr_entry *entry;
> > >  
> > > +	/* Compare ports when set in addr */
> > >  	mptcp_for_each_userspace_pm_addr(msk, entry) {
> > > -		if (mptcp_addresses_equal(&entry->addr, addr,
> > > false))
> > > +		if (mptcp_addresses_equal(&entry->addr, addr,
> > > addr-
> > > > port != 0))
> > >  			return entry;
> > >  	}
> > > +
> > > +	if (addr->port == 0)
> > > +		return NULL;
> > > +
> > > +	/* Check only wildcard ports if no exact match with the
> > > port
> > > */
> > > +	mptcp_for_each_userspace_pm_addr(msk, entry) {
> > > +		if (entry->addr.port == 0 &&
> > > +		    mptcp_addresses_equal(&entry->addr, addr,
> > > false))
> > > +			return entry;
> > > +	}
> > > +
> > >  	return NULL;
> > >  }
> > 
> > Personally, I think a single-pass lookup is better than a two-pass
> > one.
> 
> Indeed, I initially thought the code wouldn't be very readable, but
> maybe worth it.
> 
> > I've implemented a version and it passed the tests:
> > 
> > static struct mptcp_pm_addr_entry *
> > mptcp_userspace_pm_lookup_addr(struct mptcp_sock *msk,
> >                                const struct mptcp_addr_info *addr)
> > {
> >     struct mptcp_pm_addr_entry *entry, *wildcard = NULL;
> >     struct mptcp_addr_info match;
> > 
> >     mptcp_for_each_userspace_pm_addr(msk, entry) {
> >         match = entry->addr;
> 
> Mmh, but now there is a copy for each entry. Not sure what's better.
> 
> >         if (match.port == 0 && addr->port != 0)
> 
> (Would it not work to add this condition to the last argument of
> mptcp_addresses_equal()? → EDIT: no, see below)
> 
> >             match.port = addr->port;
> 
> It feels wrong: entry->addr.port == 0 should mean "same port as the
> msk"
> (inet_sk((struct sock *)msk)->inet_sport). But this "addr->port" is
> possibly yet another port.
> 
> In other words, I think doing that here means accepting the first
> wildcard one. An example: ID0 is now the first entry, if there is
> another IP with another specific port, it should be picked in
> priority.
> With this code here, I don't think that will be the case: the ID0
> entry
> will be picked instead, no?
> 
> (I think we should have a test with the userspace PM announcing the
> same
> address but with another port + doing the listen for this port
> manually,
> and checking the IDs being used: shouldn't be 0)
> 
> >         if (mptcp_addresses_equal(&match, addr, addr->port != 0)) {
> 
> What if we always call mptcp_addresses_equal without the port check,
> and
> do that "manually" here below?
> 
> -> Return if the port is the same, then save it as wildcard if one of
> them has no port set.
> 
> Even there, it feels like the comparison should be stricter: if one
> port
> is 0, either the other one is 0 (port is the same, already checked
> then)
> or equal to the msk one. I think I quickly tried this at some points,
> and it was causing issues, but I didn't investigate. Maybe the tests
> are
> wrong (mixing up IDs) or there is another bug somewhere... Do you
> mind
> looking at this if you have the opportunity, please?

Apologies for the delayed response.

I've revised the implementation to the following version:

static struct mptcp_pm_addr_entry *
mptcp_userspace_pm_lookup_addr(struct mptcp_sock *msk,
                               const struct mptcp_addr_info *addr)
{
        struct mptcp_pm_addr_entry *entry, *wildcard = NULL;

        mptcp_for_each_userspace_pm_addr(msk, entry) {
                if (mptcp_addresses_equal(&entry->addr, addr, false)) {
                        if (!addr->port)
                                return entry;
                        if (addr->port == entry->addr.port)
                                return entry;
                        if (!wildcard && !entry->addr.port)
                                wildcard = entry;
                }
        }

        return wildcard;
}

What do you think of this version?

Thanks,
-Geliang

> 
> >             if (addr->port == 0 || entry->addr.port != 0)
> >                 return entry;
> > 
> >             if (!wildcard)
> >                 wildcard = entry;
> >         }
> >     }
> > 
> >     return wildcard;
> > }
> > 
> > What do you think of this approach?
> > 
> > Also, this series has conflicts with the current export branch and
> > needs a rebase.
> Yes indeed. But let's focus on this case above, and wait a bit longer
> to
> have a review on the other patches as well.
> 
> Cheers,
> Matt

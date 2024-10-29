Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D612038B6
	for <mptcp@lists.linux.dev>; Tue, 29 Oct 2024 08:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730191439; cv=none; b=UeHSIFXxEyddFJqgvgneAC8SHJV9LfBjYZ6BUVvEVDwBKtihkLd/KeoYvpg0x4v1x+HZbyWPH4L1VhbpNpx+NeO+8f7Ly/6uo0SqsdEBVs3QCKbfJuQhapxzgLCcMuT/+thd2kw0bSFf98rljJvT1bslOAUCbNsltzoWi9+z+TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730191439; c=relaxed/simple;
	bh=7WioBimHvI8zr5vw18NEKTosxQwOY0BeRx0s9Hf9e1E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HsNAu5RW7iY5e9skfGkbtAJiUP0T/pv/kG55HqkYSkCyioJoQpiLVF4H7Q/vjrqVIgJrYy9AW73r3yTHQtnQXEkKJtboqFA2z3NkvBqWFxnrw1a58RUFwqkFR7tz6wOp4C5mwR8XUL5GTTHEQD5choD+vWFYIEWxgWnq8QLIw9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUTKADdm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUTKADdm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9414BC4CEE6;
	Tue, 29 Oct 2024 08:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730191438;
	bh=7WioBimHvI8zr5vw18NEKTosxQwOY0BeRx0s9Hf9e1E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=FUTKADdmyDWQXvTenQe6wSFXJUntpk8lhnmHhhVB+YBLcf4QNb1dZh4l/jRPNQlGB
	 5LXQAUPRN3bgXM2gHlnbTkpB8lCuT1wBbAgZhwOlBFEr6fhMPqI9dkXqpUz7Jw3ru8
	 b60E70vl1wFOcMaVHtTdEFeUmk+IlqBvAzqaxE45bzPScNPTNQz6gcXfCuI55/+I+J
	 AjLSVqWislnBADnKKL38Q759qh6jNAR0yCbhw42cxJ0ZrfoUe+lN3lv2FW0guTlv59
	 zElkS15zwjlkeBEdda2Wm9BhqTsvgwfk5j6boLagLPRz6E+bsfvGZs+h+7xxEmw2QT
	 rx0ld36tdZYdQ==
Message-ID: <7f5c3d67bad2a3e8773930128b0c3ddbccd0fd98.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v2 2/3] mptcp: pm: lockless list traversal
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 29 Oct 2024 16:43:55 +0800
In-Reply-To: <cb3c0685-a3ce-4009-b5a4-7e4fb9d4716e@kernel.org>
References: <20241025-mptcp-pm-lookup_addr_rcu-v2-0-1478f6c4b205@kernel.org>
		 <20241025-mptcp-pm-lookup_addr_rcu-v2-2-1478f6c4b205@kernel.org>
		 <48c030b9f5156dddec50e8727062b8350a53f8a0.camel@kernel.org>
		 <b303b3d0-1c0a-4c0a-8031-77023a2de005@kernel.org>
		 <bb346392a148c223c9aed723ba5f45c8d9a2f34c.camel@kernel.org>
		 <cb3c0685-a3ce-4009-b5a4-7e4fb9d4716e@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=mQINBGWKTg4BEAC/Subk93zbjSYPahLCGMgjylhY/s/R2ebALGJFp13MPZ9qWlbVC8O+X
 lU/4reZtYKQ715MWe5CwJGPyTACILENuXY0FyVyjp/jl2u6XYnpuhw1ugHMLNJ5vbuwkc1I29nNe8
 wwjyafN5RQV0AXhKdvofSIryqm0GIHIH/+4bTSh5aB6mvsrjUusB5MnNYU4oDv2L8MBJStqPAQRLl
 P9BWcKKA7T9SrlgAr0VsFLIOkKOQPVTCnYxn7gfKogH52nkPAFqNofVB6AVWBpr0RTY7OnXRBMInM
 HcjVG4I/NFn8Cc7oaGaWHqX/yHAufJKUsldieQVFd7C/SI8jCUXdkZxR0Tkp0EUzkRc/TS1VwWHav
 0x3oLSy/LGHfRaIC/MqdGVqgCnm6wapUt7f/JHloyIyKJBGBuHCLMpN6n/kNkSCzyZKV7h6Vw1OL5
 18p0U3Optyakoh95KiJsKzcd3At/eftQGlNn5WDflHV1+oMdW2sRgfVDPrYeEcYI5IkTc3LRO6ucp
 VCm9/+poZSHSXMI/oJ6iXMJE8k3/aQz+EEjvc2z0p9aASJPzx0XTTC4lciTvGj62z62rGUlmEIvU2
 3wWH37K2EBNoq+4Y0AZsSvMzM+CcTo25hgPaju1/A8ErZsLhP7IyFT17ARj/Et0G46JRsbdlVJ/Pv
 X+XIOc2mpqx/QARAQABtCVHZWxpYW5nIFRhbmcgPGdlbGlhbmcudGFuZ0BsaW51eC5kZXY+iQJUBB
 MBCgA+FiEEZiKd+VhdGdcosBcafnvtNTGKqCkFAmWKTg4CGwMFCRLMAwAFCwkIBwIGFQoJCAsCBBY
 CAwECHgECF4AACgkQfnvtNTGKqCmS+A/9Fec0xGLcrHlpCooiCnNH0RsXOVPsXRp2xQiaOV4vMsvh
 G5AHaQLb3v0cUr5JpfzMzNpEkaBQ/Y8Oj5hFOORhTyCZD8tY1aROs8WvbxqvbGXHnyVwqy7AdWelP
 +0lC0DZW0kPQLeel8XvLnm9Wm3syZgRGxiM/J7PqVcjujUb6SlwfcE3b2opvsHW9AkBNK7v8wGIcm
 BA3pS1O0/anP/xD5s5L7LIMADVB9MqQdeLdFU+FFdafmKSmcP9A2qKHAvPBUuQo3xoBOZR3DMqXIP
 kNCBfQGkAx5tm1XYli1u3r5tp5QCRbY5LSkntMNJJh0eWLU8I+zF6NWhqNhHYRD3zc1tiXlG5E0ob
 pX02Dy25SE2zB3abCRdAK30nCI4lMyMCcyaeFqvf6uhiugLiuEPRRRdJDWICOLw6KOFmxWmue1F71
 k08nj5PQMWQUX3X2K6jiOuoodYwnie/9NsH3DBHIVzVPWASFd6JkZ21i9Ng4ie+iQAveRTCeCCF6V
 RORJR0R8d7mI9+1eqhNeKzs21gQPVf/KBEIpwPFDjOdTwS/AEQQyhB+5ALeYpNgfKl2p30C20VRfJ
 GBaTc4ReUXh9xbUx5OliV69iq9nIVIyculTUsbrZX81Gz6UlbuSzWc4JclWtXf8/QcOK31wputde7
 Fl1BTSR4eWJcbE5Iz2yzgQu0IUdlbGlhbmcgVGFuZyA8Z2VsaWFuZ0BrZXJuZWwub3JnPokCVAQTA
 QoAPhYhBGYinflYXRnXKLAXGn577TUxiqgpBQJlqclXAhsDBQkSzAMABQsJCAcCBhUKCQgLAgQWAg
 MBAh4BAheAAAoJEH577TUxiqgpaGkP/3+VDnbu3HhZvQJYw9a5Ob/+z7WfX4lCMjUvVz6AAiM2atD
 yyUoDIv0fkDDUKvqoU9BLU93oiPjVzaR48a1/LZ+RBE2mzPhZF201267XLMFBylb4dyQZxqbAsEhV
 c9VdjXd4pHYiRTSAUqKqyamh/geIIpJz/cCcDLvX4sM/Zjwt/iQdvCJ2eBzunMfouzryFwLGcOXzx
 OwZRMOBgVuXrjGVB52kYu1+K90DtclewEgvzWmS9d057CJztJZMXzvHfFAQMgJC7DX4paYt49pNvh
 cqLKMGNLPsX06OR4G+4ai0JTTzIlwVJXuo+uZRFQyuOaSmlSjEsiQ/WsGdhILldV35RiFKe/ojQNd
 4B4zREBe3xT+Sf5keyAmO/TG14tIOCoGJarkGImGgYltTTTM6rIk/wwo9FWshgKAmQyEEiSzHTSnX
 cGbalD3Do89YRmdG+5eP7HQfsG+VWdn8IH6qgIvSt8GOw6RfSP7omMXvXji1VrbWG4LOFYcsKTN+d
 GDhl8LmU0y44HejkCzYj/b28MvNTiRVfucrmZMGgI8L5A4ZwQ3Inv7jY13GZSvTb7PQIbqMcb1P3S
 qWJFodSwBg9oSw21b+T3aYG3z3MRCDXDlZAJONELx32rPMdBva8k+8L+K8gc7uNVH4jkMPkP9jPnV
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.54.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Mon, 2024-10-28 at 12:48 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 28/10/2024 03:08, Geliang Tang wrote:
> > Hi Matt,
> > 
> > On Fri, 2024-10-25 at 17:26 +0200, Matthieu Baerts wrote:
> > > Hi Geliang,
> > > 
> > > Thank you for the review!
> > > 
> > > On 25/10/2024 16:25, Geliang Tang wrote:
> > > > On Fri, 2024-10-25 at 11:32 +0200, Matthieu Baerts (NGI0)
> > > > wrote:
> > > > > In a few places -- to get an endpoint, dump all of them, and
> > > > > change
> > > > > their flags -- the list is iterated while holding the pernet-
> > > > > > lock,
> > > > > but
> > > > > only to read the content of the list. In these cases, we can
> > > > > replace
> > > > > the
> > > > > spin locks, by RCU read ones, and use the _rcu variants to
> > > > > iterate
> > > > > over
> > > > > the entries list in a lockless way.
> > > > > 
> > > > > To make it clear, the lookup helpers using the _rcu variant
> > > > > are
> > > > > renamed
> > > > > with a _rcu suffix. The previous __lookup_addr() helper can
> > > > > then
> > > > > be
> > > > > removed, but __lookup_addr_by_id() is still needed.
> > > > > 
> > > > > While at it, the IDs bitmap is copied before iterating the
> > > > > list
> > > > > to
> > > > > dump
> > > > > the different addresses, to avoid any consistencies.
> > > > > 
> > > > > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > > > > ---
> > > > > Notes:
> > > > >  - This is not a fix, a small improvement for -next.
> > > > > ---
> > > > >  net/mptcp/pm_netlink.c | 36 +++++++++++++++++++-------------
> > > > > ----
> > > > >  1 file changed, 19 insertions(+), 17 deletions(-)
> > > > > 
> > > > > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > > > > index
> > > > > a93b9b7776b48781a883673fe5fd521a978487ff..f38e1ccd34e95cd88b1
> > > > > 79a8
> > > > > b50e
> > > > > 6965731542871 100644
> > > > > --- a/net/mptcp/pm_netlink.c
> > > > > +++ b/net/mptcp/pm_netlink.c
> > > 
> > > (...)
> > > 
> > > > > @@ -1872,16 +1872,18 @@ int mptcp_pm_nl_dump_addr(struct
> > > > > sk_buff
> > > > > *msg,
> > > > >   struct net *net = sock_net(msg->sk);
> > > > >   struct mptcp_pm_addr_entry *entry;
> > > > >   struct pm_nl_pernet *pernet;
> > > > > + unsigned long id_bitmap[4];
> > > > >   int id = cb->args[0];
> > > > >   void *hdr;
> > > > >   int i;
> > > > >  
> > > > >   pernet = pm_nl_get_pernet(net);
> > > > > + bitmap_copy(id_bitmap, pernet->id_bitmap,
> > > > > MPTCP_PM_MAX_ADDR_ID + 1);
> > > > 
> > > > I think the id bitmap should only be copied when id is 0:
> > > > 
> > > > if (!id)
> > > >   bitmap_copy(id_bitmap, pernet->id_bitmap,
> > > > MPTCP_PM_MAX_ADDR_ID +
> > > > 1);
> > > > 
> > > > Since this mptcp_pm_nl_dump_addr() may be called repeatedly
> > > > when
> > > > the
> > > > dump information is very long. We only copy it the first time
> > > > it is
> > 
> > A correction is needed here. Regardless of whether the dump
> > information
> > is large or small, the dumpit function will be called repeatedly
> > when
> > dumpit returns non-zero. The loop stops when dumpit returns 0.
> > 
> > > > called, and subsequent calls cannot copy it again. WDYT?
> > > 
> > > Sorry, I'm not sure to understand. Here, I did a local copy of
> > > 'id_bitmap' just to keep a certain consistency if the bitmap is
> > > changed
> > > during the RCU read section below: not to have this bitmap being
> > > changed
> > > during the for loop here below. Before, we had this protection
> > > because
> > > pernet->lock was held.
> > 
> > It is precisely because we need to maintain this consistency that
> > we
> > need to copy the bitmap only once. If we copy the bitmap when
> > dumpit is
> > called a second time, the bitmap obtained at this time is a new
> > bitmap,
> > which destroys this consistency, right?
> 
> OK, but then I have a few questions:
> 
> - Was the code before my patch here prevented such consistency
> issues?
> Or said differently: is there a regression introduced by this patch?
> 
> - Is it really an issue that can lead to a crash or reading freed
> info?
> 
> - Where would you store the copy of the bitmap? In cb-args?
> 
> - If we store this copy somewhere, could you not have situations
> where
> the bitmap would no longer be in sync with the addresses that are
> stored
> in 'pernet->local_addr_list', and then displaying wrong/freed info?
> It
> looks like more would be needed to cope with that. And maybe that's
> not
> worth it?

Your doubts are very reasonable. It seems that I have not considered it
carefully enough. So we do need to define a local bitmap and copy it
every time. It's fine to me and it's OK to implement BPF path manager
based on it.

Thanks,
-Geliang

> 
> > > Are you suggesting here to keep a copy in the cb, not a local
> > > one, to
> > > do
> > > the copy only once? Are you sure it is worth it (and safe)?
> > 
> > Because dumpit will be called repeatedly, we need to ensure that
> > the
> > same bitmap is accessed each time, so we cannot use a local one,
> > but
> > need to keep a copy in the cb just like what we do in
> > mptcp_userspace_pm_dump_addr.
> > 
> > 
> > In addition, when doing bitmap_copy, we need to hold pernet->lock:
> > 
> > bitmap = (struct mptcp_id_bitmap *)cb->ctx;
> > 
> > if (!id) {
> >   spin_lock_bh(&pernet->lock);
> >   bitmap_copy(id_bitmap, pernet->id_bitmap, MPTCP_PM_MAX_ADDR_ID +
> > 1);
> >   spin_unlock_bh(&pernet->lock);
> > }
> 
> Ah yes, maybe, I need to check: I thought the modification of the
> bitmap
> was done atomically, and it was fine to read without the lock. But
> maybe
> not because it is stored in multiple bytes.
> 
> > Also, we can put this bitmap copy code into a separate patch, which
> > is
> > applied before this one. In this patch we only need to replace
> > spin_lock_bh with rcu_read_lock.
> 
> OK so we are talking about separate fix that is not directly linked
> to
> my change, apart from the fact I modified code around, right?
> 
> Cheers,
> Matt


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DD94071D2
	for <mptcp@lists.linux.dev>; Fri, 21 Aug 2026 05:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787290403; cv=none; b=KJA7YzbZ7DFGWKhcNFNxtd2/yB6eD/M6WsJ+Lt+ISqb0oZlyvBUO4AqcFupJlfgWcvDC/64AkobGNFFqHpaFfT+YMUnuj4wcEiiPpwq26QQNfjPxyAlZKEHMKl5vk0BSeA6B3xMJeYSHGh8WGghOPAj21n02/7DhxWAPHGT2RTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787290403; c=relaxed/simple;
	bh=z+HY/VW1YiRoMYE61IZkuGChgTNDKGeeVdyjV7NbFqM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yw8jhEkFNHCgju8Qy9tZsVFDbVo5WSCs0rdaEs0cDRxxkAPiEZJdMWgzNjUqxjU5O9dWJ9IR+VrROc3ASV2B2Gmw6wxxkfKebyplQYhNGZc2n1lTnSxxxbAuVIhZkDCdtIZjGf3RxoVBhAXqba0QTX4aCZFRFVI++zVJvtaEjeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Czye9O3y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Czye9O3y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B951D1F000E9;
	Fri, 21 Aug 2026 05:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787290400;
	bh=BfXhQbCnZ9lPIVV5kUT2Iie+i/dbUbbgT9MHUi6EU04=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=Czye9O3yic2JyKpRZy+LXhFQVpfrqU+AzdqjYbj1ihZcJAKpOY+MYJawi2an/accO
	 mo/L8ZmgKySL4m8aOlGoRPCtHdq3ZDBQljJ9aAaUY6hMPto8qoy66wn6Qht3YazGzr
	 xOOj2HkGHv1hKmJBjNd/A2Cj7erJ7WwcYpE1sSzlzCvQKlR2mUqiwRCtZ7Lo1jGXlk
	 cKUSmyjCBLKc+WugJEbdqvlmqyELmYMYXWkjJCo6ltbSOV8ykldgqVwEvI2VtnC5up
	 UtbHtXoyER6/jnS2Oc2t2mgqjTW2EZenU3Ly9kJdzECGhnkWN+L0Brhtu8Uc3Tr2O4
	 WA1vHbwIHOqOQ==
Message-ID: <70fd3506eb1ae37535eb60dfa4726cd5de96a782.camel@kernel.org>
Subject: Re: [PATCH next mptcp-net 3/3] mptcp: remove thmac from subflow ctx
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, MPTCP Linux <mptcp@lists.linux.dev>
Date: Fri, 21 Aug 2026 13:33:15 +0800
In-Reply-To: <db4d2939-e543-42f6-b3e2-e044943a8e29@kernel.org>
References: <20260818-mptcp-cook-reqb-v1-0-052dea9a7f20@kernel.org>
	 <20260818-mptcp-cook-reqb-v1-3-052dea9a7f20@kernel.org>
	 <b38f34dda21fcfe46b1ecf493c268ca393a8e570.camel@kernel.org>
	 <db4d2939-e543-42f6-b3e2-e044943a8e29@kernel.org>
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

On Wed, 2026-08-19 at 12:02 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 19/08/2026 11:56, Geliang Tang wrote:
> > Hi Matt,
> > 
> > On Tue, 2026-08-18 at 19:55 +0200, Matthieu Baerts (NGI0) wrote:
> > > This entry is only used in subflow_finish_connect().
> > > 
> > > Instead, use the original value from mp_opt, and pass it to
> > > subflow_thmac_valid() to do the validation with the given
> > > truncated
> > > hmac.
> > > 
> > > While at it, rename the variables in subflow_thmac_valid() to
> > > avoid
> > > confusions about the received one vs the expected one.
> > > 
> > > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > > ---
> > >  net/mptcp/protocol.h |  1 -
> > >  net/mptcp/subflow.c  | 18 +++++++++---------
> > >  2 files changed, 9 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > > index 7e168e450fb0..d414065d1966 100644
> > > --- a/net/mptcp/protocol.h
> > > +++ b/net/mptcp/protocol.h
> > > @@ -592,7 +592,6 @@ struct mptcp_subflow_context {
> > >  	bool	fully_established;  /* path validated */
> > >  	u32	lent_mem_frag;
> > >  	u32	remote_nonce;
> > > -	u64	thmac;
> > >  	u32	local_nonce;
> > >  	u32	remote_token;
> > >  	union {
> > > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > > index 01db7edce18a..2d7ccb01d234 100644
> > > --- a/net/mptcp/subflow.c
> > > +++ b/net/mptcp/subflow.c
> > > @@ -408,20 +408,21 @@ static struct dst_entry
> > > *subflow_v6_route_req(const struct sock *sk,
> > >  #endif
> > >  
> > >  /* validate received truncated hmac and create hmac for third
> > > ACK */
> > > -static bool subflow_thmac_valid(struct mptcp_subflow_context
> > > *subflow)
> > > +static bool subflow_thmac_valid(struct mptcp_subflow_context
> > > *subflow,
> > > +				u64 thmac)
> > 
> > Perhaps we could rename this parameter, say to "subflow_thmac", so
> > that
> > we don't need to rename the local variable "thmac" to
> > "expected_thmac".
> > What do you think?
> I initially did that, but it fell more natural to use the "expected"
> keyword, similar to other places, and in the selftests, than the
> opposite. Also, we pass "thmac" to subflow_thmac_valid(), but seeing
> the
> argument renamed didn't feel right.
> 
> If it was for -net, I would have minimised the diff, but here, let's
> get
> thing rights I think, no?

OK, no further comments from my side. I'll add my Reviewed-by tag in
reply to the cover letter.

Thanks,
-Geliang

> 
> Cheers,
> Matt

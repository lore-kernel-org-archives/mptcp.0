Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A958BF8
	for <mptcp@lists.linux.dev>; Tue, 17 Dec 2024 06:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734416795; cv=none; b=Hb8DeIPaL6joq2t23CHV4Y9GcXRn5K2skadYy5Zsu2teTFRZa0p8+SUFDKL76YWtrl/n1VCEUeKiAezr+lyYLH5s5lzpg8neUtu7SpKFqVoIWR66QhY9iCZjZXyNXRf0ncuI0hHYFu+7VHADPeKlQ4IUPeSP5Q8rBh5HuXo9luo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734416795; c=relaxed/simple;
	bh=biJtf1POXgY3GR1kz7UDAjd/5Id+QmXtIJT/kZ/alWI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mvfxve8eoOGvSNoX7Y+3ERnyam0fQ/MIUVVOe6zODc6wzRQqmKNPTQIEv0GN6vV5q7m/tlPAsWEnAnmV0qWXSxzmSeKMBO87bVBx3YcWtdWN+yxfE+v2hkDoTGuirtMfw3VU6vjmpwTSeXL/hAGTgKttoNZAdddJuueyZzmTwZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtP3vV5C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtP3vV5C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9462BC4CED3;
	Tue, 17 Dec 2024 06:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734416795;
	bh=biJtf1POXgY3GR1kz7UDAjd/5Id+QmXtIJT/kZ/alWI=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=RtP3vV5Cg7W6VQxxHCMBvXiyGLjJjazmEQ81IAinG/OH4jTk/IPIc8wILWiDYMaX0
	 q16i+NDkmY7M4GSIe0ctdhTdG5U56ZRwCafqQdBUepGotGnhLsASfy0i/17YqHCJJ8
	 jv6TZsYH2lT8MjfanMQnk547q4+ZDf2rcXql+cVGs8REvd9eDTajJnSOUxrGipsqlJ
	 IFf83OSF6/dpVU0qOCSoj2QbE6MOB7fv089JRpdrfH6Tk9zQGEo6gdIOpfGJxbjbtj
	 p0Rfvmkc83YV9ffXh7zMjadW4DCglsIBhic+wogD5LeDmwPWLlDJWfDlVQ3e4XVw4C
	 hidJInQl1NZmw==
Message-ID: <05d20115cc82e9b0bb29769509cf5ca893d3c6a6.camel@kernel.org>
Subject: Re: [PATCH mptcp-net 0/2] netlink: specs: mptcp: events: missing
 and clearer attr
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Tue, 17 Dec 2024 14:26:31 +0800
In-Reply-To: <260220a4-8c58-4720-a566-7d7221502ecf@kernel.org>
References: 
	<20241213-mptcp-pm-nl-spec-doc-attr-v1-0-e43165c94e81@kernel.org>
	 <8f52bcf88666a0ef05df372d48e0132790aab90f.camel@kernel.org>
	 <260220a4-8c58-4720-a566-7d7221502ecf@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
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

On Mon, 2024-12-16 at 11:02 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> Thank you for the review.
> 
> On 16/12/2024 10:22, Geliang Tang wrote:
> > Hi Matt,
> > 
> > Thanks for this set.
> > 
> > On Fri, 2024-12-13 at 18:55 +0100, Matthieu Baerts (NGI0) wrote:
> > > Two small fixes for the documentation:
> > > 
> > > - The 'server-side' attribute was missing for two events
> > > 
> > > - Attributes were written at the beginning, but without
> > > explaining
> > > what
> > >   they were.
> > > 
> > > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > > ---
> > > Matthieu Baerts (NGI0) (2):
> > >       netlink: specs: mptcp: add missing 'server-side' attr
> > >       netlink: specs: mptcp: clearly mention attributes
> > 
> > I think we should swap the positions of these two patches, first
> > move
> > these attributes to the end, then add missing 'server-side'
> > attribute.
> > WDYT?
> 
> It would make sense if these patches were for net-next, but for fixes
> modifying the same area, I think it is better to order them by
> commits
> they fix.
> 
> The first one is for 5.19, and the second one is for 6.7. Of course,
> here, there will be conflicts for the first one with < 6.7 versions.
> But
> still, better not to increase the complexity of the backports.

If so, this set LGTM. I'll add my reviewed-by tag for v2.

Thanks,
-Geliang

> 
> Cheers,
> Matt


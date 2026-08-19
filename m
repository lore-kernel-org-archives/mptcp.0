Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285C03D1702
	for <mptcp@lists.linux.dev>; Wed, 19 Aug 2026 06:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787121019; cv=none; b=WbWH9HgyI+7Jx2ow2rFbGFsAx34U7Sz/eE1oprjfY/ulHL5buZ9giCnr4I9/2fVZh/nOi5jz0yvK7c8gONfg+FN5WOMkZn2azxRvsagsvYQr5XgrKUN3HegKEMHEeiSn8PjYTFXicyC9dRYTuy6UFvw9TW2vEXufOW+GT7umYSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787121019; c=relaxed/simple;
	bh=TBFOePm8cMzYKhU3vyIShEXY00eitdiRFh0y0WZevGk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kO7l3DDeM11WvosCIdjZo3AKbdtffg2dwxlD1gx4MdTLaU+Hf/UbPr1IcQ1iMANaRao5goWPsAZ9/japMqzUl230+GIjtU5rwgYtqSC+3gtAFSi6sbImvGdPzRsvofSUUzswZpTpYxPXub1kJ/8Mw63hDsJx+FeTw/AhcdXmLAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRRHXiyW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRRHXiyW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957371F000E9;
	Wed, 19 Aug 2026 06:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787121017;
	bh=iufWwQrLCWR4/i68tOgkDk2uavOknctOFALVJNYZtZg=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=oRRHXiyWJOHJ9u453Z7kklwJIHvS0L14Mi5DgpcGfZup84mV757TWMX+Mf1KOWGu4
	 3QF849uki+CmXgKU+2zddKlPsLaxbPX0xS4lo1AZGr9fJVz2GS0gsrbcD7BrmBIaAa
	 ArixKFJkzbz+43ugJrRbaMFFviqLjJZhcNwm6rQD+Sh2/RoAFBgyvH48ngbOvJoE40
	 HQRJHz3LjUhnIqvTjmz0FN7k/tx2WXPJ0Kv6HoviqgXD40KRQAufuB0lXADWc9mGSC
	 0OOcARNTxGIOGaURNQXQJleBP+hguQtQVvIP50DiAztDAU3y5qrKvQKqhtggZIh51S
	 wD4oRWYSroqDA==
Message-ID: <2bf1f87c0c70121075d268af1283d099dc4e1f6f.camel@kernel.org>
Subject: Re: [PATCH resend mptcp-net 0/4] mptcp: a few fixes
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Wed, 19 Aug 2026 14:30:09 +0800
In-Reply-To: <6059ccd9-e28f-42f9-90cf-267d3d645a3f@kernel.org>
References: <cover.1786713351.git.pabeni@redhat.com>
	 <ccf9480a-712d-4d37-80f1-3db80b7a4409@kernel.org>
	 <2a74fda9614c9a11b8789a33dcda21378660534c.camel@kernel.org>
	 <6059ccd9-e28f-42f9-90cf-267d3d645a3f@kernel.org>
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

On Tue, 2026-08-18 at 18:26 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 18/08/2026 09:52, Geliang Tang wrote:
> > Hi Matt,
> > 
> > On Sat, 2026-08-15 at 19:19 +0200, Matthieu Baerts wrote:
> > > Hi Paolo,
> > > 
> > > On 14/08/2026 15:38, Paolo Abeni wrote:
> > > > This is mostly a follow-up to the recent OoO queue pruning
> > > > series.
> > > > Explicitly targeting net as we have already a lot of patches
> > > > pending for
> > > > net-next, and no need to rush IMHO.
> > > > 
> > > > First 2 patches addresses explicit comments from sashiko, 3rd
> > > > one
> > > > is a
> > > > somewhat unrelated cleanup I stumbled upon while implementing
> > > > patch
> > > > 4.
> > > > 
> > > > The last patch fixes another thing implided by sashiko while
> > > > reviewing
> > > > the mentioned series.
> > > 
> > > Thank you for this series, it looks good to me:
> > > 
> > > Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > > 
> > > I will wait for the net-next → net merge to apply them to export-
> > > net.
> > 
> > If you have time, could you please merge this series into the
> > export
> > branch at your earliest convenience? My ongoing series, "Reduce the
> > differences between TCP and MPTCP for TLS usage", conflicts with
> > this
> > one.
> If that's OK, I will wait for the Net maintainers to send their PR to
> Linus, which should be done in a day or two I suppose. Is that OK?

Yes, absolutely - that works for me. Please take your time.

Thanks,
-Geliang

> 
> Cheers,
> Matt

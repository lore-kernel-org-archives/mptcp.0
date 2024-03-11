Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73677EC
	for <mptcp@lists.linux.dev>; Mon, 11 Mar 2024 01:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710122103; cv=none; b=RHL1OAPh4e+DnngZB48BWXyea3dowQXHWFB0/g96csga2uuHW58j3iL0POcuanygDGv1P1szYQ6li3agjk/Te9qgy3ESCuQHtcpVpbSpFeaJuQjUU8Mnk6CbQj8ZXR3iuyoc2ls3oY96UREpSwaHiJbk7D8zg8uqnCT8Ok7QOx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710122103; c=relaxed/simple;
	bh=SsQU9GTBOlFAvraOEwitSgci9bMvd2SaUb3gV5GdxQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCg6yqaRp+Y6dbIWwmOP8pRdGk18TNZwwnPCVfMFLwKbFRNEiAuoImp+JDQfSR4xhxqZTTcrX9uw3nOn72S9IBfj/hPZxfif+NToIqPh/JwgNtToahHII06Rk5fpz9H/XKvOYRqOeXX2IwGXe5lNUgiF6s5IvXQZ3mtKh5b5VeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjZ+M/yC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjZ+M/yC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76EEC433C7;
	Mon, 11 Mar 2024 01:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710122103;
	bh=SsQU9GTBOlFAvraOEwitSgci9bMvd2SaUb3gV5GdxQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LjZ+M/yCAnqoauy2bnyM7wCSBtap5pna4fu7owOUtMNSA9zl13Zo7x2cSP2boBnFl
	 r8sgwFNM2USK4CSSXW6gIgW/yvj8cAsdCDUeBn+W7C703LB7eCmd61mFXyHCW3hIKX
	 uqVt3TC6pas45e+VEhfNPkK47G5C3kJ1cNfbrhkytlWdA4pDt+fCnbeL41CSg2SRtC
	 eMeNgrhDZ+LyYcnjtXX2RtRiHmHIYHjyj6pBgHvui4E6bJha3CIKoFfcY5PoVdeuN4
	 OOcHu2sFGLEE0PqDzapj3El9ytKYp10vKn923f/1RgcvVfe82qnBbxjAAo81v5iiZ+
	 20flTAw/or2BQ==
Date: Mon, 11 Mar 2024 09:54:58 +0800
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Subject: Re: CI: MPTCP BPF tests are now validated
Message-ID: <Ze5kchd+9VNmQAwg@t480>
References: <47ca79ba-6212-42af-af25-46b6bdf94eb1@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47ca79ba-6212-42af-af25-46b6bdf94eb1@kernel.org>

Hi Matt,

On Thu, Mar 07, 2024 at 02:59:14PM +0100, Matthieu Baerts wrote:
> Hello,
> 
> >From today, the CI is now validating MPTCP BPF tests!

Great!

> 
> To be able to do that, I got some help from Geliang (thanks!) to update
> the script used by the CI to launch these tests. I just did the wiring
> to run these tests in a new job, in parallel to the other ones, and it
> seems working:
> 
> https://github.com/multipath-tcp/mptcp_net-next/actions/runs/8186843723
> 
> Please tell me if there are anything wrong with that (results,
> notifications, summary, etc.)
> 
> 
> @Geliang: it looks like the "burst" test is unstable. Do you mind
> looking at that please?

Sure, I'll check it.

Thanks,
-Geliang

> 
> 
> Cheers,
> Matt
> -- 
> Sponsored by the NGI0 Core fund.

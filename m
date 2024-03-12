Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723D069944
	for <mptcp@lists.linux.dev>; Tue, 12 Mar 2024 07:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710228432; cv=none; b=c0k5G15ObER2QWUwIASAS+5k7aDWAD5zWBY1vDCtkSY75irXK6r8GEcx6Ll9+P0KJtTfTmavj1yn/tRmP86YHDSSNYL7c9EDaxE9k0dULGWUgtMC42d0N4Y6bhXosMrxaybkuPWr6y6TMrtde6iw/uoUTl8lfnX25D0uByGbpwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710228432; c=relaxed/simple;
	bh=CBM5zy9gmnk2ueBTsvr9WqPfz+Qh76C2VOXPgRNsDZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCiNoUflYpb+xoOUWXMl1QPFdpxj+TsB75I5mXlEdtxeUucldWXaXr8MQtvV/VKFXIJpjyPpWLe85o/Y6I/MNp1ufJ2ehZb8RgpZzqUHiIVZBf0DfRZzp50IyWS7JPRWDM2+RzuSqdvHkQmltEX9FpQmGcsOFB9tQMxy235KA9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lcv54Jq+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lcv54Jq+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A7CC433C7;
	Tue, 12 Mar 2024 07:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710228431;
	bh=CBM5zy9gmnk2ueBTsvr9WqPfz+Qh76C2VOXPgRNsDZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lcv54Jq+eTMcxZuNLJDkxHH7yB6QfmV9QGowqQldgZ1RSuGFK/1DSxWEKPCImcXFQ
	 AID+qiyHHou/1HRVS1hoTZF5Vaq8BCXw9jVEfLGYEj9YHy5WFD2RgfV8DZ8jtvG/Ck
	 NCKIpNwKGXgKIS9FFa2QO2IL4ek/rG591Yti4h07uKj+q3CfuEjPqONSLyJ+71kC3C
	 oa9JWsNfmICHrHjprYDvgkjXX5FPgTkmpgLbufeLJMyG7K3HMz6/sv8vLLo1VYLoMm
	 rIB7YIU/SwwmdeDKDwixt9EYOSNVKE+TUEkweY+vLRLaXEt6u2iqB9EsXVkQJhhKQl
	 2w5KWG50/41LA==
Date: Tue, 12 Mar 2024 15:27:04 +0800
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH iperf3 v3] add MPTCPv1 support
Message-ID: <ZfADyFB1vDYABpf9@t480>
References: <4a85ab6ab759ba852647b03af58faded31fbb8f6.1710140596.git.geliang@kernel.org>
 <fd131421-bb46-4d40-befd-b2bcd6d2b832@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd131421-bb46-4d40-befd-b2bcd6d2b832@kernel.org>

Hi Matt,

On Tue, Mar 12, 2024 at 08:10:28AM +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> 11 Mar 2024 08:04:05 Geliang Tang <geliang@kernel.org>:
> 
> > The Multipath TCP (MPTCP) protocol (v1 / RFC 8684) has been added in
> > the upstream Linux kernel since v5.6.
> >
> > MPTCP is strongly tied to TCP, and the kernel APIs are almost the same.
> > The only required dependency is the 'IPPROTO_MPTCP' protocol number
> > definition, which should be provided by the netinet/in.h header if it
> > is recent enough.
> >
> > This patch adds a new flag '-m' or '--multipath' to support MPTCPv1.
> 
> I just noticed you switched back to "multipath" instead of "mptcp".
> I think it is best to stick with "mptcp", because "multipath"
> is too vague, thus confusing: it could be multipath as in multiple
> flows, multicast, with other protocols like UDP, etc.
> 
> Best to use "mptcp" everywhere: variables, strings, description, etc.

Sure, I'll send a v4 to update the flag to '--mptcp'. But I don't know
how to update the pull request on github. Should I send another pull
request?

> 
> 
> > It can be used like this:
> >
> >> iperf3 -m -s
> >> iperf3 -m -c 127.0.0.1
> 
> If the server doesn't have "-m", only the client, does it use MPTCP?

Yes, it use MPTCP in this case. I just tested it.

Thanks,
-Geliang

> 
> Cheers,
> Matt

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4196997C
	for <mptcp@lists.linux.dev>; Tue, 12 Mar 2024 08:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710231269; cv=none; b=HAnTQxkQ0OcL7YZFbpd342n/CyRkYzNGTql5T7mse16/JHRE8HNLnUalWBDN1V5N09a1v6Btsd2EcPoXbsLY1CyMzDecbelx3azGonBAzl7iZxt2x5VQ7gPaXEfUOnsUFGnPWBgsUTSOs4r1GhzytsZ6puUGrTqYlAsSwk5KA3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710231269; c=relaxed/simple;
	bh=npbnXjI6tmAnRu57Q2zbuglHp8aqSnJlYLA9rllJmqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5GmyGNX5dDz+L9G/7zeBksrYr8V89A5AU6+emr/J+W3gV7DkLfyRKcktmlMyVJ2kkRCh09tvu7PoaXQkzznionF6R9y92K+7BhekgN02KIYxUe/rjcsWGPWP2JY2ukjOVkpdssYc95qrmYlb2CRSFITix415IAHje1MJGWcgKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xyd4DdpE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xyd4DdpE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF669C43390;
	Tue, 12 Mar 2024 08:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710231268;
	bh=npbnXjI6tmAnRu57Q2zbuglHp8aqSnJlYLA9rllJmqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xyd4DdpEFwxi0a8s67xA9qR+6/vuxf9onoT8UqA32IdyjUhm5x26Ge/ehsWU6NcUg
	 lw1HuDXFg216SUabrApXB8ausQLPSNk1HhZWQYTbY4fSAiliyMSHNE8SiXJITfz2sK
	 5YmCH6Hq+EM+nQ7DEMUh3JLntUK/vuTeTf+jEFJgEynXI2XxboXOvTR9eW7rO+ZMib
	 FQHz2UyfYctPnrcIxaro5MH3jWsdPuLq5r864gozFvQm29ktXhRJIRaO49TDOpdSIm
	 zv/4AFE4cOP9qoVTq6ipLyqSO9Ixinc8t2pMHqKGoSiFlqcw+F37TAKl374AHqwJPz
	 +8xh/TKMgFzYw==
Date: Tue, 12 Mar 2024 16:14:24 +0800
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH iperf3 v3] add MPTCPv1 support
Message-ID: <ZfAO4OKX8sjHTQW9@t480>
References: <4a85ab6ab759ba852647b03af58faded31fbb8f6.1710140596.git.geliang@kernel.org>
 <fd131421-bb46-4d40-befd-b2bcd6d2b832@kernel.org>
 <ZfADyFB1vDYABpf9@t480>
 <4a1febfb-54e0-4d1f-ac56-e5fa4e1bdead@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a1febfb-54e0-4d1f-ac56-e5fa4e1bdead@kernel.org>

On Tue, Mar 12, 2024 at 09:09:27AM +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 12/03/2024 08:27, Geliang Tang wrote:
> > Hi Matt,
> > 
> > On Tue, Mar 12, 2024 at 08:10:28AM +0100, Matthieu Baerts wrote:
> >> Hi Geliang,
> >>
> >> 11 Mar 2024 08:04:05 Geliang Tang <geliang@kernel.org>:
> >>
> >>> The Multipath TCP (MPTCP) protocol (v1 / RFC 8684) has been added in
> >>> the upstream Linux kernel since v5.6.
> >>>
> >>> MPTCP is strongly tied to TCP, and the kernel APIs are almost the same.
> >>> The only required dependency is the 'IPPROTO_MPTCP' protocol number
> >>> definition, which should be provided by the netinet/in.h header if it
> >>> is recent enough.
> >>>
> >>> This patch adds a new flag '-m' or '--multipath' to support MPTCPv1.
> >>
> >> I just noticed you switched back to "multipath" instead of "mptcp".
> >> I think it is best to stick with "mptcp", because "multipath"
> >> is too vague, thus confusing: it could be multipath as in multiple
> >> flows, multicast, with other protocols like UDP, etc.
> >>
> >> Best to use "mptcp" everywhere: variables, strings, description, etc.
> > 
> > Sure, I'll send a v4 to update the flag to '--mptcp'.
> 
> Thanks!
> 
> > But I don't know
> > how to update the pull request on github. Should I send another pull
> > request?
> 
> No, please don't open a new pull request, nor close the old one, simply
> override your remote branch on GitHub (`git push --force`).

Sorry, I open a new one before reading this:

https://github.com/esnet/iperf/pull/1661

> 
> >>> It can be used like this:>>>
> >>>> iperf3 -m -s
> >>>> iperf3 -m -c 127.0.0.1
> >>
> >> If the server doesn't have "-m", only the client, does it use MPTCP?
> > 
> > Yes, it use MPTCP in this case. I just tested it.
> 
> Great, thank you for having tested that!
> 
> Cheers,
> Matt
> -- 
> Sponsored by the NGI0 Core fund.

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D61C2FE07
	for <mptcp@lists.linux.dev>; Tue, 10 Oct 2023 17:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsFV5wq0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E699EC433C7;
	Tue, 10 Oct 2023 17:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696957443;
	bh=6kBTMIRGASqQxbOYduvybcu2HVcyf1CGmvMtottM4qY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=NsFV5wq07ca5GbCLJ+rfuSRiwPzLUzAicG9+1koGEDLZ0C+t8ZD4vbAfR6e/wcd3G
	 E4mli3Zu8+PqEypM54THJ1JvuwL1z+qKA5sayfJFx7qkamvBS/IhWqm/mlKdAOH3nQ
	 mxZ+X/44IwdCV0cW0bVA6reBeHPnBsJk9Z1C8vNmJ6XSChLfdmfnA9ZUE9COseXXzg
	 Xdp2YJLEvTD6SWo6Ls9roYqdHZqe+6wgzUIY0UP2d48LkY/VR9txMhD9Uu74RaWwqN
	 m6IoxXHEcKDOz6zrUZ2syEkduHhnVmG0Sx8K6zupO4v//oS4QOjSAWjF+wFAH44bDZ
	 yWQdvLNYcdFbg==
Date: Tue, 10 Oct 2023 10:04:02 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Andy Tranter <andy@andyt.co>
cc: mptcp@lists.linux.dev, Matthieu Baerts <matttbe@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>
Subject: Re: mptcp - very slow start?
In-Reply-To: <CAGKODjrSDQ8r9_0+Kfskyj0Efx_1XQKMQO7N3LsYn2xhDGCMLQ@mail.gmail.com>
Message-ID: <ccc810ad-2880-5528-4497-5181492793b3@kernel.org>
References: <CAGKODjrSDQ8r9_0+Kfskyj0Efx_1XQKMQO7N3LsYn2xhDGCMLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 10 Oct 2023, Andy Tranter wrote:

> Hi
>
> I thought I'd give mptcp a go, but I've come across some confusing
> test results that I thought I might ask about.
>
> We have 4x residential Starlink connections, and (predictably) I've
> had trouble bonding them to make one big connection. But looks like
> mptcp might be useful as a basis to eventually create a similar end
> result.
>

Hi Andy -

Yes, MPTCP looks like a fit for bonding these links. It's an interesting 
setup since Starlink connections behave differently from wired or 
cellular links. MPTCP has a "packet scheduler" that decides which subflow 
(in your case, which Starlink connection) to send each packet on and we 
haven't tested that with connections like yours.

> I have mptcp working end to end, and can see several established
> messages via 'ip mptcp monitor' as soon as the connection is started.
> For each test, I see the first connection running at 200-300mbit, but
> the other 3 sit at around 8.5kbps. After approx 26-28 seconds they all
> suddenly become active, all 4 links are utilized, presumably evenly,
> and bandwidth creeps up until I think we're flooding the satellite or
> base station and can't go any faster (lol).
> But is this 26-28 second delay intentional?
> Perhaps something is wrong with my test or environment?
> Seems to me that a delay of several rtt before establishing mptcp
> makes sense, no point for short lived connections, but 26-28 seconds
> seems very particular and rather excessive.
>

It's not clear how much of the delay is due to MPTCP establishing 
additional subflows vs. the packet scheduler choosing to utilize the 
other active links after they are created.

Could you open a GitHub issue at 
https://github.com/multipath-tcp/mptcp_net-next/issues and provide a few 
more details like:

  * Which commands are you using to configure MPTCP for additional 
subflows?

  * What tool/program are you using for the bandwidth test (so we can try 
to reproduce similar conditions)?

  * Are the connection speeds you're referencing for the entire link or the 
specific TCP subflows in this test?

  * Output of 'ip mptcp monitor'


> I'm running 6.5.1 (Sept 2nd), so not the absolute latest but it's
> pretty new I think. Do you think I need to try newer?
> Various tcp options nor cubic vs bbr congestion control seem to make
> any difference.

It could be useful to try our development branch ("export") at 
https://github.com/multipath-tcp/mptcp_net-next/, if you're comfortable 
building & running a custom kernel.

That is v6.6-rc5 + net-next (networking dev branch) + MPTCP latest 
patches. Those latest MPTCP patches include some related to latency tuning 
and the MPTCP packet scheduler.


Thanks,

Mat


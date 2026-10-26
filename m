Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793009635;
	b=xPDHehKA4w8e0HsvgW2Hq+1gboS0K+D4sZKHG9gvpHDOBuce9xkN29jHsNtn3yiY/fny
	 g5KJ6jsqE1ucVq4fPOWNHEcwZFCGMiJoddYRIIDs5GE4C/EWDBll18XxNU2yFVJd3iOa0
	 PRkOIf+2+bCjHZ4gyU1yE30PCN5MgkcObgPKaCMPGvNFQrjo06DRSuugI/52KbXkZR3Iz
	 GK6rI+69mkMm/J0N7jEex1mr40EX4M+Iyb91I+WS4dr+gPhlvtKOuE7o/8mFEcIXXTK5u
	 0MnUMlXmt1+wl6MXENjpHe+uVLiKw12kuoxt9OgZ4zF1YZMopfAMoDiY0thbWi9JK4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793009635;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=0itbaYKvZlmLDAw2E9DRo+m1sD9lE8XIcLoBdm1AbuQ=;
	b=xp0bz2Yi9q6xz8Z32P509VHQNSi9PO5krheNhxkLYLeODaI4BsEgls686ypJv+snSgJx
	 GoFYNPjRzPEDv4ei5IXr9J69pVERp+XLTmf7znPWptVBABLED6Iwry0n1IQ/2i49PvQ1Q
	 JJ9vD5SU/+HfdS07h5X3kM8lDNW1yCJp6x8Hf14i+1X71SVwjbLcOoP9arQgUHnFfGfaz
	 26Zxxn5Z950fCuA6rBQI44T8MVQGnwh7uCJmBceYKNezS0j3xIWQJL5fq89Gh7VJGSEbS
	 QA0cINAPC+RCrVvj3cpObG6Z6prdueUDVK+1a4Dp9dyNDt48roH71UEtGdo+r0abCPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lrcLFp5I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C102A606A31A
	for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 10:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lrcLFp5I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3431F031E0;
	Mon, 26 Oct 2026 10:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793009634;
	bh=0itbaYKvZlmLDAw2E9DRo+m1sD9lE8XIcLoBdm1AbuQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lrcLFp5IbZTatSbsbm3MNS90dn+PyaGn0iHLgvHjofASIQWHX4PKi+1CS7diP7jmj
	 y4rvZjcMe1+N+GZ/BzYvvBqJaPsOeXRlnwCieszWRBj/9AnF2SrtCz01iS+/HAwdZ4
	 YQ6yA20LvMXwSoUJDqhgygPQ4Gy/Hx3Ngv1lNQF6iAOdFHjbDgHhralRDLIk6UJ2b5
	 Q7v9P7tNV2am3Sm/Zv1wniRc/WX6+NoxlOWT8gkgRJKdTPEpf1gj7cVhPGrs8wRtnM
	 YATp3+DDjnMxTnNVrzabV2LSLor9fkYP/u0yUzdoi9wcUDuowPINFNbIBl87ntIrlZ
	 3tsB0Q4WLTxIQ==
Message-ID: <6fbbeca8-836c-46cf-a8de-73ecd127b932@kernel.org>
Date: Mon, 26 Oct 2026 11:13:49 +0100
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH mptcp-next 0/1] mptcp: opportunistic reinjection on an
 idle subflow
Content-Language: fr
To: Abdul Wasey <w453y.me@gmail.com>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Shardul Bankar <shardul.b@mpiricsoftware.com>,
 Gregory Detal <gregory.detal@gmail.com>
References: <20261025134643.1537069-1-w453y.me@gmail.com>
 <5e0ccd66-205f-4055-8ab3-4d300e83fd48@kernel.org>
 <20261025155848.1745712-1-w453y.me@gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20261025155848.1745712-1-w453y.me@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Abdul,

Thank you for your reply.

(Do you mind quoting the text you are replying to, please: it helps to
remember the context, especially when switching between many topics per
day :) )

https://subspace.kernel.org/etiquette.html#do-not-top-post-when-replying

While at it, it usually helps to send one version per day, and ideally
wait for Netdev's Sashiko review that can take ~48h, then reply to the
comments on the list before sending a new version. Except if there is an
urgency to fix something of course. By doing that, it's easier for human
reviewers to follow and give guidance. Without that, people might only
look at the last version, and likely after a while or waiting for a
comment to say "Sashiko is happy, please review now". Note that AI
reviews can still miss things or focus on details instead of the big
picture: they might guide a dev to a wrong path.

On 25/10/2026 16:58, Abdul Wasey wrote:
> I'll rebase on Shardul's series. I'll also test his v4 on my setup and
> reply on that thread, since it's still waiting for reviews.

Thank you, that's very helpful!

> Moving it to the scheduler makes sense. The CI also caught it on v1: the
> BPF "first" test saw bytes on its second subflow because of the
> reinjection.
> 
> Gregory, are you still planning to continue the scheduler API series? If
> not, I can pick it up.

For Gregory, I'm sure he is not planning to continue working on that.

> Shardul, same if you already started on it.
> 
> About once per RTT: in the old fork that limit was on the cwnd halving.
> The reinjection itself only took the head of the rtx queue, when the
> holder's srtt was more than 4x the idle subflow's. I'll check the cost on
> fast transfers.

Thanks!

Please also note that for optimisation purposes, the current
implementation tries to push as much as possible on the selected
subflow: it can be quickly costly to stop the delegation and alternate
between subflows.

(Of course, this cost might not be a problem in some cases, e.g. a
"redundant" scheduler is not designed for fast transfers, but for low
latency.)

> The perf lab would help, yes. I can share my netns cases if that's
> useful.

That could indeed. But I'm going to try to push what I have today: it
might be better to work on improving the same thing.

> I've fixed what Sashiko found locally, and will fold it into the
> scheduler version instead of sending a v2 of this one.
Thank you!

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


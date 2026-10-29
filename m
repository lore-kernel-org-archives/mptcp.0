Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793300759;
	b=i8/syhrzhvi6b42zrxR+ANV+fnWWdkSrXJHTyDIl2D3T2vKVX1N9ryl7gjwQbTLMUII/
	 EK9lahVUjfGxjX/DrJBCvj2xL1fU+lhlHQY9/Wux5gdgmjRUy4dJioSca2qT7T9iAVWSE
	 eIqAEjS+6W0nkM8aLZbeJcOOIsOPyscgF36OodJdEMy/oGKpYL1gCy0EF1fD/zlsMDyCb
	 iN6Pgx+4MCUZ1AODMBKrXjbimfLwYl2dq3COQGcCPFi3on5dJeXfnmUYc+1HyMdolew/W
	 QtOIm8M9bNjJF+nC0+vgjnm17DHnmXjQpV6kU665DNwHMF3qvstO1dWu7IvtLu5G0lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793300759;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:From:To:Cc:References:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=FLaoRP2jZ7c6VMORttpJN7FhIVE44wSOwbbfj0TNVEI=;
	b=VaZfqHUCTh6rVGUv4qKyC+7M+d3FL0fwqp/iVaSGlWjqJJTn0l3RF1DH6QwFhIn7mf6X
	 x69rPwuXb7QSpcxwlh5PZFdEjYedrv0PO6gaq2KQuuE08y57Xr4WHGOfJL7NZM9MD8QSB
	 TwHYOLCxIAFhqofzIY/+nIUr3I0vGMEnJh72dVh7Jd3kVot+Fl+HRzx49mJ+cjgXbUi7g
	 YviJrjGZuUv9kiFLXMDaqt2B8DwW3lPd0dVdA2N+wn60Yic4nQWGspVTXvmFN4cJEget1
	 fMDzczsjy+I1poHyXNRyRuPR58LchXZTPNGGDKm4KEOy1WegxO8vZn6aMQIezxqL6rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pxor+6Ak;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29730606A31A
	for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 19:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pxor+6Ak
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 637C11F01816;
	Thu, 29 Oct 2026 19:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793300758;
	bh=FLaoRP2jZ7c6VMORttpJN7FhIVE44wSOwbbfj0TNVEI=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=Pxor+6AkfQ9iq6kUNdlhXAI7ASQX92dvMohNkwqrc0yaan3itSAYiaEjfWRiXj3+b
	 fRIYELS/8qHXzQajXGylSJV3PaAcFYrq1DYZPi8oHcMelTQuyXX4NeGFTVk+QtTXIf
	 Qk6iaFb/p/2IkZvEv1MJgtSFsDQO6ilWsn6TvmtXv/h6weq0662OaI5rc6OBfeYtVA
	 ymGMxRaWBc1tKmqlfLhqGfzWMli/oyteREIlnI/5nae/rTqdlUq4N6JQdQp+M82iX5
	 Z9nG6twCXWldzDWCVGOsvCWJU6No1pxXHaX5pmIjvGfqNJGfJkWvDoulgVG6yoN2ok
	 KtBj2nyMSiVEg==
Message-ID: <e5648dd6-e4c1-4bfc-a8a9-a00bb71791ae@kernel.org>
Date: Thu, 29 Oct 2026 20:05:55 +0100
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
From: Matthieu Baerts <matttbe@kernel.org>
To: Abdul Wasey <w453y.me@gmail.com>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Shardul Bankar <shardul.b@mpiricsoftware.com>
References: <20261025134643.1537069-1-w453y.me@gmail.com>
 <5e0ccd66-205f-4055-8ab3-4d300e83fd48@kernel.org>
 <20261025155848.1745712-1-w453y.me@gmail.com>
 <6fbbeca8-836c-46cf-a8de-73ecd127b932@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <6fbbeca8-836c-46cf-a8de-73ecd127b932@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Abdul,

On 26/10/2026 11:13, Matthieu Baerts wrote:

(...)

> On 25/10/2026 16:58, Abdul Wasey wrote:
>> I'll rebase on Shardul's series. I'll also test his v4 on my setup and
>> reply on that thread, since it's still waiting for reviews.
> 
> Thank you, that's very helpful!

Do not hesitate to send what you have without waiting for the last
details from Shardul's series to be fixed. You can simply mention the
base series in your cover letter as explained here:

  https://github.com/multipath-tcp/mptcp_net-next/wiki/CI

e.g.

  Based-on: <20261028-mptcp_penalise_send_v2-v5-0-32fb379ce117@mpiricsoftware.com>

(Sashiko also supports b4's dependencies tags, but not Patchew -- it is
 fine to add both.)

(...)

>> The perf lab would help, yes. I can share my netns cases if that's
>> useful.
> 
> That could indeed. But I'm going to try to push what I have today: it
> might be better to work on improving the same thing.

It took me a bit more time to fix the last details, but it should be
usable now:

  https://github.com/multipath-tcp/mptcp-upstream-virtme-docker/blob/latest/PERF.md#tracking-regressions-locally

There are many use-cases (based on previous work). The idea is that
the regressions are found automatically by looking at the distribution
over multiple runs. So it works best if you execute the tests a lot of
time on a base branch, then check on top of your modifications (always
under the same conditions).

The whole suite might take a lot of time (1 to 2h), but it is possible
to execute only some parts. Do not hesitate to suggest modifications or
send PRs ;)
Or tell me if that doesn't work for what you are doing.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


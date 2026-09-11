Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AEA3C416A
	for <mptcp@lists.linux.dev>; Fri, 11 Sep 2026 09:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789120702; cv=none; b=QQ03BuOKKh6neEV+qMItRnDyhmTMvljmJmi5TOd8xQpVxFuWubbVXpzGq+1Wuu0juGD8/5e+1++MtglnBVawWVXKIKxy1Z5vZ3vlS/WnACS/7jC5UZOjnecvjUNWgymCy046uj+6F8JvWGyUjXo8jtjOZAXHEVWVjse83GcCHUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789120702; c=relaxed/simple;
	bh=10BrQ+GnIVnUzuSwNps5+zBlNcXC3vckwAcQ9f0Tgvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=N/ONNeEkhXemt3fRs18jScSoEgXi13ZZ2IUJpSLEO3SlbAcrljUXmwsXqQAZvAUY5gLFKz3t10X/9GIN9B9CCHJpwnDANqRYdzVYYwONx04AQl/CXUrNYJieeREbKDnWMrl9owfAXlY/MRVA0WvjwnID7CrisO9KFACyLSCeZjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQklp8jk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQklp8jk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98CE21F000FF;
	Fri, 11 Sep 2026 09:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789120701;
	bh=hX/0VXdhTTUQXgm1nvZ6WRmwINMKY0ea3J5ZevaVPdQ=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To;
	b=HQklp8jkUzc+XuTAgt+MEZAzQNZsCMZYLWJ2IhZ3vASqAsGu2Q6be5+fWsPF7X+ge
	 Lu2SDt/K0b3cGnuSf7le/2CIqO7Jvxks58+8fjrBZcIFHS+djzdzhjpME+Tuja+dM8
	 hShq0R97Mi8BrMMCx9rsRyVlNeDPAYjQs83eq7vBDifeCxcHOcDFYupG8dREI5Wy1D
	 ZZ20OWMWZg3HsPMTEYCfGUX86VP0MthO/uN4zUKJi8Bo7i2OSCfrN9PsKXErOKoxq8
	 oI88j9GXaxM+bGfpfplqL0u3kkMZORzFLHBPOSib+zop7aJv+drYaKAc2dzqv2kyLh
	 +vi2rwyHcZZFw==
Message-ID: <b9a44b9f-0cb9-4420-8860-92763264dd1c@kernel.org>
Date: Fri, 11 Sep 2026 11:58:18 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC] Mitigating Sashiko-driven iteration noise on the main MPTCP
 list
Content-Language: fr
To: gang.yan@linux.dev, Shardul Bankar <shardulsb08@gmail.com>
References: <b13525eb141d18e1fe326fec4e71b53704cdc291@linux.dev>
 <6f86381a-72d4-4a47-bc7d-1880cc39da64@kernel.org>
 <3f13f3acd4c329480331cccf5a12411dc01ee721@linux.dev>
 <7429a238-6297-4a7c-b18c-47cbcee4ab69@kernel.org>
 <20260907125720.516598-1-shardul.b@mpiricsoftware.com>
 <703f2d892ac7432d4317f949e6ceba1b7f73ba40@linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <703f2d892ac7432d4317f949e6ceba1b7f73ba40@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Gang, Shardul,

On 10/09/2026 13:08, gang.yan@linux.dev wrote:
>>
>> Gang, you mentioned deploying Sashiko locally. Did you see anything like
>> the same cost, and what were you running it against? If this turns out
>> to be particular to a fixed-quota subscription, I would rather find that
>> out than have people avoid running reviews locally over a cost that does
>> not apply to them.
>>
> 
> Hi Shardul,
> 
> Thanks for your reply.
> 
> Sorry for the delayed reply; work has kept me busy lately so I haven’t had much
> time to check emails. Please also excuse my English — I might have caused some
> confusion earlier. I'm using the API key and noticed the cost.
> 
> I’d like to share my experience with an API-key Sashiko deployment, which may help
> folks on this list use Sashiko at lower cost.
> 
> I run Sashiko using Minimax as the LLM. Minimax offers a monthly subscription plan
> and is quite affordable. (I submitted a small PR to Sashiko to fix some issues
> I encountered while using it.)
> 
> One observation: reviewing large patch series via the web interface can burn through
> the 5-hour quota very quickly. In contrast, using `sashiko-cli` from the command line
> seems to cut token consumption significantly, this is from my practical testing.
> 
> I also tried GLM, which is another fixed-quota subscription model and relatively
> more expensive. While its quality is not as good as Gemini or Opus, it still works
> well for local code iteration.
> 
> I’m still relatively new to working with AI tools. If you have any approaches to save tokens,
> would you mind sharing them on this thread?

Did you install Semcode [1]?

I remember that this tool was recommended to people using Chris Mason's
Review Prompts [2], and Sashiko use them [3].

(I tried to use Semcode manually, but I didn't get along with it, maybe
I should retry, or maybe it is mostly made for agents?)

It looks like this tool can save tokens (don't ask me how/how much) with
the review prompt [2]. Maybe with Sashiko as well? (If yes, Sashiko's
README should mention it as well.)

One last thing, Shardul, I noticed the "/kreview" you mentioned is
something from the review prompts [2]. Perhaps it is not running
everything from Sashiko, just a part of it?

[1] https://github.com/facebookexperimental/semcode
[2] https://github.com/masoncl/review-prompts
[3] https://github.com/sashiko-dev/sashiko#prompts

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


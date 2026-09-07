Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A334E8E07
	for <mptcp@lists.linux.dev>; Mon,  7 Sep 2026 13:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788788863; cv=none; b=eYcVEGv+m7foD/FSBX0nZ2pE/QIfgPqUict8aepGcfIOw+x/0shKDsBciHfURIoUkDVBDzxmPBvBLkCxd4CVmC+xjXx+evHEFIxpkH6RsFhETZO9u/Y2/pKTqRsRLreTUvPjkkN9vXFvEwy68DKmw2HKY5AMfVOSB1xwlDrPKyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788788863; c=relaxed/simple;
	bh=84IXWbOK8qRATnGWsQRWIgx93pqkELAL3qV/I9is3bU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EGhGew334KrrztnI1Rq7e5zcDJ0ly2WqOqDIKsZ0e/34YHOWWV4m50QmeUbgahPmpg982pTbCbrZ80jhOCYrk2tyVA9ZlXda57i1BqLye+4W1OM58WtTOKuiee4B6SVyJA/y7JjYgBJ6NOLSitFK41DvGddLfHcOdjUGD04/M3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aoQtQZqm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aoQtQZqm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62DD1F00A3A;
	Mon,  7 Sep 2026 13:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788788857;
	bh=ZF4XYmnrlnYJBI2j506Q46RbolopBaz2VIKtTRvheyY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=aoQtQZqmM677tWSAjIL9vE/haCmPMpsRBNCnZjDs9MEv05pZG807urkhCkP9iiXJg
	 7HzJR+7srIne6zBjx2xkndI67pA0YB6CpQcN3Z12AN+TSXg2tgW6SUOw179efZJju6
	 zfY5F9YDbj/89cv5BQpGl3jmKmrAKXF8Bl8pjeZw8Dp9PUtDbJYxPc/dRiFMeiMNjE
	 t52Gx2nRtyKS564lqYKYPguYgCB0CH7wWqJIryaHpwQyJYcS71bqhaHWKWzLhPKpML
	 qZw7TzWFGjz0HRzaqZEgdX9bxR+XmCsPP4JKpHMT8whdl5YbWn9x0KjKPdGRzkLM1a
	 0xnbq/SKGmipw==
Message-ID: <18756632-c1d6-40f4-8e81-2dcee48f3754@kernel.org>
Date: Mon, 7 Sep 2026 15:47:33 +0200
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
To: Shardul Bankar <shardulsb08@gmail.com>, mptcp@lists.linux.dev
Cc: gang.yan@linux.dev, janak@mpiric.us, kalpan.jani@mpiricsoftware.com
References: <b13525eb141d18e1fe326fec4e71b53704cdc291@linux.dev>
 <6f86381a-72d4-4a47-bc7d-1880cc39da64@kernel.org>
 <3f13f3acd4c329480331cccf5a12411dc01ee721@linux.dev>
 <7429a238-6297-4a7c-b18c-47cbcee4ab69@kernel.org>
 <20260907125720.516598-1-shardul.b@mpiricsoftware.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 xsFNBFXj+ekBEADxVr99p2guPcqHFeI/JcFxls6KibzyZD5TQTyfuYlzEp7C7A9swoK5iCvf
 YBNdx5Xl74NLSgx6y/1NiMQGuKeu+2BmtnkiGxBNanfXcnl4L4Lzz+iXBvvbtCbynnnqDDqU
 c7SPFMpMesgpcu1xFt0F6bcxE+0ojRtSCZ5HDElKlHJNYtD1uwY4UYVGWUGCF/+cY1YLmtfb
 WdNb/SFo+Mp0HItfBC12qtDIXYvbfNUGVnA5jXeWMEyYhSNktLnpDL2gBUCsdbkov5VjiOX7
 CRTkX0UgNWRjyFZwThaZADEvAOo12M5uSBk7h07yJ97gqvBtcx45IsJwfUJE4hy8qZqsA62A
 nTRflBvp647IXAiCcwWsEgE5AXKwA3aL6dcpVR17JXJ6nwHHnslVi8WesiqzUI9sbO/hXeXw
 TDSB+YhErbNOxvHqCzZEnGAAFf6ges26fRVyuU119AzO40sjdLV0l6LE7GshddyazWZf0iac
 nEhX9NKxGnuhMu5SXmo2poIQttJuYAvTVUNwQVEx/0yY5xmiuyqvXa+XT7NKJkOZSiAPlNt6
 VffjgOP62S7M9wDShUghN3F7CPOrrRsOHWO/l6I/qJdUMW+MHSFYPfYiFXoLUZyPvNVCYSgs
 3oQaFhHapq1f345XBtfG3fOYp1K2wTXd4ThFraTLl8PHxCn4ywARAQABzSRNYXR0aGlldSBC
 YWVydHMgPG1hdHR0YmVAa2VybmVsLm9yZz7CwZEEEwEIADsCGwMFCwkIBwIGFQoJCAsCBBYC
 AwECHgECF4AWIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZUDpDAIZAQAKCRD2t4JPQmmgcz33
 EACjROM3nj9FGclR5AlyPUbAq/txEX7E0EFQCDtdLPrjBcLAoaYJIQUV8IDCcPjZMJy2ADp7
 /zSwYba2rE2C9vRgjXZJNt21mySvKnnkPbNQGkNRl3TZAinO1Ddq3fp2c/GmYaW1NWFSfOmw
 MvB5CJaN0UK5l0/drnaA6Hxsu62V5UnpvxWgexqDuo0wfpEeP1PEqMNzyiVPvJ8bJxgM8qoC
 cpXLp1Rq/jq7pbUycY8GeYw2j+FVZJHlhL0w0Zm9CFHThHxRAm1tsIPc+oTorx7haXP+nN0J
 iqBXVAxLK2KxrHtMygim50xk2QpUotWYfZpRRv8dMygEPIB3f1Vi5JMwP4M47NZNdpqVkHrm
 jvcNuLfDgf/vqUvuXs2eA2/BkIHcOuAAbsvreX1WX1rTHmx5ud3OhsWQQRVL2rt+0p1DpROI
 3Ob8F78W5rKr4HYvjX2Inpy3WahAm7FzUY184OyfPO/2zadKCqg8n01mWA9PXxs84bFEV2mP
 VzC5j6K8U3RNA6cb9bpE5bzXut6T2gxj6j+7TsgMQFhbyH/tZgpDjWvAiPZHb3sV29t8XaOF
 BwzqiI2AEkiWMySiHwCCMsIH9WUH7r7vpwROko89Tk+InpEbiphPjd7qAkyJ+tNIEWd1+MlX
 ZPtOaFLVHhLQ3PLFLkrU3+Yi3tXqpvLE3gO3LM7BTQRV4/npARAA5+u/Sx1n9anIqcgHpA7l
 5SUCP1e/qF7n5DK8LiM10gYglgY0XHOBi0S7vHppH8hrtpizx+7t5DBdPJgVtR6SilyK0/mp
 9nWHDhc9rwU3KmHYgFFsnX58eEmZxz2qsIY8juFor5r7kpcM5dRR9aB+HjlOOJJgyDxcJTwM
 1ey4L/79P72wuXRhMibN14SX6TZzf+/XIOrM6TsULVJEIv1+NdczQbs6pBTpEK/G2apME7vf
 mjTsZU26Ezn+LDMX16lHTmIJi7Hlh7eifCGGM+g/AlDV6aWKFS+sBbwy+YoS0Zc3Yz8zrdbi
 Kzn3kbKd+99//mysSVsHaekQYyVvO0KD2KPKBs1S/ImrBb6XecqxGy/y/3HWHdngGEY2v2IP
 Qox7mAPznyKyXEfG+0rrVseZSEssKmY01IsgwwbmN9ZcqUKYNhjv67WMX7tNwiVbSrGLZoqf
 Xlgw4aAdnIMQyTW8nE6hH/Iwqay4S2str4HZtWwyWLitk7N+e+vxuK5qto4AxtB7VdimvKUs
 x6kQO5F3YWcC3vCXCgPwyV8133+fIR2L81R1L1q3swaEuh95vWj6iskxeNWSTyFAVKYYVskG
 V+OTtB71P1XCnb6AJCW9cKpC25+zxQqD2Zy0dK3u2RuKErajKBa/YWzuSaKAOkneFxG3LJIv
 Hl7iqPF+JDCjB5sAEQEAAcLBXwQYAQIACQUCVeP56QIbDAAKCRD2t4JPQmmgc5VnD/9YgbCr
 HR1FbMbm7td54UrYvZV/i7m3dIQNXK2e+Cbv5PXf19ce3XluaE+wA8D+vnIW5mbAAiojt3Mb
 6p0WJS3QzbObzHNgAp3zy/L4lXwc6WW5vnpWAzqXFHP8D9PTpqvBALbXqL06smP47JqbyQxj
 Xf7D2rrPeIqbYmVY9da1KzMOVf3gReazYa89zZSdVkMojfWsbq05zwYU+SCWS3NiyF6QghbW
 voxbFwX1i/0xRwJiX9NNbRj1huVKQuS4W7rbWA87TrVQPXUAdkyd7FRYICNW+0gddysIwPoa
 KrLfx3Ba6Rpx0JznbrVOtXlihjl4KV8mtOPjYDY9u+8x412xXnlGl6AC4HLu2F3ECkamY4G6
 UxejX+E6vW6Xe4n7H+rEX5UFgPRdYkS1TA/X3nMen9bouxNsvIJv7C6adZmMHqu/2azX7S7I
 vrxxySzOw9GxjoVTuzWMKWpDGP8n71IFeOot8JuPZtJ8omz+DZel+WCNZMVdVNLPOd5frqOv
 mpz0VhFAlNTjU1Vy0CnuxX3AM51J8dpdNyG0S8rADh6C8AKCDOfUstpq28/6oTaQv7QZdge0
 JY6dglzGKnCi/zsmp2+1w559frz4+IC7j/igvJGX4KDDKUs0mlld8J2u2sBXv7CGxdzQoHaz
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260907125720.516598-1-shardul.b@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Shardul,

Thank you for sharing this feedback!

On 07/09/2026 14:57, Shardul Bankar wrote:
> On 04/09/2026 12:32, Matthieu Baerts wrote:
>> So at the end, it seems like a good thing to have access to various
>> models to cross checks the reviews.
> 
> Agreed, and that is where I ran into something worth passing on. If the
> plan is for people to run reviews locally, and more than one model at
> that, then what a local run costs decides whether anyone actually keeps
> doing it.

Just to avoid confusions, even if running multiple models *should* be
better (and/or having one cross-reviewing the comment from another one),
running one is already good, but only for those who are able to, i.e.
companies already using them. And that's what netdev maintainers expect,
so it somehow applies to MPTCP as well. I'm clearly not going to enforce
it, especially to individuals (like me) or people who don't want to use
for various reasons. The idea is "if your company is using LLM, then use
it to pre-review patches to save cycles".

> I ran Sashiko locally against my Claude subscription, using the Claude
> Code CLI provider rather than an API key. One patch took about 45
> minutes and consumed essentially a whole usage window. That window is
> five hours, so it works out at roughly one patch per window on that
> setup, which was enough to have me scheduling runs around the reset
> rather than just running them when I wanted a review. That timing was in
> August, on a build from before the declarative workflow engine landed,
> so I cannot say the 45 minutes still holds. What has not changed is the
> shape of it: the CLI provider still starts a separate claude process per
> stage, with no session carried between them, so the context is built and
> sent again for each one.
> 
> The part I did not know at the time is that there are two quite
> different things here. "sashiko init" then "sashiko review" runs the
> full staged pipeline, one process per stage, and that is the expensive
> one. The Sashiko repository also ships, in the prompt bundle it vendors,
> a /kreview command that runs the review as a single Claude Code session,
> so the context is read once instead of once per stage.
> 
> /kreview is not mentioned in Sashiko's README, its maintainers guide, or
> anything under docs/. It is documented only in
> third_party/prompts/README.md, inside the vendored copy of the review
> prompts, with the command itself in
> third_party/prompts/kernel/slash-commands/kreview.md. So anyone
> following the setup instructions gets the expensive path and has no
> particular reason to learn the other one exists. That seems worth fixing
> if the goal is more people running checks before they post.

Good idea!

(I didn't know it could take that long + the window time)

> A few of the things that make a local run costlier than it needs to be
> look fixable, and I have sent patches for them to the Sashiko project
> rather than describe them here, since that is where they belong. One is
> worth a line because of where it does and does not apply: Sashiko can
> cache model responses so a repeated request is answered from disk rather
> than sent again, but that setting has no effect on the local path, so
> retrying a failed run pays for everything a second time. The reviews you
> see arriving on this list are unaffected, since the daemon that posts
> them does use the cache.

I do wonder how people use it. Maybe many companies have deployed their
own Sashiko and local reviews are not common? (but I doubt that)

I would also not be surprised that many people don't care about the
cost, and if they use an internal ranking, it is possibly even better
without cache...

> One other thing, unrelated to cost and possibly of wider interest. Of
> the findings Sashiko has published for this list, the ones it marks as
> pre-existing are graded higher than the ones it attributes to the patch
> under review. Roughly 95 percent of the pre-existing ones are High or
> Critical and not one is Low, against roughly half for the findings
> attributed to the patch. I had been treating "this was already broken"
> as a reason to downgrade, and that is not how the tool treats it. The
> reasoning holds up, since a pre-existing bug is live in the shipping
> kernel while one introduced by a patch under review will most likely be
> caught before it merges.
Note that pre-existing issues don't always need to be fixed as part of a
series adding a new feature. A message about that in the commit message,
in the commit note or in reply to Sashiko's email. If the issue is real,
the impact has not changed with the modification, and the fix is not
simple, it is enough to create a new ticket on GitHub and look (or
someone else) at it later.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16D64028C4
	for <mptcp@lists.linux.dev>; Thu,  3 Sep 2026 09:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788429135; cv=none; b=VXlTOwz4kiqbUidXQ37YqdZ4mWEK9YVv3/3FqmuAHwOeEcgcE0zPdUC+04zY28KkJz2aSUFIBQ6uCnJUSv7AG84QosUnSLj8fN3SwFImFhBQBAFAuMFDJRxCwpfdD/4yAMtjPvrs1t7r7xu/zvkZn+/DZl4hkB6wpp2MuGKDuRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788429135; c=relaxed/simple;
	bh=x8ECSg3KsjtnwB/7baxq4qDFZH7G1mBCw3HBygEiRqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CMV6mkSNWqhnKs78V+Z8ugkr1N3xa8F1pl4kElOcHQfXNU+T0WzYFW4hCt5NdMZGfsx2ftF3M+T1f0FSyYQnkAoywyt8cWlyV7UpLlExKuwiEVIww5Pg3OOD65QhpobAkOOAB8acCbiIF9wT25tY/gneqhi3MldyPovW5R/b3XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fl/bBFJR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fl/bBFJR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F182E1F000E9;
	Thu,  3 Sep 2026 09:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788429133;
	bh=qq98CSYSYN7O1RLFxmr0PjTPpqs2iMKkmlsoBpukpr0=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=Fl/bBFJRXFzXrHqag3HT+wVXuB5ldO9wo6MMWcAjp5bFFHV0BQwTc4gcD+TMTyoma
	 P4+MOhC+AFEgdwH9IxpNOm7SnzLB+QWXbIiHp8TCNQQEcqRCuW3tbEdvMYxE59jdM8
	 DT6ruIb44vX2OTWgbZQ1TythWNWrOGSFZ2gi3/S3E0/ZOJZx/q7tf3q/+l2zvvHB7u
	 4fGyfcxYtnU89JyHC/lsxr0fRY30gNk2D/8giePQUp6VrjVMwVBl3baSmD+CCZtkyu
	 8KmnlZH/j444SC7efTaxa4Q/4QBDrQrExLGhzWeQ6YFjs6B8LvngIH68TqRCUOKLDq
	 0U3NgwfQHdqiQ==
Message-ID: <6f86381a-72d4-4a47-bc7d-1880cc39da64@kernel.org>
Date: Thu, 3 Sep 2026 11:52:11 +0200
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
To: gang.yan@linux.dev, mptcp@lists.linux.dev
References: <b13525eb141d18e1fe326fec4e71b53704cdc291@linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <b13525eb141d18e1fe326fec4e71b53704cdc291@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Gang,

On 03/09/2026 08:12, gang.yan@linux.dev wrote:
> Hi all,
> 
> Apologies for the extra email, and please don't take this as any criticism of the current workflow.

Thank you for your email, it's good to discuss that.

> I'm writing this email to see if anyone else in the community shares some confusion I have
> regarding the use of Sashiko—specifically, the multiple rounds of iteration and the large
> volume of emails generated on the main list.
> 
> Let me explain the problem more clearly.
> 
> The Problem
> 
>   Since Sashiko was introduced, it has greatly accelerated patch iteration for contributors.
>   However, from a human reviewer's perspective, the main mailing list (mptcp@lists.linux.dev)
>   now carries a significantly increased volume of emails.
> 
>   Specifically, Sashiko's comments are almost exclusively directed at the original contributor,
>   who then submits a new version of the patch addressing those comments. But this process often
>   repeats for several rounds: each new version triggers additional Sashiko feedback, leading to
>   multiple intermediate patch revisions being posted to the main list. These intermediate versions
>   are only relevant to the contributor and the bot—they do not require immediate human attention,
>   yet they clutter the inboxes.
> 
>   In other words, the main list is currently used as a live iteration sandbox between Sashiko
>   and the contributor, while human reviewers are forced to watch every step of this back‑and‑forth.
>   That seems not necessary.

I agree with you here, having to face many iterations is not good for
the reviewers, and not for the devs either.

> My suggestions
> 
>   To decouple the machine‑driven iteration loop from human‑driven review, I would like to propose a
>   split workflow:
> 
>   1. Initial submission (v1): The contributor sends the first version of the patch series to the main
>      list (mptcp@lists.linux.dev). Maintainers can quickly glance at it to filter out obviously invalid
>      or low‑quality patches early.
>   2. Bot‑driven iteration (v2, v3, …): For subsequent versions that only address Sashiko's feedback,
>      the contributor posts those revisions to a separate, dedicated list (e.g., mptcp-sashiko@lists.linux.dev).
>      Sashiko watches that list and provides its feedback there. The contributor can iterate as many
>      times as needed without bothering the main list audience.
>   3. Final polished version: Once Sashiko reports no meaningful comments (or only false‑positive warnings
>      that the contributor has already handled), the contributor resends the final, cleaned‑up patch to
>      the main list for human review.
But I cannot support your suggestion :)

Sashiko's usage has a cost: it is useful to have it to flag some
potential issues, so we want to continue having it for "legit" patches.
If its usage is "abused", then we might lose it for all patches.

At the last netdev, devs got told to run pre-checks locally, including
selftests but also AI reviews (when it is possible). Many companies are
already using LLMs, then their devs should also have their patches
tested by a local Sashiko. Sashiko can be easily executed locally, with
different models. The project's README explains how to install and use
it. In short, it is supposed to be easy: configure the model to use, run
"sashiko init", then "sashiko review". That's it. Or course, we cannot
force people to use it locally. Some refs:

 -
https://netdevconf.info/0x1A/docs/netdev-0x1a-paper49-talk-slides/Device%20driver%20workshop%20(2).pdf
 - https://github.com/linux-netdev/nipa/wiki/Running-Netdev-CI-tests-locally

Ideally, authors are expected to reply to Sashiko's emails and reviewers
can help checking if Sashiko is hallucinating (which still happen
frequently...) or is asking to fix issues that cannot happen in real
deployments. But the thing is that Sashiko can review and generate a lot
of text that humans -- especially busy reviewers -- might take time to
process. So the idea here is not to rush things, and ask questions when
something is unclear or look suspicious / wrong.

In conclusion, I don't think we want a "hidden" ML, but we do want to
reduce the traffic on the ML, and the recommended solution is to push
people validating their patches with the same tool (or closed to, if
possible) before any submissions. WDYT?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15669657DD
	for <mptcp@lists.linux.dev>; Wed, 31 Jan 2024 09:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706691612; cv=none; b=kEYSC5i+P/6ix10E8hF457JaUcaD8gOrjxlzVXoeigNEZFVS+Ty1gp0GqXW4211yF8sNs7RLev2DikHF8c3SFKcbRme4DyQ3JQH1SJ4qcHQ4NNzCLDrt8UKFsMqdVaZjwjUGUHbREH1Ys3SHDQljSpK6HbfC4yiZC9wk/k30Bms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706691612; c=relaxed/simple;
	bh=YCNb6amrzFFZnqS+Z0BClh8TgoBFxfHEvN9hUdmwtT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=be88VBIO+rIiMj7uyA4A6LAKGSsVp2iCbYdMoQP+qOWbtok9Tu57DJW9I5fCYaIlEQe3GUTFqaDJnrQdFCayDDaNIUEo6m0lZSRfqrEtqFdV+Hbt8zdIwR6FaEbdOqAMRhVj2tV7Kl1GqZ1ympCIAC9pjqy9U0AFqzbjSGiGit8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTtl/2XO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTtl/2XO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C922CC433F1;
	Wed, 31 Jan 2024 09:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706691611;
	bh=YCNb6amrzFFZnqS+Z0BClh8TgoBFxfHEvN9hUdmwtT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WTtl/2XOXKx/IM0a2Du3PCrVAvjO7ualMBWplmu57oV9Orwvb2ISOCPYg2UopwUif
	 BVV0EwPqZQ1lt7tkTLtS5neQ5VJkeUzrThgTX016rOFcVJU6y9u8X4tP4ja+Jxs6TL
	 CLACJtXL8FJhr0L+fci9zhqmSWIkSZpmpjNNIFy7a52W0f5nAcgXA4phsfSd88nj9B
	 xjPJISOMs3Di4ZykxXBkyHDLRyQw/CX2ah94KjZIvus/+bH9y37Ne0Rj6TKq1Lrwj8
	 jNYGQXx3ZFlR5gtqTjaXdIU6z55rPtpX6rRPa5vR70X+r6ehlEtYqYcBmrcyR5xSJn
	 T2K93qa/hkTWg==
Date: Wed, 31 Jan 2024 17:00:01 +0800
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH virtme-docker 2/3] upgrade to ubuntu 23.10
Message-ID: <ZboMET6t/5oso4By@t480>
References: <cover.1706422466.git.geliang@kernel.org>
 <dc2e14b63fd7ec288e015124919c28c9470d5913.1706422466.git.geliang@kernel.org>
 <ZbhHy6GPo4UcCKy0@t480>
 <a201bd1f-8c67-4196-bc71-4e08ab60d1db@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a201bd1f-8c67-4196-bc71-4e08ab60d1db@kernel.org>

On Tue, Jan 30, 2024 at 04:50:46PM +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 30/01/2024 01:50, Geliang Tang wrote:
> > On Sun, Jan 28, 2024 at 02:16:02PM +0800, Geliang Tang wrote:
> >> There will be many build errors when comliling bpf selftests under
> >> Ubuntu 22.04. Upgrade to 23.10 to use the new versions of gcc, clang
> >> and LLVM.
> >>
> >> Fix sparse build errors for llvm-16. This part alse be sent to sparse
> >> upstream. It can be dropped from this patch when accepted.
> > 
> > This part has been upstreamed, we can drop it now from this patch.
> 
> Thank you for the patches and this note, I didn't see it has been fixed
> upstream.

It fixed in the commit 0544c547 ("llvm: fix LLVM 15 deprecation
warnings").

> 
> I didn't know you needed to upgrade to Ubuntu 23.10. I did something
> similar for your two first patches last week when looking at the issue
> 471 [1] to switch to a more recent version of QEmu, but I didn't push my
> changes. I hope you don't mind if I apply my modifications (with your
> co-dev tag) where I use new versions of the dependences instead of
> patching them.

Sure, thanks.

-Geliang

> 
> I will look at the patch 3/3 (v2). I will need to modify it slightly I
> think not to have the current CI failing. I can also look at modifying
> the current CI job to validate this BPF test. I will probably need more
> conditions to be able to run on older kernels as well. I will push that
> after having done some tests, not to have regressions for the tests we
> are currently validating.
> 
> [1] https://github.com/multipath-tcp/mptcp_net-next/issues/471
> 
> Cheers,
> Matt
> -- 
> Sponsored by the NGI0 Core fund.

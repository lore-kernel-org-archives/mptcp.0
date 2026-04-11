Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D83F40DFA1
	for <mptcp@lists.linux.dev>; Sat, 11 Apr 2026 00:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775868584; cv=none; b=s8XG+ArHqaAxo3OV3coR2Pi9cKpma7aERc3qAt8TZWYg6ryT2YwR/xwn0BNi17+MGsLHRjwZufnGU19xiGAYbx1WGNK1ZdFJs/B7q5RMEWGwWcgLEqc5MVHIvl4lg2BfYFbHSp4Gocgvn7nZ88/gTHDrTWJh44YMh5IpWhrMMTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775868584; c=relaxed/simple;
	bh=yla4EybFyUZOIwdt91v9ieMlgRw18B0nfE6N9rGV3ls=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AtmRf+BvWdx+bOdez5EMulCat/Obia6eTE/TLBpQMVGUBu5PU2zaulTW0MFzQVTB9VBTiWfOoZqIseDS7vj3lnr0GFpVgkmJPPuSDOSRLU4x3cJ4yrUJhfnISvjCxnwX5OkbPQ9sM3BkMLDP6AGkyFBB+twYe1I+aGImy98A2oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AF6ZqraO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AF6ZqraO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C0AC19421;
	Sat, 11 Apr 2026 00:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775868583;
	bh=yla4EybFyUZOIwdt91v9ieMlgRw18B0nfE6N9rGV3ls=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=AF6ZqraOqUhq7voKtIfTvBvI/5tPjLM35p8qDT2n1cKTRIgGGhm/xmAIkofbBFMPE
	 GkHvegYAfNVM32xqwQwU5Bhv2dSpWkvyaFFwk9P0EdtwHnw+WqMR38y/LbuLHwBJSY
	 Cx1iPLz2uU+WpXlUgIQE+3lXuN/7Ib+hGDyVLTyDheUGT4qkpP4ZZ8/FhIQ+U2h3rx
	 1teqVCQ0/EZ4O3RwmAvOjK9gv3r1dYscGzM8M4OJ7qSdq4l0xB8YMLhCvi7eLhTfJ7
	 zMcAQ/FCjJ61YLZssX3SsAKDpd3YNAS7tsmnOAghJKHR9c35RKz6x5bumuZZK/bpzX
	 JDl+296edAY8w==
Date: Fri, 10 Apr 2026 17:49:43 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v3 0/3] only remove entry from local_addr_list
 when sending a REMOVE_ADDR
In-Reply-To: <cover.1744787273.git.tanggeliang@kylinos.cn>
Message-ID: <f3111324-edf8-3137-1af4-095479bb7040@kernel.org>
References: <cover.1744787273.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 16 Apr 2025, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> v3:
> - update userspace selftests.

Hi Geliang -

Could you rebase this and resend to the mailing list? It unfortunately 
does not apply any more, sorry it has been in the queue for so long.

- Mat


>
> v2:
> - squash patch 1 into patch 2 as Mat suggested.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/403
>
> Geliang Tang (3):
>  mptcp: pm: userspace: drop delete_local_addr helper
>  selftests: mptcp: join: update userspace dump_addr outputs
>  selftests: mptcp: userspace: send RM_ADDR between server and client
>
> net/mptcp/pm_userspace.c                      | 37 +++----------------
> .../testing/selftests/net/mptcp/mptcp_join.sh |  6 +--
> .../selftests/net/mptcp/userspace_pm.sh       | 12 ++++++
> 3 files changed, 20 insertions(+), 35 deletions(-)
>
> -- 
> 2.43.0
>
>
>

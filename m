Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C6B1AE024
	for <mptcp@lists.linux.dev>; Fri,  2 Aug 2024 17:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722620620; cv=none; b=KBFfxiI2tCTbADeFsvqgITM7bkjlGw2SWL2pAzZjoWUcRVoFTVq8JlCJbAQ8ohqToJV/EZESZDOpGJVIBRaSlR5eSz1yYW8bYzovEyd1mbuR1GTMC9Thxh1EspUgVzodeGp1QmMdenkTswFzqaHJdjnz/7Itgn8U6RMdC1XawpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722620620; c=relaxed/simple;
	bh=h+/KJ377+AWlIu0KFATBHcj4fVco9M9qk/5xzfRmoR0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kaSFD2zGP/onszS9KuuZL3qSNq2BK5GhIu5J0AOGfqRmUkxsrslEIcY/ws8AqDfHYaMB2szJvnepowV0vkDlI9ixkgXkc/zwLMp0VAUeAD9STmy98EbJXNXGDIVgE2U4V2YiLi7fNXIL3g6+5bYtl8yPzqOkxEkaSmofZfCXSpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVjEnGvi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVjEnGvi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C3A5C32782;
	Fri,  2 Aug 2024 17:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722620620;
	bh=h+/KJ377+AWlIu0KFATBHcj4fVco9M9qk/5xzfRmoR0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=MVjEnGviy0UjBAB5Y3P22alQM9/fbmoiYugNy6SbfMk6cEPWk++BZHXVIPaFA+GW1
	 NhLtwspOZieTnGFRYEPr9WdXpbH5mOmd9N3jm96qSTzb4BPNukTa23Wg8wZ6hSbvNy
	 Amii+Z/4XkDTpxQsKayYFSs4pD8rofjwC1lhejrFBa4cltj8jZkcKheaQpBp14Okar
	 IEuiBsQTwWug6BO9MsV6+p2UZD5+0qaBQ71mTAAUBYI+R2bZzPjMZBp4f2RL5aCj2R
	 +RhFg6CUBzbYqgm16fvjr73pfvaSRvVX2H9sofbGGZQ4hAhy5H3s6jBz9/lVGU2CFp
	 m/tRknWGypVxg==
Date: Fri, 2 Aug 2024 10:43:39 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net] selftests: net: lib: kill PIDs before del
 netns
In-Reply-To: <20240802-selftests-net-lib-cleanup-kill-v1-1-66220a8b6911@kernel.org>
Message-ID: <6806450e-7c7b-8072-0af9-23bac214ec0b@kernel.org>
References: <20240802-selftests-net-lib-cleanup-kill-v1-1-66220a8b6911@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 2 Aug 2024, Matthieu Baerts (NGI0) wrote:

> When deleting netns, it is possible to still have some tasks running,
> e.g. background tasks like tcpdump running in the background, not
> stopped because the test has been interrupted.
>
> Before deleting the netns, it is then safer to kill all attached PIDs,
> if any. That should reduce some noises after the end of some tests, and
> help with the debugging of some issues. That's why this modification is
> seen as a "fix".
>
> Fixes: 25ae948b4478 ("selftests/net: add lib.sh")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> tools/testing/selftests/net/lib.sh | 1 +
> 1 file changed, 1 insertion(+)
>

Sounds like a good idea to me:

Reviewed-by: Mat Martineau <martineau@kernel.org>


> diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
> index d0219032f773..8ee4489238ca 100644
> --- a/tools/testing/selftests/net/lib.sh
> +++ b/tools/testing/selftests/net/lib.sh
> @@ -146,6 +146,7 @@ cleanup_ns()
>
> 	for ns in "$@"; do
> 		[ -z "${ns}" ] && continue
> +		ip netns pids "${ns}" 2> /dev/null | xargs -r kill || true
> 		ip netns delete "${ns}" &> /dev/null || true
> 		if ! busywait $BUSYWAIT_TIMEOUT ip netns list \| grep -vq "^$ns$" &> /dev/null; then
> 			echo "Warn: Failed to remove namespace $ns"
>
> ---
> base-commit: 3b0e1975962a388844508be0b3e61e759837fa3e
> change-id: 20240802-selftests-net-lib-cleanup-kill-f546a233572e
>
> Best regards,
> -- 
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
>
>

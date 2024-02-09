Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B771F7E8
	for <mptcp@lists.linux.dev>; Fri,  9 Feb 2024 00:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707438605; cv=none; b=rOFwxo4Yrincv4zcp0AMQ6ZcKwjPeldYijPaDnfZFViLHOotr10zapLtG98cDnCgruu6BmZcl5/TtzW5mXDXhJVTctgA7G7MyF/6VrcVT+ZRKvWZ3ticbDVFqf91RQlOdobsBS/TVC+c6NaAzXuZSLrMWAai+Ynp9JWhsIg1+9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707438605; c=relaxed/simple;
	bh=Im2Rj8/lwR99WqRRqHSgHclWL417HfSWHdht2rf4VJ8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EnpJH4PEOqbot70Fg0cCVDCbE6d+HCgAKk5pvKNZgFziPCFUXD/Ume/dd/PsEbKMX+FoTwxPjEOL5sswrPoUB2repwbjEU/JlAgWdbvyXVV++HqsPEitt3LFYZGKRNAgBICw3mvFK27ae0VfkbJajF/SRecjxo/TX8LBFi0Ea7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKvZvvaa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKvZvvaa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3410DC433F1;
	Fri,  9 Feb 2024 00:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707438605;
	bh=Im2Rj8/lwR99WqRRqHSgHclWL417HfSWHdht2rf4VJ8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=oKvZvvaaRDnq7q2zJW0uVUTsAYrClG4ilGMm1yVgsPBM7b96Grh9e3YmSwbiC5p7e
	 yNnoT5NL9DKPQoPb+EWkNCdJfDXSI9zj7WFRV1/saeAzpwnytZ2EqPVZM2QWQ1nqsG
	 r8KQOplhvgHiRMgpDjaY1L/fF3OAZGkkXpHcbH1s5JB2um3aLDhJ+SWbXV3mGVqND8
	 47/fgWk89s7JBJ4Ll631A9n9sqVE2VnpaslhfEDJbELmfCnDPGNkXff6qijPvcoHYS
	 RE/WszRMGaCWtCXFM7LYTuI1wABLKhKjTWWTNtxxNXKcmGaHYv3gJaOY7qjxJ7CnDX
	 3HtqphBH0Gh1A==
Date: Thu, 8 Feb 2024 16:30:04 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net] selftests: mptcp: simult flows: re-adapt BW
In-Reply-To: <20240208-selftests-mptcp-simult_flows_faster-v1-1-2859ca46e582@kernel.org>
Message-ID: <196d5d2c-39c2-b2d9-1104-75bd4b7d6af2@kernel.org>
References: <20240208-selftests-mptcp-simult_flows_faster-v1-1-2859ca46e582@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 8 Feb 2024, Matthieu Baerts (NGI0) wrote:

> Recently, the bandwidth in simult flows selftest has been reduced. The
> idea was to improve the situation in slow environments. It helped in
> some, but not in all of them. With a longer transfer, it is also
> possible to get more instabilities along the way.
>
> We can increase a bit the rate limit for the unbalanced bandwidth cases,
> but limit the total of the two links to 20 Mbps, like the balanced
> bandwidth cases. The same 3:1 ratio is still being used like before, not
> to change the nature of the test.
>
> Fixes: 5e2f3c65af47 ("selftests: mptcp: decrease BW in simult flows")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Looks reasonable, thanks Matthieu.

Reviewed-by: Mat Martineau <martineau@kernel.org>

> ---
> tools/testing/selftests/net/mptcp/simult_flows.sh | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
> index 0cc964e6f2c1..619be0e1acf5 100755
> --- a/tools/testing/selftests/net/mptcp/simult_flows.sh
> +++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
> @@ -287,9 +287,9 @@ run_test 10 10 0 0 "balanced bwidth"
> run_test 10 10 1 25 "balanced bwidth with unbalanced delay"
>
> # we still need some additional infrastructure to pass the following test-cases
> -run_test 10 3 0 0 "unbalanced bwidth"
> -run_test 10 3 1 25 "unbalanced bwidth with unbalanced delay"
> -run_test 10 3 25 1 "unbalanced bwidth with opposed, unbalanced delay"
> +run_test 15 5 0 0 "unbalanced bwidth"
> +run_test 15 5 1 25 "unbalanced bwidth with unbalanced delay"
> +run_test 15 5 25 1 "unbalanced bwidth with opposed, unbalanced delay"
>
> mptcp_lib_result_print_all_tap
> exit $ret
>
> ---
> base-commit: c2469b38e369c3f2b9577beeb9470cc757abc1b9
> change-id: 20240208-selftests-mptcp-simult_flows_faster-0a3b46f5cde6
>
> Best regards,
> -- 
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
>
>

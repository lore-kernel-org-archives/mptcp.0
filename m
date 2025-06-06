Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B4C1E25ED
	for <mptcp@lists.linux.dev>; Fri,  6 Jun 2025 12:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749211362; cv=none; b=AFOjqiwiM6VZ+pou6AgLaPBZTUb7WzPTva1Fyt8y59sWhGmnj4IY87/SDj2eBzlV7h1CiwUtiWNVouGgGHIg3F9zutSHNtQvGbHlYe+14Tsicjkn7r4ymbBSmjmCZ3L8xlmTRQZx149WZRM0m9IvugvDJhZBM9BGo/WLoj5Emw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749211362; c=relaxed/simple;
	bh=oS4qTHYcuqFizNn5KVlyGpepqfYtJrlmSnEGy5V9w3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ouWaWamQhfC7ojIeRYou8xTom+VeF34F8HRA7awkxoxA4kaUOnnFtuuRhPd6yWh1rVEqzWhYzGVQOLvFmJqvjqrJ2dgXohTzzdXRlqfczZMZ2l/uXHbfpMifrohp03gH9UbmCMjQdcH1o1IWELjZdUgqA2sFlbJRuJUi/TnFGY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwVuHYUK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwVuHYUK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379A3C4CEEB;
	Fri,  6 Jun 2025 12:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749211361;
	bh=oS4qTHYcuqFizNn5KVlyGpepqfYtJrlmSnEGy5V9w3U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qwVuHYUKZNyeisRSVhMEja4n2dFGgIGkU96uoVNEl9UN8RmBPxg77BColxyoaz2cs
	 l7im0tg3KC988qCrk5L0aCJDb0J0dta0kQyOC5Y1JiLDHCsUselZ4nsBbqkONSArjx
	 3zU0XFwMhWROqvJ3y1QaUSP5SUvME3VyzUdlp9LBKb3EUbEdhJQiA69k+IU2C7OCVw
	 ws28I5L4wbbLsJs9PNhlV28xBHEwF1VweHI9M9ADDMdaXDbTs+h8SS08P3fZiygkcZ
	 By6+Rld34zoDFhxt1SNzVE/B/YMl3gk2sapFuYgE+1kCz/RBusYjdF/fUnpLnrOEh1
	 q8H3C1VTvbvdg==
Message-ID: <b5c707fa-4bf6-42db-b256-1ebaca4c95fb@kernel.org>
Date: Fri, 6 Jun 2025 14:02:38 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v3 0/3] Squash to "BPF packet scheduler"
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1748592117.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <cover.1748592117.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 30/05/2025 10:03, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> v3:
>  - put bpt_iter kfuncs into bpf_mptcp_iter_kfunc_set.

Thank you for this new version! The modifications in the code look good
to me, but applying them like that would cause issues in the code. Your
first squash-to patch for "bpf: Register mptcp common kfunc set" would
add a dependence on a later patch introducing bpf_mptcp_sched_ops.

I did the following modifications directly in the tree:
- Revert "bpf: Register mptcp common kfunc set".
- Add its content to "bpf: Add mptcp_subflow bpf_iter" & "bpf: Export
mptcp packet scheduler helpers".
- Remove the filter for the mptcp subflow iter.

Feel free to check the modifications I did and suggest any changes if
needed.

New patches for t/upstream:
- 7464c07e0b21: Revert "bpf: Register mptcp common kfunc set"
- 7a67a1f3a43d: tgupdate: merge t/bpf-Add-mptcp_subflow-bpf_iter base
into t/bpf-Add-mptcp_subflow-bpf_iter
- 6a9ee240a5f5: "squashed" (with conflicts) in "bpf: Add mptcp_subflow
bpf_iter"
- a3557639df4e: "squashed" (with conflicts) in "selftests/bpf: Add
mptcp_subflow bpf_iter subtest"
- 4bb0a3a3a05f: tgupdate: merge t/mptcp-add-bpf_mptcp_sched_ops base
into t/mptcp-add-bpf_mptcp_sched_ops
- e43d77b0c6aa: tgupdate: merge t/bpf-Add-bpf_mptcp_sched_kfunc_set base
into t/bpf-Add-bpf_mptcp_sched_kfunc_set
- 3f5d496d0334: conflict in t/selftests-bpf-Add-bpf-scheduler-test
- f89d0256f95f: conflict in t/selftests-bpf-add-bpf_first-scheduler
- Results: 226663e50465..8df73de5f995 (export)

Tests are now in progress:

- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/d4388fa1829e204dbc8bf97843787e8b143352cb/checks

Note: I will monitor the CI and hopefully fix new issues if any.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


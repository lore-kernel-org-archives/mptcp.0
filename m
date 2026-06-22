Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43AC33120A
	for <mptcp@lists.linux.dev>; Mon, 22 Jun 2026 16:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782146864; cv=none; b=F1xCe4xYT/HAqKHsrehPDX+B1KpZ+SCP711el59427R1GS3xmkv5DkDvalU7JGLNVEF/ApQ9SfJ0W47L9fzqIA1IOyo3/YEha4bJL1A5m6oJNQgC/UbBVOhsv/l60QnE9XSOA5gT9NCnLrqxQzwWFG22vLXw/F65VJFS1jdhNS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782146864; c=relaxed/simple;
	bh=Gn2Zu+TIk7QKnhnMia6ppjgcgsCV7lpBwOIVmOn0zXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tNm4nKzlaFbh7EvMFRANL77YNoBuaumkrX04KtkQK62WyzeSQxdRZ/CCKdoVkN/GBJT56HPwKr9dwQUWDl7uKVHhGL1Xk2417sFDzwzMwf3reQ/snbVaq3m32g1I2gAuZRksqX0BumLApep/8vWRy5A0wn/+IyC2ViS0q7BQPAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpF7y4xg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpF7y4xg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085671F000E9;
	Mon, 22 Jun 2026 16:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782146863;
	bh=aE+abUW8GGcWXPXPzm3LJLNlViTAY5FLW3YrKDv3S/0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=gpF7y4xgiu/xHGwdVRouawiA4Y1HZdsoX9+OtcNnZXCmdSX88KdZpMr/lm7gKoGNw
	 c8cmuZ87PUscq5Pc13Z8Bst79lh3TWlQ+5ClEYBQ0ePdzpPAbN/DWnjuDQoQ7hwmLK
	 0aqnSH6sDPjnvE/PvAjuPIlC99u1W6LpbjzPJk3SFzuYG+VDGvCNp1h8PqLA0vtJXs
	 JlQ8lt5XoeLBkw2M7rznbILnWlxbKXZXSe5Mbue4GFIn/RufzsUzP6ik5zpFSKc4h8
	 ANWZNHq67wHFwCMWRBRb7GAOghBrfK8h05bxepTc/EMjn+bNwXPORaTLBLLFGAy3er
	 slnwQtyvkNC0A==
Message-ID: <3ba18b31-e511-4c79-94c1-6d14f83bc980@kernel.org>
Date: Mon, 22 Jun 2026 18:47:39 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v3 0/6] bpf sched updates
Content-Language: fr
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1782120674.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <cover.1782120674.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 22/06/2026 11:38, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> v3:
>  - Add sk_type == SOCK_STREAM check in bpf_iter_mptcp_subflow_new() to
>    prevent raw sockets from bypassing validation (new patch 1).
>  - Zero iterator state (kit->msk, kit->pos) on error paths in
>    bpf_iter_mptcp_subflow_new() to avoid uninitialized dereference.
>  - Change bpf_sk_stream_memory_free() signature to accept
>    struct mptcp_subflow_context * instead of struct sock *, to make it
>    work with burst scheduler.
(slowly trying to get back to the reviews, sorry for the delay on older
series, it might take a while...)

Thanks! Sashiko may have found existing issues with other helpers
introduced in our export branch, please see:

https://sashiko.dev/#/patchset/cover.1782120674.git.tanggeliang%40kylinos.cn?part=4

New patches for t/upstream:
- beb6482d3d18: "squashed" patch 1/6 in "bpf: Add mptcp_subflow bpf_iter"
- 21533dcb5a8a: "squashed" patch 2/6 in "bpf: Export mptcp packet
scheduler helpers"
- 0f4ed15e3a62: "squashed" patch 4/6 in "bpf: Export mptcp packet
scheduler helpers"
- 0d8c9711887c: "squashed" patch 5/6 in "selftests/bpf: Add bpf_first
scheduler & test"
- 4824dc0f98f1: "squashed" patch 6/6 in "selftests/bpf: Add bpf_rr
scheduler & test"
- b077032985ac: "squashed" patch 3/6 in "selftests/bpf: Add bpf_burst
scheduler & test"
- Results: bc8075b182f4..7fc976a6891c (export)

Tests are now in progress:

- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/366d3bd40f3e2dbc4d7ffe0816c0c657d6d7c54c/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


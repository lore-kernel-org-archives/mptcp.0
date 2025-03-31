Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8C21DF73C
	for <mptcp@lists.linux.dev>; Mon, 31 Mar 2025 13:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743426411; cv=none; b=gifkqbgeVSZKasC9o7/+VFDo9QEIP3B+OMS6wJIr0QcrcHn9Z8dPPi0xIUwkuB7/Xe1tnzNYkDQVTNJIiXfNXKa953OpAE4i+iRblzdSiyNRFuUWimQ9OISLn3Y4dQKBLwH9I5lAS1qjtz+tWxWN1Oc2/mT+iIp50YXyjp+DdLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743426411; c=relaxed/simple;
	bh=t1Ar22F1YmqUU+iLXgTuM+ITqPHHQ+8GP08zvwPAXlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=q9u8hP1A5thX3XtRtolbbdBVwfpT5E4RH3Cu3dWfyVFhoHiwUt1phUDca8/j2f9NNvuVI11IegQ1wA9NUFVFVUVqwoKpEdlEUyZFvXZtWn4+tGctMStilbB0bKERaKhrA7LLNpGSnjUvzc3+jzwmMG8NChQTawTkPYyRWkcVwF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQVHPrh6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQVHPrh6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EEB7C4CEE3;
	Mon, 31 Mar 2025 13:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743426411;
	bh=t1Ar22F1YmqUU+iLXgTuM+ITqPHHQ+8GP08zvwPAXlo=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=aQVHPrh6sWOCHQAXjVlZ7ojhXZbGLjfqKdnogCZRWRhfRLMkHjteE/bbNwGJxpBQo
	 91CYwSLqwkp/ZHkFQMmoYeER8nSxWrpOi5jb1rD7oVPwRrqrqqTCkAiAKof+XzJA9I
	 qXaVeAN8IJ+bQuMib6yjCezBMv0+Nj9kDJixELA+rJLhHWhcQKRJ7XUNMKNRRsEypP
	 oyQUSO+LGcFPZg4e572iPBQdJ4oBsqqqGvw9Re3Avyji/sU8Xs4TwFsKnl9qgs4/v0
	 a5PQko/TKufkFLtyYRzVWNxSNmqHylO1VUmpZxLLsUZd6lqkB61qqHjYr/P1y8w3p9
	 5ODLt0gUFbMlw==
Message-ID: <6c929bb7-a27f-48a2-a835-a20e44c3a1ef@kernel.org>
Date: Mon, 31 Mar 2025 15:06:48 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 0/5] mptcp: fix MPJoinAckHMacFailure, add
 MPJoinRejected
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <20250329-mptcp-mpj-reject-v1-0-2396d5666e8f@kernel.org>
 <7e340c72d4b865a29f794ee9f5e7cab1a7d22df1.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <7e340c72d4b865a29f794ee9f5e7cab1a7d22df1.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 31/03/2025 04:05, Geliang Tang wrote:
> Hi Matt,
> 
> Thanks for this set.
> 
> On Sat, 2025-03-29 at 17:26 +0100, Matthieu Baerts (NGI0) wrote:
>> Recently, during a debugging session using local MPTCP connections, I
>> noticed MPJoinAckHMacFailure was strangely not zero on the server
>> side.
>>
>> The first patch fixes this issue, and the second one validates it.
>> These
>> two patches can be applied in mptcp-net.
>>
>> There is a small refactoring in the 3rd patch.
>>
>> Patch 4 adds MPJoinRejected to track when the PM rejects patches, and
>> patch 5 validates it.
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> Except for my two small suggestions in patch 2 and patch 4, the rest of
> the code LGTM! No need to send a v2, please update them when merging
> this set (if you agree with these two small changes).
> 
>     Reviewed-by: Geliang Tang <geliang@kernel.org>

Thank you for the review!

Now in our tree (with the suggested modification in patch 2):

New patches for t/upstream-net and t/upstream:
- 0331c038b8f1: mptcp: only inc MPJoinAckHMacFailure for HMAC failures
- f80f8ee1b1b7: selftests: mptcp: validate MPJoin HMacFailure counters
- Results: 3804298131e0..c8227c8f8681 (export-net)
- Results: 6ac9a8d5227d..21ef34d86439 (export)

New patches for t/upstream:
- 3f8822824116: mptcp: pass right struct to subflow_hmac_valid
- 7b0845a43565: mptcp: add MPJoinRejected MIB counter
- 49e3c7e5ef6b: selftests: mptcp: validate MPJoinRejected counter
- Results: 21ef34d86439..b291aa1915c1 (export)


Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/cc0ff77a44448f3720df63d496387419c551f415/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/5110f50c1efb4273b3a28b0ae530b282b05af9ba/checks


Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


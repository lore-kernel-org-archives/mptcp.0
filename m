Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E14248885
	for <mptcp@lists.linux.dev>; Wed,  5 Mar 2025 14:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186669; cv=none; b=ul4Z90AXWBGwj0kYCVcbsLTyLhDd21rfKCwf/fhq+YK9VVcTIeOZL2CSwd2QUYHQXwce+dzHYd132Q4GTDHlxP/SBQ1/E9qpQzZkRXIduoPHhLfJDLVxMcvwbJ8xyPjgPbPlPFzXNai1efDTgm8i9gzy5ysq2nam1c/NqZanalM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186669; c=relaxed/simple;
	bh=di5AULKk6lSCx+o7F9Xs6qhtZ9vSwD6iP8RSDPVUedY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qRQKNfujlkSEmnvmL3uK1183V1L0ObyZ8iXC5VUfRzNk8D5I9knA1pg7dP8Ihmprp8m4r/RK044bbpbF6OIjmdwYE17f8MQqfqshhNfUtVKoj7XuhHysrwHgCRA0iLuvyAPsKpRIurzsTUc/Wuk6LsW8Uxj3dSAL/svJIY1yG7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCu4p7sl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCu4p7sl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D43BC4CED1;
	Wed,  5 Mar 2025 14:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741186669;
	bh=di5AULKk6lSCx+o7F9Xs6qhtZ9vSwD6iP8RSDPVUedY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aCu4p7sl12gBbfGkCa8gvBm50e/GEgvGHkW6s877jOIYssvUCSbE6kcztS1Akarpd
	 1p9pLNUy5pVcSOmJ7bk+pLE3cPxHPU+1w1A+ZgYMi0OkAp2DUurqtrwHxM8zg6EZmm
	 Q6phEOnHpIYdTtfk+E0owN1LWa9GUxQg+NQGuTi6X5CK+StkiK9Gn+kLnHyWqsZYqf
	 M9kyG3kggbqs5hesHgKUM/z0XInqq4mJghSWYLDsBPoGf7iEeL89U8Fl81EVtYETCv
	 gZz/0jiv2brABAhuE/2+pQU1u/MmFAqUP1e6SeTTzwCZ53ucV22YqZPJ0QY+OMSoSE
	 nOv5WUxnlL65A==
Message-ID: <d36c93d9-4bef-401b-9897-8f0915b8c815@kernel.org>
Date: Wed, 5 Mar 2025 15:57:46 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net 0/2] mptcp: sockopt: fix missing get options
Content-Language: en-GB
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
References: <20250304-mptcp-sockopt-missing-get-v1-0-6d306d0384be@kernel.org>
 <b0451713-3b59-f867-6cad-fde71b84b291@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <b0451713-3b59-f867-6cad-fde71b84b291@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 05/03/2025 02:42, Mat Martineau wrote:
> On Tue, 4 Mar 2025, Matthieu Baerts (NGI0) wrote:
> 
>> When adding a socket option support in MPTCP, both the get and set parts
>> are supposed to be implemented.
>>
>> A few socket options had the 'set' part implemented, but not the 'get'
>> part, while everything was in place to expose it, just the last step was
>> missing. It looks like this was not intentional, and the 'get' support
>> should have been present from the beginning, hence the 'Fixes' tags.
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> Matthieu Baerts (NGI0) (2):
>>      mptcp: sockopt: fix getting IPV6_V6ONLY
>>      mptcp: sockopt: fix getting freebind & transparent
>>
>> net/mptcp/sockopt.c | 28 ++++++++++++++++++++++++++++
>> 1 file changed, 28 insertions(+)
>> ---
>> base-commit: b084c48057bbf45fbedc06d7a9d4ec417992fb1e
>> change-id: 20250303-mptcp-sockopt-missing-get-356e26dc6955
> 
> Hi Matthieu -
> 
> The series looks good to me:
> 
> Reviewed-by: Mat Martineau <martineau@kernel.org>

Thank you for the review!

Now in our tree (fixes for -net):

New patches for t/upstream-net and t/upstream:
- f5b862898d83: mptcp: sockopt: fix getting IPV6_V6ONLY
- 7e0ad93236c1: mptcp: sockopt: fix getting freebind & transparent
- Results: 74ce8fb51c46..f1d6b77be72d (export-net)
- Results: 0a1c12618a04..318c86579343 (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/585fa1467b894289fe3c3ad009b203d1de00ad9a/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/4a4388014f7c410b33a39aac85c1ca6fe1b4907d/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E16F1E4AB
	for <mptcp@lists.linux.dev>; Wed, 19 Feb 2025 18:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739990751; cv=none; b=izW1B5pIAgpOmbRhDnQsz3+/PLwbexLFZhTRp4xa0VsYgZ1dmUvH8OhNBS2kuWpY3oD9rG8rm0R8T36v8Gd5GW+GBDTXvNmXvGpWKifjTCVFI1o8LD9VWLcgDhHMACfdxC5rxPbzd5QWudblnO7CxAMw0cTEkbBcEyGI+iotTm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739990751; c=relaxed/simple;
	bh=iKf4/022pEXAJtaGLtvPA51f8yhq3IzZjZQnnQroh00=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=rEtyNfx1Y4+zMGJwDMH5RSFt/ERCFCMv0FGv7U9YP/cCM9GkeHq6tzut/lbGoD6CmrLWyASRhUfnP7aXobWE+CV6QeIjQZNmRvnVd/XB8kDkGSCVux/8jelkqcm0Wu/QK0PMMg8XzC5MNcxFmqoIHCGfQUsxCiHhMZbNLJx5tPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwM7orFf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwM7orFf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4107AC4CED1;
	Wed, 19 Feb 2025 18:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739990750;
	bh=iKf4/022pEXAJtaGLtvPA51f8yhq3IzZjZQnnQroh00=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=bwM7orFfvDfHWNGFOYjyEV+peADHm2iF6B3HS/1iV9OtcpQLRuY+LrDXma2aogtsI
	 gzl0lAqKfzPVXaZE/oICH5+mamkRc1uezplXEjs4ECbCukTJ/jtQy7U+95TCDivRQh
	 lwQB8TILpimxZyLi62AIME3sTpLc4xeXgNsX5cRpF9iYmqXwTUxChB9lx8AviwLxD9
	 NSLINb2SCiNSmmXbvHw0Nr9jnTQkyyFlVBXAqsuT9GCb5P2TnHZn5Zbc60z/xpZ7pq
	 tCb0vuiYWQSfOMZViqJ1YLDCNODwlB5EPx6dpr117vZ8PG8JCeEHdS+x4uop3AzDIR
	 UwPIetwUQYAWQ==
Message-ID: <869fa1f5-3617-44e9-bbd2-617aed8e9a7f@kernel.org>
Date: Wed, 19 Feb 2025 19:45:48 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net] mptcp: always handle address removal under msk
 socket lock
Content-Language: en-GB
From: Matthieu Baerts <matttbe@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <61cded134e753976259b48a4269f203dcae6c8fa.1739969092.git.pabeni@redhat.com>
 <a103802c-90e2-4cda-86a4-6bde5bb28670@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <a103802c-90e2-4cda-86a4-6bde5bb28670@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 19/02/2025 18:45, Matthieu Baerts wrote:
> Hi Paolo,
> 
> On 19/02/2025 13:45, Paolo Abeni wrote:
>> Syzkaller reported a lockdep splat in the PM control path:
> 
> (...)
> 
>> Indeed the PM can try to send a RM_ADDR over a msk without acquiring
>> first the msk socket lock.
>>
>> The bugged code-path comes from an early optimization: when there
>> are no subflows, the PM should (usually) not send RM_ADDR
>> notifications.
>>
>> The above statement is incorrect, as without locks another process
>> could concurrent create a new subflow and cause the RM_ADDR generation.
>>
>> Additionally the supposed optimization is not very effective even
>> performance-wise, as most mptcp sockets should have at least one
>> subflow: the MPC one.
> Thank you for having looked at this!
> 
> By chance, do you know how syzkaller managed to interact with an MPTCP
> socket not having any attached subflows? An msk being destroyed?
> 
> Just to know if there are specific cases we need to pay attention to in
> the future :)

(This question was obviously not blocking this patch, so I just applied it)

Now in our tree (fixes for -net):

New patches for t/upstream-net and t/upstream:
- c02a912d7eee: mptcp: always handle address removal under msk socket lock
- Results: aba580cd4fc8..eb57543e795e (export-net)
- Results: 3ee8e45b1642..98f1e7131283 (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/0098419fb05cdbc73ffd9855dc2db613f79366ea/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/d29ae41108d2ac0ae39cd5fe27da1898e826833f/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


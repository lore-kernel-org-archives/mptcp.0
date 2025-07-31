Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1C8F4FA
	for <mptcp@lists.linux.dev>; Thu, 31 Jul 2025 09:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753954402; cv=none; b=gzofDVipT8UFkrAlsg8tcSIajn2co+ZPl5Lxi4b5NA1lKyUctA8tNj5/Amd3mSnZ3WQBrfCpB02gD28Jwf6riUKkxpJfEdmPKQbHMroH3VnNQZMFEMYeG8VAIsZfVWD9xHpxEbmDt5QR86WwVmv5JVzb9sa5ZtcdJZ3DW6K+df8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753954402; c=relaxed/simple;
	bh=o8WwYnC31MBA7tm6FBSsW3cZmj3FKK0BzB0PPq/5qWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=isb0Z9Pv2FAJsdMHengaTn4mSHACWp1pHmuIopUoLgiYARPvm+gltqVcnrLwWGYXbBtPeODIpVwCFaqdXatYsn3gbn8UPkAOg47tbhIkGTfFJurJBllTpVplUYqZxSC81R7Twj5lzVX8Xd7YKh2y0WYdnhbcoQoM5iIKFqMsemY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbS/sH6q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbS/sH6q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 356F1C4CEEF;
	Thu, 31 Jul 2025 09:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753954401;
	bh=o8WwYnC31MBA7tm6FBSsW3cZmj3FKK0BzB0PPq/5qWY=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=bbS/sH6qy2+OTYeHWdhCR9PmCnhLhTv5f4miM7KVpM1khQblqEQ6vA9QxBT47KcYY
	 24zywo2ova/CHkPBLwmiIgtoSaS09pZE2+Mb945L9kKdEtCLeLKGZS4THR1qdBH6PL
	 0BgyeudEpO9HXzpiquGw/n+smP0p1mqihwU5Cd3E+xjEVWt41GeBsbw+dTs8ekQQEK
	 PzChDN12wjaaundnQ+p9QsIKthYr/46AIjvjl8+ekobp1Fnaj6p5lyjYfaRv95CQR2
	 S4Raspyk0tzCCRJs5tFdUD90Hp6S9UFU9sntOWExHTR+EGqG/0eC+fLfhfw3DQcRaV
	 0e+pJ6l8pLSyQ==
Message-ID: <f92c4481-1f5b-4475-8c5e-a5c0a6a807a6@kernel.org>
Date: Thu, 31 Jul 2025 11:33:19 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 0/7] Add MPTCP support to Java Networking API
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>
References: <cover.1753247666.git.geliang@kernel.org>
 <0e6a7026-e1cf-43b1-9ed3-829abe78a69b@kernel.org>
 <411af696051518c1ef0a6a918626491a1fdc807d.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <411af696051518c1ef0a6a918626491a1fdc807d.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 31/07/2025 09:49, Geliang Tang wrote:
> Hi Matt,
> 
> On Thu, 2025-07-31 at 00:03 +0200, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 23/07/2025 07:16, Geliang Tang wrote:
>>> The Multipath TCP (MPTCP) protocol (v1 / RFC 8684) has been added
>>> in
>>> the upstream Linux kernel since v5.6.
>>>
>>> This patch series introduces comprehensive Multipath TCP (MPTCP)
>>> support
>>> to the Java Networking API, enabling applications to leverage
>>> MPTCP's
>>> capabilities for improved reliability and throughput.
>>
>> Thank you for having looked at that.
>>
>>> The implementation provides:
>>> 1. Core infrastructure for MPTCP socket creation (Patch 1)
>>> 2. Server and client socket creation APIs (Patches 2-3)
>>> 3. Integration with NIO socket implementation (Patch 4)
>>> 4. High-level Socket and ServerSocket support (Patches 5-6)
>>> 5. Comprehensive test cases (Patch 7)
>>>
>>> Key features:
>>> - Backward compatible API extensions
>>> - Platform-independent implementation
>>> - Explicit MPTCP enablement through new constructors
>>> - Full integration with existing socket functionality
>>> - Test coverage for basic MPTCP operations
>>>
>>> The changes maintain all existing functionality while adding MPTCP
>>> capabilities. When MPTCP is not enabled or not supported by the
>>> system, the
>>> implementation gracefully falls back to regular TCP behavior.
>>
>> I don't think it is the case: if the system doesn't support it, an
>> error
>> will be returned.
>>
>> If the other host doesn't support it or didn't request it, a fallback
>> will be done.
>>
>> Also, don't hesitate to share a link to https://mptcp.dev to help
>> reviewers understanding what MPTCP is.
>>
>>> This work enables Java applications to benefit from MPTCP's
>>> capabilities:
>>> - Seamless handover between network interfaces
>>> - Aggregated bandwidth from multiple paths
>>> - Improved resilience to network failures
>>>
>>> The implementation has been tested on Linux systems with MPTCP
>>> kernel
>>> support enabled.
>>>
>>> https://github.com/openjdk/jdk
>> I have a few comments, but I don't know the project, and I didn't
>> code
>> in Java for a while. Then, feel free to send this version or an
>> updated
>> one to the Java Net maintainers (not sure how, but I'm sure you will
>> figure out :) ). Do not hesitate to share the link here.
> 
> How about I submit a pull request to openjdk?

I don't think that is that simple... Apparently you need to sign the
OCA, create a bug report, then later on, send a PR:

  https://openjdk.org/guide/#i-have-a-patch-what-do-i-do

Not that easy to contribute...

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


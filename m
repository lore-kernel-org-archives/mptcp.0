Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D749338836A
	for <mptcp@lists.linux.dev>; Mon, 20 Apr 2026 21:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776719472; cv=none; b=PjRlqnlv8a7C34tvqU9vcuPWHT+/XwTu1GmeNUOjOWff546n+I7YBM7i4dBu8CAEIYQpcsJ3lQSQXHqSYRCL5eyRivFCDW+1XCXsDzDojlKRe/37CYNwnXukCU7YPkBTJDEb/JuSYsHmECtwMn5BzUqJeFQkqnvpzpHgRAjhl7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776719472; c=relaxed/simple;
	bh=ZwHTD1/by1Sicfodn6XlnXWa0io9XPm3FjIhWtZ82Mw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LmAxm5y7qjUFvhrOKsoRFbPRBjfmDvEtEmZ9dnbZfpKgI11LmXpq/dW6FAdT3ntGFrBJKcfsxzO2yV0vK0NAJRoHURAjzP4OFye0LHddnoIXDv8kzGKRGCqVVx7erQvO1lbZMfKtgASfjZIVDXHFuBTBy8zCujA/l/fIIMjOiLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6ZFWNu6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6ZFWNu6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76186C2BCB0;
	Mon, 20 Apr 2026 21:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776719472;
	bh=ZwHTD1/by1Sicfodn6XlnXWa0io9XPm3FjIhWtZ82Mw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=O6ZFWNu6EysTIa+rD+q9RrKuRIkLorfAH7QOUMWKZtnUoPVifYkVbCOtrlfuCyOVg
	 iIRrPk3amSVCYcAC5Ztr8jMQXjKlAaXM9Q+aPlu8LMl2BVaWlMBiAZfxVK5RZQkOXr
	 YNnrIgvfTy9Hyeggykt+9dY9ZOH/J6OSs50rzo8uO2hsBDgsy/9Ar5bWEzSSMfoihd
	 ZV29fmQLR6Tjb3wRkBxOuZrNdqo13e63cSqPqlHzt6vkuE+0IN4dRho9m0fnZ77PNO
	 smnQrd0PUggUPTtDZDnaUfr0o/+B11rsHC6m8lGfsshUgI7hFT6w2OevM2PCtJoYhR
	 /MbLzcMR8NCKQ==
Date: Mon, 20 Apr 2026 14:11:11 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
cc: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-net v5 17/20] selftests: mptcp: join: validate 8x8
 subflows
In-Reply-To: <d3b5d201-4e4c-4857-bbb2-5ce3ea265e63@kernel.org>
Message-ID: <2cf999c0-8f66-39fb-8fef-fc26dbaa5ca2@kernel.org>
References: <20260415-mptcp-inc-limits-v5-0-e54c3bf80e4e@kernel.org> <20260415-mptcp-inc-limits-v5-17-e54c3bf80e4e@kernel.org> <54880733-bd55-a589-20bd-3806585c6e14@kernel.org> <d3b5d201-4e4c-4857-bbb2-5ce3ea265e63@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 20 Apr 2026, Matthieu Baerts wrote:

> Hi Mat,
>
> On 18/04/2026 20:22, Mat Martineau wrote:
>> On Wed, 15 Apr 2026, Matthieu Baerts (NGI0) wrote:
>>
>>> The limits have been recently increased, it is required to validate that
>>> having 64 subflows is allowed.
>>>
>>> Here, both the client and the server have 8 network interfaces. The
>>> server has 8 endpoints marked as 'signal' to announce all its v4
>>> addresses. The client also has 8 endpoints, but marked as 'subflow' and
>>> 'fullmesh' in order to create 8 subflows to each address announced by
>>> the server. This means 63 additional subflows will be created after the
>>> initial one.
>>>
>>> If it is not possible to increase the limits to 64, it means an older
>>> kernel version is being used, and the test is skipped.
>>>
>>
>> Does this have much of an impact on total time for the tests? Would it
>> be worthwhile to test the larger limits on kernels that can handle it,
>> and run the existing tests on older kernels?
>>
>> In other words, the larger limit test seems to have redundant coverage
>> with some older tests, so maybe skip the redundant tests on new kernels.
>
> Good point. In terms of time, like most tests there, it waits for the
> whole transfer, so the same time as other 'speed=slow' tests.
>
> Surprisingly, we didn't have similar tests before setting multiple
> 'signal' endpoints on the server side, and multiple 'subflow + fullmesh'
> on the client side. It was either one or the other. Plus we didn't check
> with subflows up the previous limit (8), it was max 5. So no redundancy
> here, I think. Or we disable the simple ones focussing on the client and
> server side separately? (but then it no longer validates that on older
> kernels)

My concern was mostly the runtime of the tests. It sounds like the 
redundancy (if any) is with some simple tests that probably don't take 
long, so it's not worth complicating the test logic and having "only for 
old kernel" tests that would be at greater risk of getting stale. So, no 
need to change this patch.

- Mat


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6F13FB1C
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 10:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708079441; cv=none; b=Oa2GHG6yp3wQiL6k4K4sRoaRjCvaNWQwIewsuNz6YK2qdof8aAfibq+7nbQOe87BuNK85EAjlomEg4FOF18xNPxBGLTOLvMzAeUVxqVSpNWmGLCIgKR5zO8oyr0sTXDpdO8Ka4IO2OpDIfcLt9gbmlpCkHqOpGXXJBWBaXhsyMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708079441; c=relaxed/simple;
	bh=eHikEwXyzhAleTxVy8GG+RWkmSDIxlh0luDOSZdh168=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ei1L3hacsgketfGJStnEUS5XJer9M5UdTZRvywBGTHZEpI8X/mASu1cCzJV5hP7Jolr8etEs7SkFxuLQr1BCDgzbKP1nmf51uaAXaSkJ2io9R1X6mVfJAPG+RSzyWS8bQWwYq5AZBKSv342mvQbfJBPfxMZihmYVg5PZQyKk63I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byt7Ld7q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byt7Ld7q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71173C433F1;
	Fri, 16 Feb 2024 10:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708079441;
	bh=eHikEwXyzhAleTxVy8GG+RWkmSDIxlh0luDOSZdh168=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=byt7Ld7qehHQ572BYezrPxi1oUMBfZaSgCtl5Q3EOWUgP/EhH1cc1xcVQsLw8RwlH
	 t7oQpiJlhG9pgKAAEqDf7kN0PIhaV8rwTLoKeWLllRiaXfBp44esUG9Nq6Gx2jEDkL
	 v24MLnHidF+pLb/qH7fCvr8aWh+Qon78WE9tPMykmOuLW3cLR33RcPddfh1YzgJQ1T
	 Ag9tEYQune5FEAFg8/ki6ukqL4Zxn5leAiAScjMCd9qwJdPlsy1a1esPVCMLYjfYrF
	 dIrF2eeiBz7c8Uh9rVx31STIhOv00ddKxEES5bBk9RMLaI4z9TyvdWwfHG8hmQCx5C
	 8QCA6tHXtwG5w==
Message-ID: <81ba80af-b387-49e1-b720-92cb750e98ec@kernel.org>
Date: Fri, 16 Feb 2024 11:30:38 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v12 10/15] selftests: mptcp: dump userspace
 addrs list
Content-Language: en-GB, fr-BE
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1707910454.git.tanggeliang@kylinos.cn>
 <2acb96d2ed25df7fce8bfc0241dc920678510542.1707910454.git.tanggeliang@kylinos.cn>
 <3478f286-365b-1bb3-1f9f-9b6611888888@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <3478f286-365b-1bb3-1f9f-9b6611888888@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat, Geliang,

On 15/02/2024 23:57, Mat Martineau wrote:
> On Wed, 14 Feb 2024, Geliang Tang wrote:
> 
>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>
>> This patch adds two new tests for userspace pm dump address and subflow.
>> Use userspace_pm_add_addr() and userspace_pm_add_sf() to add an address
>> and a suflow.
>>
> 
> Hi Geliang -
> 
> The kernel code looks good to me, but I realized the selftests need some
> changes.
> 
> In order to run the new tests with old kernels (without userspace dump
> address support), mptcp_lib_kallsyms_has checks are needed so the new
> functionality is skipped on old kernels (right Matthieu?).

Good point!

I didn't check what can be done, but yes, something needs to be done:
looking for a counter, a symbol, the output of a command, etc.

> Also, since our tests already take a long time to run, could the
> userspace dump addrs checks be integrated with an existing test like
> "userspace pm add & remove address"?

Good idea! (maybe even more tests doing the same actions, but checking
different things, could be merged with a new title)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

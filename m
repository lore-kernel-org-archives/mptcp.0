Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FFC1798C
	for <mptcp@lists.linux.dev>; Fri, 10 May 2024 17:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715361147; cv=none; b=ObL9YaG6Qjbta8O17S0NqoEa0wzTM/kLkoRMKTsKeisTbBFnQOk1hkUUSnXzGDbCLjgsfsht4r+CVs7/x6Grti5McLKdgnpo8Ywz8TODfjjjZk0Rnom0FHITKLGOR2lf5FcHPmNte/R40IYxp0KayBl66abWvlkzxMjxpQFiGok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715361147; c=relaxed/simple;
	bh=h/7fh1yhn7w9Wrx3lOu2LwI0z1V4146YQs0sd4sGDBg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RQcQoqTGStbadFV0gGr/M+G4mi8GduNew0yUs2qq1hHidpg94+eEoVCGAzkBZtV3jKBkieD56buyBjQhrLzwDD4yL1caD+Ka1q6bNEzVFhBVB8iRrW5b91fRwqHfiU8Vn7W7W3kqXt6LfxkIY4FrQwpO9BTTypQjvQFiEIN2v7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJ93WSS/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJ93WSS/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05968C113CC;
	Fri, 10 May 2024 17:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715361147;
	bh=h/7fh1yhn7w9Wrx3lOu2LwI0z1V4146YQs0sd4sGDBg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=jJ93WSS/Vyvg8tHpd4IKSBLKDMfO4WiGKRzGfz2n0DXTFnTuehh9HsPwMYSpzYYXJ
	 Qt8IO4lD6jmNm1jARyjajF8sL6EH1OI8LcrLx1Yxke2sjCIZhXUjnvCV2kCh+jrJ8n
	 ueseFpBwFQihE1rWh+SLKhbIHEc7BQO0NHMnnqo06NUAozhlrShHbia4M0S5ufU4Z9
	 zxq9cWDKVWHHzg14Ek1ABF28Lq3I+6fOEHUtchPqybDDz3VZRv/8ZlTfv9bfy4iRDb
	 Jdx7Cqh+6Xv2b0+hO6d9maZXPIgWSBWJuXGmyqjHQxYA1VOEUyIfwkbDYM2bjxkzIF
	 ELTJc9fmy7Jgg==
Date: Fri, 10 May 2024 10:12:26 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
cc: mptcp@lists.linux.dev, Davide Caratti <dcaratti@redhat.com>, 
    Paolo Abeni <pabeni@redhat.com>
Subject: Re: MPTCP selftest failures on Fedora 40
In-Reply-To: <77dc9ea1-02b2-45c3-9fb6-8b153285dcfa@kernel.org>
Message-ID: <0bdddb31-dff1-524b-d56d-53caf75360f5@kernel.org>
References: <5464ef10-4c64-17da-7cd3-c819af2fa837@kernel.org> <77dc9ea1-02b2-45c3-9fb6-8b153285dcfa@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 9 May 2024, Matthieu Baerts wrote:

> Hi Mat,
>
> 9 May 2024 22:17:11 Mat Martineau <martineau@kernel.org>:
>
>>
>> Just a heads-up, Fedora 40 shipped with a broken 'ss' command which causes MPTCP self test failures.
>>
>> In short, the "-i" flag is ignored by the 'ss' command. I've filed a Fedora bug:
>>
>> https://bugzilla.redhat.com/show_bug.cgi?id=2279920
>
> Thank you for the heads-up.
>
> On Debian side, they ended up taking the fix, not the revert:
>
> https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/misc/ss.c?id=87d804ca0854b09c07872e9fd6036bf5d3e0cc85
>
> https://salsa.debian.org/kernel-team/iproute2/-/commit/14cfd95e598ba712c9000a5212f57c8282223c19
>
> Maybe better to suggest to take this fix instead of the revert?

Matthieu -

I'm glad our CI was 4 months ahead of me in catching this, and you 
expertly fixed it way back in January :)


- Mat

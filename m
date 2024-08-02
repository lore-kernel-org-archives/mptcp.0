Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0C81AE029
	for <mptcp@lists.linux.dev>; Fri,  2 Aug 2024 18:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722622689; cv=none; b=TBIJHbewWuqBaHQcU5C4gHy0X7e6vnFiK6kEoM7A3VrE6iz+aWHRgM0frOMKozLucAdQvolsyk7tL+zBWnCw32tudn+Fz0mDdNTm78aYeq+HD7Pt4rBv5DmYhYy3MPIzP5oQespfBU+zIAfAsW/2jdIBE/2uAgSpvpUC4oN3alM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722622689; c=relaxed/simple;
	bh=96JOsPjOid/UUHhvY8Dn5IGF+FXi6xXk0u+Zyj48ZQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=km1dtiCnSGk4e5HgPGYsDx48VbqgQyNBgpvlfwOycznDsVb/D5GWmVLWJ32glwSMVVPKM9F41ZXyEbrFUstefZCxBPhFAS0nlU25XehYHmA8A7PG+aeR76/ulMLHqoWp2OuJFuwPdQMHt397QLwK/qfbfrMS3o35U+1YViY4R00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZyJnp93; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZyJnp93"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87BD2C32782;
	Fri,  2 Aug 2024 18:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722622689;
	bh=96JOsPjOid/UUHhvY8Dn5IGF+FXi6xXk0u+Zyj48ZQE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tZyJnp93kRbf8UHqKfyIYhQfLeVTPwLZkL9ie4bRNucJ3UYt348/JaQk09BCGt+53
	 fM6MpVsfmksUleWuEgaIzA3XzsVFciuL9c/qiXfesE5wYtFNE8UMTQCdWpJdAUENCX
	 fKgQNHpYwsEkUxvZ+rsblyJhncIeg0JrRIli5Rbw99Ze1KBv+0vUpUewIInODrtJyP
	 vbrqB4TegzyrWnr4WgbQyyCvTHJmXSyVfWFdOCsgI0XBS0IXcMBJOKD2ApfnePqfEB
	 a0JQTu0AVtcxt5IoDEd1IC1fD7E+GjacYqqnq0VlJbzp3Z2eXn50IECV0QRO2x+fCf
	 JIugR8CIdXphQ==
Message-ID: <5a2ddf91-e810-4433-b333-972967ef5f2b@kernel.org>
Date: Fri, 2 Aug 2024 20:18:05 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net] selftests: net: lib: kill PIDs before del netns
Content-Language: en-GB
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
References: <20240802-selftests-net-lib-cleanup-kill-v1-1-66220a8b6911@kernel.org>
 <6806450e-7c7b-8072-0af9-23bac214ec0b@kernel.org>
 <CABbSpciZfzrTdgQAp9fpKN5EPn7QdRXMCgBoipDQ6EF_u3eWzg@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CABbSpciZfzrTdgQAp9fpKN5EPn7QdRXMCgBoipDQ6EF_u3eWzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 02/08/2024 19:52, Mat Martineau wrote:
> On Fri, Aug 2, 2024 at 10:43 AM Mat Martineau <martineau@kernel.org> wrote:
>>
>> On Fri, 2 Aug 2024, Matthieu Baerts (NGI0) wrote:
>>
>>> When deleting netns, it is possible to still have some tasks running,
>>> e.g. background tasks like tcpdump running in the background, not
>>> stopped because the test has been interrupted.
>>>
>>> Before deleting the netns, it is then safer to kill all attached PIDs,
>>> if any. That should reduce some noises after the end of some tests, and
>>> help with the debugging of some issues. That's why this modification is
>>> seen as a "fix".
>>>
>>> Fixes: 25ae948b4478 ("selftests/net: add lib.sh")
>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>> ---
>>> tools/testing/selftests/net/lib.sh | 1 +
>>> 1 file changed, 1 insertion(+)
>>>
>>
>> Sounds like a good idea to me:
>>
>> Reviewed-by: Mat Martineau <martineau@kernel.org>
> 
> Oops, it's in the net/ lib, not net/mptcp! I should have said:
> 
> Acked-by: Mat Martineau <martineau@kernel.org>

Thank you for the review!

Now in our tree:

New patches for t/upstream-net and t/upstream:
- 8ebb566eeb44: selftests: net: lib: kill PIDs before del netns
- Results: 4636b17d0a66..35242dba0f3b (export-net)
- Results: 3b0e1975962a..2b058d91b960 (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/37ea6923481f76518c4ec25ce70981cc77a5dfca/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/5faa935e1c80da7b646c37ff0ea876778b8c984a/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111B11CD215
	for <mptcp@lists.linux.dev>; Fri, 11 Jul 2025 10:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752228269; cv=none; b=L2292d05/0oUMDlaEMhM7q98pcIQiTe8f9M8N6WBaush+sIqwH7KHcvyoK/h+J4DeLy5kia7Gsyf2euY7Ojz+OjQdUW9Jf11wpJBiVJAOjsrWL5nN5Ml+bW6icechZY/7AWtbFXhwmkMr2wUiXyCCVn8BL0iFN/jy24WOwcwX1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752228269; c=relaxed/simple;
	bh=q4VslJNivTv/hdjdRTkDybf7KXsIZSU9Igqrz6XtSMI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=IY9z5uJUfxBD0LPuyP0eY7UsDf9sdVk/9Rqx5z1uFJCve4vsLaoWfoW+catWPadQiI3qDKPvxO63BGoE8p4xIBfdkUpr1zx844+17JFJT1VTN58LYUvTCy06RyrdRTbN8su/hUumL4HGJGFzem0WwAdZMXjPkKILsnS8jG8SVzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6RG2eeF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6RG2eeF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1426AC4CEED;
	Fri, 11 Jul 2025 10:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752228268;
	bh=q4VslJNivTv/hdjdRTkDybf7KXsIZSU9Igqrz6XtSMI=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=T6RG2eeFe1mCQRY+74D053XAmHzXFGTlJ3O6Sr6T6BJAyG37U5wBR7Gh6a1ZBEHYM
	 +JSaMRNPedPSORUUYqER39djs4d/S3CbxT62tmXl2NmH4Sg0fNyog9xjXB6IZweKxm
	 /ntzyvP+xBnT7VLqLAKZ3xWZAxPQy7OP5pxNgzEFozi6HNXiaLj54rk8ywlZ/ZJ1wy
	 spEDMG8jxtYYWcoCBxLyxLvlNDx1zfg4YgcyWNIi27+X0MpeHHyx/q9hWXk4PaaPXf
	 Ja26zSr7k7d++YHJDYEm67uAHs4AMxvkEmMkE4ALw9ZF/3o1KwnlAwzIB+ykagbEGo
	 uACgw/tYXZGqQ==
Message-ID: <954ef380-7eb4-4801-9914-45606aa737b5@kernel.org>
Date: Fri, 11 Jul 2025 12:04:26 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v4 mptcp-net 0/5] mptcp: fix fallback-related races
Content-Language: en-GB, fr-BE
From: Matthieu Baerts <matttbe@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1752221786.git.pabeni@redhat.com>
 <697f6cb1-1783-4b1c-8d76-75aad0faf8b2@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <697f6cb1-1783-4b1c-8d76-75aad0faf8b2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/07/2025 11:36, Matthieu Baerts wrote:
> Hi Paolo,
> 
> On 11/07/2025 11:29, Paolo Abeni wrote:
>> This series contains 3 fixes somewhat related to various races we have
>> while handling fallback and 2 small follow-up likely more suited for
>> net-next.
>>
>> The root cause of the issues addressed here is that the check for
>> "we can fallback to tcp now" and the related action are not atomic. That
>> also applies to fallback due to MP_FAIL - where the window race is even
>> wider.
>>
>> Address the issue introducing an additional spinlock to bundle together
>> all the relevant events, as per patch 1 and 2.
>>
>> Note that mptcp_disconnect() unconditionally
>> clears the fallback status (zeroing msk->flags) but don't tuch the
>> `allows_infinite_fallback` flag. Such issue is addressed in patch 3.
>>
>> Patch 4 cleans up a bit the fallback code, introducing specific MIB for
>> each FB reason, and patch 5 drops the, hopefully now redundant
>> pr_fallback().
>> ---
>> v3 -> v4:
>>  - fic MIB exposed names
> 
> Thank you for the new version, it looks good to me!
> 
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> I can apply this series, restart syzkaller on top of it, and send
> patches 1-3 on Monday if everything is OK. WDYT?

I just applied them in our tree, I will now restart syzkaller. On
Monday, I will send them upstream if there are no objections.

New patches for t/upstream-net and t/upstream:
- 158a4c639b9b: mptcp: make fallback action and fallback decision atomic
- afbefa78d049: mptcp: plug races between subflow fail and subflow creation
- a741374bcb64: mptcp: reset fallback status gracefully at disconnect() time
- Results: 46fddb9ffaee..67147340a318 (export-net)
- Results: ac3befbcaa5b..65264ae05855 (export)

New patches for t/upstream:
- 54d5646bfb71: mptcp: track fallbacks accurately via mibs
- 58f3909466f6: mptcp: remove pr_fallback()
- Results: 65264ae05855..712a5aad742a (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/f5d6eefb3351a27f96c3d62119772169e4be6552/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/455f606172fae38e46b6bc4b5aa6ee1e5564f0ad/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


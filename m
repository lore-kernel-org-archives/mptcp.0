Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0514776C6C
	for <mptcp@lists.linux.dev>; Tue, 20 Feb 2024 17:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708451310; cv=none; b=seVAL1o7Wg9pmNW3jm7bZKuigU7epZ7AuCwU/f4AkXDzbK+PXXUyHJl0W4j/Is1sXDWZWPIppMenSkOF8et0K8cadgFqFrphOUyDlJDBwT7ybMOc1RYt9GPWEWc+jou7bfbMBmUc3KU0QgB22ZB6rCit/bXGjKzxWWbFqfLKGA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708451310; c=relaxed/simple;
	bh=jRZDxJMH8Q/wOffAYCgW6RuRFLeUaKj1ujVYsmGIctw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tZwVnTFTe3qxEQHrHaLMX8PEnWOV8qOoR/g0f4nFwB+1l/ipeMf10mDAvGRjc9psC4nm7RE3yC9e2gN0qCdoXTNMTXpdPDYYYHXgeBzb2RuAAbPEXTRWalkqn/2XRcpFq+oDMTSMoimytGzHb/sbfERWyKrga6fkTHERigv5zRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fO4d/Vt/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fO4d/Vt/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D12C433F1;
	Tue, 20 Feb 2024 17:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708451309;
	bh=jRZDxJMH8Q/wOffAYCgW6RuRFLeUaKj1ujVYsmGIctw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=fO4d/Vt/CqMIR9/SBo5WKSqIMQSff+z/gu9z8AwmAwVPL7QY0yIeJx1j8T/J4hw59
	 tHXbEyE2BfDogBxzMw4ZkP5UNQvYHlZfKItEJJut7q1BuX6ZUX1B6PKRm+i+UVHXdZ
	 xtXxpZRLRlqgJ84EfF0xaaOSBVnT86FC7gLpp1AFLlH3ra6Bl48QBdsQvWxAhBDGaj
	 a8/hsCZLWNORoC8ZB5Y8n/kQQjCNCOCCapMHqwJcT9VSTHAjpqkDHg0nOKDzqsREIF
	 tUDRW888QBuc7dccvBnO0Xipmacbe1vSP5E7fICJkC/em/e3WvAj2rDn5G21neWDkB
	 NMIo+809dQp6Q==
Date: Tue, 20 Feb 2024 09:48:28 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
cc: Geliang Tang <geliang@kernel.org>, Geliang Tang <tanggeliang@kylinos.cn>, 
    mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v14 00/14] dump for userspace pm
In-Reply-To: <2f34c7fd-ae40-40a3-ad44-39a5ce226a85@kernel.org>
Message-ID: <83ed6927-ab2f-474d-d9e8-0cc3c9cbbdff@kernel.org>
References: <cover.1708422758.git.tanggeliang@kylinos.cn> <682134fb-8893-4ee0-9ddd-c0a4a4f5650b@kernel.org> <2f34c7fd-ae40-40a3-ad44-39a5ce226a85@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 20 Feb 2024, Matthieu Baerts wrote:

> Hi Geliang, Mat,
>
> On 20/02/2024 12:50 pm, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 20/02/2024 10:58, Geliang Tang wrote:
>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>
>>> v14:
>>>  - address Matt's comments in v13.
>>
>> Thank you for the new version!
>>
>> I didn't look at it yet, but:
>>
>>>  - I have to use these lines in patch #8:
>>>
>>>       local cmd_ret=0
>>>       local out=$(${cmd} 2>${err}) || cmd_ret=${?}
>>>
>>>    The following expected code breaks pm_netlink.sh, I don't know why:
>>>
>>>       local out cmd_ret=0
>>>       out=$(${cmd} 2>${err}) || cmd_ret=${?}
>>>
>>>    If this is still a problem, I'll send a squash-to patch to fix it.
>>
>> Yes, we should either fix warnings or explicitly mark the false positive
>> ones as ignored.
>>
>> Can you try with the attached patch please? It is not clear to me why
>> the second block doesn't do the same as the first one.
>>
>> I can squash it when applying the series if there are no other comments.
>
> There are no other comments from me, thanks for the v14.
>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
> @Geliang: OK for you if I squash the suggested patch?
>
> @Mat: still OK for you with this v14? There are only modifications in
> the selftests (patches 8, 9 and 14) except a small change in patch 5.
>

Yes, v14 looks good, my tag still applies:

Reviewed-by: Mat Martineau <martineau@kernel.org>

Thanks for your review Matthieu!


- Mat


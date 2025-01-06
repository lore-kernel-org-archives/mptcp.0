Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A0A1D959E
	for <mptcp@lists.linux.dev>; Mon,  6 Jan 2025 10:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736157667; cv=none; b=ZxGLyb1u+1V0bQyBrU5+ThaU6g/drfAFGau0+v8fmEtLnr1nhTm77zPzKVNefRjLxzVGQdZaRRuw6xdOgqgZHu2RQ+mB5I4fh3+c+VncvNu+ZCG7vMDTEbie8XgRVrfvyfYGkqAobY7z+6JGK9E2b3JJFixJuLrDAWXLEfORV7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736157667; c=relaxed/simple;
	bh=aq3/xW3CgP65Fuvh6mKpeulqo2U4FfS0sXNRSfdotUc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WxVXxA+AkDHz8O8e+fUty/GuVFTqzYJ/s3zsvDZhjj8Ovm5IqLvOLO5O+es+4KM0158kd3ZrJtwwlegv50eeoSmlfDg0BrZckEQ0iMu8+VpRHv2pUP/9ov7vpCMvE91CFBtFAEWMySKjc6W+TPIIh3PzCgfNjvMqIiegu0oaNz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ExVyvb73; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ExVyvb73"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED403C4CED2;
	Mon,  6 Jan 2025 10:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736157666;
	bh=aq3/xW3CgP65Fuvh6mKpeulqo2U4FfS0sXNRSfdotUc=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=ExVyvb73FQhchs82tKVERx9aM3kn7yzT7JkP9tZiYRg21r0DLFn+3zAtaxsb/rrgw
	 r4T8DaT2fAZcNqoy3jgTKx+lyBHSZme4cxA6CwxEg33b+vNm+FC57uIE0YONKj4AwP
	 7DxG7qTIFNL3qb9v0ip7QSpgVzIbiJM1VsiDktHqJXyrCaUPwZI0hSjkBKJFQ9akNV
	 41ercfVauUvlM0A7MGNgrrBm2v+8cQEqxm95VMRs5NkL2MUz2Rf25tZTwnKtUREqah
	 53ngt0EVp/Vfs1z0RG9+54KyH8dKjuApoYlKQULaYsC8qR1GQ7AGwQSr0HUW/2eXQU
	 Gr2bhI/2yKw8w==
Message-ID: <945e4bc2-92e5-4acb-8fc3-f7a7ebbe2c77@kernel.org>
Date: Mon, 6 Jan 2025 11:01:04 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v7 05/11] mptcp: add local & remote parameters
 for set_flags
Content-Language: en-GB
From: Matthieu Baerts <matttbe@kernel.org>
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1736150983.git.tanggeliang@kylinos.cn>
 <fd0daf0d017e8b60c2503ddcbda67254c57ee6e7.1736150983.git.tanggeliang@kylinos.cn>
 <9f7a607d-2553-4a8f-a694-b9c7212d46b8@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <9f7a607d-2553-4a8f-a694-b9c7212d46b8@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 06/01/2025 10:39, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 06/01/2025 09:16, Geliang Tang wrote:
>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>
>> This patch updates the interfaces set_flags to reduce repetitive code,
>> adds two more parameters 'local' and 'remote' for them. These addresses
>> are parsed in public helper mptcp_pm_nl_set_flags_doit(), then pass them
>> to mptcp_pm_nl_set_flags() and mptcp_userspace_pm_set_flags().
> 
> Because the in-kernel and userspace PM have different requirements:
> token and remote addr only for the userspace PM, search by local addr ID
> probably only for the in-kernel, etc. it might be clearer to keep them
> separated.
> 
> At the end, I think only the parsing of the local address can be done
> for both (mptcp_pm_parse_entry()). Maybe not worth it to move only this
> part? WDYT?

Just in case you drop this patch, please note that in my v6, I was also
modifying the two set_flags() helpers in different patches:

- The split without changing the behaviour in "mptcp: pm: more precise
error messages"
- Keeping "mptcp: pm: userspace: flags: clearer msg if no remote addr"
- Using NL_SET_ERR_MSG_ATTR() in "mptcp: pm: use NL_SET_ERR_MSG_ATTR
when possible"
- "missing address ID" message in "mptcp: pm: improve error messages"
- Adding GENL_REQ_ATTR_CHECK() in "mptcp: pm: mark missing address
attributes"

Make sure to compare your future v8 with the v6 ;)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


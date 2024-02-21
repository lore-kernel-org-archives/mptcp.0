Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CCC4122C
	for <mptcp@lists.linux.dev>; Wed, 21 Feb 2024 11:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708515965; cv=none; b=UfmQaRxqBL0n3nvi+tRKpXJkefIoCbeF9i+jB5aMcPILNbIga229NTpMrW+WSgEbTT0VpUaEzIggTR67aesXIqkfo2tqAVdUu5Q4daQZm88v0/R9XjSizSd7LzYZxkLzSw890uJI3ca3cetf7jSmTSke5MWawOySuNbAl/OCZkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708515965; c=relaxed/simple;
	bh=WVHMUOGXvSPJKuQpQQ+gMHsp1e/lgX/Kh7Bl8W9HoIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tv7r7d516tusBFCH5LsZQc4/MFyURqWt9tIRKd9beN8XpyMd7vQtjWdvl4Mt6cjC2Oz6HD2pbSSawoTN1tpZbeAl0b4PxWnmEhO6GTEQUGF5L4O51Kb7sVk1dvsIZrZfIJHYSGn7uJLiBOX0Ac3c7ImHbVfYnV06E/DpuY1bQTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQsC1rOY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQsC1rOY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD3AC433F1;
	Wed, 21 Feb 2024 11:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708515965;
	bh=WVHMUOGXvSPJKuQpQQ+gMHsp1e/lgX/Kh7Bl8W9HoIo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nQsC1rOY8FWyE4U4m/IUYnKMEq9dxRobWc8KeiXMXly+KeXV8jUJW5OWKbEEiEFs8
	 +BDoAZ2AMlRoMU4M/gxDzB1hlyguDtMTfVG7KIiS8PebBMnWU46ghShhegxgS71OiW
	 ndnJmhzr6npPEO/FwxUFBcVW55EISpfXHFTzlp+LCwRgPsUs1XHdUlIHTg3u3UudBv
	 /393mkchluEjiVKx3Blakg7D5tSgtlZfjeznSUelaBKIigz4CQJEapnUT2RHNH/DgV
	 xaTTfcROFTs93/K6qVfI9/JVTTQYllMf/TEg8yLzOY/PFiD7WrU/v3xBEkbO+lmi26
	 iBOtXnvAvxsxg==
Message-ID: <644e7e29-ef39-47cf-aebf-0f309caa70cc@kernel.org>
Date: Wed, 21 Feb 2024 12:46:02 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v14 00/14] dump for userspace pm
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1708422758.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <cover.1708422758.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 20/02/2024 10:58 am, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> v14:
>  - address Matt's comments in v13.
>  - I have to use these lines in patch #8:
> 
>       local cmd_ret=0
>       local out=$(${cmd} 2>${err}) || cmd_ret=${?}
> 
>    The following expected code breaks pm_netlink.sh, I don't know why:
> 
>       local out cmd_ret=0
>       out=$(${cmd} 2>${err}) || cmd_ret=${?}
> 
>    If this is still a problem, I'll send a squash-to patch to fix it.
> 
> Geliang Tang (14):
>   mptcp: export mptcp_genl_family & mptcp_nl_fill_addr
>   mptcp: implement mptcp_userspace_pm_dump_addr
>   mptcp: add token for get-addr in yaml
>   mptcp: dump addrs in userspace pm list
>   mptcp: check userspace pm flags
>   selftests: mptcp: add userspace pm subflow flag
>   selftests: mptcp: add token for dump_addr
>   selftests: mptcp: add mptcp_lib_check_output helper
>   selftests: mptcp: dump userspace addrs list
>   mptcp: add userspace_pm_lookup_addr_by_id helper
>   mptcp: implement mptcp_userspace_pm_get_addr
>   mptcp: get addr in userspace pm list
>   selftests: mptcp: add token for get_addr
>   selftests: mptcp: userspace pm get addr tests

Thank you for the new version and the reviews!

Now in our tree (feat. for next):

New patches for t/upstream:
- 7d868c62af9f: mptcp: export mptcp_genl_family & mptcp_nl_fill_addr
- 67cb691f1093: mptcp: implement mptcp_userspace_pm_dump_addr
- 60ef9f34e3d3: mptcp: add token for get-addr in yaml
- ffb2fe640112: mptcp: dump addrs in userspace pm list
- 76eac7d3c80c: mptcp: check userspace pm flags
- 409cea20942c: selftests: mptcp: add userspace pm subflow flag
- 6353432774ce: selftests: mptcp: add token for dump_addr
- d09f50cf57ae: selftests: mptcp: add mptcp_lib_check_output helper
- c6ad331dc5ab: selftests: mptcp: dump userspace addrs list
- 47038dcd3675: mptcp: add userspace_pm_lookup_addr_by_id helper
- 2a5b3503d500: mptcp: implement mptcp_userspace_pm_get_addr
- bbfcefc51c19: mptcp: get addr in userspace pm list
- 1cda2a037f12: selftests: mptcp: add token for get_addr
- d0c5cd880322: selftests: mptcp: userspace pm get addr tests
- Results: 23f1f4962d2e..bf8465c7dc96 (export)

- ae4144118862: "squashed" in "selftests: mptcp: add
mptcp_lib_check_output helper"
- Results: bf8465c7dc96..55a829ff16aa (export)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

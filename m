Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D76A191F88
	for <mptcp@lists.linux.dev>; Sat, 21 Dec 2024 10:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734777561; cv=none; b=TBKxGRAoYJnMhCMYBgympbZOXPUY3c/umPeAgvqNtkisnItnnK8yGY1v449Co194tzjnKQYx/J/jOVDtBzd93W1rYcm+WuKQrhS45blg6zKn8rNCUIMF5ipbMNX5A1Bwx1gSc48fAM3qpc4BEfETX7AYxeMO/4y64+ucBTpS+24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734777561; c=relaxed/simple;
	bh=+3sLKX5Zv5MzFVrNCfllbTz3SL7psHYttfUilZEQY6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gDqgWX//eDntSF+g2BrARCEM8BKDlB4glV2C2KRKMwLY/o1xxQ8HRRFXxbQpaSDNxbR/0jbh+4paZuBKwOMjDYqOoJ2fi6aqqk9TW3EjczTwKCknk0rYlP5mllQlQkRhWeLZS5SwzTdPdbmq0rrfz/Fbnv7A3iR2nS0Ggp3AEKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dY7uhBH3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dY7uhBH3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384B3C4CECE;
	Sat, 21 Dec 2024 10:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734777560;
	bh=+3sLKX5Zv5MzFVrNCfllbTz3SL7psHYttfUilZEQY6M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dY7uhBH30UV+hc6a0uQDpRoOcVik/ov634xvhUfK6B6kiRhnYGBDE5zSSQJAiH+tb
	 v+Sv+1z857wwMjUmdSaldHdQFobaj+JQlVgaW3XsB/Nbo6vtBA08B8+QdOU1HcDCmy
	 emX0hqYugaWgjq9jp/O1XzuMPoiWRewJpjfn3fa/4XJ+wPvh+Pp86BkDi4Z8sRppZy
	 5WTPMX6OOKeWn6eGWRvrIskEXo2MVg0T1SurhfPyfF3YzBwied+voyDQqBRpTZG0tw
	 aqbGAKG7Ewd0bXtnwj71oz8IdbjQOsAiJfDbr6Rrs2BU+dKcnRDpbpdaS+a954P5Q8
	 06nHWfWcKtCDg==
Message-ID: <c5d1e778-7989-4ed4-ac90-cf8334604cc3@kernel.org>
Date: Sat, 21 Dec 2024 11:39:18 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v3] mptcp: use GENL_REQ_ATTR_CHECK for token
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <d9c76c6c008c770046f665a4a4e93735fd121399.1734337790.git.tanggeliang@kylinos.cn>
 <93b46bed-cc91-46bc-9cc3-fff79cb3dac9@kernel.org>
 <f10fd4d16e3fe406dbac0c8dc17d37c5ab2431b6.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <f10fd4d16e3fe406dbac0c8dc17d37c5ab2431b6.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 20/12/2024 10:50, Geliang Tang wrote:
> Hi Matt,
> 
> On Mon, 2024-12-16 at 12:24 +0100, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 16/12/2024 09:31, Geliang Tang wrote:
>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>
>>> A more general way to check if MPTCP_PM_ATTR_TOKEN exists in 'info'
>>> is to use GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_TOKEN) instead of
>>> directly reading info->attrs[MPTCP_PM_ATTR_TOKEN] and then checking
>>> if it's NULL.
>>>
>>> So this patch uses GENL_REQ_ATTR_CHECK() for 'token' in 'info' in
>>> mptcp_userspace_pm_get_sock().
>>>
>>> 'Suggested-by: Jakub Kicinski <kuba@kernel.org>'
>>> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
>>> ---
>>> v3:
>>>  - use GENL_REQ_ATTR_CHECK in mptcp_userspace_pm_get_sock only
>>>  - drop GENL_SET_ERR_MSG as Matt suggested (thanks)
>>
>> Thank you for the v3. While at it, do you want to do a similar change
>> everywhere we do:
>>
>>   struct nlattr *X = info->attrs[MPTCP_PM_ATTR_Y]:
>>   if (!X) {
>>       GENL_SET_ERR_MSG(info, "missing ...");
>>       return Z;
>>   }
>>
>> e.g. in mptcp_pm_nl_announce_doit() (addr), mptcp_pm_nl_remove_doit()
>> (id), mptcp_pm_nl_subflow_create_doit() (raddr, laddr),
>> mptcp_pm_nl_subflow_destroy_doit() (raddr, laddr).
>> (and maybe mptcp_pm_parse_pm_addr_attr(), but it needs more changes
>> around to pass the attribute ID, probably best not to change that)
> 
> Thanks for this suggestion, I updated this in v4.

Thank you!

>> Also, do you know if 'pm_nl_ctl' will continue to indicate a helpful
>> message if such attribute is missing (that's a message more for
> 
> 'pm_nl_ctl' can't display nl error msg, this is a bug in nl_error():
> 
>  $ sudo ip mptcp endpoint del id 100
>  Error: address not found.
>  $ sudo ./pm_nl_ctl del 100
>  netlink error -22 (Invalid argument)
>  ./pm_nl_ctl: bailing out due to netlink error[s]
> 
> Look at this test, nl error msg "address not found" in
> mptcp_pm_nl_del_addr_doit() can be displayed in 'ip mptcp', but not in
> 'pm_nl_ctl'. I'll try to fix it.

It might help developers if pm_nl_ctl could also print errors generated
by GENL_REQ_ATTR_CHECK(), not only the ones generated with
GENL_SET_ERR_MSG().

>> userspace app dev)? Or does it need to be modified to display the
>> missing argument set by GENL_REQ_ATTR_CHECK()?
> 
> I think no need to modify this, since after GENL_REQ_ATTR_CHECK(), we
> will also call NL_SET_ERR_MSG_ATTR/GENL_SET_ERR_MSG to set nl error msg
> in the error paths.

If GENL_REQ_ATTR_CHECK() is used, it should no longer needed to use
NL_SET_ERR_MSG_ATTR/GENL_SET_ERR_MSG. I guess the userspace should be
able to find the arguments that are missing, no?

This can be done in another series of course.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


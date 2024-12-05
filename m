Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B321D516A
	for <mptcp@lists.linux.dev>; Thu,  5 Dec 2024 09:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733391514; cv=none; b=ZnljPRH4I8tcPTwudw1eGP8xjoy7UhjvSxdegl19nF4QgSt8hHrNddsKqTaqy++pkrTCVffY+kQDI+odDjhvJf+qldhsMYOP7llde8ak645uNS3KAG0zZylmntuumlEEReRDI7Oq+yaw5CFYgksUikkCR0vaVIYlH4RSG6IeULU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733391514; c=relaxed/simple;
	bh=JzaVjbKV88hM0AFWvMZ0fUkt2eTO0R08czCP+RUXl3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fWhnXbRwhxq2Ftl+zI/5yxib7Du/FMM2W7rzBlOvy9xDRUN8kKcX9BT1d2eB+uL38NVmIHhV7VRidMfRvpxC+yCq9Sb0bSnIqoqQdpFhPExcqYe7KTUKxvhqURPpwmlYyTVSDj57ZTw6NBH9FnTLTx5oKxeH1hrRpVI0gNuNgnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNE0UwJO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNE0UwJO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B9FC4CED1;
	Thu,  5 Dec 2024 09:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733391512;
	bh=JzaVjbKV88hM0AFWvMZ0fUkt2eTO0R08czCP+RUXl3E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hNE0UwJOF8/b9j8U1xfy7T9WgHo3b3RwYai+Qg9tc4QSJwJ7vWhlOgD6Pa9vG645q
	 n1g1uzcT7LqnotCwajhufgxpBulEaIZZ8cFeTYc57u3suvvqLhF8PTFmpnAje5tUK7
	 dsEgRjd94jewms4WRkPARS2sszrs2bX3BzWyODiVNoxhhk8w+9gcN/ByUOVL9T4fL7
	 EfhvNsYQBZdMtZxBWJMmUq74ZzUORd1AhpYphXIsOLTomQ/+VLkjPDPQt8uxy9LRFI
	 fYyTCTYhgWuKMDlKrvXkVxwYj5CVPzbomLrhaKycNsPOTUoCTQYXD7GwNuIYbLXNP9
	 vMKOvm8reix7Q==
Message-ID: <bacb453c-81e3-4faa-a913-2bbacb8ef66e@kernel.org>
Date: Thu, 5 Dec 2024 10:38:30 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v3 4/9] mptcp: move mptcp_pm_remove_addrs into
 pm_userspace
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1730961809.git.tanggeliang@kylinos.cn>
 <92ab4cbf71a2be676481b20c662b2f602aa346e2.1730961809.git.tanggeliang@kylinos.cn>
 <b1024055-405e-426d-a5d1-2a6b16054191@kernel.org>
 <e041dcecfe0c9080b91b49546ec29a49061e39c6.camel@kernel.org>
 <24b958fa-b61a-44c6-825a-7108792054b2@kernel.org>
 <fb3011b557dcf812a427a735ff66f8063fbd6af2.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <fb3011b557dcf812a427a735ff66f8063fbd6af2.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 05/12/2024 10:36, Geliang Tang wrote:
> On Thu, 2024-12-05 at 10:27 +0100, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 05/12/2024 08:26, Geliang Tang wrote:
>>> On Wed, 2024-12-04 at 18:48 +0100, Matthieu Baerts wrote:
>>>> On 07/11/2024 07:45, Geliang Tang wrote:
>>
>> (...)
>>
>>>>> diff --git a/net/mptcp/pm_userspace.c
>>>>> b/net/mptcp/pm_userspace.c
>>>>> index a6de837d8958..737a07f5defe 100644
>>>>> --- a/net/mptcp/pm_userspace.c
>>>>> +++ b/net/mptcp/pm_userspace.c
>>>>> @@ -286,6 +286,34 @@ static int
>>>>> mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock
>>>>> *msk,
>>>>>  	return err;
>>>>>  }
>>>>>  
>>>>> +void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct
>>>>> list_head *rm_list)
>>>>
>>>> Can it not be 'static' now that it is only used in the userspace
>>>> pm?
>>>
>>> It will be invoked in BPF path manager, 'static' doesn't work.
>>
>> OK. Hopefully people will not send a patch in between to add
>> 'static'.
> 
> I've mentioned this in the commit log of v4:
> 
> '''
> Here, mptcp_pm_remove_addrs() is not changed to a static function
> because it will be used in BPF Path Manager.
> '''

Good, thank you (I saw that after I sent my previous email).

If someone sends a patch, we can refer to this commit then.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


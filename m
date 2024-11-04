Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84B817C7C6
	for <mptcp@lists.linux.dev>; Mon,  4 Nov 2024 10:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730715372; cv=none; b=HYFMQE367ril7YoyTAofW0eIObgeKxzmFpnR3aR+45wFib5ycDMnkvyLjvHz2YxTrSPBnKx+iHnWkczmssqjdSSHxRh6So4NL/9xqP890EDQ7Eu6sRvNU96qDl+2vNbW1pbbZX/L7VpynP1fE3EOpdVZFhQVnXgjj1AI3FQHYN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730715372; c=relaxed/simple;
	bh=EY9rJTaGYigt6e27T4mFXR9iWoW8Nn5W/pAELSu4YVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T7Rx7JPSb9PVqdVrTwn7CbCIfKQ70HaNt24laFy6bL1Ski54zJyn4rB5ObV5KOeXBNxXfQnEbHTcWtwZ3NUwwqvSGh4jIpd+dYbM5OWd4fqQrqEc+MX3s06TMYBDsNB+og27UjVOam2iRiQhPlL/Ihg+xQq4EXs9RAAGEv45aUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GF9IoyVW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GF9IoyVW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D047C4CECE;
	Mon,  4 Nov 2024 10:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730715372;
	bh=EY9rJTaGYigt6e27T4mFXR9iWoW8Nn5W/pAELSu4YVg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GF9IoyVWI9HOvrjwYc3XK0dvxhfhafHKWP6W19f566U2f/Q4LHULTT2lB4/j91MUM
	 okZRpmkRoyAU7rJ26l941tkW+KLmw+2ISHYI3FREMLClUei3p6R4rnZebFs1nfaLM8
	 XPD5laQnfXvgDAoyuaDknmnZGgCgpZqfE8KeDjbLWufbduukHBLDsPE4Flyqc/yES7
	 9XQSMdHAeFZTnbE3XlU173KN/Skwes4UtSA1AOi1Ah60G/vWXM/bVn+d46ecTC0UyM
	 tGNjn+bDzSJqeIVd50F4aGKhl0jFT6Le7J1HDRyYAEHNsDSYzHHEbni0XCH58hNNr+
	 3nFHZpDRgOp2g==
Message-ID: <eebb0f6f-5866-4d34-82ab-f6206daf9041@kernel.org>
Date: Mon, 4 Nov 2024 11:16:09 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 13/36] mptcp: add struct mptcp_id_bitmap
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1729588019.git.tanggeliang@kylinos.cn>
 <344964d66ab0250ae027ffd46a0e6782d572c33d.1729588019.git.tanggeliang@kylinos.cn>
 <cbd9eaa2-e236-421e-82e9-784ae7054dca@kernel.org>
 <d44a000cfe49a9fb2c868833694f4da61a457d16.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <d44a000cfe49a9fb2c868833694f4da61a457d16.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

Thank you for your reply!

On 04/11/2024 10:12, Geliang Tang wrote:
> Hi Matt,
> 
> On Thu, 2024-10-31 at 19:45 +0100, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 22/10/2024 11:14, Geliang Tang wrote:
>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>
>>> A new struct mptcp_id_bitmap is defined to unify all bitmap type of
>>> address
>>> IDs for both in-kernel PM and userspace PM.
>>>
>>> This type can be used to easily refactor dump_addr() interface of
>>> the path
>>> managers to accept an mptcp_id_bitmap type parameter. It also
>>> allows this
>>> parameter of dump_addr() can be modified by BPF program when
>>> implementing
>>> this interface of a BFP path manager.
>>>
>>> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
>>
>> (...)
>>
>>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>>> index 8282a6355765..4358a9a21270 100644
>>> --- a/net/mptcp/protocol.h
>>> +++ b/net/mptcp/protocol.h
>>> @@ -211,6 +211,10 @@ enum mptcp_addr_signal_status {
>>>  /* max value of mptcp_addr_info.id */
>>>  #define MPTCP_PM_MAX_ADDR_ID		U8_MAX
>>>  
>>> +struct mptcp_id_bitmap {
>>
>> This name is too generic, while here this bitmap is specific to the
>> path-manager and its PM address:
>>
>>   mptcp_pm_addr_avail_id?
>>
>>> +	DECLARE_BITMAP(map, MPTCP_PM_MAX_ADDR_ID + 1);
>>
>> Sorry, I'm not sure to understand this modification: why do you need
>> a
>> specific structure with only one field? I didn't check the next
>> patches
>> yet, but I saw that at the end of the series, the structure still
>> only
>> has one field.
>>
>> Do you require this dedicated structure because of a limitation of
>> BPF?
> 
> Yes, defining dump_addr interface as either
> 
> int userspace_pm_dump_addr(struct mptcp_sock *msk,
>                            unsigned long *bitmap)
> 
> or
> 
> int userspace_pm_dump_addr(struct mptcp_sock *msk,
> 			   unsigned long id_bitmap[4])
> 
> is not allowed by BPF.

OK, thank you! (Do not hesitate to put such comment in commit message,
that's clearer and helpful for the reviewers :) )

>> Can we not use a typedef, a macro or something else to avoid all
>> these
>> modifications here?
> 
> In v3 I defined a type using typedef like this:
> 
> typedef struct {
>         DECLARE_BITMAP(map, MPTCP_PM_MAX_ADDR_ID + 1); 
> } mptcp_pm_addr_id_bitmap_t;
> 
> and only used it in the parameters of the dump_addr interfaces. The
> rest of the places continue to use DECLARE_BITMAP. It works well,

Just to be sure: by doing that, do you avoid adding ".map" a bit
everywhere? Because you still have a structure with a single item called
'map' at the end.
Or with that, you can use it only on BPF side and this structure can
then be declared in net/mptcp.bpf.c?

> the only downside is that checkpatch.pl complains about it:
> 
> $ ./scripts/checkpatch.pl 0001-mptcp-add-mptcp_pm_addr_id_bitmap_t-
> type.patch 
> WARNING: do not add new typedefs
> #31: FILE: include/net/mptcp.h:124:
> +typedef struct {
> 
> total: 0 errors, 1 warnings, 0 checks, 40 lines checked
> 
> We can ignore this warning.

Yes we can, but please add a comment above the typedef explaining why it
is useful.

> 
> WDYT?
> 
> Thanks,
> -Geliang
> 
>>
>>> +};
>>> +
>>>  struct mptcp_pm_data {
>>>  	struct mptcp_addr_info local;
>>>  	struct mptcp_addr_info remote;
>>> @@ -231,7 +235,7 @@ struct mptcp_pm_data {
>>>  	u8		pm_type;
>>>  	u8		subflows;
>>>  	u8		status;
>>> -	DECLARE_BITMAP(id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
>>> +	struct mptcp_id_bitmap id_avail_bitmap;
>>>  	struct mptcp_rm_list rm_list_tx;
>>>  	struct mptcp_rm_list rm_list_rx;
>>>  };
>>
>> Cheers,
>> Matt
> 

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


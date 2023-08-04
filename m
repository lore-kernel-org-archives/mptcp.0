Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B7BBE4A
	for <mptcp@lists.linux.dev>; Fri,  4 Aug 2023 12:23:36 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3178fa77b27so1752435f8f.2
        for <mptcp@lists.linux.dev>; Fri, 04 Aug 2023 05:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1691151815; x=1691756615;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cimSxPn4KvMzR4R6vzyKtXlVieQ+DFxTD1qD8B/bqI8=;
        b=qocv2klwtlsN+rn66+ldC/KZz/1txRqGvjOzQ7BlDkTdeRPzpkHjFgKrxDTPmJNJ/O
         Buh1zpFhdWZ8MNKdNyOzUntJk943SZYb/2ntKGcdmpanZmrifaGn6kXztB1UgBDnDtiW
         BXy2QKRC+c2pQDK+7wNKgSZS6T3aId4J/k9sNeZo2naLKA9PByZvxT7OtE5ffSU7QXBm
         iAcZLy1cBDXnmpGvKuoaujH5agZpWfvGgqMu11UttQbA6UO8AITjlrzNZg7WeUd5rfzf
         E7QF02yGnaLL9YxqnjhRDtMH+SdxrxAcmBgx/+vXyGvFPUfXbcaOzjDYMX9P+QIS4ADW
         IRig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691151815; x=1691756615;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cimSxPn4KvMzR4R6vzyKtXlVieQ+DFxTD1qD8B/bqI8=;
        b=OAXGj2UL5Tzk3ucpg6Bgkb7sbD6BL/eOzITppXy0sUaEV8BJvk1NTY9SFIkiabUtfg
         C96mtXa0v2lnzrF0tPNR+cTbw9ayj3mp5X1B8JAD/f4oDLTZl9SF8UR4eSbpCrOYlEVn
         Ii3JgNZXcMqXGR7h7MXpWKht0inHVbdIcYGHTNhZKxBnrOZOziMnIvbNiqcOI6bC+q/p
         3UZbk2AoK6isgRFI2SEiFR+hKJDTe+f3n2s0cknmaIJziwwJDhYou9JLcmpujy1X+bOy
         MU9TTmsWfdftz9wxAr8cq9TjQ4sKjZwWpfUMhlS0Lg0iLUuVqOq7HPIsVXzJAHSNxdj1
         sBMw==
X-Gm-Message-State: AOJu0YwyJWQsCnpol+KMkKE7kPtJP8FBqPo6DkjCAFmHe/9mTdZfNTAL
	u8+g/I4cNNocEthCN2HSbyy4vA==
X-Google-Smtp-Source: AGHT+IH0QmmQF00omC4UMZFvWgrjHFejAD6Zi1fxTqNCF0RhyVhkt++hZbJbInFVXc0Z8EbkEezbcw==
X-Received: by 2002:a05:6000:1b06:b0:317:6639:852d with SMTP id f6-20020a0560001b0600b003176639852dmr1463451wrz.43.1691151814953;
        Fri, 04 Aug 2023 05:23:34 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id r15-20020adfdc8f000000b00317909f9985sm2398537wrj.113.2023.08.04.05.23.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 05:23:34 -0700 (PDT)
Message-ID: <772ed33e-8893-41e2-9783-4b225f0d90ca@tessares.net>
Date: Fri, 4 Aug 2023 14:23:33 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Weekly meetings] MoM - 1st of August 2023
Content-Language: en-GB
To: Geliang Tang <geliangtang@gmail.com>, Mat Martineau <martineau@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
References: <336e8b92-8416-44a3-917f-5fcb1ae3a919@tessares.net>
 <CA+WQbwuhjitKkgobY7vgFMSQE5JTsPpq9VjC0KEO2Ldm_TT2gQ@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 xsFNBFXj+ekBEADxVr99p2guPcqHFeI/JcFxls6KibzyZD5TQTyfuYlzEp7C7A9swoK5iCvf
 YBNdx5Xl74NLSgx6y/1NiMQGuKeu+2BmtnkiGxBNanfXcnl4L4Lzz+iXBvvbtCbynnnqDDqU
 c7SPFMpMesgpcu1xFt0F6bcxE+0ojRtSCZ5HDElKlHJNYtD1uwY4UYVGWUGCF/+cY1YLmtfb
 WdNb/SFo+Mp0HItfBC12qtDIXYvbfNUGVnA5jXeWMEyYhSNktLnpDL2gBUCsdbkov5VjiOX7
 CRTkX0UgNWRjyFZwThaZADEvAOo12M5uSBk7h07yJ97gqvBtcx45IsJwfUJE4hy8qZqsA62A
 nTRflBvp647IXAiCcwWsEgE5AXKwA3aL6dcpVR17JXJ6nwHHnslVi8WesiqzUI9sbO/hXeXw
 TDSB+YhErbNOxvHqCzZEnGAAFf6ges26fRVyuU119AzO40sjdLV0l6LE7GshddyazWZf0iac
 nEhX9NKxGnuhMu5SXmo2poIQttJuYAvTVUNwQVEx/0yY5xmiuyqvXa+XT7NKJkOZSiAPlNt6
 VffjgOP62S7M9wDShUghN3F7CPOrrRsOHWO/l6I/qJdUMW+MHSFYPfYiFXoLUZyPvNVCYSgs
 3oQaFhHapq1f345XBtfG3fOYp1K2wTXd4ThFraTLl8PHxCn4ywARAQABzS5NYXR0aGlldSBC
 YWVydHMgPG1hdHRoaWV1LmJhZXJ0c0B0ZXNzYXJlcy5uZXQ+wsGSBBMBCAA8AhsDBgsJCAcD
 AgYVCAIJCgsEFgIDAQIeAQIXgBYhBOjLhfdodwV6bif3eva3gk9CaaBzBQJhI2BOAhkBAAoJ
 EPa3gk9CaaBzlQMQAMa1ZmnZyJlom5NQD3JNASXQws5F+owB1xrQ365GuHA6C/dcxeTjByIW
 pmMWnjBH22Cnu1ckswWPIdunYdxbrahHE+SGYBHhxZLoKbQlotBMTUY+cIHl8HIUjr/PpcWH
 HuuzHwfm3Aabc6uBOlVz4dqyEWr1NRtsoB7l4B2iRv4cAIrZlVF4j5imU0TAwZxBMVW7C4Os
 gxnxr4bwyxQqqXSIFSVhniM5GY2BsM03cmKEuduugtMZq8FCt7p0Ec9uURgNNGuDPntk+mbD
 WoXhxiZpbMrwGbOEYqmSlixqvlonBCxLDxngxYuh66dPeeRRrRy2cJaaiNCZLWDwbZcDGtpk
 NyFakNT0SeURhF23dNPc4rQvz4It0QDQFZucebeZephTNPDXb46WSwNM7242qS7UqfVm1OGa
 Q8967qk36VbRe8LUJOfyNpBtO6t9R2IPJadtiOl62pCmWKUYkxtWjL+ajTkvNUT6cieVLRGz
 UtWT6cjwL1luTT5CKf43+ehCmlefPfXR50ZEC8oh7Yens9m/acnvUL1HkAHa8SUOOoDd4fGP
 6Tv0T/Cq5m+HijUi5jTHrNWMO9LNbeKpcBVvG8q9B3E2G1iazEf1p4GxSKzFgwtkckhRbiQD
 ZDTqe7aZufQ6LygbiLdjuyXeSkNDwAffVlb5V914Xzx/RzNXWo0AzsFNBFXj+ekBEADn679L
 HWf1qcipyAekDuXlJQI/V7+oXufkMrwuIzXSBiCWBjRcc4GLRLu8emkfyGu2mLPH7u3kMF08
 mBW1HpKKXIrT+an2dYcOFz2vBTcqYdiAUWydfnx4SZnHPaqwhjyO4WivmvuSlwzl1FH1oH4e
 OU44kmDIPFwlPAzV7Lgv/v0/vbC5dGEyJs3XhJfpNnN/79cg6szpOxQtUkQi/X411zNBuzqk
 FOkQr8bZqkwTu9+aNOxlTboTOf4sMxfXqUdOYgmLseWHt6J8IYYz6D8CUNXppYoVL6wFvDL5
 ihLRlzdjPzOt1uIrOfeRsp3733/+bKxJWwdp6RBjJW87QoPYo8oGzVL8iasFvpd5yrEbL/L/
 cdYd2eAYRja/Yg9CjHuYA/OfIrJcR8b7SutWx5lISywqZjTUiyDDBuY31lypQpg2GO/rtYxf
 u03CJVtKsYtmip9eWDDhoB2cgxDJNbycTqEf8jCprLhLay2vgdm1bDJYuK2Ts3576/G4rmq2
 jgDG0HtV2Ka8pSzHqRA7kXdhZwLe8JcKA/DJXzXff58hHYvzVHUvWrezBoS6H3m9aPqKyTF4
 1ZJPIUBUphhWyQZX45O0HvU/VcKdvoAkJb1wqkLbn7PFCoPZnLR0re7ZG4oStqMoFr9hbO5J
 ooA6Sd4XEbcski8eXuKo8X4kMKMHmwARAQABwsFfBBgBAgAJBQJV4/npAhsMAAoJEPa3gk9C
 aaBzlWcP/1iBsKsdHUVsxubu13nhSti9lX+Lubd0hA1crZ74Ju/k9d/X1x7deW5oT7ADwP6+
 chbmZsACKiO3cxvqnRYlLdDNs5vMc2ACnfPL8viVfBzpZbm+elYDOpcUc/wP09Omq8EAtteo
 vTqyY/jsmpvJDGNd/sPaus94iptiZVj11rUrMw5V/eBF5rNhrz3NlJ1WQyiN9axurTnPBhT5
 IJZLc2LIXpCCFta+jFsXBfWL/TFHAmJf001tGPWG5UpC5LhbuttYDztOtVA9dQB2TJ3sVFgg
 I1b7SB13KwjA+hoqst/HcFrpGnHQnOdutU61eWKGOXgpXya04+NgNj277zHjXbFeeUaXoALg
 cu7YXcQKRqZjgbpTF6Nf4Tq9bpd7ifsf6sRflQWA9F1iRLVMD9fecx6f1ui7E2y8gm/sLpp1
 mYweq7/ZrNftLsi+vHHJLM7D0bGOhVO7NYwpakMY/yfvUgV46i3wm49m0nyibP4Nl6X5YI1k
 xV1U0s853l+uo6+anPRWEUCU1ONTVXLQKe7FfcAznUnx2l03IbRLysAOHoLwAoIM59Sy2mrb
 z/qhNpC/tBl2B7Qljp2CXMYqcKL/Oyanb7XDnn1+vPj4gLuP+KC8kZfgoMMpSzSaWV3wna7a
 wFe/sIbF3NCgdrOXNVsV7t924dsAGZjP1x59Ck7vAMT9
In-Reply-To: <CA+WQbwuhjitKkgobY7vgFMSQE5JTsPpq9VjC0KEO2Ldm_TT2gQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 02/08/2023 11:34, Geliang Tang wrote:
> Matthieu Baerts <matthieu.baerts@tessares.net> 于2023年8月2日周三 01:28写道：

(...)

>> Patches to send to netdev:

(...)

>>     - Features for other trees:
>>
>>         - [30c925a26900] mptcp: refactor push_pending logic (Geliang Tang)
>>         - [d92e7c3ac566] mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
>> (Geliang Tang)
>>         - [2e2ed433f72f] mptcp: add struct mptcp_sched_ops (Geliang Tang)
>>         - [8d3528b3804d] mptcp: add a new sysctl scheduler (Geliang Tang)
>>         - [36329d82af78] mptcp: add sched in mptcp_sock (Geliang Tang)
>>         - [58b653130078] mptcp: add scheduled in mptcp_subflow_context
>> (Geliang Tang)
>>         - [b86a7f3f4f2b] mptcp: add sched_data helpers (Geliang Tang)
>>         - [1da743dfb834] mptcp: add scheduler wrappers (Geliang Tang)
>>         - [172ae1f29b25] mptcp: use get_send wrapper (Geliang Tang)
>>         - [7449b11ec26b] mptcp: use get_retrans wrapper (Geliang Tang)
>>         - [abb330dac85f] mptcp: register default scheduler (Geliang Tang):
>>             - can maybe be sent?
>>             - Mat will re-review them to see what can be sent
> 
> I read these bpf schedulers patches again today and found that some
> patches need to be update:
> 
> 1. mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
> 
> The commit log needs to update:
> '''
> mptcp_subflow_get_send(), it makes some msk->last_snd useless.
> ->
> mptcp_subflow_get_send(), it makes all msk->last_snd useless.
> '''
> 
> 2. mptcp: add struct mptcp_sched_ops
> 
> The commit log needs to update:
> '''
> mptcp_sched_data parameter, which contains a reinject flag and a
> mptcp_subflow_context array.
>  ->
> mptcp_sched_data parameter, which contains a reinject flag for
> retrans or not, a subflows number and a mptcp_subflow_context array.
> '''
> 
> @Matt, could you please help me to update these commit logs? Thanks.

Thank you for having checked that!

I just applied these modifications in our tree. While at it, I also
updated Mat's email in these "old patches":

New patches for t/upstream:
- 785ba39756ad: tg:msg: update requested by Geliang
- 24db5bf84b4b: tg:msg: update requested by Geliang
- d25098265693: tg:msg: fix Mat's email address
- 4e6cab447490: tg:msg: fix Mat's email address
- 827901fa9870: tg:msg: fix Mat's email address
- 95f83ee5251f: tg:msg: fix Mat's email address
- 7b2bd7e15d81: tg:msg: fix Mat's email address
- f6a3e846c8c0: tg:msg: fix Mat's email address
- e7bd30b91bad: tg:msg: fix Mat's email address
- 554ca1bca6a0: tg:msg: fix Mat's email address
- 2d7584de4856: tg:msg: fix Mat's email address
- 21c4f32abcb2: tg:msg: fix Mat's email address
- ec51dec45885: tg:msg: fix Mat's email address
- f74165f83ed1: tg:msg: fix Mat's email address
- 4d597c39f9b8: tg:msg: fix Mat's email address
- 23acfa97c761: tg:msg: fix Mat's email address
- 0f63ac824dcd: tg:msg: fix Mat's email address
- 06e13746b715: tg:msg: fix Mat's email address
- 84db4f5a6f57: tg:msg: fix Mat's email address
- 8ce5149322c5: tg:msg: fix Mat's email address
- e132cd47cce7: tg:msg: fix Mat's email address
- c385961fa9e7: tg:msg: fix Mat's email address
- 8ad3b922a1b1: tg:msg: fix Mat's email address
- Results: d3ccb2956067..e54740d33eef (export)

> 3. mptcp: add sched_data helpers
> 
> This is a BPF related patch. Maybe we can send it together with the other
> BPF patches.

Good to know, thank you! Is it the only patches from this list above
that is BPF related and not an MPTCP refactoring that can be sent?

> If so, can we just move this patch between the commit "mptcp: register
> default scheduler" and "bpf: Add bpf_mptcp_sched_ops"?
If that's OK, I will wait before moving the commit (it's a manual
operation, always a risk to do something wrong) to see if it is really
needed: the next step is to select which patches we can send (Mat will
also re-review these patches). We can always select which patches we
send and omit some as long as there are no conflicts. If there are some,
I will do the modifications in our tree before.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

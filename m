Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFAB125D0
	for <mptcp@lists.linux.dev>; Thu, 17 Aug 2023 09:30:07 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-31783d02093so6504086f8f.0
        for <mptcp@lists.linux.dev>; Thu, 17 Aug 2023 02:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1692264605; x=1692869405;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a8XjHhejpnIfwfLeHHiaI8QMI7hTfyJqQhI598uiiAs=;
        b=jEXEpvAZEyozU09fEACrxOQNHtti4aJUoXlVNklhuvwnrUHjif3O/eD9AYK4/u23CD
         YTDAr8vGkiAG1kGCeIHO/Sg4NXZe+0RDGh15ddlSD8PhiX8MWMoTEE0eP9L7b3hqJv/w
         kfWlWSfoPz1Yjvh9NclMxlWYvEHelHMYL/Y17NybsNz6AcifRigjZXofGV5tAcYRYzyb
         mMH39AUXQO5LRIyLK4iszftARGkJPvbn34EgrOUXnvoTsmYrbdhCj6ttDC6ZJeANw4eX
         gh1NiVxTTdsEEc/0AG1YYdefT1caHjxcMYKeaGXDfhNf0KIMr6UiSw7aY1a0TXK+9dd6
         QFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692264605; x=1692869405;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a8XjHhejpnIfwfLeHHiaI8QMI7hTfyJqQhI598uiiAs=;
        b=X68J5yrlQ9AG7eESwGMhSIeMeK/3VYnci5852/++CWHSocRKWuh1vx5twHZJLVuH4w
         S+lRQAAEbRfJEvSH8CmN6yndruDaYwRiOWu2a7FePURftM3/MssA1bNpsaAyipu3X7yK
         wWgzkTsrZVEkwdVFuR18FnMhVG/UAEyy3P8rMLKTx1p+RarIhskfeWK8ULGGO7fGPyAy
         uliH8jUSSUK/Ubjuki1l29aNv2dhs5HAyp42S4E9pEwpJYJ2/35hgsO3R2Artb7ttDfY
         SjunctN6isRetbun2Z6yQAvFiakVBHN8aHLU6X4MSgRpa2UYp1aXmoGwIFSXfBM3PruN
         qbCA==
X-Gm-Message-State: AOJu0Yx0ed39bxRhu9zSk191cR3lwxpZCpFXfk6RuQ573LicOfpQP/79
	8Cg7Twu5bSXVLrxgqF3GHpnD8GT3FA+Hy6KFxZU=
X-Google-Smtp-Source: AGHT+IHr2D3NyOuFBeFuvBJeT/rKlwDES8dsFwLU8jI0zyNMKJZE6J3SKQ7by4pQK5Hpr3b/j9pe0Q==
X-Received: by 2002:adf:efcb:0:b0:318:8b5:4159 with SMTP id i11-20020adfefcb000000b0031808b54159mr3719200wrp.24.1692264605515;
        Thu, 17 Aug 2023 02:30:05 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:c88:d59b:1c03:4962? ([2a02:578:8593:1200:c88:d59b:1c03:4962])
        by smtp.gmail.com with ESMTPSA id k1-20020a5d4281000000b00317a29af4b2sm23971934wrq.68.2023.08.17.02.30.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 02:30:05 -0700 (PDT)
Message-ID: <13e5c589-d31b-462d-8c1e-afc05e70346f@tessares.net>
Date: Thu, 17 Aug 2023 11:30:04 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next 0/9] Update scheduler refactor commits
Content-Language: en-GB
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <cover.1692080803.git.geliang.tang@suse.com>
 <ecf0e1f7-feae-e8bb-dad0-5e3a87b4aec5@kernel.org>
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
In-Reply-To: <ecf0e1f7-feae-e8bb-dad0-5e3a87b4aec5@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 17/08/2023 02:07, Mat Martineau wrote:
> On Tue, 15 Aug 2023, Geliang Tang wrote:
> 
>> Update scheduler refactor commits:
>> - drop data_init interface.
>> - call mptcp_sched_default_get_subflow in get_send/retrans.
>> - update commit logs.
>>

Thank you for the patches and the review!

> Thanks for the changes Geliang, these look good to squash.
> 
> Matthieu, I think the build failures were due to the squash commits
> being applied after the final export branch commit?

It looks like they are due to the squash commits. Let's see :)

New patches for t/upstream:
- 334385dbbaff: "squashed" patch 1/9 in "mptcp: add struct mptcp_sched_ops"
- 72867507b737: tg:msg: update after the recent squash-to patch

- b1737babf8e1: "squashed" patch 2/9 (with conflicts) in "mptcp: add
scheduler wrappers"
- ebc8d6bc5e46: tg:msg: update after the recent squash-to patch

- eeffd6a7a5d6: "squashed" patch 3/9 (with conflicts) in "mptcp:
register default scheduler"
- ff14b1c54442: tg:msg: update after the recent squash-to patch

- dd2afaeb7bf9: "squashed" patch 4/9 in "selftests/bpf: Add mptcp sched
structs"
- 28c12982dd5b: "squashed" patch 5/9 in "selftests/bpf: Add bpf_first
scheduler"
- 22674b47badb: "squashed" patch 6/9 in "selftests/bpf: Add bpf_bkup
scheduler"
- 48f4f33191d4: "squashed" patch 7/9 in "selftests/bpf: Add bpf_rr
scheduler"
- 658be6218f95: "squashed" patch 8/9 in "selftests/bpf: Add bpf_red
scheduler"
- c1714527d1e2: "squashed" patch 9/9 in "selftests/bpf: Add bpf_burst
scheduler"
- Results: f28cd69d6233..ca3243095d76 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230817T092922

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

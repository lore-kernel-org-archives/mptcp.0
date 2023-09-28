Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5175B5C96
	for <mptcp@lists.linux.dev>; Thu, 28 Sep 2023 21:37:11 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5362bcc7026so1932944a12.1
        for <mptcp@lists.linux.dev>; Thu, 28 Sep 2023 14:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1695937029; x=1696541829; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qn3jDLZvxQbqHWgi0LyNA68q4z/hrOTJgGK+4CtVYZA=;
        b=bZb0ZYvIKt1afMPTfdwZb8/6pDxgr3TPNwlvEtG83ldIVfz874jmuVwy8eicod6img
         APR0Mzg1oMznrocv2oC1Y9Fkf/JFeCdLlPbzw/hwyfPREmC3M1eT4FuaIrm1gpfR9UTh
         /SN+4rujwVRgjG8XVh6txiezx3C56j80DY8EUUyJ4M4U9mhioJPl9fS7EmyKrFhDMCvM
         sQvpyRv5IIFvH1YpmTBM/jXGM5x4vT3pb7Z+fwciK2Fd1AtGKBGrt7a+pepVb73QMrnw
         +cFs3+hFn0b47HaF22dWfNcX8L3ro1NwI2SANgUwMibSF3HurXufiD0mj+s5rXSRMKur
         cthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695937029; x=1696541829;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qn3jDLZvxQbqHWgi0LyNA68q4z/hrOTJgGK+4CtVYZA=;
        b=UDVsrPOcQ41BIq5AXYJqCKlOmQFRxc/67OwrEZtC0ZrslvqkQSi7ItPVH/0/1TphtF
         OKnFmIsvEi3fjh51ldpKRNbGrIb6bVYoM78KbTaNBqLs3Glj74WaptIM3tkdyzOOthjK
         X/aC+bxfxXnJofvV/1n7Dw4bQO2WN1cOh2N5FspDUvjMGA0UJf01i292ouUdbKPEE2zo
         /ryJpDK31WyELe9qD3fsJ4tbHtTEAwy09yB5v7/4chVwfeOHUewchDeka9F9mG6QuGW2
         FLw9U3yzQTu2mNNsZOPP1QykNeK4yKHjl0gX8dr+/83RqlnqsXeM3IN0Ap31Q/48Aj/1
         ZLYA==
X-Gm-Message-State: AOJu0Yy4/scxZuBgoCCahL+4FDpjWlMWd5QSTpRXkWof1h4PJU0cyHwa
	kb0B+uvvmUPA4PVv1Ni8J+Me4WRVgtTor4+mB5CyIw==
X-Google-Smtp-Source: AGHT+IEQI9B6x9ag+LMi4S1D5jIfK7Kcx45vY144bDLYTTtAf+UFNM1nBGnP6V9syyBMaYk8aSO+Eg==
X-Received: by 2002:a17:906:76d1:b0:9b2:a7db:9662 with SMTP id q17-20020a17090676d100b009b2a7db9662mr2267477ejn.12.1695937029560;
        Thu, 28 Sep 2023 14:37:09 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:ff86:e30:98cd:120? ([2a02:578:8593:1200:ff86:e30:98cd:120])
        by smtp.gmail.com with ESMTPSA id i22-20020a17090671d600b009929ab17be0sm11318168ejk.162.2023.09.28.14.37.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 14:37:09 -0700 (PDT)
Message-ID: <be43e409-389f-466f-a77f-0b24e29cb4f3@tessares.net>
Date: Thu, 28 Sep 2023 23:37:08 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v3 00/29] userspace pm enhancements
Content-Language: en-GB, fr-BE
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1695631132.git.geliang.tang@suse.com>
 <4faab698-f464-43b4-91aa-19177a0ee77b@tessares.net>
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
In-Reply-To: <4faab698-f464-43b4-91aa-19177a0ee77b@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 28/09/2023 22:54, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 25/09/2023 10:41, Geliang Tang wrote:
>> v3:
>>  - drop patch 4 in v2
>>  - invert patch 10 and 11 in v2
>>  - rebased
> 
> Thank you for the v3! And again, sorry for the delays!
> 
> I think patches 1-11 + 13-14 are OK to be applied (with two small
> modifications for patch 7 and 11 that I can do when applying these patches):
> 
> Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> 
> Please note that patch 13 will go to "Fixes for -net". Patch 14 can stay
> in "Features for net-next" due to other dependences.

I just did that:

New patches for t/upstream-net and t/upstream:
- 505a33d76a32: mptcp: userspace pm allow creating id 0 subflow
- Results: 05758f924fe3..999b9f7e47a5 (export-net)

New patches for t/upstream:
- 1cb016e94837: mptcp: drop useless ssk in pm_subflow_check_next
- 450deaf6dd71: mptcp: use mptcp_check_fallback helper
- 6df74a0ced73: mptcp: use mptcp_get_ext helper
- 03649553fd68: mptcp: move sk assignment statement ahead
- 6bc1e5144525: mptcp: define more local variables sk
- b7e3cc69d9fe: selftests: mptcp: sockopt: drop mptcp_connect var
- 14c099dbd7a7: selftests: mptcp: display simult in extra_msg
- 7d9e508e1117: mptcp: add mptcpi_subflows_total counter
- af6ed0819599: selftests: mptcp: add evts_get_info helper
- 9177dc0b474c: selftests: mptcp: add chk_subflows_total helper
- bc1edd827cfa: selftests: mptcp: update userspace pm test helpers
- 0dd61d4e14e8: selftests: mptcp: userspace pm create id 0 subflow
- Results: 3be1c8ce544a..516baae7a220 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230928T211416
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230928T213439

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B974C144
	for <mptcp@lists.linux.dev>; Mon,  4 Sep 2023 15:58:35 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-31c73c21113so1326514f8f.1
        for <mptcp@lists.linux.dev>; Mon, 04 Sep 2023 08:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1693843113; x=1694447913; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U2xYBSIEmsgx2xMQPuQkVVMFx9uO9Bngc2VcTU/2M9E=;
        b=BpOYM2Lrqc1t4xhtEEj8iUTxvwJJqWPumt97iknYk53wMlDuqFzwVwd8x4risUy1az
         1wHi9nsQpdfzvjDTxY8Zr4kGYWPQK02Scz/5m2p2OVhGp0ySeya7urexGGrkdqNf6YUn
         2HuEgI7bHKkaitsMDlIlPAg7Jz2MQ72bOXQ+E3IYoZiXsihMg1WKgdS3Acarm3bcGcHB
         gO2rxQ2UfF8bi88I2RILBORUXXPjiri/ik4ba0gooiCnNjehn6Bfcy12TjlFjO8+GLaI
         3T03oapwpj9vC5rYyrJTaqQj/s29cYQE18IdrmFtxQ5/KaFC0iOibTQ7O73hzWoNo4mT
         y+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693843113; x=1694447913;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U2xYBSIEmsgx2xMQPuQkVVMFx9uO9Bngc2VcTU/2M9E=;
        b=TVjQXoqama2DO5d90Ij/fMdTifqf9uuD6emR9pIi9opeDX5UDqrVdhaSmCL9UB8koU
         gIMShve039iP1sEjRPehxXpJyvbi4JE0EN7tan3zupoZ3khcYcWzqB9pRAyvrU3dusLK
         MhQXvA3tvHpnqJaDTnpM7uArvn9eWj8yqu5gno+Dz8UXTUXD1VnDcQvNAvv2Fs0pNZur
         qUdFazfJKjI/7HtpY0UfWSTjKe7VF3+daSoK3zyur/T/d0dsLpsAO3V9q/BCJ/BUBkE7
         sXTbX0DfeKgy/ceMoxMb6WT4G9+l+wKxfx2C0EQDCxbuxRl5d0OApjUqlEw6JNiH7cel
         c9Ww==
X-Gm-Message-State: AOJu0YxlUJ/tXuxqQ7bcwIPH72Krr0MJlW5gOEUp5mnBMJqpHJPShNvV
	Wl1UitMUVOHF8lfvg9QjcP7+WZc8Nbeo0/MALtI=
X-Google-Smtp-Source: AGHT+IGAUNA8lwtdSS4ADpsn4XJakMeWoWU1utO7RaS0o4UAtJxl7IjcmgYONh79LIobkzWgHfjHkQ==
X-Received: by 2002:adf:f512:0:b0:313:e9f6:3378 with SMTP id q18-20020adff512000000b00313e9f63378mr7253163wro.4.1693843113380;
        Mon, 04 Sep 2023 08:58:33 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id y8-20020adff148000000b00317c742ca9asm14643256wro.43.2023.09.04.08.58.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 08:58:33 -0700 (PDT)
Message-ID: <b7703287-9e04-4c9a-93a6-b50c2020c5ab@tessares.net>
Date: Mon, 4 Sep 2023 17:58:32 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v2] mptcp: add a new sysctl for make after
 break timeout
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <dfadc0c4a9bf4649c01e09d675f4de59eb409f5d.1693841118.git.pabeni@redhat.com>
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
In-Reply-To: <dfadc0c4a9bf4649c01e09d675f4de59eb409f5d.1693841118.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 04/09/2023 17:48, Paolo Abeni wrote:
> The MPTCP protocol allows sockets with no alive subflows to stay
> in ESTABLISHED status for and user-defined timeout, to allow for
> later subflows creation.
> 
> Currently such timeout is constant - TCP_TIMEWAIT_LEN. Let the
> user-space configure them via a newly added sysctl, to better cope
> with busy servers and simplify (make them faster) the relevant
> pktdrill tests.
> 
> Note that the new know does not apply to orphaned MPTCP socket
> waiting for the data_fin handshake completion: they always wait
> TCP_TIMEWAIT_LEN.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1 -> v2:
>  - add the doc for the new knob (Matttbe)
>  - fix a couple of bad/strange indentation (Matttbe)

Thank you for the update!

> ---
>  Documentation/networking/mptcp-sysctl.rst | 11 +++++++++++
>  net/mptcp/ctrl.c                          | 16 ++++++++++++++++
>  net/mptcp/protocol.c                      |  5 +++--
>  net/mptcp/protocol.h                      |  1 +
>  4 files changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
> index 15f1919d640c..f569129ea881 100644
> --- a/Documentation/networking/mptcp-sysctl.rst
> +++ b/Documentation/networking/mptcp-sysctl.rst
> @@ -25,6 +25,17 @@ add_addr_timeout - INTEGER (seconds)
>  
>  	Default: 120
>  
> +close_timeout - INTEGER (seconds)
> +	Set the make-after-break timeout: in absence of any close or
> +        shutdown syscall, MPTCP sockets will maintain the status
> +        unchanged for such time, after the last subflow removal, before
> +        moving to TCP_CLOSE.

You are using spaces for these 3 lines, the rest is OK using tabs. Did
you switch to EMACS? :-D

I can do the modification when applying the patch (if I don't forget :) )

> +
> +	The default value matches TCP_TIMEWAIT_LEN. This is a per-namespace
> +	sysctl.
> +
> +	Default: 60
> +
>  checksum_enabled - BOOLEAN
>  	Control whether DSS checksum can be enabled.
>  
> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> index c46c22a84d23..36e389326073 100644
> --- a/net/mptcp/ctrl.c
> +++ b/net/mptcp/ctrl.c

(...)

> @@ -141,6 +150,12 @@ static struct ctl_table mptcp_sysctl_table[] = {
>  		.mode = 0644,
>  		.proc_handler = proc_dostring,
>  	},
> +	{
> +		.procname = "close_timeout",
> +		.maxlen = sizeof(unsigned int),

(just to be sure not to miss the idea which is probably not interesting)
No need to accept negatives values and use -1 as a special case not to
close "subflow-less" MPTCP connections?

> +		.mode = 0644,
> +		.proc_handler = proc_dointvec_jiffies,
> +	},
>  	{}
>  };
>  
Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

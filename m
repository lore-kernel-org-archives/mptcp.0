Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6312FBE
	for <mptcp@lists.linux.dev>; Fri,  7 May 2021 12:19:19 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id t4so13377054ejo.0
        for <mptcp@lists.linux.dev>; Fri, 07 May 2021 05:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OMsToV3gsRUNBBQ7VRuPD/KjIwWzFhL5PGez7Gg8ttg=;
        b=jOdv6BVNrrjZUE8lyYlkuQGEqMZkNQSmvvG79NAwHd4ybS4LkkB3jZeW6jpOSmnfqU
         fFhGUG/B8DowwsaDFrXbiaEX3DueGBCp17+1LHbJ4YH3VFMExZO8e7zmnYj//SLH4a4T
         qTtxRoa2L8q2hnGu3wjUOzJGaChwAuYhHUsZDmc4awWpztYp1ONISnwDmAuYaNQjtEfa
         UsXf/P/FvB3+8YoyAsK8Z3dTfm4rMYY6PEDsZUkaD8hujIIC96h78DRYu8+Lve+CBXpK
         vyKfhaVGCN3M5I2RV76Z8lmshsBkf5rjeD2zOzdkIRPtXb44o4MX+REJ4XdEN9Hn3Jt4
         B78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OMsToV3gsRUNBBQ7VRuPD/KjIwWzFhL5PGez7Gg8ttg=;
        b=pg5THXwpDEq/f3dJuKj5hO+WYRktHM4isFODsVdYgHmcgC/FTvZo/HCYcYuguLaMFC
         DzJdjUchBI6CTXqou67Mmfi9ZmVtMHc1k0nox2/2jEk1ancxqRLCQCd1g5mahosQ93iC
         sV1dFJXBBM+9gw+TpfPCq6+JB3sjWoIrfqXQrwu/0l2euyVmCQ4v4a5qSmqlWG1g5uMv
         gGmYQpwF2ypYo0UwfQv2lON1m8tTCSzsknIJXiNGhBgTyVsbf97zhOsaT6v6tslicVd8
         hFyN7dhZ0lwQr/uJkGspdGLb9ggF2Q5E6DcAXksCFU5CjaKGWILt0wkYUOY4fp6xCQY0
         VoSg==
X-Gm-Message-State: AOAM530WrDCx4lVdunt3/bvk++ys503R3J2xzyZ0FOVgwtE/vJ+VNetm
	ZeZcL86nzZrTGMFRHYLSOEZ0n06aD1u+VT+2BHQ=
X-Google-Smtp-Source: ABdhPJwnmtbCdkVrk84RIkeR7KNfE8Q5MeWzalUY+iZcvCgEmrEwQLGgIAOHny56xoBuIgcGyf80iQ==
X-Received: by 2002:a17:906:3544:: with SMTP id s4mr9887321eja.73.1620389957613;
        Fri, 07 May 2021 05:19:17 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:2fa9:2d27:234d:525d])
        by smtp.gmail.com with ESMTPSA id j22sm3666542ejt.11.2021.05.07.05.19.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 May 2021 05:19:17 -0700 (PDT)
To: Geliang Tang <geliangtang@gmail.com>
Cc: mptcp@lists.linux.dev
References: <c8b33d7b10e063f3bd93d25955d539a6af7f0372.1620374286.git.geliangtang@gmail.com>
 <c92941a2-d629-ae34-23e3-18faec2a3750@tessares.net>
 <CA+WQbwvfLSqK5uWUmNrPwzazwXV2HNUXU_8HUz6dxifYmRTGCw@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [MPTCP][PATCH mptcp-next] mptcp: don't fallback when data_fin
 enabled
Message-ID: <619cd782-bb39-c284-b59e-546a0aea3e3d@tessares.net>
Date: Fri, 7 May 2021 14:19:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CA+WQbwvfLSqK5uWUmNrPwzazwXV2HNUXU_8HUz6dxifYmRTGCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 07/05/2021 11:08, Geliang Tang wrote:
> Hi Matt,
> 
> Thanks for your review.
> 
> Matthieu Baerts <matthieu.baerts@tessares.net> 于2021年5月7日周五 下午4:51写道：
>>
>> Hi Geliang,
>>
>> On 07/05/2021 09:58, Geliang Tang wrote:
>>> This patch fixed this fallback error:
>>
>> Thank you for the patch!
>>
>>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>>> index f3e379a0f08d..940b32511443 100644
>>> --- a/net/mptcp/options.c
>>> +++ b/net/mptcp/options.c
>>> @@ -901,7 +901,7 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
>>>        * MP_JOIN subflows.
>>>        */
>>>       if (!mp_opt->mp_capable) {
>>> -             if (subflow->mp_join)
>>> +             if (subflow->mp_join || mptcp_data_fin_enabled(msk))>                   goto reset;
>>
>> I don't think we should send a reset here. For me this behaviour is normal.
> 
> Yes, we don't need to send a reset here. What about just return here?
> Something like this:
> 
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 3428c163299b..bd62dadfefdb 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -905,6 +905,8 @@ static bool check_fully_established(struct
> mptcp_sock *msk, struct sock *ssk,
>         if (!mp_opt->mp_capable) {
>                 if (subflow->mp_join)
>                         goto reset;
> +               if (mptcp_data_fin_enabled(msk))
> +                       return false;
>                 subflow->mp_capable = 0;
>                 pr_fallback(msk);
>                 __mptcp_do_fallback(msk);

I think we still need to do a fallback here not to expect a DATA_ACK.
For example in __mptcp_check_send_data_fin(), we change the state
because we will not get a DATA_ACK.

So I think everything is OK there.

Just one thing: should we send a DATA_FIN if we were not "fully
established" when closing the socket?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

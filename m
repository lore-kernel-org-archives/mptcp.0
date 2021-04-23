Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D65B70
	for <mptcp@lists.linux.dev>; Fri, 23 Apr 2021 08:21:51 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id bx20so55387975edb.12
        for <mptcp@lists.linux.dev>; Fri, 23 Apr 2021 01:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CjvPvFxCf/PtIuaijMANRt4cLNmt258GXZV85C0gE4c=;
        b=CHUSEUoYqwr8Irbv5015rzZZ74nDRoEIHtLP7/FbzesRHIBjnqQ6njvQUiYyUmjFYc
         wjgNhlRsDOmvToL6GdJzdH2wZEDejVv+kl31Xtcai80oObeHKQ2Bx78oXc0nM52EjiJT
         vnpJNYkLz/lRLysg/vwJiNvSMksdtSs1DBGQ7QBmNddOvuHcH9zwQSg4ULbODtm9Aq67
         d3TQhEtO64RxbApMdkohO5Dd7Xrcz9qgHHyTMxkby5KT3iFqtszGEaqsWtb5InVIcaAe
         lf+aF+EMmZ3SzzHKiiotsGo/AUu0PdwsNuOYKw1umBa51R1m7g3hvCZXECNTKp2vqZMg
         xYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CjvPvFxCf/PtIuaijMANRt4cLNmt258GXZV85C0gE4c=;
        b=MhtxIT2B49N2JVfysvTUGGgGxsGLInHRyWUsh97dfsxSEM4x6hsi1b9LVhbvLAuijc
         8eWqC6j/I4fnKnjsjhMfas8sAUuEm5cmH0UrtnhBPnAkWCbBtvCxMnSha6j6wGi9nt4n
         GtE9HkZ46ojAY1ZIavNeqfh+X6V3SIY8sr2olH9CasVJmGrHHqXBwKQITfVL64We4oAd
         9aQ40TGHmVwN8zsO8DUNEL//PoLZj/Ha7HwbZEp2mosuK89iblSjKGjmrNhhffPEBysl
         QIqgD9esLgUOiUThhgrAEseUykJP+iaUQUwcF1FQfSc8z3ZpcvOvRs68hbWfYrrRF3Ut
         lYyQ==
X-Gm-Message-State: AOAM532MGngO75SSIGSvZkntKQZU973RZOA3Gm1EZhyfgYBwer1CwfaB
	DrS/LC9H9e1DHML5G9K3UCVdbHrNHMAw5w==
X-Google-Smtp-Source: ABdhPJyTcEIm4Ar5TyVYLMh9782OOb+fnGUSkdVZ5xwbiwciW4XoYDrKzmuvxGWt9x8zCvHVaejZBQ==
X-Received: by 2002:aa7:cd6e:: with SMTP id ca14mr3027780edb.111.1619166109562;
        Fri, 23 Apr 2021 01:21:49 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:1677:2b08:7faa:72e2])
        by smtp.gmail.com with ESMTPSA id u1sm4106966edv.90.2021.04.23.01.21.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 01:21:49 -0700 (PDT)
To: Jianguo Wu <wujianguo106@163.com>, Geliang Tang <geliangtang@gmail.com>
Cc: mptcp@lists.linux.dev
References: <bbe531db-6d59-d341-16ed-f48b1fd43d2a@163.com>
 <CA+WQbwvpviu3FAE06bO3CO2azAegzMi8YUXcQPPMBYM8nW7_cg@mail.gmail.com>
 <1b50d699-45ec-e747-983a-1966f64f8e1c@163.com>
 <CA+WQbwvzabuhsbKKHeWwa3raOfCh270sccdg6=18ytgPjjkaVw@mail.gmail.com>
 <CA+WQbwuSDvyJH+MT00Qvi73MhGoWcrg-AkZfPR56Zfaks2s1uQ@mail.gmail.com>
 <681e0810-fbbc-daaf-054a-0e83038b4d12@163.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH] mptcp: create listening socket only if signal flag is set
 on
Message-ID: <3c3cf25d-aa4c-d522-102b-ebdd3b767cc0@tessares.net>
Date: Fri, 23 Apr 2021 10:21:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <681e0810-fbbc-daaf-054a-0e83038b4d12@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Jianguo, Geliang,

Thank you for the patches and reviews!

On 23/04/2021 09:41, Jianguo Wu wrote:
> 
> 
> On 2021/4/23 15:27, Geliang Tang wrote:
>> Geliang Tang <geliangtang@gmail.com> 于2021年4月23日周五 下午3:17写道：
>>>
>>> Hi Jianguo,
>>>
>>> Jianguo Wu <wujianguo106@163.com> 于2021年4月23日周五 下午2:39写道：
>>>>
>>>>
>>>>
>>>> On 2021/4/23 12:33, Geliang Tang wrote:
>>>>> Hi Jianguo,
>>>>>
>>>>> Thanks for your patch.
>>>>>
>>>>> Jianguo Wu <wujianguo106@163.com> 于2021年4月22日周四 下午6:30写道：
>>>>>>
>>>>>> From: Jianguo Wu <wujianguo@chinatelecom.cn>
>>>>>>
>>>>>> PM announces address to remote host when signal flag is set,
>>>>>> so create listening socket only if signal flag is set.
>>>>>
>>>>> This check has done in the user-space, here are these lines in pm_nl_ctl.c:
>>>>>
>>>>> 274                 } else if (!strcmp(argv[arg], "port")) {
>>>>> 275                         u_int16_t port;
>>>>> 276
>>>>> 277                         if (++arg >= argc)
>>>>> 278                                 error(1, 0, " missing port value");
>>>>> 279                         if (!(flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
>>>>> 280                                 error(1, 0, " flags must be signal
>>>>> when using port");
>>>>>
>>>>
>>>> Hi Geliang, Thanks for point out this, I was use 'ip mptcp' to add address, It doesn't seem to have done that check.
>>>> Is it worth to do check in kernel to make sure there is a signal flag before create listening socket?
>>>
>>> I think it's better to check this in the user-space, you can write a patch
>>> to iproute2 to add this check in 'ip mptcp'.
>>
>> Or add this check in mptcp_pm_parse_addr, something like:
>>
>> $ git diff net/mptcp/pm_netlink.c
>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>> index 6ba040897738..9cd4a4180a2a 100644
>> --- a/net/mptcp/pm_netlink.c
>> +++ b/net/mptcp/pm_netlink.c
>> @@ -971,8 +971,14 @@ static int mptcp_pm_parse_addr(struct nlattr
>> *attr, struct genl_info *info,
>>         if (tb[MPTCP_PM_ADDR_ATTR_FLAGS])
>>                 entry->flags = nla_get_u32(tb[MPTCP_PM_ADDR_ATTR_FLAGS]);
>>
>> -       if (tb[MPTCP_PM_ADDR_ATTR_PORT])
>> +       if (tb[MPTCP_PM_ADDR_ATTR_PORT]) {
>> +               if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
>> +                       NL_SET_ERR_MSG_ATTR("");
>> +                       return -EINVAL;
>> +               }
>> +
>>                 entry->addr.port =
>> htons(nla_get_u16(tb[MPTCP_PM_ADDR_ATTR_PORT]));
>> +       }
>>
>>         return 0;
>>  }
>>
>> WDYT?
>>
> 
> I think this is better, we can't assume that all user-space tools works correctly.

I was thinking a bit about that. With the proposed modifications, it
means that a server will have to send an ADD_ADDR if it wants to accept
subflows on another port. I guess there will be use-cases where we will
not want to send ADD_ADDR because we are in a controlled environment or
we don't want to announce a public ADD_ADDR+port on a specific network.

Do we have to support that? Maybe safer to restrict actions for now and
allow that later if there are needs, no?

In other words, I guess we should accept the proposed modifications.
Any other points of view? :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

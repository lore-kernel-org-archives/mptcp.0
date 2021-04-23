Received: from m12-13.163.com (m12-13.163.com [220.181.12.13])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1A070
	for <mptcp@lists.linux.dev>; Fri, 23 Apr 2021 07:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=RzPiU
	FvTBGmjDm2mRzDuG4Ar3AJgiT8i4ivdq0TrenU=; b=PZrEDf4vGsO/WVCFRdYj1
	LunPOeKOaTyLoizxZ2bbB72Ateai/rR9Gps72VSbUHgzHzmTV0t1Su1rsERfmdw0
	qqqcHLcXoam2z0Tytvq54gyY5OKEUd8iQu9JeEaEu3V0xEcAgF1z1s9Drbfnw52g
	cZ2+3ht82kMx3Y+hzx/eRw=
Received: from [192.168.15.51] (unknown [120.36.226.89])
	by smtp9 (Coremail) with SMTP id DcCowADHtEkmeoJgGKH8HA--.3615S2;
	Fri, 23 Apr 2021 15:41:27 +0800 (CST)
Subject: Re: [PATCH] mptcp: create listening socket only if signal flag is set
 on
To: Geliang Tang <geliangtang@gmail.com>
Cc: mptcp@lists.linux.dev
References: <bbe531db-6d59-d341-16ed-f48b1fd43d2a@163.com>
 <CA+WQbwvpviu3FAE06bO3CO2azAegzMi8YUXcQPPMBYM8nW7_cg@mail.gmail.com>
 <1b50d699-45ec-e747-983a-1966f64f8e1c@163.com>
 <CA+WQbwvzabuhsbKKHeWwa3raOfCh270sccdg6=18ytgPjjkaVw@mail.gmail.com>
 <CA+WQbwuSDvyJH+MT00Qvi73MhGoWcrg-AkZfPR56Zfaks2s1uQ@mail.gmail.com>
From: Jianguo Wu <wujianguo106@163.com>
Message-ID: <681e0810-fbbc-daaf-054a-0e83038b4d12@163.com>
Date: Fri, 23 Apr 2021 15:41:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CA+WQbwuSDvyJH+MT00Qvi73MhGoWcrg-AkZfPR56Zfaks2s1uQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:DcCowADHtEkmeoJgGKH8HA--.3615S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGF4fCw4rGr17Ww47uFW5Awb_yoW5ZrW7pr
	48J3Z8Wr48XryIqrZ2qF1jqr1a9F1Yqr1kW34UK3WIvr4qgF1xJ3yUGr15CFy7Crs5JFWU
	XF4jga13Aw1Uuw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07b8DGOUUUUU=
X-Originating-IP: [120.36.226.89]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/1tbiUQd9kFWBS6T9OwAAsG



On 2021/4/23 15:27, Geliang Tang wrote:
> Geliang Tang <geliangtang@gmail.com> 于2021年4月23日周五 下午3:17写道：
>>
>> Hi Jianguo,
>>
>> Jianguo Wu <wujianguo106@163.com> 于2021年4月23日周五 下午2:39写道：
>>>
>>>
>>>
>>> On 2021/4/23 12:33, Geliang Tang wrote:
>>>> Hi Jianguo,
>>>>
>>>> Thanks for your patch.
>>>>
>>>> Jianguo Wu <wujianguo106@163.com> 于2021年4月22日周四 下午6:30写道：
>>>>>
>>>>> From: Jianguo Wu <wujianguo@chinatelecom.cn>
>>>>>
>>>>> PM announces address to remote host when signal flag is set,
>>>>> so create listening socket only if signal flag is set.
>>>>
>>>> This check has done in the user-space, here are these lines in pm_nl_ctl.c:
>>>>
>>>> 274                 } else if (!strcmp(argv[arg], "port")) {
>>>> 275                         u_int16_t port;
>>>> 276
>>>> 277                         if (++arg >= argc)
>>>> 278                                 error(1, 0, " missing port value");
>>>> 279                         if (!(flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
>>>> 280                                 error(1, 0, " flags must be signal
>>>> when using port");
>>>>
>>>
>>> Hi Geliang, Thanks for point out this, I was use 'ip mptcp' to add address, It doesn't seem to have done that check.
>>> Is it worth to do check in kernel to make sure there is a signal flag before create listening socket?
>>
>> I think it's better to check this in the user-space, you can write a patch
>> to iproute2 to add this check in 'ip mptcp'.
> 
> Or add this check in mptcp_pm_parse_addr, something like:
> 
> $ git diff net/mptcp/pm_netlink.c
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 6ba040897738..9cd4a4180a2a 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -971,8 +971,14 @@ static int mptcp_pm_parse_addr(struct nlattr
> *attr, struct genl_info *info,
>         if (tb[MPTCP_PM_ADDR_ATTR_FLAGS])
>                 entry->flags = nla_get_u32(tb[MPTCP_PM_ADDR_ATTR_FLAGS]);
> 
> -       if (tb[MPTCP_PM_ADDR_ATTR_PORT])
> +       if (tb[MPTCP_PM_ADDR_ATTR_PORT]) {
> +               if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
> +                       NL_SET_ERR_MSG_ATTR("");
> +                       return -EINVAL;
> +               }
> +
>                 entry->addr.port =
> htons(nla_get_u16(tb[MPTCP_PM_ADDR_ATTR_PORT]));
> +       }
> 
>         return 0;
>  }
> 
> WDYT?
> 

I think this is better, we can't assume that all user-space tools works correctly.

> -Geliang
> 
> 
>>
>> Thanks.
>>
>> -Geliang
>>
>>>
>>>> -Geliang
>>>>
>>>>>
>>>>> Fixes: 1729cf186d8a ("mptcp: create the listening socket for new port")
>>>>> Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
>>>>> ---
>>>>>  net/mptcp/pm_netlink.c | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>>>>> index becc32b..dbd6910 100644
>>>>> --- a/net/mptcp/pm_netlink.c
>>>>> +++ b/net/mptcp/pm_netlink.c
>>>>> @@ -1025,7 +1025,7 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
>>>>>         }
>>>>>
>>>>>         *entry = addr;
>>>>> -       if (entry->addr.port) {
>>>>> +       if (entry->addr.port && (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
>>>>>                 ret = mptcp_pm_nl_create_listen_socket(skb->sk, entry);
>>>>>                 if (ret) {
>>>>>                         GENL_SET_ERR_MSG(info, "create listen socket error");
>>>>> --
>>>>> 1.8.3.1
>>>>>
>>>>>
>>>


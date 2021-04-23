Received: from m12-13.163.com (m12-13.163.com [220.181.12.13])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 8DC5770
	for <mptcp@lists.linux.dev>; Fri, 23 Apr 2021 08:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=mv5tn
	IEzuTJTpLDQL+Aesi7uQou54gQQPm011ezC8jU=; b=KG3tTGRRhRwEd1IfQD7gg
	524S/sqEcYXovCXeMlUQPfoD7b6XcCsp2ObI1cUqEtBxrYGGK+Tfr4gV9vraOk97
	f3bp+wkr4LY3ivWmM7/1Wqv+jc6tMk2S+3nqUM3qeJCZTeOs3iF0btM9mOYe9McE
	hZ5YXXFlynYLM4y1mT22Y0=
Received: from [192.168.15.51] (unknown [120.36.226.89])
	by smtp9 (Coremail) with SMTP id DcCowABXX3dggIJgtPL+HA--.3897S2;
	Fri, 23 Apr 2021 16:08:03 +0800 (CST)
Subject: Re: [PATCH] mptcp: create listening socket only if signal flag is set
 on
To: Geliang Tang <geliangtang@gmail.com>
Cc: mptcp@lists.linux.dev
References: <bbe531db-6d59-d341-16ed-f48b1fd43d2a@163.com>
 <CA+WQbwvpviu3FAE06bO3CO2azAegzMi8YUXcQPPMBYM8nW7_cg@mail.gmail.com>
 <1b50d699-45ec-e747-983a-1966f64f8e1c@163.com>
 <CA+WQbwvzabuhsbKKHeWwa3raOfCh270sccdg6=18ytgPjjkaVw@mail.gmail.com>
 <CA+WQbwuSDvyJH+MT00Qvi73MhGoWcrg-AkZfPR56Zfaks2s1uQ@mail.gmail.com>
 <681e0810-fbbc-daaf-054a-0e83038b4d12@163.com>
 <CA+WQbwsfM_DtYk-q1BFy_Ver2z-=-v96yh4xAt_h2ukNmGKJTg@mail.gmail.com>
From: Jianguo Wu <wujianguo106@163.com>
Message-ID: <a7590d2c-6617-3c63-f0a2-ddc96f2ae636@163.com>
Date: Fri, 23 Apr 2021 16:08:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CA+WQbwsfM_DtYk-q1BFy_Ver2z-=-v96yh4xAt_h2ukNmGKJTg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:DcCowABXX3dggIJgtPL+HA--.3897S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXw45uF45JFWktF1kJw4UCFg_yoWrJF4Dpr
	18J3Z8Wr48XryIqry0qF1jqr1agFy5tr1kWr1UK3W2qr4qgF1xJrWUGr15CF1UAr4DJrWU
	XF4UKa13Jw1Uu3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07b0a0PUUUUU=
X-Originating-IP: [120.36.226.89]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/xtbB9wN9kF2MYnoz8QAAsS



On 2021/4/23 15:47, Geliang Tang wrote:
> Jianguo Wu <wujianguo106@163.com> 于2021年4月23日周五 下午3:41写道：
>>
>>
>>
>> On 2021/4/23 15:27, Geliang Tang wrote:
>>> Geliang Tang <geliangtang@gmail.com> 于2021年4月23日周五 下午3:17写道：
>>>>
>>>> Hi Jianguo,
>>>>
>>>> Jianguo Wu <wujianguo106@163.com> 于2021年4月23日周五 下午2:39写道：
>>>>>
>>>>>
>>>>>
>>>>> On 2021/4/23 12:33, Geliang Tang wrote:
>>>>>> Hi Jianguo,
>>>>>>
>>>>>> Thanks for your patch.
>>>>>>
>>>>>> Jianguo Wu <wujianguo106@163.com> 于2021年4月22日周四 下午6:30写道：
>>>>>>>
>>>>>>> From: Jianguo Wu <wujianguo@chinatelecom.cn>
>>>>>>>
>>>>>>> PM announces address to remote host when signal flag is set,
>>>>>>> so create listening socket only if signal flag is set.
>>>>>>
>>>>>> This check has done in the user-space, here are these lines in pm_nl_ctl.c:
>>>>>>
>>>>>> 274                 } else if (!strcmp(argv[arg], "port")) {
>>>>>> 275                         u_int16_t port;
>>>>>> 276
>>>>>> 277                         if (++arg >= argc)
>>>>>> 278                                 error(1, 0, " missing port value");
>>>>>> 279                         if (!(flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
>>>>>> 280                                 error(1, 0, " flags must be signal
>>>>>> when using port");
>>>>>>
>>>>>
>>>>> Hi Geliang, Thanks for point out this, I was use 'ip mptcp' to add address, It doesn't seem to have done that check.
>>>>> Is it worth to do check in kernel to make sure there is a signal flag before create listening socket?
>>>>
>>>> I think it's better to check this in the user-space, you can write a patch
>>>> to iproute2 to add this check in 'ip mptcp'.
>>>
>>> Or add this check in mptcp_pm_parse_addr, something like:
>>>
>>> $ git diff net/mptcp/pm_netlink.c
>>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>>> index 6ba040897738..9cd4a4180a2a 100644
>>> --- a/net/mptcp/pm_netlink.c
>>> +++ b/net/mptcp/pm_netlink.c
>>> @@ -971,8 +971,14 @@ static int mptcp_pm_parse_addr(struct nlattr
>>> *attr, struct genl_info *info,
>>>         if (tb[MPTCP_PM_ADDR_ATTR_FLAGS])
>>>                 entry->flags = nla_get_u32(tb[MPTCP_PM_ADDR_ATTR_FLAGS]);
>>>
>>> -       if (tb[MPTCP_PM_ADDR_ATTR_PORT])
>>> +       if (tb[MPTCP_PM_ADDR_ATTR_PORT]) {
>>> +               if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
>>> +                       NL_SET_ERR_MSG_ATTR("");
>>> +                       return -EINVAL;
>>> +               }
>>> +
>>>                 entry->addr.port =
>>> htons(nla_get_u16(tb[MPTCP_PM_ADDR_ATTR_PORT]));
>>> +       }
>>>
>>>         return 0;
>>>  }
>>>
>>> WDYT?
>>>
>>
>> I think this is better, we can't assume that all user-space tools works correctly.
> 
> You can add this check both in mptcp_pm_parse_addr and in 'ip mptcp'.
> 

Ok, I will send patches soon, Thanks:)

> -Geliang
> 
>>
>>> -Geliang
>>>
>>>
>>>>
>>>> Thanks.
>>>>
>>>> -Geliang
>>>>
>>>>>
>>>>>> -Geliang
>>>>>>
>>>>>>>
>>>>>>> Fixes: 1729cf186d8a ("mptcp: create the listening socket for new port")
>>>>>>> Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
>>>>>>> ---
>>>>>>>  net/mptcp/pm_netlink.c | 2 +-
>>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>>>>>>> index becc32b..dbd6910 100644
>>>>>>> --- a/net/mptcp/pm_netlink.c
>>>>>>> +++ b/net/mptcp/pm_netlink.c
>>>>>>> @@ -1025,7 +1025,7 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
>>>>>>>         }
>>>>>>>
>>>>>>>         *entry = addr;
>>>>>>> -       if (entry->addr.port) {
>>>>>>> +       if (entry->addr.port && (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
>>>>>>>                 ret = mptcp_pm_nl_create_listen_socket(skb->sk, entry);
>>>>>>>                 if (ret) {
>>>>>>>                         GENL_SET_ERR_MSG(info, "create listen socket error");
>>>>>>> --
>>>>>>> 1.8.3.1
>>>>>>>
>>>>>>>
>>>>>
>>
>>


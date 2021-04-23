Received: from m12-13.163.com (m12-13.163.com [220.181.12.13])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 2412E71
	for <mptcp@lists.linux.dev>; Fri, 23 Apr 2021 08:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=rVQhf
	LEcF7hfANd8wNkHtN2F/H57BhJdZ2bjVu7CeLk=; b=gykoc2vRwWyi0Bf3fWzcA
	PJcYY7WWcQz40oR7TytCTv7wymJ7dT8MekWTnUrBViwtrfH4+fuB8r69/aX6rzQ7
	TI2ecSUHIfpIsxqYOi1UP4Ns4ZC/IzZsBpa32uQdRmmreW3cmfdhpwtS25usgFge
	ZVuyDPzHVDV1hGxR+rlMqQ=
Received: from [192.168.15.51] (unknown [120.36.226.89])
	by smtp9 (Coremail) with SMTP id DcCowACHzJGZh4JgIgwCHQ--.12763S2;
	Fri, 23 Apr 2021 16:38:51 +0800 (CST)
Subject: Re: [PATCH] mptcp: create listening socket only if signal flag is set
 on
To: Matthieu Baerts <matthieu.baerts@tessares.net>,
 Geliang Tang <geliangtang@gmail.com>
Cc: mptcp@lists.linux.dev
References: <bbe531db-6d59-d341-16ed-f48b1fd43d2a@163.com>
 <CA+WQbwvpviu3FAE06bO3CO2azAegzMi8YUXcQPPMBYM8nW7_cg@mail.gmail.com>
 <1b50d699-45ec-e747-983a-1966f64f8e1c@163.com>
 <CA+WQbwvzabuhsbKKHeWwa3raOfCh270sccdg6=18ytgPjjkaVw@mail.gmail.com>
 <CA+WQbwuSDvyJH+MT00Qvi73MhGoWcrg-AkZfPR56Zfaks2s1uQ@mail.gmail.com>
 <681e0810-fbbc-daaf-054a-0e83038b4d12@163.com>
 <3c3cf25d-aa4c-d522-102b-ebdd3b767cc0@tessares.net>
From: Jianguo Wu <wujianguo106@163.com>
Message-ID: <4b4f4935-138d-a6fc-dfdc-3ef059a33c3e@163.com>
Date: Fri, 23 Apr 2021 16:38:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <3c3cf25d-aa4c-d522-102b-ebdd3b767cc0@tessares.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:DcCowACHzJGZh4JgIgwCHQ--.12763S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuFy5uFy7Wr4DXr47Xw1fWFg_yoW5ur47pr
	W5tF1DWF4DXr10yr92qF1jgr13Kr90yr1rWw1jg3W2vw4qgFyftrWxGr15CFyUCrs5XrW2
	vF4UtayfAa4Uu3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07b038nUUUUU=
X-Originating-IP: [120.36.226.89]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/1tbiNxt9kFWBkLGJ0gAAsv



On 2021/4/23 16:21, Matthieu Baerts wrote:
> Hi Jianguo, Geliang,
> 
> Thank you for the patches and reviews!
> 
> On 23/04/2021 09:41, Jianguo Wu wrote:
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
> I was thinking a bit about that. With the proposed modifications, it
> means that a server will have to send an ADD_ADDR if it wants to accept
> subflows on another port. I guess there will be use-cases where we will
> not want to send ADD_ADDR because we are in a controlled environment or
> we don't want to announce a public ADD_ADDR+port on a specific network.
> 

Hi Matt, do you mean there will be use-cases where using ADD_ADDR+port as local address to initiate
a outgoing subflow join, but not send ADD_ADDR?

> Do we have to support that? Maybe safer to restrict actions for now and
> allow that later if there are needs, no?
> 
> In other words, I guess we should accept the proposed modifications.
> Any other points of view? :)
> 
> Cheers,
> Matt
> 


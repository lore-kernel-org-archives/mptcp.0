Received: from m12-18.163.com (m12-18.163.com [220.181.12.18])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A38A2F81
	for <mptcp@lists.linux.dev>; Thu, 22 Apr 2021 03:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=sypIb
	CUAzzP4Gtjm8/kzfESlxTbbSBcb5LY6o9i+afQ=; b=Nj8n1DF2uucC3CQ/VJcmd
	rtBkLRT733+l8v8zVdYKEummN2fE4VgQ+D5v8UB94VwFDs18xYVWW5+am+p7+XUB
	PMf5Yr6c27Hrp28FUlxf4I3AAMIec9bgRTDMbfEBJJLrue/11I7rnWxAcSvIcPzO
	cxNeieDFtGKQhV9DNsmoP0=
Received: from [192.168.15.51] (unknown [120.36.226.89])
	by smtp14 (Coremail) with SMTP id EsCowAB3fQml5IBgiHXUfA--.30536S2;
	Thu, 22 Apr 2021 10:51:18 +0800 (CST)
Subject: Re: [PATCH] mptcp: store remote token in mptcp sock
To: Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev, matthieu.baerts@tessares.net,
 Florian Westphal <fw@strlen.de>
References: <4e1d608e-4bcd-a432-03b7-860cd3e007c2@163.com>
 <4cf0e328-db13-9c37-e87f-f84910d01070@linux.intel.com>
 <28677691-e7f6-4192-d6c1-41e3087c5509@163.com>
 <1cae9ed8392577adab3e20fd6904a1a0af7176ab.camel@redhat.com>
 <eb233af8-0941-abb1-3da3-60453be3d849@163.com>
 <b75258f2fdf3997ac80b043e39db9914843e46af.camel@redhat.com>
From: Jianguo Wu <wujianguo106@163.com>
Message-ID: <a72622cb-d998-e457-77ce-7e7e7b83e654@163.com>
Date: Thu, 22 Apr 2021 10:51:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <b75258f2fdf3997ac80b043e39db9914843e46af.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:EsCowAB3fQml5IBgiHXUfA--.30536S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKFWUWFyDAw1fuFWfJw4DXFb_yoWxXFW5pr
	W7KF15Crn5JF9rtw1vvr1UXwnFgr4ftFn8Ww17X3WxArsFvr9rJr1UGFW5CrWUWr4DtF9x
	Xr45XanrGFyDCaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07b2pB-UUUUU=
X-Originating-IP: [120.36.226.89]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/1tbiNwZ8kFWBkKGLeAAAsL



On 2021/4/21 17:53, Paolo Abeni wrote:
> On Wed, 2021-04-21 at 16:49 +0800, Jianguo Wu wrote:
>>
>> On 2021/4/21 16:01, Paolo Abeni wrote:
>>> On Wed, 2021-04-21 at 09:43 +0800, Jianguo Wu wrote:
>>>> On 2021/4/21 9:01, Mat Martineau wrote:
>>>>> On Tue, 20 Apr 2021, Jianguo Wu wrote:
>>>>>
>>>>>> From: Jianguo Wu <wujianguo@chinatelecom.cn>
>>>>>>
>>>>>> Now every time create a new subflow, it needs to generate remote
>>>>>> token in __mptcp_subflow_connect(), the remote token is the same
>>>>>> among all subflows in a mptcp connection, so we can store
>>>>>> remote token in mptcp sock.
>>>>>>
>>>>>> Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
>>>>>> ---
>>>>>> net/mptcp/protocol.c | 5 +++--
>>>>>> net/mptcp/protocol.h | 1 +
>>>>>> net/mptcp/subflow.c  | 7 +++----
>>>>>> 3 files changed, 7 insertions(+), 6 deletions(-)
>>>>>>
>>>>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>>>>> index a8180a9..607fb30 100644
>>>>>> --- a/net/mptcp/protocol.c
>>>>>> +++ b/net/mptcp/protocol.c
>>>>>> @@ -2736,7 +2736,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
>>>>>>     if (mp_opt->mp_capable) {
>>>>>>         msk->can_ack = true;
>>>>>>         msk->remote_key = mp_opt->sndr_key;
>>>>>> -        mptcp_crypto_key_sha(msk->remote_key, NULL, &ack_seq);
>>>>>> +        mptcp_crypto_key_sha(msk->remote_key, &msk->remote_token, &ack_seq);
>>>>>>         ack_seq++;
>>>>>>         WRITE_ONCE(msk->ack_seq, ack_seq);
>>>>>>         WRITE_ONCE(msk->rcv_wnd_sent, ack_seq);
>>>>>> @@ -2967,7 +2967,7 @@ void mptcp_finish_connect(struct sock *ssk)
>>>>>>
>>>>>>     pr_debug("msk=%p, token=%u", sk, subflow->token);
>>>>>>
>>>>>> -    mptcp_crypto_key_sha(subflow->remote_key, NULL, &ack_seq);
>>>>>> +    mptcp_crypto_key_sha(subflow->remote_key, &subflow->remote_token, &ack_seq);
>>>>>>     ack_seq++;
>>>>>>     subflow->map_seq = ack_seq;
>>>>>>     subflow->map_subflow_seq = 1;
>>>>>> @@ -2976,6 +2976,7 @@ void mptcp_finish_connect(struct sock *ssk)
>>>>>>      * accessing the field below
>>>>>>      */
>>>>>>     WRITE_ONCE(msk->remote_key, subflow->remote_key);
>>>>>> +    WRITE_ONCE(msk->remote_token, subflow->remote_token);
>>>>>>     WRITE_ONCE(msk->local_key, subflow->local_key);
>>>>>>     WRITE_ONCE(msk->write_seq, subflow->idsn + 1);
>>>>>>     WRITE_ONCE(msk->snd_nxt, msk->write_seq);
>>>>>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>>>>>> index edc0128..abd8e31 100644
>>>>>> --- a/net/mptcp/protocol.h
>>>>>> +++ b/net/mptcp/protocol.h
>>>>>> @@ -226,6 +226,7 @@ struct mptcp_sock {
>>>>>>     u64        wnd_end;
>>>>>>     unsigned long    timer_ival;
>>>>>>     u32        token;
>>>>>> +    u32        remote_token;
>>>>>>     int        rmem_released;
>>>>>>     unsigned long    flags;
>>>>>>     bool        can_ack;
>>>>>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>>>>>> index 82e91b0..ddd8c03 100644
>>>>>> --- a/net/mptcp/subflow.c
>>>>>> +++ b/net/mptcp/subflow.c
>>>>>> @@ -1046,6 +1046,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
>>>>>>                 goto fatal;
>>>>>>             }
>>>>>>             WRITE_ONCE(msk->remote_key, subflow->remote_key);
>>>>>> +            mptcp_crypto_key_sha(READ_ONCE(msk->remote_key), &msk->remote_token, NULL);
>>>>>
>>>>> Hi Jianguo, thanks for your patch.
>>>>>
>>>>> This adds a possible extra SHA calculation in this function, on the server side of a connection that may not ever use the token. This code path is only encountered in rare conditions, though: when an MP_CAPABLE+data packet is late, retransmitted, or out-of-order.
>>>>>
>>>>> (also, if we move ahead with this patch, the token should be written to a local variable and then copied to msk->remote_token using WRITE_ONCE(). Would also be more efficient to pass subflow->remote_key as the first arg because there's no READ_ONCE() required to read from the subflow structure)
>>>>>
>>>>>>             WRITE_ONCE(msk->ack_seq, subflow->map_seq);
>>>>>>             WRITE_ONCE(msk->can_ack, true);
>>>>>>         }
>>>>>> @@ -1268,7 +1269,6 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
>>>>>>     int local_id = loc->id;
>>>>>>     struct socket *sf;
>>>>>>     struct sock *ssk;
>>>>>> -    u32 remote_token;
>>>>>>     int addrlen;
>>>>>>     int err;
>>>>>>
>>>>>> @@ -1308,10 +1308,9 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
>>>>>>     if (err)
>>>>>>         goto failed;
>>>>>>
>>>>>> -    mptcp_crypto_key_sha(subflow->remote_key, &remote_token, NULL);
>>>>>>     pr_debug("msk=%p remote_token=%u local_id=%d remote_id=%d", msk,
>>>>>> -         remote_token, local_id, remote_id);
>>>>>> -    subflow->remote_token = remote_token;
>>>>>> +         msk->remote_token, local_id, remote_id);
>>>>>> +    subflow->remote_token = msk->remote_token;
>>>>>
>>>>> And here, I think, is the tradeoff: with this patch, there is no need to recalculate the SHA on every outgoing join. That's more common on the client side of a connection, where there will not be a large number of joins initiated so the cost is not very high.
>>>>>
>>>>> Given the client/server tradeoff and the likely small number of joins on any given connection, do you think this is worth changing?
>>>>
>>>> Hi Mat, thanks for your comments!
>>>>
>>>> I think, with high CPS, it can reduce lots of recalculation, and in
>>>> some scenarios, such as the middle mile, server side can also
>>>> initiate join subflows,
>>>
>>> Uhmm... In the connections/rate performance test I did, the crypto-
>>> related overhead was quite low, almost un-noticeable. Do you have any
>>> perf figures for the above scenario (e.g. perf report or flamegraph)?
>>>
>>
>> Sorry, I haven't do performance test.
> 
> Ok, than I think you should really start from there, collecting the
> perf data in your reference scenario (or in a testbed doing similar
> works) and see if something interesting and addressable pops up.
> 

OK, Thanks!

> For the records, there are a bunch of items which will improve
> performances with no drawback:
> 
> https://github.com/multipath-tcp/mptcp_net-next/issues/42
> https://github.com/multipath-tcp/mptcp_net-next/issues/15
> 
> (the above 2 are related)
> 
> https://github.com/multipath-tcp/mptcp_net-next/issues/41
> https://github.com/multipath-tcp/mptcp_net-next/issues/24
> 
> Thanks!
> 
> Paolo
> 


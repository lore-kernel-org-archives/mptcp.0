Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.228])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02CC72
	for <mptcp@lists.linux.dev>; Mon, 12 Jul 2021 09:21:51 +0000 (UTC)
HMM_SOURCE_IP:172.18.0.218:49810.228866607
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.26?logid-bd158d1f8b1f4c5a87ed6d1cf82604be (unknown [172.18.0.218])
	by chinatelecom.cn (HERMES) with SMTP id D4469280141;
	Mon, 12 Jul 2021 17:21:51 +0800 (CST)
X-189-SAVE-TO-SEND: liyonglong@chinatelecom.cn
Received: from  ([172.18.0.218])
	by app0025 with ESMTP id bd158d1f8b1f4c5a87ed6d1cf82604be for mptcp@lists.linux.dev;
	Mon Jul 12 17:21:50 2021
X-Transaction-ID: bd158d1f8b1f4c5a87ed6d1cf82604be
X-filter-score:
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 172.18.0.218
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
Subject: Re: [MPTCP][PATCH mptcp-next] Squash to "mptcp: build
 ADD_ADDR/echo-ADD_ADDR option according pm.add_signal"
To: Geliang Tang <geliangtang@gmail.com>
Cc: mptcp@lists.linux.dev
References: <9365b79b245b8a87af18ca458c67820d47de2515.1626016228.git.geliangtang@gmail.com>
 <80fa33a249c2ecc7edd9d0047dd84f163307cee7.1626016292.git.geliangtang@gmail.com>
 <347f6214-cc6b-2af2-c1e7-d9ac7f77f87e@chinatelecom.cn>
 <CA+WQbwuTFxxzsbDdeiWgMN7iqUp9e-ubAmsLa7JpaZbQ+WSBBw@mail.gmail.com>
 <4f790fa7-f99e-401e-d266-8fd85921204a@chinatelecom.cn>
 <CA+WQbwsuJTtVZ_hW1K25a4YOkSs7DGKOnjt=escT66QQg8WjRQ@mail.gmail.com>
 <CA+WQbwsd_3AqgwawQu_6socwuviNXMrck-BxjMJ+PU-D9QVX9g@mail.gmail.com>
From: Yonglong Li <liyonglong@chinatelecom.cn>
Message-ID: <8b424320-ae9e-18bb-2011-cb7562497f13@chinatelecom.cn>
Date: Mon, 12 Jul 2021 17:21:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CA+WQbwsd_3AqgwawQu_6socwuviNXMrck-BxjMJ+PU-D9QVX9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit



On 2021/7/12 17:07, Geliang Tang wrote:
> Geliang Tang <geliangtang@gmail.com> 于2021年7月12日周一 下午4:44写道：
>>
>> Yonglong Li <liyonglong@chinatelecom.cn> 于2021年7月12日周一 下午4:07写道：
>>>
>>>
>>>
>>> On 2021/7/12 15:33, Geliang Tang wrote:
>>>> Hi Yonglong,
>>>>
>>>> Yonglong Li <liyonglong@chinatelecom.cn> 于2021年7月12日周一 上午9:34写道：
>>>>>
>>>>>
>>>>>
>>>>> On 2021/7/11 23:15, Geliang Tang wrote:
>>>>>> I think there're still some issues in v8:
>>>>>>
>>>>>> The remaining value is incorrect since "remaining += opt_size;" in the
>>>>>> "drop other suboptions" checks has been called twice in
>>>>>> mptcp_pm_add_addr_signal and mptcp_established_options_add_addr.
>>>>>>
>>>>> I think "remaining" in mptcp_pm_add_addr_signal does not touch "remaining" in
>>>>> mptcp_established_options_add_addr.
>>>>>
>>>>>> opts->local and opts->remote in mptcp_pm_add_addr_signal need be
>>>>>> populate after the length chech, not before the check.]
>>>>>>
>>>>>> The squash-to patch keeped the more orignal code unchanged, and just do
>>>>>> the least, necessary modifications.
>>>>>>
>>>>> Agree opts->local and opts->remote should be asigned after the length check.
>>>>> But if keep the length check out of mptcp_pm_add_addr_signal (out of pm lock )
>>>>> as orignal code, there is a race that:
>>>>>
>>>>> ==> a add addr event (pm.addr_signal == MPTCP_ADD_ADDR_SIGNAL)
>>>>> ==> call mptcp_pm_add_addr_signal
>>>>> ==> a echo add addr event trigger (pm.addr_signal == MPTCP_ADD_ADDR_ECHO|MPTCP_ADD_ADDR_SIGNAL)
>>>>> ==> at this time opts->remote is empty and the length is incorrect.
>>>>>
>>>>
>>>> What will happen in v8 when this race occurs? How dose v8 deal with the
>>>> race?
>>> Hi Geliang, thinks for your patience.
>>>
>>> I think v8 doesn't have this issue:
>>> ==> a add addr event (pm.addr_signal == MPTCP_ADD_ADDR_SIGNAL)
>>> ==> call mptcp_pm_add_addr_signal, save pm.addr_signal to add_addr and save addr in opts under pm.lock
>>> ==> a echo add addr event trigger (pm.addr_signal == MPTCP_ADD_ADDR_ECHO), but add_addr doesn't changed.
>>> ==> use add_addr and opts to check length.
>>> ==> next send ack process will deal with MPTCP_ADD_ADDR_ECHO event.
>>
>> Thanks for your explanation.
>>
>> I think this squash-to patch did the same thing:
>>
>> ==> an add addr event (pm.addr_signal == MPTCP_ADD_ADDR_SIGNAL)
>> ==> call mptcp_pm_add_addr_signal, save echo bit of pm.addr_signal to
>> 'echo' (echo = false), save the port number to 'port', and save addr
>> in opts under pm.lock
>> ==> an echo add addr event trigger (pm.addr_signal ==
>> MPTCP_ADD_ADDR_ECHO), but 'echo' and 'port' don't changed.
>> ==> use 'echo' to get the address family, use 'family', 'echo' and
>> 'port' to check length.
>> ==> next send ack process will deal with MPTCP_ADD_ADDR_ECHO event.
>>
>> Do you think so?
> 
> And one more thing. How do you test this "mptcp: fix conflicts when using
> pm.add_signal in ADD_ADDR/echo and RM_ADDR process" series? Do you use our
> mptcp_join.sh to test it, or you did some special tests? Does this race
> scenario mentioned above easy to reproduce?
> 
> I just did the mptcp_join.sh tests for my squash-to patches, and everything
> looks fine. If you have some special tests, could you please help me to test
> these squash-to patches too? Hope it works in the race scenario.
> 
> Thanks.
> -Geliang
> 
OK. I will try to test the squash-to patches.
The race scenario is not easy to reproduce. :(
A loop script will try many times to reproduce.

> 
> 
>>
>>>
>>>>
>>>>> So I think the orignal code is incorrect. WDYT?
>>>>>
>>>>>> Drop the "drop other suboptions" check in mptcp_pm_add_addr_signal.
>>>>>>
>>>>>> Change arguments of mptcp_pm_add_addr_signal.
>>>>>>
>>>>>> Keep mptcp_add_addr_len unchanged.
>>>>>>
>>>>>> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
>>>>>> ---
>>>>>>  net/mptcp/options.c  | 35 +++++++++++++++++------------------
>>>>>>  net/mptcp/pm.c       | 23 +++++++++--------------
>>>>>>  net/mptcp/protocol.h | 27 +++++++++------------------
>>>>>>  3 files changed, 35 insertions(+), 50 deletions(-)
>>>>>>
>>>>>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>>>>>> index 5c0ad9b90866..93ad7b134f74 100644
>>>>>> --- a/net/mptcp/options.c
>>>>>> +++ b/net/mptcp/options.c
>>>>>> @@ -663,16 +663,14 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
>>>>>>       struct mptcp_sock *msk = mptcp_sk(subflow->conn);
>>>>>>       bool drop_other_suboptions = false;
>>>>>>       unsigned int opt_size = *size;
>>>>>> -     u8 add_addr;
>>>>>> +     bool echo;
>>>>>> +     bool port;
>>>>>> +     u8 family;
>>>>>>       int len;
>>>>>>
>>>>>> -     if (!mptcp_pm_should_add_signal(msk) ||
>>>>>> -         !mptcp_pm_add_addr_signal(msk, skb, opt_size, remaining, opts, &add_addr))
>>>>>> -             return false;
>>>>>> -
>>>>>> -     if (((add_addr & BIT(MPTCP_ADD_ADDR_ECHO)) ||
>>>>>> -          ((add_addr & BIT(MPTCP_ADD_ADDR_SIGNAL)) &&
>>>>>> -           (opts->local.family == AF_INET6 || opts->local.port))) &&
>>>>>> +     if ((mptcp_pm_should_add_signal_echo(msk) ||
>>>>>> +          (mptcp_pm_should_add_signal_addr(msk) &&
>>>>>> +           (msk->pm.local.family == AF_INET6 || msk->pm.local.port))) &&
>>>>>>           skb && skb_is_tcp_pure_ack(skb)) {
>>>>>>               pr_debug("drop other suboptions");
>>>>>>               opts->suboptions = 0;
>>>>>> @@ -682,7 +680,12 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
>>>>>>               drop_other_suboptions = true;
>>>>>>       }
>>>>>>
>>>>>> -     len = mptcp_add_addr_len(opts, add_addr);
>>>>>> +     if (!mptcp_pm_should_add_signal(msk) ||
>>>>>> +         !mptcp_pm_add_addr_signal(msk, remaining, &opts->local, &opts->remote, &echo, &port))
>>>>>> +             return false;
>>>>>> +
>>>>>> +     family = echo ? opts->remote.family : opts->local.family;
>>>>>> +     len = mptcp_add_addr_len(family, echo, port);
>>>>>>       if (remaining < len)
>>>>>>               return false;
>>>>>>
>>>>>> @@ -690,15 +693,14 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
>>>>>>       if (drop_other_suboptions)
>>>>>>               *size -= opt_size;
>>>>>>       opts->suboptions |= OPTION_MPTCP_ADD_ADDR;
>>>>>> -     if (!(add_addr & BIT(MPTCP_ADD_ADDR_ECHO)) &&
>>>>>> -         (add_addr & BIT(MPTCP_ADD_ADDR_SIGNAL))) {
>>>>>> +     if (!echo) {
>>>>>>               opts->ahmac = add_addr_generate_hmac(msk->local_key,
>>>>>>                                                    msk->remote_key,
>>>>>>                                                    &opts->local);
>>>>>>       }
>>>>>> -     pr_debug("addr_signal:%x, echo=%d, local_addr_id=%d, ahmac=%llu, local_port=%d, remote_addr_id=%d, remote_port=%d",
>>>>>> -              add_addr, (opts->ahmac == 0), opts->local.id, opts->ahmac,
>>>>>> -              ntohs(opts->local.port), opts->remote.id, ntohs(opts->remote.port));
>>>>>> +     pr_debug("local_id=%d, local_port=%d, remote_id=%d, remote_port=%d, ahmac=%llu, echo=%d",
>>>>>> +              opts->local.id, ntohs(opts->local.port), opts->remote.id,
>>>>>> +              ntohs(opts->remote.port), opts->ahmac, echo);
>>>>>>
>>>>>>       return true;
>>>>>>  }
>>>>>> @@ -1253,13 +1255,10 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
>>>>>>
>>>>>>  mp_capable_done:
>>>>>>       if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
>>>>>> -             struct mptcp_addr_info *addr = &opts->remote;
>>>>>> +             struct mptcp_addr_info *addr = opts->ahmac ? &opts->local : &opts->remote;
>>>>>>               u8 len = TCPOLEN_MPTCP_ADD_ADDR_BASE;
>>>>>>               u8 echo = MPTCP_ADDR_ECHO;
>>>>>>
>>>>>> -             if (opts->ahmac)
>>>>>> -                     addr = &opts->local;
>>>>>> -
>>>>>>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
>>>>>>               if (addr->family == AF_INET6)
>>>>>>                       len = TCPOLEN_MPTCP_ADD_ADDR6_BASE;
>>>>>> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
>>>>>> index 264f522af530..399b59cb7563 100644
>>>>>> --- a/net/mptcp/pm.c
>>>>>> +++ b/net/mptcp/pm.c
>>>>>> @@ -253,12 +253,13 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup)
>>>>>>
>>>>>>  /* path manager helpers */
>>>>>>
>>>>>> -bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
>>>>>> -                           unsigned int opt_size, unsigned int remaining,
>>>>>> -                           struct mptcp_out_options *opts,  u8 *add_addr)
>>>>>> +bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
>>>>>> +                           struct mptcp_addr_info *saddr, struct mptcp_addr_info *daddr,
>>>>>> +                           bool *echo, bool *port)
>>>>>>  {
>>>>>>       int ret = false;
>>>>>>       u8 add_addr;
>>>>>> +     u8 family;
>>>>>>
>>>>>>       spin_lock_bh(&msk->pm.lock);
>>>>>>
>>>>>> @@ -266,21 +267,15 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
>>>>>>       if (!mptcp_pm_should_add_signal(msk))
>>>>>>               goto out_unlock;
>>>>>>
>>>>>> -     opts->local = msk->pm.local;
>>>>>> -     opts->remote = msk->pm.remote;
>>>>>> -     *add_addr = msk->pm.addr_signal;
>>>>>> +     *echo = mptcp_pm_should_add_signal_echo(msk);
>>>>>> +     *port = !!(*echo ? msk->pm.remote.port : msk->pm.local.port);
>>>>>>
>>>>>> -     if (((msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_ECHO)) ||
>>>>>> -          ((msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_SIGNAL)) &&
>>>>>> -           (msk->pm.local.family == AF_INET6 || msk->pm.local.port))) &&
>>>>>> -         skb && skb_is_tcp_pure_ack(skb)) {
>>>>>> -             remaining += opt_size;
>>>>>> -     }
>>>>>> -
>>>>>> -     if (remaining < mptcp_add_addr_len(opts, *add_addr))
>>>>>> +     family = *echo ? msk->pm.remote.family : msk->pm.local.family;
>>>>>> +     if (remaining < mptcp_add_addr_len(family, *echo, *port))
>>>>>>               goto out_unlock;
>>>>>>
>>>>>>       *saddr = msk->pm.local;
>>>>>> +     *daddr = msk->pm.remote;
>>>>>>       add_addr = READ_ONCE(msk->pm.addr_signal);
>>>>>>       if (mptcp_pm_should_add_signal_echo(msk))
>>>>>>               add_addr &= ~BIT(MPTCP_ADD_ADDR_ECHO);
>>>>>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>>>>>> index 937e0309e340..4b63cc6079fa 100644
>>>>>> --- a/net/mptcp/protocol.h
>>>>>> +++ b/net/mptcp/protocol.h
>>>>>> @@ -766,25 +766,16 @@ static inline bool mptcp_pm_should_rm_signal(struct mptcp_sock *msk)
>>>>>>       return READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_RM_ADDR_SIGNAL);
>>>>>>  }
>>>>>>
>>>>>> -static inline unsigned int mptcp_add_addr_len(struct mptcp_out_options *opts,
>>>>>> -                                           u8 add_addr)
>>>>>> +static inline unsigned int mptcp_add_addr_len(int family, bool echo, bool port)
>>>>>>  {
>>>>>> -     struct mptcp_addr_info *addr = &opts->remote;
>>>>>> -     u8 len = 0;
>>>>>> +     u8 len = TCPOLEN_MPTCP_ADD_ADDR_BASE;
>>>>>>
>>>>>> -     if (!(add_addr & BIT(MPTCP_ADD_ADDR_ECHO)) &&
>>>>>> -         (add_addr & BIT(MPTCP_ADD_ADDR_SIGNAL))) {
>>>>>> -             addr = &opts->local;
>>>>>> +     if (family == AF_INET6)
>>>>>> +             len = TCPOLEN_MPTCP_ADD_ADDR6_BASE;
>>>>>> +     if (!echo)
>>>>>>               len += MPTCPOPT_THMAC_LEN;
>>>>>> -     }
>>>>>> -
>>>>>> -     if (addr->family == AF_INET6)
>>>>>> -             len += TCPOLEN_MPTCP_ADD_ADDR6_BASE;
>>>>>> -     else
>>>>>> -             len += TCPOLEN_MPTCP_ADD_ADDR_BASE;
>>>>>> -
>>>>>>       /* account for 2 trailing 'nop' options */
>>>>>> -     if (addr->port)
>>>>>> +     if (port)
>>>>>>               len += TCPOLEN_MPTCP_PORT_LEN + TCPOLEN_MPTCP_PORT_ALIGN;
>>>>>>
>>>>>>       return len;
>>>>>> @@ -798,9 +789,9 @@ static inline int mptcp_rm_addr_len(const struct mptcp_rm_list *rm_list)
>>>>>>       return TCPOLEN_MPTCP_RM_ADDR_BASE + roundup(rm_list->nr - 1, 4) + 1;
>>>>>>  }
>>>>>>
>>>>>> -bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
>>>>>> -                           unsigned int opt_size, unsigned int remaining,
>>>>>> -                           struct mptcp_out_options *opts,  u8 *add_addr);
>>>>>> +bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
>>>>>> +                           struct mptcp_addr_info *saddr, struct mptcp_addr_info *daddr,
>>>>>> +                           bool *echo, bool *port);
>>>>>>  bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
>>>>>>                            struct mptcp_rm_list *rm_list);
>>>>>>  int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
>>>>>>
>>>>>
>>>>> --
>>>>> Li YongLong
>>>>
>>>
>>> --
>>> Li YongLong
> 

-- 
Li YongLong

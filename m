Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8B670
	for <mptcp@lists.linux.dev>; Wed, 30 Jun 2021 01:37:22 +0000 (UTC)
HMM_SOURCE_IP:172.18.0.48:42188.2138905206
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.26?logid-55f7ddb8cbb94cbaa507b28e8c7b78e5 (unknown [172.18.0.48])
	by chinatelecom.cn (HERMES) with SMTP id 5500028011A;
	Wed, 30 Jun 2021 09:30:30 +0800 (CST)
X-189-SAVE-TO-SEND: liyonglong@chinatelecom.cn
Received: from  ([172.18.0.48])
	by app0024 with ESMTP id 55f7ddb8cbb94cbaa507b28e8c7b78e5 for mathew.j.martineau@linux.intel.com;
	Wed Jun 30 09:30:30 2021
X-Transaction-ID: 55f7ddb8cbb94cbaa507b28e8c7b78e5
X-filter-score:
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 172.18.0.48
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
Subject: Re: [PATCH v6 3/4] mptcp: build ADD_ADDR/echo-ADD_ADDR option
 according pm.add_signal
To: Geliang Tang <geliangtang@gmail.com>
Cc: mptcp@lists.linux.dev, Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <1624930899-99623-1-git-send-email-liyonglong@chinatelecom.cn>
 <1624930899-99623-4-git-send-email-liyonglong@chinatelecom.cn>
 <CA+WQbwvCWgCog4jxVjpQxvJ0_ojms8ND=gP1WJUA=0B-zGB-=A@mail.gmail.com>
 <3ab57409-8d5b-981a-7656-fc2f1f6167ad@chinatelecom.cn>
 <CA+WQbwtW-H6NoHFV=xqfVsGJ4Z5YwQkOd8vu=JSiuJyztx3Kzg@mail.gmail.com>
 <2f36e070-496f-c7a7-cb5a-26787db05dbd@chinatelecom.cn>
 <CA+WQbwuAkExnpvCMLQAQ=Z2uKApJJ+tZZb4p06Zf+YPznovOWw@mail.gmail.com>
From: Yonglong Li <liyonglong@chinatelecom.cn>
Message-ID: <14a8296f-cd3e-dc1d-68fe-b0f0e67930d4@chinatelecom.cn>
Date: Wed, 30 Jun 2021 09:30:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CA+WQbwuAkExnpvCMLQAQ=Z2uKApJJ+tZZb4p06Zf+YPznovOWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit



On 2021/6/29 16:25, Geliang Tang wrote:
> Yonglong Li <liyonglong@chinatelecom.cn> 于2021年6月29日周二 下午3:54写道：
>>
>>
>>
>> On 2021/6/29 15:35, Geliang Tang wrote:
>>> Yonglong Li <liyonglong@chinatelecom.cn> 于2021年6月29日周二 下午3:02写道：
>>>>
>>>>
>>>> Hi Geiliang, Thanks for your reviews.
>>>>
>>>> On 2021/6/29 13:58, Geliang Tang wrote:
>>>>> Yonglong Li <liyonglong@chinatelecom.cn> 于2021年6月29日周二 上午9:42写道：
>>>>>>
>>>>>> according MPTCP_ADD_ADDR_SIGNAL and MPTCP_ADD_ADDR_ECHO flag build
>>>>>> ADD_ADDR/echo-ADD_ADDR option
>>>>>>
>>>>>> add a suboptions type OPTION_MPTCP_ADD_ECHO to mark as echo option
>>>>>>
>>>>>> Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
>>>>>> ---
>>>>>>  include/net/mptcp.h  |  3 ++-
>>>>>>  net/mptcp/options.c  | 65 +++++++++++++++++++++++++++++++---------------------
>>>>>>  net/mptcp/pm.c       | 33 +++++++++++---------------
>>>>>>  net/mptcp/protocol.h | 23 ++++++++++++-------
>>>>>>  4 files changed, 69 insertions(+), 55 deletions(-)
>>>>>>
>>>>>> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
>>>>>> index d61bbbf..d2c6ebe 100644
>>>>>> --- a/include/net/mptcp.h
>>>>>> +++ b/include/net/mptcp.h
>>>>>> @@ -61,7 +61,8 @@ struct mptcp_out_options {
>>>>>>         u64 sndr_key;
>>>>>>         u64 rcvr_key;
>>>>>>         u64 ahmac;
>>>>>> -       struct mptcp_addr_info addr;
>>>>>> +       struct mptcp_addr_info local;
>>>>>> +       struct mptcp_addr_info remote;
>>>>>>         struct mptcp_rm_list rm_list;
>>>>>>         u8 join_id;
>>>>>>         u8 backup;
>>>>>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>>>>>> index 1aec016..1707bec 100644
>>>>>> --- a/net/mptcp/options.c
>>>>>> +++ b/net/mptcp/options.c
>>>>>> @@ -655,13 +655,15 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
>>>>>>         struct mptcp_sock *msk = mptcp_sk(subflow->conn);
>>>>>>         bool drop_other_suboptions = false;
>>>>>>         unsigned int opt_size = *size;
>>>>>> -       bool echo;
>>>>>> -       bool port;
>>>>>> -       int len;
>>>>>> +       u8 add_addr, flags = 0xff;
>>>>>> +       int len = 0;
>>>>>>
>>>>>> -       if ((mptcp_pm_should_add_signal_ipv6(msk) ||
>>>>>> -            mptcp_pm_should_add_signal_port(msk) ||
>>>>>> -            mptcp_pm_should_add_signal_echo(msk)) &&
>>>>>> +       if (!mptcp_pm_add_addr_signal(msk, opts, &add_addr))
>>>>>> +               return false;
>>>>>
>>>>> This add_addr argument is useless, let's drop it.
>>>>>
>>>> we can use add_addr use in debug log.
>>>
>>> I think it's not worth adding a new argument just for debugging.
>> agree.
>>
>>>
>>>>
>>>>> And here add back mptcp_pm_should_add_signal check here. The original code
>>>>> called mptcp_pm_should_add_signal twice for double check, once out of pm
>>>>> lock, once under pm lock. We should keep it.
>>>> Sorry, I think double check is not necessary. does we need double check?
>>>
>>> I think we should keep the original logic here. If we want to drop this
>>> double check or something, we should do it in another patch, don't mix too
>>> much things in one patch.
>> agree.
>>
>>>
>>>>
>>>>>
>>>>>> +
>>>>>> +       if ((mptcp_pm_should_add_signal_echo(msk) ||
>>>>>> +            (mptcp_pm_should_add_signal_addr(msk) &&
>>>>>> +             (opts->local.family == AF_INET6 || opts->local.port))) &&
>>>>>>             skb && skb_is_tcp_pure_ack(skb)) {
>>>>>>                 pr_debug("drop other suboptions");
>>>>>>                 opts->suboptions = 0;
>>>>>> @@ -671,11 +673,17 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
>>>>>>                 drop_other_suboptions = true;
>>>>>>         }
>>>>>>
>>>>>> -       if (!mptcp_pm_should_add_signal(msk) ||
>>>>>> -           !(mptcp_pm_add_addr_signal(msk, remaining, &opts->addr, &echo, &port)))
>>>>>> -               return false;
>>>>>>
>>>>>> -       len = mptcp_add_addr_len(opts->addr.family, echo, port);
>>>>>> +       if (mptcp_pm_should_add_signal_echo(msk)) {
>>>>>> +               flags = (u8)~BIT(MPTCP_ADD_ADDR_ECHO);
>>>>>> +       } else {
>>>>>> +               opts->ahmac = add_addr_generate_hmac(msk->local_key,
>>>>>> +                                                    msk->remote_key,
>>>>>> +                                                    &opts->local);
>>>>>
>>>>> Keep this ahmac generating code after opts->suboptions set just like the
>>>>> original code, since ahmac is the more expensive to populate. If remaining
>>>>> length isn't enough, no need to set ahmac.
>>>>
>>>> because mptcp_add_addr_len(opts) will use ahmac to calculate len of opts, so I think Keep this ahmac
>>>> generating code after opts->suboptions set is not ok.
>>>
>>> So we should use mptcp_pm_should_add_signal_addr instead of opts->ahmac in
>>> mptcp_add_addr_len.
>> agree.
>>
>>>
>>>>
>>>>>
>>>>>> +               flags = (u8)~BIT(MPTCP_ADD_ADDR_SIGNAL);
>>>>>> +       }
>>>>>> +
>>>>>> +       len = mptcp_add_addr_len(opts);
>>>>>>         if (remaining < len)
>>>>>>                 return false;
>>>>>>
>>>>>> @@ -683,13 +691,14 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
>>>>>>         if (drop_other_suboptions)
>>>>>>                 *size -= opt_size;
>>>>>>         opts->suboptions |= OPTION_MPTCP_ADD_ADDR;
>>>>>> -       if (!echo) {
>>>>>> -               opts->ahmac = add_addr_generate_hmac(msk->local_key,
>>>>>> -                                                    msk->remote_key,
>>>>>> -                                                    &opts->addr);
>>>>>> -       }
>>>>>> -       pr_debug("addr_id=%d, ahmac=%llu, echo=%d, port=%d",
>>>>>> -                opts->addr.id, opts->ahmac, echo, ntohs(opts->addr.port));
>>>>>> +
>>>>>> +       spin_lock_bh(&msk->pm.lock);
>>>>>> +       WRITE_ONCE(msk->pm.addr_signal, flags & msk->pm.addr_signal);
>>>>>> +       spin_unlock_bh(&msk->pm.lock);
>>>>>
>>>>> addr_signal has been set in mptcp_pm_add_addr_signal in patch 1, no need to
>>>>> set it again. I thinks this trunk and all the flags set above should be
>>>>> dropped.
>>>>
>>>> Because MPTCP_ADD_ADDR_SIGNAL and MPTCP_ADD_ADDR_ECHO maybe set at the same time.
>>>> So i think we should only unset one flag.
>>>
>>> We can only unset one flag in mptcp_pm_add_addr_signal, see my comment in
>>> patch 1.
>>
>> if change like this. there is a issue: if remaining len checking is not ok and return false, The ADD_ADDR/ECHO event will
>> be clear. So I think we should make sure ADD_ADDR/ECHO option will add in packet before clean flags. WDYT?
>>
> 
> You're right, let's clear it in mptcp_established_options_add_addr.
> Furthermore, we should do the same thing for RM_ADDR, clear rm_addr in
> mptcp_established_options_rm_addr too.
> 
> If so, patch 1 will become useless. Let's drop it.
> 
> -Geliang
> I think RM_ADDR doesn't have this issue. Because mptcp_pm_rm_addr_signal() check the failed case.

> 
> 
>>>
>>> -Geliang
>>>
>>>>
>>>>>
>>>>>> +
>>>>>> +       pr_debug("addr_signal:%x, echo=%d, local_addr_id=%d, ahmac=%llu, local_port=%d, remote_addr_id=%d, remote_port=%d",
>>>>>> +                add_addr, (opts->ahmac == 0), opts->local.id,
>>>>>> +                opts->ahmac, ntohs(opts->local.port), opts->remote.id, ntohs(opts->remote.port));
>>>>>>
>>>>>>         return true;
>>>>>>  }
>>>>>
>>>>> The whole function is something like this:
>>>>> '''
>>>>>         struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
>>>>>         struct mptcp_sock *msk = mptcp_sk(subflow->conn);
>>>>>         bool drop_other_suboptions = false;
>>>>>         unsigned int opt_size = *size;
>>>>>         int len;
>>>>>
>>>>>         if (!mptcp_pm_should_add_signal(msk) ||
>>>>>             !mptcp_pm_add_addr_signal(msk, remaining, opts))
>>>>>                 return false;
>>>>>
>>>>>         if ((mptcp_pm_should_add_signal_echo(msk) ||
>>>>>              (mptcp_pm_should_add_signal_addr(msk) &&
>>>>>               (opts->local.family == AF_INET6 || opts->local.port))) &&
>>>>>             skb && skb_is_tcp_pure_ack(skb)) {
>>>>>                 pr_debug("drop other suboptions");
>>>>>                 opts->suboptions = 0;
>>>>>                 opts->ext_copy.use_ack = 0;
>>>>>                 opts->ext_copy.use_map = 0;
>>>>>                 remaining += opt_size;
>>>>>                 drop_other_suboptions = true;
>>>>>         }
>>>>>
>>>>>         len = mptcp_add_addr_len(opts);
>>>>>         if (remaining < len)
>>>>>                 return false;
>>>>>
>>>>>         *size = len;
>>>>>         if (drop_other_suboptions)
>>>>>                 *size -= opt_size;
>>>>>         opts->suboptions |= OPTION_MPTCP_ADD_ADDR;
>>>>>         if (mptcp_pm_should_add_signal_addr(msk)) {
>>>>>                 opts->ahmac = add_addr_generate_hmac(msk->local_key,
>>>>>                                                      msk->remote_key,
>>>>>                                                      &opts->local);
>>>>>         }
>>>>>
>>>>>         pr_debug("addr_signal:%x, echo=%d, local_addr_id=%d,
>>>>> ahmac=%llu, local_port=%d, remote_addr_id=%d, remote_port=%d",
>>>>>                  msk->pm.addr_signal, (opts->ahmac == 0), opts->local.id,
>>>>>                  opts->ahmac, ntohs(opts->local.port),
>>>>> opts->remote.id, ntohs(opts->remote.port));
>>>>>
>>>>>         return true;
>>>>> '''
>>>>>
>>>>>> @@ -1229,15 +1238,19 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
>>>>>>
>>>>>>  mp_capable_done:
>>>>>>         if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
>>>>>> +               struct mptcp_addr_info *addr = &opts->remote;
>>>>>
>>>>> We can simplify it like this:
>>>>>          struct mptcp_addr_info *addr = opts->ahmac ? &opts->local :
>>>>> &opts->remote;
>>>>>
>>>>>>                 u8 len = TCPOLEN_MPTCP_ADD_ADDR_BASE;
>>>>>>                 u8 echo = MPTCP_ADDR_ECHO;
>>>>>>
>>>>>> +               if (opts->ahmac)
>>>>>> +                       addr = &opts->local;
>>>>>
>>>>> And this trunk can be dropped.
>>>>>
>>>>>> +
>>>>>>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
>>>>>> -               if (opts->addr.family == AF_INET6)
>>>>>> +               if (addr->family == AF_INET6)
>>>>>>                         len = TCPOLEN_MPTCP_ADD_ADDR6_BASE;
>>>>>>  #endif
>>>>>>
>>>>>> -               if (opts->addr.port)
>>>>>> +               if (addr->port)
>>>>>>                         len += TCPOLEN_MPTCP_PORT_LEN;
>>>>>>
>>>>>>                 if (opts->ahmac) {
>>>>>> @@ -1246,25 +1259,25 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
>>>>>>                 }
>>>>>>
>>>>>>                 *ptr++ = mptcp_option(MPTCPOPT_ADD_ADDR,
>>>>>> -                                     len, echo, opts->addr.id);
>>>>>> -               if (opts->addr.family == AF_INET) {
>>>>>> -                       memcpy((u8 *)ptr, (u8 *)&opts->addr.addr.s_addr, 4);
>>>>>> +                                     len, echo, addr->id);
>>>>>> +               if (addr->family == AF_INET) {
>>>>>> +                       memcpy((u8 *)ptr, (u8 *)&addr->addr.s_addr, 4);
>>>>>>                         ptr += 1;
>>>>>>                 }
>>>>>>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
>>>>>> -               else if (opts->addr.family == AF_INET6) {
>>>>>> -                       memcpy((u8 *)ptr, opts->addr.addr6.s6_addr, 16);
>>>>>> +               else if (addr->family == AF_INET6) {
>>>>>> +                       memcpy((u8 *)ptr, addr->addr6.s6_addr, 16);
>>>>>>                         ptr += 4;
>>>>>>                 }
>>>>>>  #endif
>>>>>>
>>>>>> -               if (!opts->addr.port) {
>>>>>> +               if (!addr->port) {
>>>>>>                         if (opts->ahmac) {
>>>>>>                                 put_unaligned_be64(opts->ahmac, ptr);
>>>>>>                                 ptr += 2;
>>>>>>                         }
>>>>>>                 } else {
>>>>>> -                       u16 port = ntohs(opts->addr.port);
>>>>>> +                       u16 port = ntohs(addr->port);
>>>>>>
>>>>>>                         if (opts->ahmac) {
>>>>>>                                 u8 *bptr = (u8 *)ptr;
>>>>>> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
>>>>>> index cf873e9..9c621293 100644
>>>>>> --- a/net/mptcp/pm.c
>>>>>> +++ b/net/mptcp/pm.c
>>>>>> @@ -253,32 +253,25 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup)
>>>>>>
>>>>>>  /* path manager helpers */
>>>>>>
>>>>>> -bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
>>>>>> -                             struct mptcp_addr_info *saddr, bool *echo, bool *port)
>>>>>> +bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct mptcp_out_options *opts,
>>>>>> +                             u8 *add_addr)
>>>>>
>>>>> Drop this add_addr argument.
>>>>>
>>>>>>  {
>>>>>> -       u8 add_addr;
>>>>>> -       int ret = false;
>>>>>> -
>>>>>>         spin_lock_bh(&msk->pm.lock);
>>>>>>
>>>>>> -       /* double check after the lock is acquired */
>>>>>> -       if (!mptcp_pm_should_add_signal(msk))
>>>>>> -               goto out_unlock;
>>>>>
>>>>> Keep this double check code.
>>>>>
>>>>>> -
>>>>>> -       *echo = mptcp_pm_should_add_signal_echo(msk);
>>>>>> -       *port = mptcp_pm_should_add_signal_port(msk);
>>>>>> -
>>>>>> -       if (remaining < mptcp_add_addr_len(msk->pm.local.family, *echo, *port))
>>>>>> -               goto out_unlock;
>>>>>
>>>>> Keep this length double check code too.
>>>>>
>>>>>> +       if (!mptcp_pm_should_add_signal(msk)) {
>>>>>> +               spin_unlock_bh(&msk->pm.lock);
>>>>>> +               return false;
>>>>>> +       }
>>>>>>
>>>>>> -       *saddr = msk->pm.local;
>>>>>> -       add_addr = msk->pm.addr_signal & ~(BIT(MPTCP_ADD_ADDR_SIGNAL) | BIT(MPTCP_ADD_ADDR_ECHO));
>>>>> -       WRITE_ONCE(msk->pm.addr_signal, add_addr);
>>>>>
>>>>> This code is just added in patch 1, I think we should keep it. And no need
>>>>> to write addr_signal again in mptcp_established_options_add_addr.
>>>>>
>>>>>> -       ret = true;
>>>>>> +       opts->local = msk->pm.local;
>>>>>> +       opts->remote = msk->pm.remote;
>>>>>> +       *add_addr = msk->pm.addr_signal;
>>>>>>
>>>>>> -out_unlock:
>>>>>>         spin_unlock_bh(&msk->pm.lock);
>>>>>> -       return ret;
>>>>>
>>>>> Keep this out_unlock code.
>>>>>
>>>>>> +
>>>>>> +       if ((mptcp_pm_should_add_signal_echo(msk)) && (mptcp_pm_should_add_signal_addr(msk)))
>>>>>> +               mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_SEND_ACK);
>>>>>
>>>>> Could we use mptcp_pm_add_addr_send_ack here instead of open coding?
>>>>>
>>>>> I'm no sure why we need this two lines, and why you use '&&' here. Do you
>>>>> mean set MPTCP_ADD_ADDR_SIGNAL and MPTCP_ADD_ADDR_ECHO at the same time?
>>>>>
>>>>>> +       return true;
>>>>>>  }
>>>>>
>>>>> The whole function is something like this:
>>>>> '''
>>>>>         int ret = false;
>>>>>         u8 add_addr;
>>>>>
>>>>>         spin_lock_bh(&msk->pm.lock);
>>>>>
>>>>>         /* double check after the lock is acquired */
>>>>>         if (!mptcp_pm_should_add_signal(msk))
>>>>>                 goto out_unlock;
>>>>>
>>>>>         if (remaining < mptcp_add_addr_len(opts))
>>>>>                 goto out_unlock;
>>>>>
>>>>>         opts->local = msk->pm.local;
>>>>>         opts->remote = msk->pm.remote;
>>>>>         if (mptcp_pm_should_add_signal_echo(msk))
>>>>>                 add_addr = msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_ECHO);
>>>>>         else
>>>>>                 add_addr = msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_SIGNAL);
>>>>>         WRITE_ONCE(msk->pm.addr_signal, add_addr);
>>>>>         ret = true;
>>>>>
>>>>> out_unlock:
>>>>>         spin_unlock_bh(&msk->pm.lock);
>>>>>         if (ret && mptcp_pm_should_add_signal_echo(msk) &&
>>>>> mptcp_pm_should_add_signal_addr(msk))
>>>>>                 mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_SEND_ACK);
>>>>>         return ret;
>>>>> '''
>>>>>
>>>>>>
>>>>>>  bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
>>>>>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>>>>>> index a0b0ec0..0bfbbdef 100644
>>>>>> --- a/net/mptcp/protocol.h
>>>>>> +++ b/net/mptcp/protocol.h
>>>>>> @@ -737,16 +737,23 @@ static inline bool mptcp_pm_should_rm_signal(struct mptcp_sock *msk)
>>>>>>         return READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_RM_ADDR_SIGNAL);
>>>>>>  }
>>>>>>
>>>>>> -static inline unsigned int mptcp_add_addr_len(int family, bool echo, bool port)
>>>>>> +static inline unsigned int mptcp_add_addr_len(struct mptcp_out_options *opts)
>>>>>>  {
>>>>>> -       u8 len = TCPOLEN_MPTCP_ADD_ADDR_BASE;
>>>>>> +       u8 len = 0;
>>>>>> +       struct mptcp_addr_info *addr = &opts->remote;
>>>>>
>>>>> We can simplify it like this:
>>>>>          struct mptcp_addr_info *addr = opts->ahmac ? &opts->local :
>>>>> &opts->remote;
>>>>>
>>>>> And keep the orignal code unchanged.
>>>>>
>>>>>>
>>>>>> -       if (family == AF_INET6)
>>>>>> -               len = TCPOLEN_MPTCP_ADD_ADDR6_BASE;
>>>>>> -       if (!echo)
>>>>>> +       if (opts->ahmac) {
>>>>>> +               addr = &opts->local;
>>>>>>                 len += MPTCPOPT_THMAC_LEN;
>>>>>> +       }
>>>>>> +
>>>>>> +       if (addr->family == AF_INET6)
>>>>>> +               len += TCPOLEN_MPTCP_ADD_ADDR6_BASE;
>>>>>> +       else
>>>>>> +               len += TCPOLEN_MPTCP_ADD_ADDR_BASE;
>>>>>> +
>>>>>>         /* account for 2 trailing 'nop' options */
>>>>>> -       if (port)
>>>>>> +       if (addr->port)
>>>>>>                 len += TCPOLEN_MPTCP_PORT_LEN + TCPOLEN_MPTCP_PORT_ALIGN;
>>>>>>
>>>>>>         return len;
>>>>>
>>>>> The whole function is something like this:
>>>>> '''
>>>>>         struct mptcp_addr_info *addr = opts->ahmac ? &opts->local :
>>>>> &opts->remote;
>>>>>         u8 len = TCPOLEN_MPTCP_ADD_ADDR_BASE;
>>>>>
>>>>>         if (addr->family == AF_INET6)
>>>>>                 len = TCPOLEN_MPTCP_ADD_ADDR6_BASE;
>>>>>         if (opts->ahmac)
>>>>>                 len += MPTCPOPT_THMAC_LEN;
>>>>>         /* account for 2 trailing 'nop' options */
>>>>>         if (addr->port)
>>>>>                 len += TCPOLEN_MPTCP_PORT_LEN + TCPOLEN_MPTCP_PORT_ALIGN;
>>>>>
>>>>>         return len;
>>>>> '''
>>>>>
>>>>> Thanks.
>>>>> -Geliang
>>>>>
>>>>>> @@ -760,8 +767,8 @@ static inline int mptcp_rm_addr_len(const struct mptcp_rm_list *rm_list)
>>>>>>         return TCPOLEN_MPTCP_RM_ADDR_BASE + roundup(rm_list->nr - 1, 4) + 1;
>>>>>>  }
>>>>>>
>>>>>> -bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
>>>>>> -                             struct mptcp_addr_info *saddr, bool *echo, bool *port);
>>>>>> +bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct mptcp_out_options *opts,
>>>>>> +                             u8 *add_addr);
>>>>>>  bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
>>>>>>                              struct mptcp_rm_list *rm_list);
>>>>>>  int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
>>>>>> --
>>>>>> 1.8.3.1
>>>>>>
>>>>>>
>>>>>
>>>>>
>>>>
>>>> --
>>>> Li YongLong
>>>
>>
>> --
>> Li YongLong
>>
> 

-- 
Li YongLong

Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F084D177
	for <mptcp@lists.linux.dev>; Fri, 25 Jun 2021 09:43:33 +0000 (UTC)
HMM_SOURCE_IP:172.18.0.218:52776.709223827
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.26?logid-55722aab59cf4eb08b24cd4bc1274650 (unknown [172.18.0.218])
	by chinatelecom.cn (HERMES) with SMTP id 402AA280029;
	Fri, 25 Jun 2021 17:43:31 +0800 (CST)
X-189-SAVE-TO-SEND: liyonglong@chinatelecom.cn
Received: from  ([172.18.0.218])
	by app0025 with ESMTP id 55722aab59cf4eb08b24cd4bc1274650 for mathew.j.martineau@linux.intel.com;
	Fri Jun 25 17:43:31 2021
X-Transaction-ID: 55722aab59cf4eb08b24cd4bc1274650
X-filter-score:
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 172.18.0.218
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
Subject: Re: [PATCH v5 3/4] mptcp: build ADD_ADDR/echo-ADD_ADDR option
 according pm.add_signal
To: Geliang Tang <geliangtang@gmail.com>
Cc: mptcp@lists.linux.dev, Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <1624337135-149084-1-git-send-email-liyonglong@chinatelecom.cn>
 <1624337135-149084-4-git-send-email-liyonglong@chinatelecom.cn>
 <CA+WQbwuiewnKr8NeKrGLTq-e4FYE1SGqS7GpHZLMz0kB2db-Sw@mail.gmail.com>
From: Yonglong Li <liyonglong@chinatelecom.cn>
Message-ID: <3c8306d3-3a7f-fd37-bd9d-741863f8f7f8@chinatelecom.cn>
Date: Fri, 25 Jun 2021 17:43:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CA+WQbwuiewnKr8NeKrGLTq-e4FYE1SGqS7GpHZLMz0kB2db-Sw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit

Hi Geliang,

Thanks for your review. I will prepare v6 as your suggestion.

On 2021/6/25 12:44, Geliang Tang wrote:
> Hi Yonglong,
> 
> Thank you for this new patch!
> 
> Yonglong Li <liyonglong@chinatelecom.cn> 于2021年6月22日周二 下午12:46写道：
>>
>> according MPTCP_ADD_ADDR_SIGNAL and MPTCP_ADD_ADDR_ECHO flag build
>> ADD_ADDR/echo-ADD_ADDR option
>>
>> add a suboptions type OPTION_MPTCP_ADD_ECHO to mark as echo option
>>
>> Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
>> ---
>>  include/net/mptcp.h  |   2 +-
>>  net/mptcp/options.c  | 105 ++++++++++++++++++++++++++++++---------------------
>>  net/mptcp/pm.c       |  30 +++++----------
>>  net/mptcp/protocol.h |  13 ++++---
>>  4 files changed, 80 insertions(+), 70 deletions(-)
>>
>> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
>> index 637e90b..d2c6ebe 100644
>> --- a/include/net/mptcp.h
>> +++ b/include/net/mptcp.h
>> @@ -61,7 +61,7 @@ struct mptcp_out_options {
>>         u64 sndr_key;
>>         u64 rcvr_key;
>>         u64 ahmac;
>> -       struct mptcp_addr_info addr;
>> +       struct mptcp_addr_info local;
>>         struct mptcp_addr_info remote;
>>         struct mptcp_rm_list rm_list;
>>         u8 join_id;
>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>> index 1aec016..a1fafed 100644
>> --- a/net/mptcp/options.c
>> +++ b/net/mptcp/options.c
>> @@ -655,13 +655,19 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
>>         struct mptcp_sock *msk = mptcp_sk(subflow->conn);
>>         bool drop_other_suboptions = false;
>>         unsigned int opt_size = *size;
>> -       bool echo;
>> -       bool port;
>> -       int len;
>> +       struct mptcp_addr_info remote;
>> +       struct mptcp_addr_info local;
>> +       u8 add_addr, flags = 0xff;
>> +       int len = 0;
>>
>> -       if ((mptcp_pm_should_add_signal_ipv6(msk) ||
>> -            mptcp_pm_should_add_signal_port(msk) ||
>> -            mptcp_pm_should_add_signal_echo(msk)) &&
>> +       if (!mptcp_pm_should_add_signal(msk))
>> +               return false;
>> +
>> +       mptcp_pm_add_addr_signal(msk, &local, &remote, &add_addr);
> 
> Could we check the return value of mptcp_pm_add_addr_signal as the original
> code:
> 
>        if (!mptcp_pm_should_add_signal(msk) ||
>            !(mptcp_pm_add_addr_signal(msk, remaining, &opts->addr,
> &echo, &port)))
>                return false;
> 
>> +       if ((mptcp_pm_should_add_signal_echo(msk) ||
>> +            (!mptcp_pm_should_add_signal_echo(msk) &&
>> +             mptcp_pm_should_add_signal_addr(msk) &&
>> +             (local.family == AF_INET6 || local.port))) &&
>>             skb && skb_is_tcp_pure_ack(skb)) {
>>                 pr_debug("drop other suboptions");
>>                 opts->suboptions = 0;
>> @@ -671,25 +677,35 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
>>                 drop_other_suboptions = true;
>>         }
>>
>> -       if (!mptcp_pm_should_add_signal(msk) ||
>> -           !(mptcp_pm_add_addr_signal(msk, remaining, &opts->addr, &echo, &port)))
>> -               return false;
>> -
>> -       len = mptcp_add_addr_len(opts->addr.family, echo, port);
>> -       if (remaining < len)
>> -               return false;
>> +       if (mptcp_pm_should_add_signal_echo(msk)) {
>> +               len = mptcp_add_addr_len(remote.family, true, !!remote.port);
> 
> Could we pass 'opts' as the only argument to mptcp_add_addr_len, and use
> mptcp_pm_should_add_signal_echo in mptcp_add_addr_len to check whether
> it's a ADD_ADDR_ECHO?
> 
>> +               if (remaining < len)
>> +                       return false;
> 
> Then we can move these lines out of the if... else... trunk.
> 
>> +               opts->remote = remote;
>> +               flags = (u8)~BIT(MPTCP_ADD_ADDR_ECHO);
>> +               opts->suboptions |= OPTION_MPTCP_ADD_ECHO;
> 
> I prefer to change the order of these three lines to:
> 
>               opts->remote = remote;
>               opts->suboptions |= OPTION_MPTCP_ADD_ECHO;
>               flags = (u8)~BIT(MPTCP_ADD_ADDR_ECHO);
> 
>> +       } else {
>> +               len = mptcp_add_addr_len(local.family, false, !!local.port);
>> +               if (remaining < len)
>> +                       return false;
>> +               opts->local = local;
>> +               opts->ahmac = add_addr_generate_hmac(msk->local_key,
>> +                                                    msk->remote_key,
>> +                                                    &opts->local);
>> +               opts->suboptions |= OPTION_MPTCP_ADD_ADDR;
>> +               flags = (u8)~BIT(MPTCP_ADD_ADDR_SIGNAL);
> 
> And here I prefer to use the same order as the if trunk:
> 
>               opts->local = local;
>               opts->suboptions |= OPTION_MPTCP_ADD_ADDR;
>               opts->ahmac = add_addr_generate_hmac(msk->local_key,
>                                                    msk->remote_key,
>                                                    &opts->local);
>               flags = (u8)~BIT(MPTCP_ADD_ADDR_SIGNAL);
> 
>> +       }
>>
>>         *size = len;
>>         if (drop_other_suboptions)
>>                 *size -= opt_size;
>> -       opts->suboptions |= OPTION_MPTCP_ADD_ADDR;
>> -       if (!echo) {
>> -               opts->ahmac = add_addr_generate_hmac(msk->local_key,
>> -                                                    msk->remote_key,
>> -                                                    &opts->addr);
>> -       }
>> -       pr_debug("addr_id=%d, ahmac=%llu, echo=%d, port=%d",
>> -                opts->addr.id, opts->ahmac, echo, ntohs(opts->addr.port));
>> +       spin_lock_bh(&msk->pm.lock);
>> +       WRITE_ONCE(msk->pm.addr_signal, flags & msk->pm.addr_signal);
>> +       spin_unlock_bh(&msk->pm.lock);
>> +
>> +       pr_debug("addr_signal:%x, echo=%d, local_addr_id=%d, ahmac=%llu, local_port=%d, remote_addr_id=%d, remote_port=%d",
>> +                add_addr, mptcp_pm_should_add_signal_echo(msk), opts->local.id,
>> +                opts->ahmac, ntohs(opts->local.port), opts->remote.id, ntohs(opts->remote.port));
>>
>>         return true;
>>  }
>> @@ -1228,45 +1244,51 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
>>         }
>>
>>  mp_capable_done:
>> -       if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
>> -               u8 len = TCPOLEN_MPTCP_ADD_ADDR_BASE;
>> -               u8 echo = MPTCP_ADDR_ECHO;
>> +       if ((OPTION_MPTCP_ADD_ADDR | OPTION_MPTCP_ADD_ECHO) & opts->suboptions) {
>> +               struct mptcp_addr_info *addr_info;
>> +               u8 len = 0;
>> +               u8 echo = 0;
>> +
>> +               if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
>> +                       len += sizeof(opts->ahmac);
>> +                       addr_info = &opts->local;
>> +               } else {
>> +                       echo = MPTCP_ADDR_ECHO;
>> +                       addr_info = &opts->remote;
>> +               }
>>
>>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
>> -               if (opts->addr.family == AF_INET6)
>> -                       len = TCPOLEN_MPTCP_ADD_ADDR6_BASE;
>> +               if (addr_info->family == AF_INET6)
>> +                       len += TCPOLEN_MPTCP_ADD_ADDR6_BASE;
>> +               else
>>  #endif
>> +                       len += TCPOLEN_MPTCP_ADD_ADDR_BASE;
>>
>> -               if (opts->addr.port)
>> +               if (addr_info->port)
>>                         len += TCPOLEN_MPTCP_PORT_LEN;
>>
>> -               if (opts->ahmac) {
>> -                       len += sizeof(opts->ahmac);
>> -                       echo = 0;
>> -               }
>> -
>>                 *ptr++ = mptcp_option(MPTCPOPT_ADD_ADDR,
>> -                                     len, echo, opts->addr.id);
>> -               if (opts->addr.family == AF_INET) {
>> -                       memcpy((u8 *)ptr, (u8 *)&opts->addr.addr.s_addr, 4);
>> +                                     len, echo, addr_info->id);
>> +               if (addr_info->family == AF_INET) {
>> +                       memcpy((u8 *)ptr, (u8 *)&addr_info->addr.s_addr, 4);
>>                         ptr += 1;
>>                 }
>>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
>> -               else if (opts->addr.family == AF_INET6) {
>> -                       memcpy((u8 *)ptr, opts->addr.addr6.s6_addr, 16);
>> +               else if (addr_info->family == AF_INET6) {
>> +                       memcpy((u8 *)ptr, addr_info->addr6.s6_addr, 16);
>>                         ptr += 4;
>>                 }
>>  #endif
>>
>> -               if (!opts->addr.port) {
>> -                       if (opts->ahmac) {
>> +               if (!addr_info->port) {
>> +                       if (!echo) {
>>                                 put_unaligned_be64(opts->ahmac, ptr);
>>                                 ptr += 2;
>>                         }
>>                 } else {
>> -                       u16 port = ntohs(opts->addr.port);
>> +                       u16 port = ntohs(addr_info->port);
>>
>> -                       if (opts->ahmac) {
>> +                       if (!echo) {
>>                                 u8 *bptr = (u8 *)ptr;
>>
>>                                 put_unaligned_be16(port, bptr);
>> @@ -1275,7 +1297,6 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
>>                                 bptr += 8;
>>                                 put_unaligned_be16(TCPOPT_NOP << 8 |
>>                                                    TCPOPT_NOP, bptr);
>> -
>>                                 ptr += 3;
>>                         } else {
>>                                 put_unaligned_be32(port << 16 |
>> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
>> index 107a5a2..a62d4a5 100644
>> --- a/net/mptcp/pm.c
>> +++ b/net/mptcp/pm.c
>> @@ -22,7 +22,8 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
>>
>>         lockdep_assert_held(&msk->pm.lock);
>>
>> -       if (add_addr) {
>> +       if (add_addr &
>> +           (echo ? BIT(MPTCP_ADD_ADDR_ECHO) : BIT(MPTCP_ADD_ADDR_SIGNAL))) {
>>                 pr_warn("addr_signal error, add_addr=%d", add_addr);
>>                 return -EINVAL;
>>         }
>> @@ -252,32 +253,19 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup)
>>
>>  /* path manager helpers */
>>
>> -bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
>> -                             struct mptcp_addr_info *saddr, bool *echo, bool *port)
>> +void mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct mptcp_addr_info *saddr,
>> +                             struct mptcp_addr_info *daddr, u8 *add_addr)
> 
> Could we keep the return value as bool here?
> 
> And pass 'opts' as an argument of this function, instead of using two
> arguments 'saddr' and 'daddr'.
> 
>>  {
>> -       u8 add_addr;
>> -       int ret = false;
>> -
>>         spin_lock_bh(&msk->pm.lock);
>>
>> -       /* double check after the lock is acquired */
>> -       if (!mptcp_pm_should_add_signal(msk))
>> -               goto out_unlock;
> 
> Could we keep these double check codes here?
> 
>> -
>> -       *echo = mptcp_pm_should_add_signal_echo(msk);
>> -       *port = mptcp_pm_should_add_signal_port(msk);
>> -
>> -       if (remaining < mptcp_add_addr_len(msk->pm.local.family, *echo, *port))
>> -               goto out_unlock;
>> -
>>         *saddr = msk->pm.local;
> 
> Use 'opts->local = msk->pm.local' here...
> 
>> -       add_addr = msk->pm.addr_signal & ~(BIT(MPTCP_ADD_ADDR_SIGNAL) | BIT(MPTCP_ADD_ADDR_ECHO));
>> -       WRITE_ONCE(msk->pm.addr_signal, add_addr);
>> -       ret = true;
>> +       *daddr = msk->pm.remote;
> 
> And 'opts->remote = msk->pm.remote' here.
> 
> WDYT?
> 
> -Geliang
> 
>> +       *add_addr = msk->pm.addr_signal;
>>
>> -out_unlock:
>>         spin_unlock_bh(&msk->pm.lock);
>> -       return ret;
>> +
>> +       if ((mptcp_pm_should_add_signal_echo(msk)) && (mptcp_pm_should_add_signal_addr(msk)))
>> +               mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_SEND_ACK);
>>  }
>>
>>  bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>> index a0b0ec0..90fb532 100644
>> --- a/net/mptcp/protocol.h
>> +++ b/net/mptcp/protocol.h
>> @@ -22,10 +22,11 @@
>>  #define OPTION_MPTCP_MPJ_SYNACK        BIT(4)
>>  #define OPTION_MPTCP_MPJ_ACK   BIT(5)
>>  #define OPTION_MPTCP_ADD_ADDR  BIT(6)
>> -#define OPTION_MPTCP_RM_ADDR   BIT(7)
>> -#define OPTION_MPTCP_FASTCLOSE BIT(8)
>> -#define OPTION_MPTCP_PRIO      BIT(9)
>> -#define OPTION_MPTCP_RST       BIT(10)
>> +#define OPTION_MPTCP_ADD_ECHO  BIT(7)
>> +#define OPTION_MPTCP_RM_ADDR   BIT(8)
>> +#define OPTION_MPTCP_FASTCLOSE BIT(9)
>> +#define OPTION_MPTCP_PRIO      BIT(10)
>> +#define OPTION_MPTCP_RST       BIT(11)
>>
>>  /* MPTCP option subtypes */
>>  #define MPTCPOPT_MP_CAPABLE    0
>> @@ -760,8 +761,8 @@ static inline int mptcp_rm_addr_len(const struct mptcp_rm_list *rm_list)
>>         return TCPOLEN_MPTCP_RM_ADDR_BASE + roundup(rm_list->nr - 1, 4) + 1;
>>  }
>>
>> -bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
>> -                             struct mptcp_addr_info *saddr, bool *echo, bool *port);
>> +void mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct mptcp_addr_info *saddr,
>> +                             struct mptcp_addr_info *daddr, u8 *add_addr);
>>  bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
>>                              struct mptcp_rm_list *rm_list);
>>  int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
>> --
>> 1.8.3.1
>>
> 

-- 
Li YongLong

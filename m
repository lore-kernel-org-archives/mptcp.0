Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.227])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124CE72
	for <mptcp@lists.linux.dev>; Fri,  2 Jul 2021 06:16:11 +0000 (UTC)
HMM_SOURCE_IP:172.18.0.48:37978.1311750309
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.26?logid-566dfbafba734a43b4446e7dbe526f9a (unknown [172.18.0.48])
	by chinatelecom.cn (HERMES) with SMTP id 5992B28008F;
	Fri,  2 Jul 2021 14:16:01 +0800 (CST)
X-189-SAVE-TO-SEND: liyonglong@chinatelecom.cn
Received: from  ([172.18.0.48])
	by app0024 with ESMTP id 566dfbafba734a43b4446e7dbe526f9a for mathew.j.martineau@linux.intel.com;
	Fri Jul  2 14:16:02 2021
X-Transaction-ID: 566dfbafba734a43b4446e7dbe526f9a
X-filter-score:
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 172.18.0.48
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
Subject: Re: [PATCH v7 3/5] mptcp: build ADD_ADDR/echo-ADD_ADDR option
 according pm.add_signal
To: Geliang Tang <geliangtang@gmail.com>
Cc: mptcp@lists.linux.dev, Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <1625048653-6825-1-git-send-email-liyonglong@chinatelecom.cn>
 <1625048653-6825-4-git-send-email-liyonglong@chinatelecom.cn>
 <CA+WQbws0e9dkYy_VDimHQkuXF-fyAz1z1SGWYHcLFycNykaZrA@mail.gmail.com>
From: Yonglong Li <liyonglong@chinatelecom.cn>
Message-ID: <372dc8e1-1c6f-c70d-54c7-2e9e117ad0ab@chinatelecom.cn>
Date: Fri, 2 Jul 2021 14:15:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CA+WQbws0e9dkYy_VDimHQkuXF-fyAz1z1SGWYHcLFycNykaZrA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit

Hi Geliang,
Thanks for your reviews.

On 2021/6/30 19:14, Geliang Tang wrote:
> Hi Yonglong,
> 
> Thank you for this new patch!
> 
> Yonglong Li <liyonglong@chinatelecom.cn> 于2021年6月30日周三 下午6:24写道：
>>
>> according MPTCP_ADD_ADDR_SIGNAL and MPTCP_ADD_ADDR_ECHO flag build
>> ADD_ADDR/echo-ADD_ADDR option
>>
>> add a suboptions type OPTION_MPTCP_ADD_ECHO to mark as echo option
>>
>> Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
>> ---
>>  include/net/mptcp.h  |  3 ++-
>>  net/mptcp/options.c  | 54 +++++++++++++++++++++++++++++-----------------------
>>  net/mptcp/pm.c       | 35 +++++++++++++++++++++++-----------
>>  net/mptcp/protocol.h | 25 ++++++++++++++++--------
>>  4 files changed, 73 insertions(+), 44 deletions(-)
>>
>> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
>> index d61bbbf..d2c6ebe 100644
>> --- a/include/net/mptcp.h
>> +++ b/include/net/mptcp.h
>> @@ -61,7 +61,8 @@ struct mptcp_out_options {
>>         u64 sndr_key;
>>         u64 rcvr_key;
>>         u64 ahmac;
>> -       struct mptcp_addr_info addr;
>> +       struct mptcp_addr_info local;
>> +       struct mptcp_addr_info remote;
>>         struct mptcp_rm_list rm_list;
>>         u8 join_id;
>>         u8 backup;
>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>> index 1aec016..cceff0a 100644
>> --- a/net/mptcp/options.c
>> +++ b/net/mptcp/options.c
>> @@ -655,13 +655,16 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
>>         struct mptcp_sock *msk = mptcp_sk(subflow->conn);
>>         bool drop_other_suboptions = false;
>>         unsigned int opt_size = *size;
>> -       bool echo;
>> -       bool port;
>> -       int len;
>> +       u8 add_addr;
>> +       int len = 0;
>>
>> -       if ((mptcp_pm_should_add_signal_ipv6(msk) ||
>> -            mptcp_pm_should_add_signal_port(msk) ||
>> -            mptcp_pm_should_add_signal_echo(msk)) &&
>> +       if (!mptcp_pm_should_add_signal(msk) ||
>> +           !mptcp_pm_add_addr_signal(msk, skb, opt_size, remaining, opts, &add_addr))
>> +               return false;
>> +
>> +       if (((add_addr & BIT(MPTCP_ADD_ADDR_ECHO)) ||
>> +            ((add_addr & BIT(MPTCP_ADD_ADDR_SIGNAL)) &&
>> +             (opts->local.family == AF_INET6 || opts->local.port))) &&
>>             skb && skb_is_tcp_pure_ack(skb)) {
>>                 pr_debug("drop other suboptions");
>>                 opts->suboptions = 0;
>> @@ -671,11 +674,7 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
>>                 drop_other_suboptions = true;
>>         }
>>
>> -       if (!mptcp_pm_should_add_signal(msk) ||
>> -           !(mptcp_pm_add_addr_signal(msk, remaining, &opts->addr, &echo, &port)))
>> -               return false;
>> -
>> -       len = mptcp_add_addr_len(opts->addr.family, echo, port);
>> +       len = mptcp_add_addr_len(msk, opts);
>>         if (remaining < len)
>>                 return false;
>>
>> @@ -683,13 +682,16 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
>>         if (drop_other_suboptions)
>>                 *size -= opt_size;
>>         opts->suboptions |= OPTION_MPTCP_ADD_ADDR;
>> -       if (!echo) {
>> +       if (!(add_addr & BIT(MPTCP_ADD_ADDR_ECHO)) &&
>> +           (add_addr & BIT(MPTCP_ADD_ADDR_SIGNAL))) {
>>                 opts->ahmac = add_addr_generate_hmac(msk->local_key,
>>                                                      msk->remote_key,
>> -                                                    &opts->addr);
>> +                                                    &opts->local);
>>         }
>> -       pr_debug("addr_id=%d, ahmac=%llu, echo=%d, port=%d",
>> -                opts->addr.id, opts->ahmac, echo, ntohs(opts->addr.port));
>> +
> 
> Drop this blank line.
> 
>> +       pr_debug("addr_signal:%x, echo=%d, local_addr_id=%d, ahmac=%llu, local_port=%d, remote_addr_id=%d, remote_port=%d",
>> +                add_addr, (opts->ahmac == 0), opts->local.id,
>> +                opts->ahmac, ntohs(opts->local.port), opts->remote.id, ntohs(opts->remote.port));
>>
>>         return true;
>>  }
>> @@ -1229,15 +1231,19 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
>>
>>  mp_capable_done:
>>         if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
>> +               struct mptcp_addr_info *addr = &opts->remote;
>>                 u8 len = TCPOLEN_MPTCP_ADD_ADDR_BASE;
>>                 u8 echo = MPTCP_ADDR_ECHO;
>>
>> +               if (opts->ahmac)
>> +                       addr = &opts->local;
>> +
>>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
>> -               if (opts->addr.family == AF_INET6)
>> +               if (addr->family == AF_INET6)
>>                         len = TCPOLEN_MPTCP_ADD_ADDR6_BASE;
>>  #endif
>>
>> -               if (opts->addr.port)
>> +               if (addr->port)
>>                         len += TCPOLEN_MPTCP_PORT_LEN;
>>
>>                 if (opts->ahmac) {
>> @@ -1246,25 +1252,25 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
>>                 }
>>
>>                 *ptr++ = mptcp_option(MPTCPOPT_ADD_ADDR,
>> -                                     len, echo, opts->addr.id);
>> -               if (opts->addr.family == AF_INET) {
>> -                       memcpy((u8 *)ptr, (u8 *)&opts->addr.addr.s_addr, 4);
>> +                                     len, echo, addr->id);
>> +               if (addr->family == AF_INET) {
>> +                       memcpy((u8 *)ptr, (u8 *)&addr->addr.s_addr, 4);
>>                         ptr += 1;
>>                 }
>>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
>> -               else if (opts->addr.family == AF_INET6) {
>> -                       memcpy((u8 *)ptr, opts->addr.addr6.s6_addr, 16);
>> +               else if (addr->family == AF_INET6) {
>> +                       memcpy((u8 *)ptr, addr->addr6.s6_addr, 16);
>>                         ptr += 4;
>>                 }
>>  #endif
>>
>> -               if (!opts->addr.port) {
>> +               if (!addr->port) {
>>                         if (opts->ahmac) {
>>                                 put_unaligned_be64(opts->ahmac, ptr);
>>                                 ptr += 2;
>>                         }
>>                 } else {
>> -                       u16 port = ntohs(opts->addr.port);
>> +                       u16 port = ntohs(addr->port);
>>
>>                         if (opts->ahmac) {
>>                                 u8 *bptr = (u8 *)ptr;
>> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
>> index 0dc9021..9c5b15c 100644
>> --- a/net/mptcp/pm.c
>> +++ b/net/mptcp/pm.c
>> @@ -253,11 +253,11 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup)
>>
>>  /* path manager helpers */
>>
>> -bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
>> -                             struct mptcp_addr_info *saddr, bool *echo, bool *port)
>> +bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
>> +                             unsigned int opt_size, unsigned int remaining,
>> +                             struct mptcp_out_options *opts,  u8 *add_addr)
>>  {
>> -       int ret = false;
>> -       u8 add_addr;
>> +       int ret = false, len;
>>
>>         spin_lock_bh(&msk->pm.lock);
>>
>> @@ -265,18 +265,31 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
>>         if (!mptcp_pm_should_add_signal(msk))
>>                 goto out_unlock;
>>
>> -       *echo = mptcp_pm_should_add_signal_echo(msk);
>> -       *port = mptcp_pm_should_add_signal_port(msk);
>> +       opts->local = msk->pm.local;
>> +       opts->remote = msk->pm.remote;
>> +       *add_addr = msk->pm.addr_signal;
>> +
>> +       if (((msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_ECHO)) ||
>> +            ((msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_SIGNAL)) &&
>> +             (msk->pm.local.family == AF_INET6 || msk->pm.local.port))) &&
>> +           skb && skb_is_tcp_pure_ack(skb)) {
>> +               remaining += opt_size;
>> +       }
> 
> Move it back to mptcp_established_options_add_addr, if so, no need to
> add the opt_size argument too.
ok.

> 
>>
>> -       if (remaining < mptcp_add_addr_len(msk->pm.local.family, *echo, *port))
>> +       len = mptcp_add_addr_len(msk, opts);
>> +       if (remaining < len)
>>                 goto out_unlock;
>>
>> -       *saddr = msk->pm.local;
>> -       add_addr = msk->pm.addr_signal & ~(BIT(MPTCP_ADD_ADDR_SIGNAL) | BIT(MPTCP_ADD_ADDR_ECHO));
>> -       WRITE_ONCE(msk->pm.addr_signal, add_addr);
>> -       ret = true;
>> +       if ((msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_ECHO)))
>> +               WRITE_ONCE(msk->pm.addr_signal, msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_ECHO));
>> +       else
>> +               WRITE_ONCE(msk->pm.addr_signal, msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_SIGNAL));
>>
> 
> Drop this blank line.
> 
>> +       ret = true;
>>  out_unlock:
>> +       if ((mptcp_pm_should_add_signal_echo(msk)) && (mptcp_pm_should_add_signal_addr(msk)))
>> +               mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_SEND_ACK);
>> +
> 
> Again, why we need these two lines?sorry, these two lines is usless now.

> 
>>         spin_unlock_bh(&msk->pm.lock);
>>         return ret;
>>  }
>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>> index a0b0ec0..caa4a60 100644
>> --- a/net/mptcp/protocol.h
>> +++ b/net/mptcp/protocol.h
>> @@ -737,16 +737,24 @@ static inline bool mptcp_pm_should_rm_signal(struct mptcp_sock *msk)
>>         return READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_RM_ADDR_SIGNAL);
>>  }
>>
>> -static inline unsigned int mptcp_add_addr_len(int family, bool echo, bool port)
>> +static inline unsigned int mptcp_add_addr_len(struct mptcp_sock *msk,
>> +                                             struct mptcp_out_options *opts)
>>  {
>> -       u8 len = TCPOLEN_MPTCP_ADD_ADDR_BASE;
>> +       u8 len = 0;
>> +       struct mptcp_addr_info *addr = &opts->remote;
> 
> Use the reverse xmas tree order.
sorry.

> 
> Thanks,
> -Geliang
> 
>>
>> -       if (family == AF_INET6)
>> -               len = TCPOLEN_MPTCP_ADD_ADDR6_BASE;
>> -       if (!echo)
>> +       if (mptcp_pm_should_add_signal_addr(msk)) {
>> +               addr = &opts->local;
>>                 len += MPTCPOPT_THMAC_LEN;
>> +       }
>> +
>> +       if (addr->family == AF_INET6)
>> +               len += TCPOLEN_MPTCP_ADD_ADDR6_BASE;
>> +       else
>> +               len += TCPOLEN_MPTCP_ADD_ADDR_BASE;
>> +
>>         /* account for 2 trailing 'nop' options */
>> -       if (port)
>> +       if (addr->port)
>>                 len += TCPOLEN_MPTCP_PORT_LEN + TCPOLEN_MPTCP_PORT_ALIGN;
>>
>>         return len;
>> @@ -760,8 +768,9 @@ static inline int mptcp_rm_addr_len(const struct mptcp_rm_list *rm_list)
>>         return TCPOLEN_MPTCP_RM_ADDR_BASE + roundup(rm_list->nr - 1, 4) + 1;
>>  }
>>
>> -bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
>> -                             struct mptcp_addr_info *saddr, bool *echo, bool *port);
>> +bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
>> +                             unsigned int opt_size, unsigned int remaining,
>> +                             struct mptcp_out_options *opts,  u8 *add_addr);
>>  bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
>>                              struct mptcp_rm_list *rm_list);
>>  int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
>> --
>> 1.8.3.1
>>
> 

-- 
Li YongLong

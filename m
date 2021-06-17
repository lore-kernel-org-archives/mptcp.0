Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.227])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5993E70
	for <mptcp@lists.linux.dev>; Thu, 17 Jun 2021 02:32:07 +0000 (UTC)
HMM_SOURCE_IP:172.18.0.218:40632.300695254
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.26?logid-e630e0d829f34334830cd855f30b8072 (unknown [172.18.0.218])
	by chinatelecom.cn (HERMES) with SMTP id 8149A2800DB;
	Thu, 17 Jun 2021 10:31:56 +0800 (CST)
X-189-SAVE-TO-SEND: liyonglong@chinatelecom.cn
Received: from  ([172.18.0.218])
	by app0025 with ESMTP id e630e0d829f34334830cd855f30b8072 for geliangtang@gmail.com;
	Thu Jun 17 10:31:58 2021
X-Transaction-ID: e630e0d829f34334830cd855f30b8072
X-filter-score:  filter<0>
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 172.18.0.218
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
Subject: Re: [PATCH v2 3/4] mptcp: build ADD_ADDR/echo-ADD_ADDR option
 according pm.add_signal
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev, pabeni@redhat.com, matthieu.baerts@tessares.net,
 geliangtang@gmail.com
References: <1623720670-73539-1-git-send-email-liyonglong@chinatelecom.cn>
 <1623720670-73539-4-git-send-email-liyonglong@chinatelecom.cn>
 <ff8a313c-faca-d5b8-58be-802b795f8b8b@linux.intel.com>
From: Yonglong Li <liyonglong@chinatelecom.cn>
Message-ID: <883a9ce8-8943-2c94-5acf-97034445e789@chinatelecom.cn>
Date: Thu, 17 Jun 2021 10:31:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ff8a313c-faca-d5b8-58be-802b795f8b8b@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit



On 2021/6/17 7:47, Mat Martineau wrote:
> On Tue, 15 Jun 2021, Yonglong Li wrote:
> 
>> according MPTCP_ADD_ADDR_SIGNAL and MPTCP_ADD_ADDR_ECHO flag build
>> ADD_ADDR/echo-ADD_ADDR option
>>
>> add a suboptions type OPTION_MPTCP_ADD_ECHO to mark as echo option
>>
>> Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
>> ---
>> net/mptcp/options.c  | 161 +++++++++++++++++++++++++++++++++------------------
>> net/mptcp/pm.c       |  32 ++++------
>> net/mptcp/protocol.h |  13 +++--
>> 3 files changed, 124 insertions(+), 82 deletions(-)
>>
>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>> index 1aec016..8875ba4 100644
>> --- a/net/mptcp/options.c
>> +++ b/net/mptcp/options.c
>> @@ -655,43 +655,72 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
>>     struct mptcp_sock *msk = mptcp_sk(subflow->conn);
>>     bool drop_other_suboptions = false;
>>     unsigned int opt_size = *size;
>> -    bool echo;
>> -    bool port;
>> +    struct mptcp_addr_info remote;
>> +    struct mptcp_addr_info local;
>> +    int ret = false;
>> +    u8 add_addr;
>>     int len;
>>
>> -    if ((mptcp_pm_should_add_signal_ipv6(msk) ||
>> -         mptcp_pm_should_add_signal_port(msk) ||
>> -         mptcp_pm_should_add_signal_echo(msk)) &&
>> -        skb && skb_is_tcp_pure_ack(skb)) {
>> -        pr_debug("drop other suboptions");
>> -        opts->suboptions = 0;
>> -        opts->ext_copy.use_ack = 0;
>> -        opts->ext_copy.use_map = 0;
>> -        remaining += opt_size;
>> -        drop_other_suboptions = true;
>> -    }
>> -
>> -    if (!mptcp_pm_should_add_signal(msk) ||
>> -        !(mptcp_pm_add_addr_signal(msk, remaining, &opts->addr, &echo, &port)))
>> -        return false;
>> -
>> -    len = mptcp_add_addr_len(opts->addr.family, echo, port);
>> -    if (remaining < len)
>> -        return false;
>> -
>> -    *size = len;
>> -    if (drop_other_suboptions)
>> -        *size -= opt_size;
>> -    opts->suboptions |= OPTION_MPTCP_ADD_ADDR;
>> -    if (!echo) {
>> +    if (!mptcp_pm_should_add_signal(msk))
>> +        goto out;
>> +
>> +    *size = 0;
>> +    mptcp_pm_add_addr_signal(msk, &local, &remote, &add_addr);
> 
> Return value of this function is ignored, so it shouldn't return bool anymore. However, read below about locking and handling of the add_addr value before making changes.
> 
>> +    if (mptcp_pm_should_add_signal_echo(msk)) {
>> +        if (skb && skb_is_tcp_pure_ack(skb)) {
>> +            pr_debug("drop other suboptions");
>> +            opts->suboptions = 0;
>> +            opts->ext_copy.use_ack = 0;
>> +            opts->ext_copy.use_map = 0;
>> +            remaining += opt_size;
>> +            drop_other_suboptions = true;
>> +        }
>> +        len = mptcp_add_addr_len(remote.family, true, !!remote.port);
>> +        if (remaining < len && mptcp_pm_should_add_addr(msk))
>> +            goto add_addr;
>> +        else if (remaining < len)
>> +            goto out;
>> +        remaining -= len;
>> +        *size += len;
>> +        opts->remote = remote;
>> +        add_addr &= ~BIT(MPTCP_ADD_ADDR_ECHO);
>> +        opts->suboptions |= OPTION_MPTCP_ADD_ECHO;
>> +        pr_debug("addr_id=%d, echo=1, port=%d addr_signal:%x",
>> +             opts->remote.id, ntohs(opts->remote.port), add_addr);
>> +    } else if (mptcp_pm_should_add_addr(msk)) {
>> +add_addr:
>> +        if ((local.family == AF_INET6 || local.port) && skb &&
>> +            skb_is_tcp_pure_ack(skb)) {
>> +            pr_debug("drop other suboptions");
>> +            opts->suboptions = 0;
>> +            opts->ext_copy.use_ack = 0;
>> +            opts->ext_copy.use_map = 0;
>> +            remaining += opt_size;
>> +            drop_other_suboptions = true;
>> +        }
>> +        len = mptcp_add_addr_len(local.family, false, !!local.port);
>> +        if (remaining < len)
>> +            goto out;
>> +        *size += len;
>> +        opts->addr = local;
>>         opts->ahmac = add_addr_generate_hmac(msk->local_key,
>>                              msk->remote_key,
>>                              &opts->addr);
>> +        opts->suboptions |= OPTION_MPTCP_ADD_ADDR;
>> +        add_addr &= ~BIT(MPTCP_ADD_ADDR_SIGNAL);
>> +        pr_debug("addr_id=%d, ahmac=%llu, echo=0, port=%d, addr_signal:%x",
>> +             opts->addr.id, opts->ahmac, ntohs(opts->addr.port), add_addr);
>>     }
>> -    pr_debug("addr_id=%d, ahmac=%llu, echo=%d, port=%d",
>> -         opts->addr.id, opts->ahmac, echo, ntohs(opts->addr.port));
>>
>> -    return true;
>> +    if (drop_other_suboptions)
>> +        *size -= opt_size;
>> +    spin_lock_bh(&msk->pm.lock);
>> +    WRITE_ONCE(msk->pm.addr_signal, add_addr);
>> +    spin_unlock_bh(&msk->pm.lock);
> 
> It's not safe to do a read-modify-write of msk->pm.addr_signal if the pm lock is not held for the *entire* time. Another thread could have set or cleared any other bit in msk->pm_addr_signal while the lock was not held here, and this code would overwrite any of those changes.

right. Thanks for you review. I will prepare v2 patch.

> 
>> +    ret = true;
>> +
>> +out:
>> +    return ret;
>> }
>>
>> static bool mptcp_established_options_rm_addr(struct sock *sk,
> 
> -- 
> Mat Martineau
> Intel
> 
> 

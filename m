Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.227])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA5970
	for <mptcp@lists.linux.dev>; Fri, 18 Jun 2021 01:24:44 +0000 (UTC)
HMM_SOURCE_IP:172.18.0.48:50350.1096390252
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.26?logid-cd2652cd494142868a7383321d844183 (unknown [172.18.0.48])
	by chinatelecom.cn (HERMES) with SMTP id 3D40A2800E3;
	Fri, 18 Jun 2021 09:24:42 +0800 (CST)
X-189-SAVE-TO-SEND: liyonglong@chinatelecom.cn
Received: from  ([172.18.0.48])
	by app0024 with ESMTP id cd2652cd494142868a7383321d844183 for mptcp@lists.linux.dev;
	Fri Jun 18 09:24:42 2021
X-Transaction-ID: cd2652cd494142868a7383321d844183
X-filter-score:  filter<0>
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 172.18.0.48
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
Subject: Re: [PATCH v3 3/4] mptcp: build ADD_ADDR/echo-ADD_ADDR option
 according pm.add_signal
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
References: <1623921276-97178-1-git-send-email-liyonglong@chinatelecom.cn>
 <1623921276-97178-4-git-send-email-liyonglong@chinatelecom.cn>
 <d4b0a07d-72af-9a9d-69d3-d63f65ee367@linux.intel.com>
From: Yonglong Li <liyonglong@chinatelecom.cn>
Message-ID: <43f90eee-f256-9e1a-7ef3-84130885e0e3@chinatelecom.cn>
Date: Fri, 18 Jun 2021 09:24:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <d4b0a07d-72af-9a9d-69d3-d63f65ee367@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit



On 2021/6/18 8:25, Mat Martineau wrote:
> 
> This goto isn't quite right. It jumps below with opts and remaining already modified, and may end up modifying 'remaining' again.
> 
> Would be better to separate the logic for sending echo-vs-signal, so the goto isn't necessary.

Thanks for your review. The goto logic is not right indeed. I will separate the logic for sending echo-vs-signal

> 
>> +        else if (remaining < len)
>> +            goto out;
>> +        remaining -= len;
>> +        *size += len;
>> +        opts->remote = remote;
>> +        flags = (u8)~BIT(MPTCP_ADD_ADDR_ECHO);
>> +        opts->suboptions |= OPTION_MPTCP_ADD_ECHO;
>> +        pr_debug("addr_id=%d, echo=1, port=%d addr_signal:%x",
>> +             opts->remote.id, ntohs(opts->remote.port), add_addr);
>> +    } else if (mptcp_pm_should_add_signal_addr(msk)) {
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
>> +        flags = (u8)~BIT(MPTCP_ADD_ADDR_SIGNAL);
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
>> +    WRITE_ONCE(msk->pm.addr_signal, flags | msk->pm.addr_signal);
>> +    spin_unlock_bh(&msk->pm.lock);
> 
> This would set bits in msk->pm.addr_signal rather than clear them. Did you intend '&' instead of '|'?

Sorry for this mistake. :(

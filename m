Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAA672
	for <mptcp@lists.linux.dev>; Fri,  2 Jul 2021 06:29:01 +0000 (UTC)
HMM_SOURCE_IP:172.18.0.48:40976.543622904
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.26?logid-9ad78d60f1d543a9816c6d93887b86c2 (unknown [172.18.0.48])
	by chinatelecom.cn (HERMES) with SMTP id 471312800B0;
	Fri,  2 Jul 2021 14:22:16 +0800 (CST)
X-189-SAVE-TO-SEND: liyonglong@chinatelecom.cn
Received: from  ([172.18.0.48])
	by app0024 with ESMTP id 9ad78d60f1d543a9816c6d93887b86c2 for mathew.j.martineau@linux.intel.com;
	Fri Jul  2 14:22:18 2021
X-Transaction-ID: 9ad78d60f1d543a9816c6d93887b86c2
X-filter-score:
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 172.18.0.48
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
Subject: Re: [PATCH v7 4/5] mptcp: remove some double-check
To: Geliang Tang <geliangtang@gmail.com>
Cc: mptcp@lists.linux.dev, Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <1625048653-6825-1-git-send-email-liyonglong@chinatelecom.cn>
 <1625048653-6825-5-git-send-email-liyonglong@chinatelecom.cn>
 <CA+WQbwsGFZsQYaigbQJ7nC31RbUdU70Ue6f1i15XzSO_wrMFDA@mail.gmail.com>
From: Yonglong Li <liyonglong@chinatelecom.cn>
Message-ID: <6771e9d0-102a-a261-fe97-b9104d432683@chinatelecom.cn>
Date: Fri, 2 Jul 2021 14:22:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CA+WQbwsGFZsQYaigbQJ7nC31RbUdU70Ue6f1i15XzSO_wrMFDA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit

Hi Geliang,

I think these double check is unnecessary. the reason to keep them is?
I think keep "!mptcp_pm_should_add_signal(msk)" you said in v6 is reasonable,
It can avoid to get pm.lock in process of sending packets. But the other double
check is useless.

On 2021/6/30 18:57, Geliang Tang wrote:
> As I said in v6, I prefer to keep these double check code, no need to
> remove them.
> 
> Yonglong Li <liyonglong@chinatelecom.cn> 于2021年6月30日周三 下午6:24写道：
>>
>> remove some double-check in mptcp_established_options_add_addr() and
>> mptcp_established_options_rm_addr()
>>
>> Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
>> ---
>>  net/mptcp/options.c  | 14 ++------------
>>  net/mptcp/pm.c       | 21 +++++++++++----------
>>  net/mptcp/protocol.h |  4 ++--
>>  3 files changed, 15 insertions(+), 24 deletions(-)
>>
>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>> index cceff0a..0711fc1 100644
>> --- a/net/mptcp/options.c
>> +++ b/net/mptcp/options.c
>> @@ -659,7 +659,7 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
>>         int len = 0;
>>
>>         if (!mptcp_pm_should_add_signal(msk) ||
>> -           !mptcp_pm_add_addr_signal(msk, skb, opt_size, remaining, opts, &add_addr))
>> +           !mptcp_pm_add_addr_signal(msk, skb, opt_size, remaining, opts, &add_addr, &len))
>>                 return false;
>>
>>         if (((add_addr & BIT(MPTCP_ADD_ADDR_ECHO)) ||
>> @@ -674,10 +674,6 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
>>                 drop_other_suboptions = true;
>>         }
>>
>> -       len = mptcp_add_addr_len(msk, opts);
>> -       if (remaining < len)
>> -               return false;
>> -
>>         *size = len;
>>         if (drop_other_suboptions)
>>                 *size -= opt_size;
>> @@ -707,13 +703,7 @@ static bool mptcp_established_options_rm_addr(struct sock *sk,
>>         int i, len;
>>
>>         if (!mptcp_pm_should_rm_signal(msk) ||
>> -           !(mptcp_pm_rm_addr_signal(msk, remaining, &rm_list)))
>> -               return false;
>> -
>> -       len = mptcp_rm_addr_len(&rm_list);
>> -       if (len < 0)
>> -               return false;
>> -       if (remaining < len)
>> +           !(mptcp_pm_rm_addr_signal(msk, remaining, &rm_list, &len)))
>>                 return false;
>>
>>         *size = len;
>> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
>> index 9c5b15c..2311ea5 100644
>> --- a/net/mptcp/pm.c
>> +++ b/net/mptcp/pm.c
>> @@ -255,9 +255,9 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup)
>>
>>  bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
>>                               unsigned int opt_size, unsigned int remaining,
>> -                             struct mptcp_out_options *opts,  u8 *add_addr)
>> +                             struct mptcp_out_options *opts,  u8 *add_addr, int *len)
>>  {
>> -       int ret = false, len;
>> +       int ret = false;
>>
>>         spin_lock_bh(&msk->pm.lock);
>>
>> @@ -276,8 +276,8 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
>>                 remaining += opt_size;
>>         }
>>
>> -       len = mptcp_add_addr_len(msk, opts);
>> -       if (remaining < len)
>> +       *len = mptcp_add_addr_len(msk, opts);
>> +       if (remaining < *len)
>>                 goto out_unlock;
>>
>>         if ((msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_ECHO)))
>> @@ -287,17 +287,18 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
>>
>>         ret = true;
>>  out_unlock:
>> +       spin_unlock_bh(&msk->pm.lock);
>> +
>>         if ((mptcp_pm_should_add_signal_echo(msk)) && (mptcp_pm_should_add_signal_addr(msk)))
>>                 mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_SEND_ACK);
>>
>> -       spin_unlock_bh(&msk->pm.lock);
>>         return ret;
>>  }
>>
>>  bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
>> -                            struct mptcp_rm_list *rm_list)
>> +                            struct mptcp_rm_list *rm_list, int *len)
>>  {
>> -       int ret = false, len;
>> +       int ret = false;
>>         u8 rm_addr;
>>
>>         spin_lock_bh(&msk->pm.lock);
>> @@ -307,12 +308,12 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
>>                 goto out_unlock;
>>
>>         rm_addr = msk->pm.addr_signal & ~BIT(MPTCP_RM_ADDR_SIGNAL);
>> -       len = mptcp_rm_addr_len(&msk->pm.rm_list_tx);
>> -       if (len < 0) {
>> +       *len = mptcp_rm_addr_len(&msk->pm.rm_list_tx);
>> +       if (*len < 0) {
>>                 WRITE_ONCE(msk->pm.addr_signal, rm_addr);
>>                 goto out_unlock;
>>         }
>> -       if (remaining < len)
>> +       if (remaining < *len)
>>                 goto out_unlock;
>>
>>         *rm_list = msk->pm.rm_list_tx;
>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>> index caa4a60..5d7c9d7 100644
>> --- a/net/mptcp/protocol.h
>> +++ b/net/mptcp/protocol.h
>> @@ -770,9 +770,9 @@ static inline int mptcp_rm_addr_len(const struct mptcp_rm_list *rm_list)
>>
>>  bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
>>                               unsigned int opt_size, unsigned int remaining,
>> -                             struct mptcp_out_options *opts,  u8 *add_addr);
>> +                             struct mptcp_out_options *opts,  u8 *add_addr, int *len);
>>  bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
>> -                            struct mptcp_rm_list *rm_list);
>> +                            struct mptcp_rm_list *rm_list, int *len);
>>  int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
>>
>>  void __init mptcp_pm_nl_init(void);
>> --
>> 1.8.3.1
>>
>>
> 

-- 
Li YongLong

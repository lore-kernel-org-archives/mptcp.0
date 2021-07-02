Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6E672
	for <mptcp@lists.linux.dev>; Fri,  2 Jul 2021 06:23:16 +0000 (UTC)
HMM_SOURCE_IP:172.18.0.48:45474.1892041030
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.26?logid-477956a80b9d4b11bdd093108f87a23b (unknown [172.18.0.48])
	by chinatelecom.cn (HERMES) with SMTP id 3B0E12800BA;
	Fri,  2 Jul 2021 14:23:15 +0800 (CST)
X-189-SAVE-TO-SEND: liyonglong@chinatelecom.cn
Received: from  ([172.18.0.48])
	by app0024 with ESMTP id 477956a80b9d4b11bdd093108f87a23b for mathew.j.martineau@linux.intel.com;
	Fri Jul  2 14:23:15 2021
X-Transaction-ID: 477956a80b9d4b11bdd093108f87a23b
X-filter-score:
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 172.18.0.48
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
Subject: Re: [PATCH v7 1/5] mptcp: fix ADD_ADDR and RM_ADDR maybe flush
 addr_signal each other
To: Geliang Tang <geliangtang@gmail.com>
Cc: mptcp@lists.linux.dev, Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <1625048653-6825-1-git-send-email-liyonglong@chinatelecom.cn>
 <1625048653-6825-2-git-send-email-liyonglong@chinatelecom.cn>
 <CA+WQbwuKVK5wQ3b9ux_43sJQHcCN2xvJqVCDGi9uaUT0LREOrg@mail.gmail.com>
From: Yonglong Li <liyonglong@chinatelecom.cn>
Message-ID: <35e3911b-454b-745c-7500-396c1b6451e8@chinatelecom.cn>
Date: Fri, 2 Jul 2021 14:23:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CA+WQbwuKVK5wQ3b9ux_43sJQHcCN2xvJqVCDGi9uaUT0LREOrg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit



On 2021/6/30 18:37, Geliang Tang wrote:
> Yonglong Li <liyonglong@chinatelecom.cn> 于2021年6月30日周三 下午6:24写道：
> 
>>
>> ADD_ADDR share pm.addr_signal with RM_ADDR, so after RM_ADDR/ADD_ADDR
>> done we should not clean ADD_ADDR/RM_ADDR's addr_signal.
>>
>> Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
>> ---
>>  net/mptcp/pm.c | 10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
>> index 9d00fa6..50079e5 100644
>> --- a/net/mptcp/pm.c
>> +++ b/net/mptcp/pm.c
>> @@ -253,6 +253,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
>>                               struct mptcp_addr_info *saddr, bool *echo, bool *port)
>>  {
>>         int ret = false;
>> +       u8 add_addr;
>>
>>         spin_lock_bh(&msk->pm.lock);
>>
>> @@ -267,7 +268,8 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
>>                 goto out_unlock;
>>
>>         *saddr = msk->pm.local;
>> -       WRITE_ONCE(msk->pm.addr_signal, 0);
>> +       add_addr = msk->pm.addr_signal & ~(BIT(MPTCP_ADD_ADDR_SIGNAL) | BIT(MPTCP_ADD_ADDR_ECHO));
>> +       WRITE_ONCE(msk->pm.addr_signal, add_addr);
>>         ret = true;
>>
>>  out_unlock:
> 
> This part is removed in patch 3, why we need to add it here?
I will remove it in next patch.

> 
>> @@ -279,6 +281,7 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
>>                              struct mptcp_rm_list *rm_list)
>>  {
>>         int ret = false, len;
>> +       u8 rm_addr;
>>
>>         spin_lock_bh(&msk->pm.lock);
>>
>> @@ -286,16 +289,17 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
>>         if (!mptcp_pm_should_rm_signal(msk))
>>                 goto out_unlock;
>>
>> +       rm_addr = msk->pm.addr_signal & ~BIT(MPTCP_RM_ADDR_SIGNAL);
>>         len = mptcp_rm_addr_len(&msk->pm.rm_list_tx);
>>         if (len < 0) {
>> -               WRITE_ONCE(msk->pm.addr_signal, 0);
>> +               WRITE_ONCE(msk->pm.addr_signal, rm_addr);
>>                 goto out_unlock;
>>         }
>>         if (remaining < len)
>>                 goto out_unlock;
>>
>>         *rm_list = msk->pm.rm_list_tx;
>> -       WRITE_ONCE(msk->pm.addr_signal, 0);
>> +       WRITE_ONCE(msk->pm.addr_signal, rm_addr);
>>         ret = true;
>>
>>  out_unlock:
>> --
>> 1.8.3.1
>>
> 

-- 
Li YongLong

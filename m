Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B8571
	for <mptcp@lists.linux.dev>; Thu, 17 Jun 2021 02:13:21 +0000 (UTC)
HMM_SOURCE_IP:172.18.0.218:36628.690729095
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.26?logid-8bd42fcc4c654cd498058dc99871a0a1 (unknown [172.18.0.218])
	by chinatelecom.cn (HERMES) with SMTP id 290CE28009F;
	Thu, 17 Jun 2021 10:13:07 +0800 (CST)
X-189-SAVE-TO-SEND: liyonglong@chinatelecom.cn
Received: from  ([172.18.0.218])
	by app0025 with ESMTP id 8bd42fcc4c654cd498058dc99871a0a1 for geliangtang@gmail.com;
	Thu Jun 17 10:13:12 2021
X-Transaction-ID: 8bd42fcc4c654cd498058dc99871a0a1
X-filter-score:  filter<0>
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 172.18.0.218
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
Subject: Re: [PATCH v2 1/4] mptcp: fix ADD_ADDR and RM_ADDR maybe flush
 addr_signal each other
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev, pabeni@redhat.com, matthieu.baerts@tessares.net,
 geliangtang@gmail.com
References: <1623720670-73539-1-git-send-email-liyonglong@chinatelecom.cn>
 <1623720670-73539-2-git-send-email-liyonglong@chinatelecom.cn>
 <fdfdf3c-f3bb-4e83-d49-84e97f667954@linux.intel.com>
From: Yonglong Li <liyonglong@chinatelecom.cn>
Message-ID: <5eee8ce5-05d6-70ad-a1f6-84cca0a87eda@chinatelecom.cn>
Date: Thu, 17 Jun 2021 10:13:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <fdfdf3c-f3bb-4e83-d49-84e97f667954@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit



On 2021/6/17 7:30, Mat Martineau wrote:
> On Tue, 15 Jun 2021, Yonglong Li wrote:
> 
>> ADD_ADDR share pm.addr_signal with RM_ADDR, so after RM_ADDR/ADD_ADDR
>> done we should not clean ADD_ADDR/RM_ADDR's addr_signal.
>>
>> Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
>> ---
>> net/mptcp/pm.c | 10 +++++++---
>> 1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
>> index 9d00fa6..74886a3 100644
>> --- a/net/mptcp/pm.c
>> +++ b/net/mptcp/pm.c
>> @@ -252,6 +252,7 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup)
>> bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
>>                   struct mptcp_addr_info *saddr, bool *echo, bool *port)
>> {
>> +    u8 add_addr;
>>     int ret = false;
>>
>>     spin_lock_bh(&msk->pm.lock);
>> @@ -267,7 +268,8 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
>>         goto out_unlock;
>>
>>     *saddr = msk->pm.local;
>> -    WRITE_ONCE(msk->pm.addr_signal, 0);
>> +    add_addr = msk->pm.addr_signal & BIT(MPTCP_RM_ADDR_SIGNAL);
> 
> Hello Yonglong, thank you for your revised patch series.
> 
> It would be better to use ~BIT(MPTCP_ADD_ADDR_SIGNAL), similar to the change in 
Hi Mat, Thanks for your review.
If use ~BIT(MPTCP_ADD_ADDR_SIGNAL), MPTCP_ADD_ADDR_ECHO maybe not being clean out. MPTCP_ADD_ADDR_ECHO
and MPTCP_ADD_ADDR_SIGNAL are being set with pm.lock at the same time, So I think here use
BIT(MPTCP_RM_ADDR_SIGNAL) is ok.

mptcp_pm_rm_addr_signal() below.
> 
>> +    WRITE_ONCE(msk->pm.addr_signal, add_addr);
>>     ret = true;
>>
>> out_unlock:
>> @@ -278,6 +280,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
>> bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
>>                  struct mptcp_rm_list *rm_list)
>> {
>> +    u8 rm_addr;
>>     int ret = false, len;
>>
>>     spin_lock_bh(&msk->pm.lock);
>> @@ -286,16 +289,17 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
>>     if (!mptcp_pm_should_rm_signal(msk))
>>         goto out_unlock;
>>
>> +    rm_addr = msk->pm.addr_signal & ~BIT(MPTCP_RM_ADDR_SIGNAL);
>>     len = mptcp_rm_addr_len(&msk->pm.rm_list_tx);
>>     if (len < 0) {
>> -        WRITE_ONCE(msk->pm.addr_signal, 0);
>> +        WRITE_ONCE(msk->pm.addr_signal, rm_addr);
>>         goto out_unlock;
>>     }
>>     if (remaining < len)
>>         goto out_unlock;
>>
>>     *rm_list = msk->pm.rm_list_tx;
>> -    WRITE_ONCE(msk->pm.addr_signal, 0);
>> +    WRITE_ONCE(msk->pm.addr_signal, rm_addr);
>>     ret = true;
>>
>> out_unlock:
>> -- 
>> 1.8.3.1
>>
>>
> 
> -- 
> Mat Martineau
> Intel
> 
> 

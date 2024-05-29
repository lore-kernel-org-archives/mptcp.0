Received: from chinatelecom.cn (smtpnm6-08.21cn.com [182.42.159.130])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718B716D9AD
	for <mptcp@lists.linux.dev>; Wed, 29 May 2024 09:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=182.42.159.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716976137; cv=none; b=Mqh2C7/GBeVyu2IPe2Y9G9tTqdtoV1dWJYrdFaejW8gjO7G+70g5PlNIsBMvbc13Ph2r/jOFB9gCXHNPMBwRrnAuVDjmsBSncfIv0wpC4W36Pm3gvHOYKw4RA28IJqKyEPza1KK2SOxEYSrbxreWLLVdlx/gWQiWOA88yJczCf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716976137; c=relaxed/simple;
	bh=i0HesL3kyI9VWREQunNgbfcn/l2oQnlkkirfFe6/Adg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=twgsShmQVOZs3G6hjCnKFI7sOx8/W0e4UK7Up9du/x2N8j544iGse3mY/wCm1crxj2fgTolw1SHteRRbsjWybbBKOvaQvs0wTH4zYoDcNMCoMvYhXgIuwcOPWFGf6ReSDH5IpncaZrsGK+A0Ey4yn4IiafpuhsiprnRLjZIIMfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn; spf=pass smtp.mailfrom=chinatelecom.cn; arc=none smtp.client-ip=182.42.159.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chinatelecom.cn
HMM_SOURCE_IP:192.168.137.232:36280.540440798
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-27.148.194.68 (unknown [192.168.137.232])
	by chinatelecom.cn (HERMES) with SMTP id 51615903257C;
	Wed, 29 May 2024 17:37:48 +0800 (CST)
X-189-SAVE-TO-SEND: liyonglong@chinatelecom.cn
Received: from  ([27.148.194.68])
	by gateway-ssl-dep-67bdc54df-b7md5 with ESMTP id 800bb0f293d142c2a06292579c99fafd for matttbe@kernel.org;
	Wed, 29 May 2024 17:37:54 CST
X-Transaction-ID: 800bb0f293d142c2a06292579c99fafd
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 27.148.194.68
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
Message-ID: <9baca944-9777-445b-8344-d6755c65a509@chinatelecom.cn>
Date: Wed, 29 May 2024 17:37:47 +0800
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mptcp: update add_addr_accepted and accept_add after
 subflow added
Content-Language: en-US
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: pabeni@redhat.com, geliang@kernel.org
References: <1716543865-37448-1-git-send-email-liyonglong@chinatelecom.cn>
 <1990877063.5336.1716773859206.JavaMail.root@jt-retransmission-dep-59f6f76b7b-svmkb>
From: YonglongLi <liyonglong@chinatelecom.cn>
In-Reply-To: <1990877063.5336.1716773859206.JavaMail.root@jt-retransmission-dep-59f6f76b7b-svmkb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Matt,

Sorry for the late relay. And thanks for your review.

On 5/24/2024 23:06, Matthieu Baerts wrote:
> Hi Yonglong Li,
> 
> On 24/05/2024 11:44, Yonglong Li wrote:
>> From: YonglongLi <liyonglong@chinatelecom.cn>
>>
>> receive RM_ADDR will update pm.add_addr_accepted and pm.add_addr_accepted
>> only if remove id match remote id of subflow. so receive ADD_ADDR should
>> update pm.add_addr_accepted and pm.add_addr_accepted after subflow added
>> to conn_list.
> 
> Do you think it could be possible to cover this case by modifying/adding
> one subtest in our selftests?
> 

yes, test case for this issue like this:

       if reset "remove invalid address and re-add"; then
               pm_nl_set_limits $ns1 2 2
               pm_nl_set_limits $ns2 2 2
               pm_nl_add_endpoint $ns1 224.0.0.1  flags signal
               #pm_nl_add_endpoint $ns1 10.0.4.1  flags signal
               run_tests $ns1 $ns2 10.0.1.1 0 -1 0 speed_10 2>/dev/null &
               sleep 0.5

               pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
               pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
               wait_mpj $ns2
               chk_join_nr 2 2 2
               chk_rm_nr 1 0 invert
               chk_add_nr 3 3
               chk_rst_nr 0 0
               kill_tests_wait
       fi


> The commit message is not very clear to me. ("add_addr_accepted" are
> also always duplicated, I'm not sure why).

sorry for mistake. my origin mean is "pm.add_addr_accepted and pm.accept_addr"

> 
> I understand we can have issues with __mptcp_subflow_connect() and we
> might want to increment the counter only if it was possible to create a
> subflow (even if the connection can fail later -- I'm not sure whether
> we decrement the counter in this case as well), but I'm not sure to
> understand the context: the reason why this call could fail, and the
> link with RM_ADDR.
> 

I think we should make sure that update pm.add_addr_accepted and pm.accept_addr
after new subflow was added into conn_list when receive do ADD_ADDR action. And
decremant the counter when unlink the last subflow of the addr ID from conn_list.

decremant the counter like this:

@@ -827,10 +829,7 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
                if (!mptcp_pm_is_kernel(msk))
                        continue;

-               if (rm_type == MPTCP_MIB_RMADDR) {
-                       msk->pm.add_addr_accepted--;
-                       WRITE_ONCE(msk->pm.accept_addr, true);
-               } else if (rm_type == MPTCP_MIB_RMSUBFLOW) {
+               if (rm_type == MPTCP_MIB_RMSUBFLOW) {
                        msk->pm.local_addr_used--;
                }
        }

@@ -757,11 +757,32 @@ static void subflow_ulp_fallback(struct sock *sk,
 void mptcp_subflow_drop_ctx(struct sock *ssk)
 {
        struct mptcp_subflow_context *ctx = mptcp_subflow_ctx(ssk);
+       struct mptcp_sock *msk = NULL;

        if (!ctx)
                return;

        list_del(&mptcp_subflow_ctx(ssk)->node);
+        if (ctx->conn)
+                msk = mptcp_sk(ctx->conn);
+        if (msk && !list_empty(&msk->conn_list)) {
+                struct mptcp_subflow_context *subflow, *tmp;
+                u8 id = subflow_get_local_id(ctx);
+                bool lastone = true;
+                mptcp_for_each_subflow_safe(msk, subflow, tmp) {
+                        if (id == 0 || id == subflow_get_local_id(subflow)) {
+                                lastone = false;
+                                break;
+                        }
+                }
+                if (lastone == true) {
+                        spin_lock_bh(&msk->pm.lock);
+                        msk->pm.add_addr_accepted++;
+                        WRITE_ONCE(msk->pm.accept_addr, true);
+                        spin_unlock_bh(&msk->pm.lock);
+                }
+        }
+
        if (inet_csk(ssk)->icsk_ulp_ops) {
                subflow_ulp_fallback(ssk, ctx);
                if (ctx->conn)

And do the same thing in __mptcp_close_ssk

WDYT?

>>
>> Fixes: f7d6a237d742 ("mptcp: fix per socket endpoint accounting")
>>
> 
> (no new line here)
> 
>> Signed-off-by: YonglongLi <liyonglong@chinatelecom.cn>
>> ---
>>  net/mptcp/pm_netlink.c | 16 ++++++++++------
>>  1 file changed, 10 insertions(+), 6 deletions(-)
>>
>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>> index 766a840..117cc7b 100644
>> --- a/net/mptcp/pm_netlink.c
>> +++ b/net/mptcp/pm_netlink.c
>> @@ -676,6 +676,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
>>  	struct sock *sk = (struct sock *)msk;
>>  	unsigned int add_addr_accept_max;
>>  	struct mptcp_addr_info remote;
>> +	bool subflow_added = false;
>>  	unsigned int subflows_max;
>>  	int i, nr;
>>  
>> @@ -704,15 +705,18 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
>>  	if (nr == 0)
>>  		return;
>>  
>> -	msk->pm.add_addr_accepted++;
>> -	if (msk->pm.add_addr_accepted >= add_addr_accept_max ||
>> -	    msk->pm.subflows >= subflows_max)
>> -		WRITE_ONCE(msk->pm.accept_addr, false);
>> -
>>  	spin_unlock_bh(&msk->pm.lock);
>>  	for (i = 0; i < nr; i++)
>> -		__mptcp_subflow_connect(sk, &addrs[i], &remote);
>> +		if (!__mptcp_subflow_connect(sk, &addrs[i], &remote))
>> +			subflow_added = true;
> 
> Probably clearer to use:
> 
>   if (__mptcp_subflow_connect(...) == 0)
> 
> Otherwise, we might think the subflow is added in case of issues.
> 
>>  	spin_lock_bh(&msk->pm.lock);
>> +
>> +	if (subflow_added) {
>> +		msk->pm.add_addr_accepted++;
>> +		if (msk->pm.add_addr_accepted >= add_addr_accept_max ||
>> +		    msk->pm.subflows >= subflows_max)
>> +			WRITE_ONCE(msk->pm.accept_addr, false);
>> +	}
>>  }
>>  
>>  void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
> 
> Cheers,
> Matt

-- 
Li YongLong

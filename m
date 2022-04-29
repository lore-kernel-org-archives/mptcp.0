Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A1B7B
	for <mptcp@lists.linux.dev>; Fri, 29 Apr 2022 19:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651261795; x=1682797795;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ZPQXs+wL5UyPE/453TYT9jKLg/tSY3I8C+7NDwgUF8k=;
  b=UEDvwoufw7C35RIw1iv7hyEF+pxATnPzsCljzHCLsljT/q7FOh1mLxAX
   QFmVYMQK3QdiJLicyy91rOTGQmsLPYCCcEdwTHHO+10Ly6ZvMoxhv0gy2
   LAz9Oh3LiCUbmagnNOm6701RA+lzTJGsRInXpAkV0qsngZvu8J2hAg8Dd
   3NK5HJKJgNHvMFthHxxWN2t5QAXT+rr9/9gZlhXuSSOvrkOAgT+E9S61j
   CFTeuyXSGcxt7GRCWVq1/HfbjhC28kayYCEwM6Vbqy6x318SlVEUPVAJA
   eTOwy+qP1VblI6VcqezN5E+6EQuK5A79kGWySO0hgEOacJpdfmLp+aJkt
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="246672741"
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="246672741"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 12:49:54 -0700
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="534658616"
Received: from mdbellow-mobl.amr.corp.intel.com ([10.209.122.4])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 12:49:54 -0700
Date: Fri, 29 Apr 2022 12:49:54 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net 1/2] mptcp: fix subflow accounting on close
In-Reply-To: <cfad224c-fe81-beaa-751d-fa54f7b21be9@linux.intel.com>
Message-ID: <92df1fd1-8fa6-be4-10d-734b965f44af@linux.intel.com>
References: <84bfd492fa6e4a5ca5c90201283c48ed07318aa9.1651165091.git.pabeni@redhat.com> <cfad224c-fe81-beaa-751d-fa54f7b21be9@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 29 Apr 2022, Mat Martineau wrote:

> On Thu, 28 Apr 2022, Paolo Abeni wrote:
>
>> If the PM closes a fully established MPJ subflow or the subflow
>> creation errors out in it's early stage the subflows counter is
>> not bumped accordingly.
>> 
>> This change adds the missing accouting, additionally taking care
>> of updating accordingly the 'accept_subflow' flag.
>> 
>> Fixes: a88c9e496937 ("mptcp: do not block subflows creation on errors")
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>> net/mptcp/pm.c       |  5 ++---
>> net/mptcp/protocol.h | 14 ++++++++++++++
>> net/mptcp/subflow.c  | 12 +++++++++---
>> 3 files changed, 25 insertions(+), 6 deletions(-)
>> 
>> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
>> index cdc2d79071f8..59fdab2d0c27 100644
>> --- a/net/mptcp/pm.c
>> +++ b/net/mptcp/pm.c
>> @@ -181,15 +181,14 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock 
>> *msk, const struct sock *ssk,
>> 	struct mptcp_pm_data *pm = &msk->pm;
>> 	bool update_subflows;
>> 
>> -	update_subflows = (ssk->sk_state == TCP_CLOSE) &&
>> -			  (subflow->request_join || subflow->mp_join) &&
>> +	update_subflows = (subflow->request_join || subflow->mp_join) &&
>> 			  mptcp_pm_is_kernel(msk);
>> 	if (!READ_ONCE(pm->work_pending) && !update_subflows)
>> 		return;
>>
>> 	spin_lock_bh(&pm->lock);
>> 	if (update_subflows)
>> -		pm->subflows--;
>> +		__mptcp_pm_close_subflow(msk);
>>
>> 	/* Even if this subflow is not really established, tell the PM to try
>> 	 * to pick the next ones, if possible.
>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>> index 4672901d0dfe..06b8ebc15204 100644
>> --- a/net/mptcp/protocol.h
>> +++ b/net/mptcp/protocol.h
>> @@ -893,6 +893,20 @@ unsigned int mptcp_pm_get_add_addr_accept_max(const 
>> struct mptcp_sock *msk);
>> unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk);
>> unsigned int mptcp_pm_get_local_addr_max(const struct mptcp_sock *msk);
>> 
>> +/* called under PM lock */
>> +static inline void __mptcp_pm_close_subflow(struct mptcp_sock *msk)
>> +{
>> +	if (--msk->pm.subflows < mptcp_pm_get_subflows_max(msk))
>> +		WRITE_ONCE(msk->pm.accept_subflow, true);
>> +}
>> +
>> +static inline void mptcp_pm_close_subflow(struct mptcp_sock *msk)
>> +{
>> +	spin_lock_bh(&msk->pm.lock);
>> +	__mptcp_pm_close_subflow(msk);
>> +	spin_unlock_bh(&msk->pm.lock);
>> +}
>> +
>> void mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk);
>> void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk);
>> 
>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>> index 6d59336a8e1e..75c85ce9a19e 100644
>> --- a/net/mptcp/subflow.c
>> +++ b/net/mptcp/subflow.c
>> @@ -1444,20 +1444,20 @@ int __mptcp_subflow_connect(struct sock *sk, const 
>> struct mptcp_addr_info *loc,
>> 	struct sockaddr_storage addr;
>> 	int remote_id = remote->id;
>> 	int local_id = loc->id;
>> +	int err = -ENOTCONN;
>> 	struct socket *sf;
>> 	struct sock *ssk;
>> 	u32 remote_token;
>> 	int addrlen;
>> 	int ifindex;
>> 	u8 flags;
>> -	int err;
>>
>> 	if (!mptcp_is_fully_established(sk))
>> -		return -ENOTCONN;
>> +		goto err_out;
>>
>> 	err = mptcp_subflow_create_socket(sk, &sf);
>> 	if (err)
>> -		return err;
>> +		goto err_out;
>>
>> 	ssk = sf->sk;
>> 	subflow = mptcp_subflow_ctx(ssk);
>> @@ -1515,6 +1515,12 @@ int __mptcp_subflow_connect(struct sock *sk, const 
>> struct mptcp_addr_info *loc,
>> failed:
>> 	subflow->disposable = 1;
>> 	sock_release(sf);
>> +
>> +err_out:
>> +	/* we account subflows before the creation, and this failures will 
>> not
>> +	 * be catched by sk_state_change()
>> +	 */
>> +	mptcp_pm_close_subflow(msk);
>
> __mptcp_subflow_connect() is also called by the userspace PM, which doesn't 
> use this accounting. How about having the caller be responsible for doing 
> mptcp_pm_close_subflow() if __mptcp_subflow_connect() returns an error other 
> than -EINPROGRESS?
>

Hi Paolo,

One other thing - these patches applied cleanly to the export branch, but 
not export-net. The conflicts were not complicated, but in the future 
could you make sure mptcp-net patches apply to export-net?

Thanks,

--
Mat Martineau
Intel

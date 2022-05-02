Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7142F2A
	for <mptcp@lists.linux.dev>; Mon,  2 May 2022 17:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651511795; x=1683047795;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=0kHVpkZoHrpCI2zETqbZmN477CeFzKnaBwpI3/PESUM=;
  b=Ra/aGaunC3BH/EsJyU/NQUEhNmfhkjhRkNkrfSiF2hGeGJabavx2x75e
   xTKF+h3bpFtO4u6Acx27wlZuDXblgWhmdMtieGYl5hOa9IHsC/oLyKLSM
   x4K/g0zF3tH1DLXfumsJST4ADG/Kyv62g+d4d3VcPzUBzx9qnR8lnwtTg
   IjcienioCr9LogNgRsWaqwupOtNCZMvLPLru5yE96t5cv2uyLT6i5jPrp
   7/TAC/tWgUTmBnj67My3JiSV7WfDHzQi+HkG+fLuWAy1Zv47QfVpoaj1c
   zNJB+ZBIRX5VQhzlBdgXu/uk0fbbichqBPmOtRx8PoeYXlBR+4ykLPMz0
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="327814985"
X-IronPort-AV: E=Sophos;i="5.91,192,1647327600"; 
   d="scan'208";a="327814985"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 10:16:35 -0700
X-IronPort-AV: E=Sophos;i="5.91,192,1647327600"; 
   d="scan'208";a="561831720"
Received: from raltenor-mobl.amr.corp.intel.com ([10.212.200.195])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 10:16:35 -0700
Date: Mon, 2 May 2022 10:16:34 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net 1/2] mptcp: fix subflow accounting on close
In-Reply-To: <9561e194e1ccaf6e91c97b94973ed58984f361ec.camel@redhat.com>
Message-ID: <3894ce2a-764e-3479-981b-1c7862285a59@linux.intel.com>
References: <84bfd492fa6e4a5ca5c90201283c48ed07318aa9.1651165091.git.pabeni@redhat.com>  <cfad224c-fe81-beaa-751d-fa54f7b21be9@linux.intel.com> <9561e194e1ccaf6e91c97b94973ed58984f361ec.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 2 May 2022, Paolo Abeni wrote:

> On Fri, 2022-04-29 at 12:03 -0700, Mat Martineau wrote:
>> On Thu, 28 Apr 2022, Paolo Abeni wrote:
>>
>>> If the PM closes a fully established MPJ subflow or the subflow
>>> creation errors out in it's early stage the subflows counter is
>>> not bumped accordingly.
>>>
>>> This change adds the missing accouting, additionally taking care
>>> of updating accordingly the 'accept_subflow' flag.
>>>
>>> Fixes: a88c9e496937 ("mptcp: do not block subflows creation on errors")
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>> ---
>>> net/mptcp/pm.c       |  5 ++---
>>> net/mptcp/protocol.h | 14 ++++++++++++++
>>> net/mptcp/subflow.c  | 12 +++++++++---
>>> 3 files changed, 25 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
>>> index cdc2d79071f8..59fdab2d0c27 100644
>>> --- a/net/mptcp/pm.c
>>> +++ b/net/mptcp/pm.c
>>> @@ -181,15 +181,14 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk, const struct sock *ssk,
>>> 	struct mptcp_pm_data *pm = &msk->pm;
>>> 	bool update_subflows;
>>>
>>> -	update_subflows = (ssk->sk_state == TCP_CLOSE) &&
>>> -			  (subflow->request_join || subflow->mp_join) &&
>>> +	update_subflows = (subflow->request_join || subflow->mp_join) &&
>>> 			  mptcp_pm_is_kernel(msk);
>>> 	if (!READ_ONCE(pm->work_pending) && !update_subflows)
>>> 		return;
>>>
>>> 	spin_lock_bh(&pm->lock);
>>> 	if (update_subflows)
>>> -		pm->subflows--;
>>> +		__mptcp_pm_close_subflow(msk);
>>>
>>> 	/* Even if this subflow is not really established, tell the PM to try
>>> 	 * to pick the next ones, if possible.
>>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>>> index 4672901d0dfe..06b8ebc15204 100644
>>> --- a/net/mptcp/protocol.h
>>> +++ b/net/mptcp/protocol.h
>>> @@ -893,6 +893,20 @@ unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk);
>>> unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk);
>>> unsigned int mptcp_pm_get_local_addr_max(const struct mptcp_sock *msk);
>>>
>>> +/* called under PM lock */
>>> +static inline void __mptcp_pm_close_subflow(struct mptcp_sock *msk)
>>> +{
>>> +	if (--msk->pm.subflows < mptcp_pm_get_subflows_max(msk))
>>> +		WRITE_ONCE(msk->pm.accept_subflow, true);
>>> +}
>>> +
>>> +static inline void mptcp_pm_close_subflow(struct mptcp_sock *msk)
>>> +{
>>> +	spin_lock_bh(&msk->pm.lock);
>>> +	__mptcp_pm_close_subflow(msk);
>>> +	spin_unlock_bh(&msk->pm.lock);
>>> +}
>>> +
>>> void mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk);
>>> void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk);
>>>
>>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>>> index 6d59336a8e1e..75c85ce9a19e 100644
>>> --- a/net/mptcp/subflow.c
>>> +++ b/net/mptcp/subflow.c
>>> @@ -1444,20 +1444,20 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
>>> 	struct sockaddr_storage addr;
>>> 	int remote_id = remote->id;
>>> 	int local_id = loc->id;
>>> +	int err = -ENOTCONN;
>>> 	struct socket *sf;
>>> 	struct sock *ssk;
>>> 	u32 remote_token;
>>> 	int addrlen;
>>> 	int ifindex;
>>> 	u8 flags;
>>> -	int err;
>>>
>>> 	if (!mptcp_is_fully_established(sk))
>>> -		return -ENOTCONN;
>>> +		goto err_out;
>>>
>>> 	err = mptcp_subflow_create_socket(sk, &sf);
>>> 	if (err)
>>> -		return err;
>>> +		goto err_out;
>>>
>>> 	ssk = sf->sk;
>>> 	subflow = mptcp_subflow_ctx(ssk);
>>> @@ -1515,6 +1515,12 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
>>> failed:
>>> 	subflow->disposable = 1;
>>> 	sock_release(sf);
>>> +
>>> +err_out:
>>> +	/* we account subflows before the creation, and this failures will not
>>> +	 * be catched by sk_state_change()
>>> +	 */
>>> +	mptcp_pm_close_subflow(msk);
>>
>> __mptcp_subflow_connect() is also called by the userspace PM, which
>> doesn't use this accounting. How about having the caller be responsible
>> for doing mptcp_pm_close_subflow() if __mptcp_subflow_connect() returns an
>> error other than -EINPROGRESS?
>
> Additionally we probably want to take care of  to take care of
> mptcp_pm_subflow_check_next(), which is called regardless of the active
> PM and can touch subflows, too.
>
> On the flip side, touching 'subflows' when the active PM is the user-
> space one should not have any effect - beyond likely be confusing.
>
> I propose to handle all the above with a cleanup net-next patch after
> the relevant -net merge, so we can leverage the mptcp_pm_is_userspace()
> helper and keep the code as simple as possible.
>
> WDYT?
>

That plan works for me, thanks.

--
Mat Martineau
Intel

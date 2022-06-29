Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA343D6C
	for <mptcp@lists.linux.dev>; Wed, 29 Jun 2022 15:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656518344; x=1688054344;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=wBrIgT+nM73FmtCHxq1lygsBhDFEfHnVVqZQYrF3ef4=;
  b=nTd9U3lIEKx1I+WdhUhXaisGC9GgNj36IdWidOj3yRRyIFsoQ7t/fHJr
   je4H6jAocCV0wyMoAZeubyO5y9f1+z6rx3oIzcSHyffDJD+fmSf2PGgjI
   jTN14TmSM23bkw3T0TlBm8DPayRFWvyIGplUd/rZBs2FqapdFjzKzZuqI
   bdxCQzPgSNiMfdHSGjTbicpuWBxEUh766prMNWnZ+xHLks3NH4NaCDesQ
   ucXG2yDdmdiWu9I2QtV3Cz+Y1jBgmJ0n85e70e1mIxu+51X7I0/OtroJV
   TQkuU0SYc/HbvE+xl0XNvQDCFoqeQ06zvk8YlEdYw68gBowKjK1jJRj3E
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="368380680"
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="368380680"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 08:59:01 -0700
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="595285955"
Received: from bschenc3-mobl.amr.corp.intel.com ([10.209.57.164])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 08:59:01 -0700
Date: Wed, 29 Jun 2022 08:59:00 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH RFC 2/4]  mptcp: introduce and use mptcp_pm_send_ack()
In-Reply-To: <6693bf191808b3089a01b60bfaa350e551c62bc5.camel@redhat.com>
Message-ID: <ed8a271-fcef-2449-972a-f62c6cecc@linux.intel.com>
References: <cover.1656088406.git.pabeni@redhat.com>  <a59c3eb1e47c5c32f97c87d66c52f6c0021846bc.1656088406.git.pabeni@redhat.com>  <12f7b059-d6c8-cd75-1e1-33abe8b2b8fd@linux.intel.com> <6693bf191808b3089a01b60bfaa350e551c62bc5.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 29 Jun 2022, Paolo Abeni wrote:

> On Tue, 2022-06-28 at 16:28 -0700, Mat Martineau wrote:
>> On Fri, 24 Jun 2022, Paolo Abeni wrote:
>>
>>> The in-kernel PM has a bit of duplicate code related to ack
>>> generation. Create a new helper factoring out the PM-specific
>>> needs and use it in a couple of places.
>>>
>>> Note that this additionally moves a few unsafe subflow socket
>>> access under the relevant socket lock.
>>>
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>> ---
>>> net/mptcp/pm_netlink.c | 45 ++++++++++++++++++++++++------------------
>>> net/mptcp/protocol.c   | 11 ++++++++---
>>> net/mptcp/protocol.h   |  2 +-
>>> 3 files changed, 35 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>>> index 2b2bb3599781..91f6ed2a076a 100644
>>> --- a/net/mptcp/pm_netlink.c
>>> +++ b/net/mptcp/pm_netlink.c
>>> @@ -463,6 +463,29 @@ static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk, bool fullm
>>> 	return i;
>>> }
>>>
>>> +static void mptcp_pm_send_ack(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
>>> +			      bool prio, bool backup)
>>> +{
>>> +	struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
>>> +	bool slow;
>>> +
>>> +	spin_unlock_bh(&msk->pm.lock);
>>> +	pr_debug("send ack for %s",
>>> +		 prio ? "mp_prio" : (mptcp_pm_should_add_signal(msk) ? "add_addr" : "rm_addr"));
>>> +
>>> +	slow = lock_sock_fast(ssk);
>>> +	if (prio) {
>>> +		subflow->send_mp_prio = 1;
>>> +		subflow->backup = backup;
>>> +		subflow->request_bkup = backup;
>>> +	}
>>> +
>>> +	__mptcp_subflow_send_ack(ssk);
>>> +	unlock_sock_fast(ssk, slow);
>>> +
>>> +	spin_lock_bh(&msk->pm.lock);
>>> +}
>>
>> I was short on time yesterday so I delayed reviewing this RFC series...
>> Instead I spent time working on the "Locking fixes for subflow flag
>> changes" series which has very, very similar locking changes. MPTCP minds
>> think alike?
>
> :)
>
>
>> I guess the lesson is that I should always look at Paolo's pending patches
>> before trying to solve a "new" problem :)
>>
>> In that other series, I remove the pm locking when sending this ack for
>> MP_PRIO - but I think this refactoring could still be helpful. The pm lock
>> could be released and reacquired by the caller instead of inside
>> mptcp_pm_send_ack().
>
> LGTM! If you agree, I could rebase this series on top of "mptcp: Avoid
> acquiring PM lock for subflow priority changes".
>

Yes, would be good to rebase on that series. Thanks!

--
Mat Martineau
Intel

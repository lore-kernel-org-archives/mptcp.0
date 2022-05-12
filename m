Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9EF3D93
	for <mptcp@lists.linux.dev>; Thu, 12 May 2022 23:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652398836; x=1683934836;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=FKhOU+w6tiUTx3EIFbJ8M5yINHzUo5WIQ5TzYpX4ttM=;
  b=AfmRe0wxFcjhAiD4UT3LUuM9qgANl8m724XSqKhG1DgTdtQLGj1/bl4i
   mXBMV5R7tjlWDs+ZuDlNCFGFznRdnyLGjBhvsj5sEOTTNMnr24Nr92llj
   lpusb5iD0iGMfNqYqNi58POrQMGenqrkyIc4EfTjbCp7GoFBTU9dFH03w
   rgZSUQ7GCwyf0re4vGeovcOhfXijJ44BIe+2qPYFJCbDsZotdsst42L80
   g10Xwd/buTx81ao/65rt9hAOvF0bcIu+OgT4XawcqrPNeoGA+KFFvZR4D
   qUfPPvPPcxvFfL/4ERnFT35WQbBlIgSog+n9PuDbupFGhPqsDjWHoab4S
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="269834562"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="269834562"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 16:40:30 -0700
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="624619593"
Received: from gjimenez-mobl2.amr.corp.intel.com ([10.212.193.238])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 16:40:30 -0700
Date: Thu, 12 May 2022 16:40:20 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 2/2] mptcp: Do not traverse the subflow
 connection list without lock
In-Reply-To: <9f3f7f33e4fb662d85046205018f9cffd93aac44.camel@redhat.com>
Message-ID: <8f82e782-8e64-d198-24fc-f4d7f4689f@linux.intel.com>
References: <20220512002308.445416-1-mathew.j.martineau@linux.intel.com>  <20220512002308.445416-2-mathew.j.martineau@linux.intel.com> <9f3f7f33e4fb662d85046205018f9cffd93aac44.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 12 May 2022, Paolo Abeni wrote:

> On Wed, 2022-05-11 at 17:23 -0700, Mat Martineau wrote:
>> The MPTCP socket's conn_list (list of subflows) requires the socket lock
>> to access. The MP_FAIL timeout code added such an access, where it would
>> check the list of subflows both in timer context and (later) in workqueue
>> context where the socket lock is held.
>>
>> Rather than check the list twice, remove the check in the timeout
>> handler and only depend on the check in the workqueue.
>>
>> Reported-by: Paolo Abeni <pabeni@redhat.com>
>> Fixes: 49fa1919d6bc ("mptcp: reset subflow when MP_FAIL doesn't respond")
>> Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
>> ---
>>  net/mptcp/protocol.c | 16 ++--------------
>>  net/mptcp/protocol.h |  2 +-
>>  2 files changed, 3 insertions(+), 15 deletions(-)
>>
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 3c55e7f45aef..11e1c58dcbcf 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -2182,23 +2182,11 @@ mp_fail_response_expect_subflow(struct mptcp_sock *msk)
>>  	return ret;
>>  }
>>
>> -static void mptcp_check_mp_fail_response(struct mptcp_sock *msk)
>> -{
>> -	struct mptcp_subflow_context *subflow;
>> -	struct sock *sk = (struct sock *)msk;
>> -
>> -	bh_lock_sock(sk);
>> -	subflow = mp_fail_response_expect_subflow(msk);
>> -	if (subflow)
>> -		__set_bit(MPTCP_FAIL_NO_RESPONSE, &msk->flags);
>> -	bh_unlock_sock(sk);
>> -}
>> -
>>  static void mptcp_timeout_timer(struct timer_list *t)
>>  {
>>  	struct sock *sk = from_timer(sk, t, sk_timer);
>>
>> -	mptcp_check_mp_fail_response(mptcp_sk(sk));
>> +	set_bit(MPTCP_WORK_TIMEOUT, &mptcp_sk(sk)->flags);
>>  	mptcp_schedule_work(sk);
>>  	sock_put(sk);
>>  }
>
> I'm wondering if at this point we could get rid also of the
> MPTCP_WORK_TIMEOUT flags. In case of mptcp-level timeout we just
> schedule the worker and let it do it's check.

Yeah, the iteration and READ_ONCE() calls over the subflows are not that 
expensive. I'll send a v2 for this patch...

>
> Other than that the series LGTM, thanks!

...and mark the first patch as "queued".

--
Mat Martineau
Intel

Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F31EB8
	for <mptcp@lists.linux.dev>; Mon, 18 Jul 2022 18:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658169143; x=1689705143;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=BeFyZl8KKBJPqBnqHYKlLCgqk/uTWPdF8liPgdVWUxU=;
  b=bMW5CU/JhAbVOtIn4eMRFpsIyF9AUJA0YoUF3mQmhj07KIFtfah5GrGd
   XKtHcfoncZgM8LmfzmkxCErHHBcQ4ZK54ZyMd6sXOL14CQfYOf72OEJEH
   x7e9BfQ7bXWAYREYIlkFDbeVcbFNxnh3ethon9rKEmGwYZHst2TCvx9YE
   Sq1wUs9Mzl+eXGqL8SSciCGcB1rcT1TDTmTfo2lKxb+ncHVu8PPB1kHbg
   AnXPLdkcvI28IZXoVd31wjb3/C3s5FBwIba1DOgaEAsaOCV+jZ0qO9SuF
   GhjO1oMvPY4XVb+L3VDYfNhE+5DybJ/jqRz6sCurzy6UU/1OpRsdI2Gqm
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="347982062"
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="347982062"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 11:31:59 -0700
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="594559173"
Received: from sinforoz-mobl.amr.corp.intel.com ([10.251.20.49])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 11:31:58 -0700
Date: Mon, 18 Jul 2022 11:31:58 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, phind.uet@gmail.com
Subject: Re: [PATCH mptcp-net] mptcp: move subflow cleanup in
 mptcp_destroy_common()
In-Reply-To: <64bcf034cea0d8f4e19c8d2c8cd289ed0ccd6cb0.camel@redhat.com>
Message-ID: <7b1bb2af-381-bfcf-305d-a2676f58e3ef@linux.intel.com>
References: <bcfa7cfc41ada0c8811794cb3c45cdeb1b34f303.1657883173.git.pabeni@redhat.com>  <3e824615-67a2-77c5-6752-572fb17a71d5@linux.intel.com> <64bcf034cea0d8f4e19c8d2c8cd289ed0ccd6cb0.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 18 Jul 2022, Paolo Abeni wrote:

> On Fri, 2022-07-15 at 12:13 -0700, Mat Martineau wrote:
>> On Fri, 15 Jul 2022, Paolo Abeni wrote:
>>
>>> If the mptcp socket creation fails due to a CGROUP_INET_SOCK_CREATE
>>> eBPF program, the MPTCP protocol ends-up leaking all the subflows:
>>> the related cleanup happens in __mptcp_destroy_sock() that is not
>>> invoked in such code path.
>>>
>>> Address the issue moving the subflow sockets cleanup in the
>>> mptcp_destroy_common() helper, which is invoked in every msk cleanup
>>> path.
>>>
>>> Additionally get rid of the intermediate list_splice_init step, which
>>> is an unneeded relic from the past.
>>>
>>> The issue is present since before the reported root cause commit, but
>>> any attempt to backport the fix before that hash will require a complete
>>> rewrite.
>>>
>>> Fixes: e16163b6e2 ("mptcp: refactor shutdown and close")
>>> Reported-by: Nguyen Dinh Phi <phind.uet@gmail.com>
>>> Co-developed-by: Nguyen Dinh Phi <phind.uet@gmail.com>
>>> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>> ---
>>> The tags are provisional, waiting for Nguyen feedback/preferences.
>>>
>>> Sending out early to trigger the CI.
>>
>> For some reason patchew didn't tag this commit, so the CI didn't trigger.
>> Patchew did tag my patch about a half hour ago, so the importer doesn't
>> seem to be completely offline.
>>
>> I manually pushed a tag: patchew/20220715-pabeni-subflow-cleanup
>>
>> That has started the github and cirrus-ci builds:
>>
>> https://github.com/multipath-tcp/mptcp_net-next/actions/runs/2678690859
>> https://cirrus-ci.com/build/4905612499746816
>>
>>
>> I also noticed that this patch conflicts with Matthieu's "mptcp: add
>> mptcp_for_each_subflow_safe helper" patch, but that's only in the export
>> branch currently so we can easily wait on that until your -net fix
>> propagates to net-next.
>>
>>
>> One more question below (about mptcp_dispose_initial_subflow), but
>> assuming the CI results are ok I think this would be good to apply to
>> export-net and squash further fixes if needed:
>>
>> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
>>
>>>
>>> This will need likely some staging period.
>>>
>>> "mptcp: add mptcp_for_each_subflow_safe helper" needs to be rebased
>>> on top of this (we can replace another list_for_each_safe instance)
>>> ---
>>> net/mptcp/protocol.c | 39 +++++++++++++++------------------------
>>> net/mptcp/protocol.h |  2 +-
>>> net/mptcp/subflow.c  |  3 ++-
>>> 3 files changed, 18 insertions(+), 26 deletions(-)
>>>
>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>> index 21a3ed64226e..6f3324955355 100644
>>> --- a/net/mptcp/protocol.c
>>> +++ b/net/mptcp/protocol.c
>>> @@ -2804,30 +2804,16 @@ static void __mptcp_wr_shutdown(struct sock *sk)
>>>
>>> static void __mptcp_destroy_sock(struct sock *sk)
>>> {
>>> -	struct mptcp_subflow_context *subflow, *tmp;
>>> 	struct mptcp_sock *msk = mptcp_sk(sk);
>>> -	LIST_HEAD(conn_list);
>>>
>>> 	pr_debug("msk=%p", msk);
>>>
>>> 	might_sleep();
>>>
>>> -	/* join list will be eventually flushed (with rst) at sock lock release time*/
>>> -	list_splice_init(&msk->conn_list, &conn_list);
>>> -
>>> 	mptcp_stop_timer(sk);
>>> 	sk_stop_timer(sk, &sk->sk_timer);
>>> 	msk->pm.status = 0;
>>>
>>> -	/* clears msk->subflow, allowing the following loop to close
>>> -	 * even the initial subflow
>>> -	 */
>>> -	mptcp_dispose_initial_subflow(msk);
>>> -	list_for_each_entry_safe(subflow, tmp, &conn_list, node) {
>>> -		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
>>> -		__mptcp_close_ssk(sk, ssk, subflow, 0);
>>> -	}
>>> -
>>> 	sk->sk_prot->destroy(sk);
>>>
>>> 	WARN_ON_ONCE(msk->rmem_fwd_alloc);
>>> @@ -2919,24 +2905,20 @@ static void mptcp_copy_inaddrs(struct sock *msk, const struct sock *ssk)
>>>
>>> static int mptcp_disconnect(struct sock *sk, int flags)
>>> {
>>> -	struct mptcp_subflow_context *subflow, *tmp;
>>> 	struct mptcp_sock *msk = mptcp_sk(sk);
>>>
>>> 	inet_sk_state_store(sk, TCP_CLOSE);
>>>
>>> -	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
>>> -		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
>>> -
>>> -		__mptcp_close_ssk(sk, ssk, subflow, MPTCP_CF_FASTCLOSE);
>>> -	}
>>> -
>>> 	mptcp_stop_timer(sk);
>>> 	sk_stop_timer(sk, &sk->sk_timer);
>>>
>>> 	if (mptcp_sk(sk)->token)
>>> 		mptcp_event(MPTCP_EVENT_CLOSED, mptcp_sk(sk), NULL, GFP_KERNEL);
>>>
>>> -	mptcp_destroy_common(msk);
>>> +	/* msk->subflow is still intact, the following will not free the first
>>> +	 * subflow
>>> +	 */
>>> +	mptcp_destroy_common(msk, MPTCP_CF_FASTCLOSE);
>>> 	msk->last_snd = NULL;
>>> 	WRITE_ONCE(msk->flags, 0);
>>> 	msk->cb_flags = 0;
>>> @@ -3086,12 +3068,17 @@ static struct sock *mptcp_accept(struct sock *sk, int flags, int *err,
>>> 	return newsk;
>>> }
>>>
>>> -void mptcp_destroy_common(struct mptcp_sock *msk)
>>> +void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
>>> {
>>> +	struct mptcp_subflow_context *subflow, *tmp;
>>> 	struct sock *sk = (struct sock *)msk;
>>>
>>> 	__mptcp_clear_xmit(sk);
>>>
>>> +	/* join list will be eventually flushed (with rst) at sock lock release time */
>>> +	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node)
>>> +		__mptcp_close_ssk(sk, mptcp_subflow_tcp_sock(subflow), subflow, flags);
>>> +
>>> 	/* move to sk_receive_queue, sk_stream_kill_queues will purge it */
>>> 	mptcp_data_lock(sk);
>>> 	skb_queue_splice_tail_init(&msk->receive_queue, &sk->sk_receive_queue);
>>> @@ -3113,7 +3100,11 @@ static void mptcp_destroy(struct sock *sk)
>>> {
>>> 	struct mptcp_sock *msk = mptcp_sk(sk);
>>>
>>> -	mptcp_destroy_common(msk);
>>> +	/* clears msk->subflow, allowing the following to close
>>> +	 * even the initial subflow
>>> +	 */
>>> +	mptcp_dispose_initial_subflow(msk);
>>
>> Was the missing call to mptcp_displose_initial_subflow() also causing a
>> problem? Or did this cleanup end up happening through a different path?
>>
>> This seems different from the "leaking all subflows" case mentioned in the
>> commit message.
>
> I'm unsure I read the question correctly.
>
> This patch does not add a new mptcp_dispose_initial_subflow() call in
> the cleanup/free code path. Such call was already there in
> __mptcp_destroy_sock(), and is needed to ensure even the initial
> subflow is deleted.
>
> mptcp_dispose_initial_subflow() is placed outside
> mptcp_destroy_common() to allow mptcp_disconnect() to re-use the latter
> helper while preserving the initial subflow
>

Right, it was clear that the old call in __mptcp_destroy_sock() was moved 
to mptcp_destroy().

But the commit message states that not every cleanup/free code path was 
calling __mptcp_destroy_sock(). That means not every code path was calling 
mptcp_dispose_initial_subflow(), and now it is consistently called by 
mptcp_destroy().

Does this mean the msk->subflow inode was leaked as part of "leaking all 
the subflows"? Or was that inode cleaned up some other way when 
__mptcp_destroy_sock() was not called?

--
Mat Martineau
Intel

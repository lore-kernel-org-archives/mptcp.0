Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9471FC8
	for <mptcp@lists.linux.dev>; Fri, 27 May 2022 20:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653681790; x=1685217790;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=R+m1A8O9uXZ1WPXOWzbZUWDGZyq/X/EnHvyZNx8rU7A=;
  b=Z73I1whQJafi80c5TN/vusRRb1l03gv7Aer3cUiuYJhRSdW5CaYHP+H8
   vizcKPAgru6uFArwxGxUv9AjDEZ2PJWfei3vZ3RtzghM8PRZpdD1xhiup
   D+0RnGV+8t806t0XsldgrrKoZmD8gHg655peDgZvqZuQyDMMGaEzRzs4z
   xssgBThHi0eyVm3AblMIXR1jpKPY1iQISq1xwOOi1uNPUIU2W0f202g53
   On8+HNSgWOjavvRd5LY7SX9C3SzsV/IaUImi1IzKpR7Iz30DRV06AAY2R
   FS+IPYmJO+wfpfz3GOpErLctoumI5Hk6N80qLiqUj3uk/dtiW9MAwzY5x
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10360"; a="255059750"
X-IronPort-AV: E=Sophos;i="5.91,256,1647327600"; 
   d="scan'208";a="255059750"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 13:03:09 -0700
X-IronPort-AV: E=Sophos;i="5.91,256,1647327600"; 
   d="scan'208";a="560914094"
Received: from mapenner-mobl1.amr.corp.intel.com ([10.209.63.165])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 13:03:09 -0700
Date: Fri, 27 May 2022 13:03:02 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 3/5] Squash to "mptcp: add get_subflow
 wrappers"
In-Reply-To: <20220527152717.GA19642@bogon.HOST>
Message-ID: <f580e7c6-bfcf-c990-5232-bb3e5184475@linux.intel.com>
References: <cover.1653305364.git.geliang.tang@suse.com> <e0034f846f86901bd0c996bca6693c4036602750.1653305364.git.geliang.tang@suse.com> <294011b7-28d5-5549-c138-e6e674b18b9e@linux.intel.com> <20220526121659.GA2665@bogon.HOST> <92789df9-f9e7-9d31-e859-eef24b938919@linux.intel.com>
 <20220527152717.GA19642@bogon.HOST>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 27 May 2022, Geliang Tang wrote:

> Hi Mat,
>
> On Thu, May 26, 2022 at 04:48:41PM -0700, Mat Martineau wrote:
>> On Thu, 26 May 2022, Geliang Tang wrote:
>>
>>> Hi Mat,
>>>
>>> On Mon, May 23, 2022 at 06:01:03PM -0700, Mat Martineau wrote:
>>>> On Mon, 23 May 2022, Geliang Tang wrote:
>>>>
>>>>> Please update the commit log:
>>>>>
>>>>> '''
>>>>> This patch defines two new wrappers mptcp_sched_get_send() and
>>>>> mptcp_sched_get_retrans(), invoke get_subflow() of msk->sched in them.
>>>>> Use them instead of using mptcp_subflow_get_send() or
>>>>> mptcp_subflow_get_retrans() directly.
>>>>>
>>>>> Set the subflow pointers array in struct mptcp_sched_data before invoking
>>>>> get_subflow(), then it can be used in get_subflow() in the BPF contexts.
>>>>>
>>>>> Get the return bitmap of get_subflow() and test which subflow or subflows
>>>>> are picked by the scheduler.
>>>>> '''
>>>>>
>>>>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
>>>>> ---
>>>>> net/mptcp/sched.c | 47 +++++++++++++++++++++++++++++++++++++++--------
>>>>> 1 file changed, 39 insertions(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
>>>>> index 3ceb721e6489..0ef805c489ab 100644
>>>>> --- a/net/mptcp/sched.c
>>>>> +++ b/net/mptcp/sched.c
>>>>> @@ -91,8 +91,19 @@ void mptcp_release_sched(struct mptcp_sock *msk)
>>>>> static int mptcp_sched_data_init(struct mptcp_sock *msk,
>>>>> 				 struct mptcp_sched_data *data)
>>>>> {
>>>>> -	data->sock = NULL;
>>>>> -	data->call_again = 0;
>>>>> +	struct mptcp_subflow_context *subflow;
>>>>> +	int i = 0;
>>>>> +
>>>>> +	mptcp_for_each_subflow(msk, subflow) {
>>>>> +		if (i == MPTCP_SUBFLOWS_MAX) {
>>>>> +			pr_warn_once("too many subflows");
>>>>> +			break;
>>>>> +		}
>>>>> +		data->contexts[i++] = subflow;
>>>>> +	}
>>>>> +
>>>>> +	for (; i < MPTCP_SUBFLOWS_MAX; i++)
>>>>> +		data->contexts[i++] = NULL;
>>>>>
>>>>> 	return 0;
>>>>> }
>>>>> @@ -100,6 +111,9 @@ static int mptcp_sched_data_init(struct mptcp_sock *msk,
>>>>> struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
>>>>> {
>>>>> 	struct mptcp_sched_data data;
>>>>> +	struct sock *ssk = NULL;
>>>>> +	unsigned long bitmap;
>>>>> +	int i;
>>>>>
>>>>> 	sock_owned_by_me((struct sock *)msk);
>>>>>
>>>>> @@ -114,15 +128,25 @@ struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
>>>>> 		return mptcp_subflow_get_send(msk);
>>>>>
>>>>> 	mptcp_sched_data_init(msk, &data);
>>>>> -	msk->sched->get_subflow(msk, false, &data);
>>>>> +	bitmap = msk->sched->get_subflow(msk, false, &data);
>>>>>
>>>>> -	msk->last_snd = data.sock;
>>>>> -	return data.sock;
>>>>> +	for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
>>>>> +		if (test_bit(i, &bitmap) && data.contexts[i]) {
>>>>> +			ssk = data.contexts[i]->tcp_sock;
>>>>> +			msk->last_snd = ssk;
>>>>> +			break;
>>>>> +		}
>>>>> +	}
>>>>> +
>>>>> +	return ssk;
>>>>
>>>> The commit that this gets squashed too also ignores call_again, so is this
>>>> code that just returns the ssk for the first bit in the bitmap also
>>>> placeholder code?
>>>
>>> Yes. Since the redundant scheduler is still under development and there's
>>> still a lot of work to be done, I plan to support single subflow schedulers
>>> in this series first. The multiple subflows schedulers will be added later.
>>>
>>>>
>>>>
>>>> It also seems like correlate the bitmap bits with the data.contexts array
>>>> makes the bitmap require extra work. What do you think about using an array
>>>> instead, like:
>>>>
>>>> struct mptcp_sched_data {
>>>>        struct mptcp_subflow_context *context;
>>>>        bool is_scheduled;
>>>> };
>>>>
>>>> And passing an array of that struct to the BPF code? Then the is_scheduled
>>>> flag could be set for the corresponding subflow.
>>>>
>>>> Do you think that array-based API would be clearer than the bitmap to
>>>> someone writing a BPF scheduler?
>>>
>>> I tried to implement this array-based API, but it's not going well. Array
>>> parameters are not easily supported in BPF functions. And the write access
>>> permissions of array members is not easy to allow in BPF. I haven't found
>>> a solution to these two issues yet. Here are codes and error logs in the
>>> attachment.
>>>
>>
>> Yeah, after looking at your logs and trying a few experiments, I definitely
>> agree that array parameters are not well supported by the BPF verifies.
>>
>> It looks like the bpf verifier was inspecting the args for get_subflow in
>> mptcp_sched_ops:
>>
>> void (*get_subflow)(const struct mptcp_sock *msk, bool reinject,
>> 		    struct mptcp_sched_data contexts[]);
>>
>> and thinking 'contexts' was a pointer to a single struct mptcp_sched_data
>> instance, instead of an array. The verifier can't guarantee safe access for
>> a variable-length array so that does make some sense.
>>
>> I tried changing the code to:
>>
>> void (*get_subflow)(const struct mptcp_sock *msk, bool reinject,
>>                     struct mptcp_sched_data (*contexts)[MPTCP_SUBFLOWS_MAX]);
>>
>> so the third arg was a "pointer to array of structs, with MPTCP_SUBFLOWS_MAX
>> elements in the array". The verifier didn't like that either:
>>
>> """
>> func 'get_subflow' arg2 type ARRAY is not a struct
>> """
>>
>> That error message is printed by btf_ctx_access(). It might be possible to
>> customize bpf_mptcp_sched_verifier_ops to handle that, but it seems
>> complicated.
>>
>>
>> We could instead use mptcp_sched_data to contain all the parameters
>> (including an array of structs):
>>
>> struct mptcp_sched_subflow {
>> 	struct mptcp_subflow_context *context;
>> 	bool is_scheduled;
>> };
>>
>> struct mptcp_sched_data {
>> 	/* Moving the msk and reinject args here is optional, but
>> 	 * it seemed like a good way to group all of the data
>> 	 * for a bpf scheduler to use */
>> 	const struct mptcp_sock *msk;
>> 	bool reinject;
>> 	struct mptcp_sched_subflow subflows[MPTCP_SUBFLOWS_MAX];
>> };
>>
>> struct mptcp_sched_ops {
>> 	void (*get_subflow)(struct mptcp_sched_data *data);
>>
>> 	char			name[MPTCP_SCHED_NAME_MAX];
>> 	struct module		*owner;
>> 	struct list_head	list;
>>
>> 	void (*init)(const struct mptcp_sock *msk);
>> 	void (*release)(const struct mptcp_sock *msk);
>> } ____cacheline_aligned_in_smp;
>>
>> It looks like btf_struct_access() and btf_struct_walk() know how to handle
>> an array *inside* a struct, so MPTCP would not need as much custom verifier
>> code. This seems like a better fit than my array idea - hopefully it's more
>> workable.
>
> It's hard to get the write access to is_scheduled in this case.
>
> If we add another member bitmap in mptcp_sched_data like this:
>
> struct mptcp_sched_subflow {
> 	struct mptcp_subflow_context *context;
> 	bool is_scheduled;
> };
>
> struct mptcp_sched_data {
> 	struct mptcp_sched_subflow subflows[MPTCP_SUBFLOWS_MAX];
> 	const struct mptcp_sock *msk;
> 	bool reinject;
> 	unsigned bitmap;
> };
>
> It's easy to calculate the offset in bpf_mptcp_sched_btf_struct_access():
>
> 	switch (off) {
> 	case offsetof(struct mptcp_sched_data, bitmap):
> 		end = offsetofend(struct mptcp_sched_data, bitmap);
> 		break;
>
> But it's hard to calculate the offsets of is_scheduled, we need to have
> write access for 8 different offsets.
>
> We may calculate them like this:
>
> data->contexts[0].is_scheduled	offset = 0 + sizeof(struct mptcp_subflow_context)
> data->contexts[1].is_scheduled  offset = 1 * sizeof(mptcp_sched_subflow) + sizeof(struct mptcp_subflow_context *)
> data->contexts[2].is_scheduled  ...
> data->contexts[3].is_scheduled  ...
> data->contexts[4].is_scheduled  ...
> data->contexts[5].is_scheduled  ...
> data->contexts[6].is_scheduled  ...
> data->contexts[7].is_scheduled  offset = 7 * sizeof(mptcp_sched_subflow) + sizeof(struct mptcp_subflow_context *)
>
> But it doesn't work. I haven't found a solution yet.
>
> Maybe we also need to consider the actual number of subflows, which makes
> it more complicated.
>
>
> If we make the array read only, just write the bitmap member or return a
> bitmap, we can avoid dealing with these complex offsets.
>
>
> Anyway, I will continue to solve this write access issue, but I also want
> to hear your opinion.


I think using a loop to evaluate possible offsets within the array is not 
too complex.


Going back to this layout:

struct mptcp_sched_data {
 	const struct mptcp_sock *msk;
 	bool reinject;
 	struct mptcp_sched_subflow subflows[MPTCP_SUBFLOWS_MAX];
};

The offset limits of is_scheduled within each mptcp_sched_subflow are:

nested_offset = offsetof(struct mptcp_sched_subflow, is_scheduled);
nested_offset_end = offsetofend(struct mptcp_sched_subflow, is_scheduled);

and the starting offset of each element in the subflows[] array is:

static size_t subflow_offset(int i)
{
 	return offsetof(struct mptcp_sched_data, subflows) + i * sizeof(struct mptcp_sched_subflow);
}


Then I think the offset 'off' can be checked for write access in a loop:

for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
 	size_t soff = subflow_offset(i);
 	if (off == soff + nested_offset && off + size <= soff + nested_offset_end)
 		return NOT_INIT; /* offsets match up with is_scheduled */
}


--
Mat Martineau
Intel

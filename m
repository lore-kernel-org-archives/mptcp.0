Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9438F2CA4
	for <mptcp@lists.linux.dev>; Thu, 26 May 2022 23:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653608922; x=1685144922;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=guIkA9KYh4xhpGpIigDQfUC3jenNeH1mrzDOSvc9sIs=;
  b=FBP/GCP0TAlyULxUhhtvzmH8u6LJpQFKT3KPlKhc6+8ErjexJp3ZUeCp
   n7gC7+/JyLxA+sdifR8nbCYeEMXd6rNp4TDhqnrfZlxSTbHXod40ubYfI
   QHbnwUKcduoFmSmQnJlQHuTgoaB6KSM2Vzh6E0JeYd8sTNaITeCw2jhk/
   MC2xyni+VWvyyEilwLhayiGvnUFGJCXgh7HejtOKzE4qCxIQg3FldiAEp
   2gkPlT3m9d4liQeCPWeVVKTnihZBWxcBwqTaFslbcSJw+WPXUXMpIbuoP
   yCMt87s1ze6qHqMGE5LdLbO9Qn2d/aLLNfiywLdAadi/q1gp/gKyc9kZg
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="299668168"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="299668168"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 16:48:41 -0700
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="609958018"
Received: from boyao-mobl2.amr.corp.intel.com ([10.251.4.60])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 16:48:41 -0700
Date: Thu, 26 May 2022 16:48:41 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 3/5] Squash to "mptcp: add get_subflow
 wrappers"
In-Reply-To: <20220526121659.GA2665@bogon.HOST>
Message-ID: <92789df9-f9e7-9d31-e859-eef24b938919@linux.intel.com>
References: <cover.1653305364.git.geliang.tang@suse.com> <e0034f846f86901bd0c996bca6693c4036602750.1653305364.git.geliang.tang@suse.com> <294011b7-28d5-5549-c138-e6e674b18b9e@linux.intel.com> <20220526121659.GA2665@bogon.HOST>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 26 May 2022, Geliang Tang wrote:

> Hi Mat,
>
> On Mon, May 23, 2022 at 06:01:03PM -0700, Mat Martineau wrote:
>> On Mon, 23 May 2022, Geliang Tang wrote:
>>
>>> Please update the commit log:
>>>
>>> '''
>>> This patch defines two new wrappers mptcp_sched_get_send() and
>>> mptcp_sched_get_retrans(), invoke get_subflow() of msk->sched in them.
>>> Use them instead of using mptcp_subflow_get_send() or
>>> mptcp_subflow_get_retrans() directly.
>>>
>>> Set the subflow pointers array in struct mptcp_sched_data before invoking
>>> get_subflow(), then it can be used in get_subflow() in the BPF contexts.
>>>
>>> Get the return bitmap of get_subflow() and test which subflow or subflows
>>> are picked by the scheduler.
>>> '''
>>>
>>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
>>> ---
>>> net/mptcp/sched.c | 47 +++++++++++++++++++++++++++++++++++++++--------
>>> 1 file changed, 39 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
>>> index 3ceb721e6489..0ef805c489ab 100644
>>> --- a/net/mptcp/sched.c
>>> +++ b/net/mptcp/sched.c
>>> @@ -91,8 +91,19 @@ void mptcp_release_sched(struct mptcp_sock *msk)
>>> static int mptcp_sched_data_init(struct mptcp_sock *msk,
>>> 				 struct mptcp_sched_data *data)
>>> {
>>> -	data->sock = NULL;
>>> -	data->call_again = 0;
>>> +	struct mptcp_subflow_context *subflow;
>>> +	int i = 0;
>>> +
>>> +	mptcp_for_each_subflow(msk, subflow) {
>>> +		if (i == MPTCP_SUBFLOWS_MAX) {
>>> +			pr_warn_once("too many subflows");
>>> +			break;
>>> +		}
>>> +		data->contexts[i++] = subflow;
>>> +	}
>>> +
>>> +	for (; i < MPTCP_SUBFLOWS_MAX; i++)
>>> +		data->contexts[i++] = NULL;
>>>
>>> 	return 0;
>>> }
>>> @@ -100,6 +111,9 @@ static int mptcp_sched_data_init(struct mptcp_sock *msk,
>>> struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
>>> {
>>> 	struct mptcp_sched_data data;
>>> +	struct sock *ssk = NULL;
>>> +	unsigned long bitmap;
>>> +	int i;
>>>
>>> 	sock_owned_by_me((struct sock *)msk);
>>>
>>> @@ -114,15 +128,25 @@ struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
>>> 		return mptcp_subflow_get_send(msk);
>>>
>>> 	mptcp_sched_data_init(msk, &data);
>>> -	msk->sched->get_subflow(msk, false, &data);
>>> +	bitmap = msk->sched->get_subflow(msk, false, &data);
>>>
>>> -	msk->last_snd = data.sock;
>>> -	return data.sock;
>>> +	for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
>>> +		if (test_bit(i, &bitmap) && data.contexts[i]) {
>>> +			ssk = data.contexts[i]->tcp_sock;
>>> +			msk->last_snd = ssk;
>>> +			break;
>>> +		}
>>> +	}
>>> +
>>> +	return ssk;
>>
>> The commit that this gets squashed too also ignores call_again, so is this
>> code that just returns the ssk for the first bit in the bitmap also
>> placeholder code?
>
> Yes. Since the redundant scheduler is still under development and there's
> still a lot of work to be done, I plan to support single subflow schedulers
> in this series first. The multiple subflows schedulers will be added later.
>
>>
>>
>> It also seems like correlate the bitmap bits with the data.contexts array
>> makes the bitmap require extra work. What do you think about using an array
>> instead, like:
>>
>> struct mptcp_sched_data {
>>        struct mptcp_subflow_context *context;
>>        bool is_scheduled;
>> };
>>
>> And passing an array of that struct to the BPF code? Then the is_scheduled
>> flag could be set for the corresponding subflow.
>>
>> Do you think that array-based API would be clearer than the bitmap to
>> someone writing a BPF scheduler?
>
> I tried to implement this array-based API, but it's not going well. Array
> parameters are not easily supported in BPF functions. And the write access
> permissions of array members is not easy to allow in BPF. I haven't found
> a solution to these two issues yet. Here are codes and error logs in the
> attachment.
>

Yeah, after looking at your logs and trying a few experiments, I 
definitely agree that array parameters are not well supported by the BPF 
verifies.

It looks like the bpf verifier was inspecting the args for get_subflow in 
mptcp_sched_ops:

void (*get_subflow)(const struct mptcp_sock *msk, bool reinject,
 		    struct mptcp_sched_data contexts[]);

and thinking 'contexts' was a pointer to a single struct mptcp_sched_data 
instance, instead of an array. The verifier can't guarantee safe access 
for a variable-length array so that does make some sense.

I tried changing the code to:

void (*get_subflow)(const struct mptcp_sock *msk, bool reinject,
                     struct mptcp_sched_data (*contexts)[MPTCP_SUBFLOWS_MAX]);

so the third arg was a "pointer to array of structs, with 
MPTCP_SUBFLOWS_MAX elements in the array". The verifier didn't like that 
either:

"""
func 'get_subflow' arg2 type ARRAY is not a struct
"""

That error message is printed by btf_ctx_access(). It might be possible to 
customize bpf_mptcp_sched_verifier_ops to handle that, but it seems 
complicated.


We could instead use mptcp_sched_data to contain all the parameters 
(including an array of structs):

struct mptcp_sched_subflow {
 	struct mptcp_subflow_context *context;
 	bool is_scheduled;
};

struct mptcp_sched_data {
 	/* Moving the msk and reinject args here is optional, but
 	 * it seemed like a good way to group all of the data
 	 * for a bpf scheduler to use */
 	const struct mptcp_sock *msk;
 	bool reinject;
 	struct mptcp_sched_subflow subflows[MPTCP_SUBFLOWS_MAX];
};

struct mptcp_sched_ops {
 	void (*get_subflow)(struct mptcp_sched_data *data);

 	char			name[MPTCP_SCHED_NAME_MAX];
 	struct module		*owner;
 	struct list_head	list;

 	void (*init)(const struct mptcp_sock *msk);
 	void (*release)(const struct mptcp_sock *msk);
} ____cacheline_aligned_in_smp;

It looks like btf_struct_access() and btf_struct_walk() know how to handle 
an array *inside* a struct, so MPTCP would not need as much custom 
verifier code. This seems like a better fit than my array idea - hopefully 
it's more workable.

Do you think this seems like a reasonable interface for BPF 
scheduler code?


--
Mat Martineau
Intel

Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25571173
	for <mptcp@lists.linux.dev>; Fri, 10 Dec 2021 23:04:27 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10194"; a="218492850"
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="218492850"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 15:04:27 -0800
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="680921093"
Received: from dmales-mobl.amr.corp.intel.com ([10.251.4.94])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 15:04:26 -0800
Date: Fri, 10 Dec 2021 15:04:26 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Florian Westphal <fw@strlen.de>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v2 1/2] mptcp: clear 'kern' flag from fallback sockets
In-Reply-To: <20211210090004.GF26636@breakpoint.cc>
Message-ID: <f89e2257-c2bd-672-ad5b-eb4e6d6cf749@linux.intel.com>
References: <d5c4d25c-7498-46c5-54b6-4fd067d075f2@linux.intel.com> <20211206212650.1895-1-fw@strlen.de> <bf919f98-d135-fffe-e586-873810a81f4d@linux.intel.com> <6c32d24c-d4d-727d-27a9-75478838157e@linux.intel.com> <20211210090004.GF26636@breakpoint.cc>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 10 Dec 2021, Florian Westphal wrote:

> Mat Martineau <mathew.j.martineau@linux.intel.com> wrote:
>> On Mon, 6 Dec 2021, Mat Martineau wrote:
>>
>>> On Mon, 6 Dec 2021, Florian Westphal wrote:
>>>
>>>> The mptcp ULP extension relies on sk->sk_sock_kern being set correctly:
>>>> It prevents setsockopt(fd, IPPROTO_TCP, TCP_ULP, "mptcp", 6); from
>>>> working for plain tcp sockets (any userspace-exposed socket).
>>>>
>>>> But in case of fallback, accept() can return a plain tcp sk.
>>>> In such case, sk is still tagged as 'kernel' and setsockopt will work.
>>>>
>>>> This will crash the kernel, The subflow extension has a NULL ctx->conn
>>>> mptcp socket:
>>>>
>>>> BUG: KASAN: null-ptr-deref in subflow_data_ready+0x181/0x2b0
>>>> Call Trace:
>>>> tcp_data_ready+0xf8/0x370
>>>> [..]
>>>>
>>>> Fixes: cf7da0d66cc1 ("mptcp: Create SUBFLOW socket for incoming
>>>> connections")
>>>> Signed-off-by: Florian Westphal <fw@strlen.de>
>>>> ---
>>>> v2: also handle early-return
>>>
>>> Thanks - v2 looks good to me.
>>>
>>> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
>>>
>>>>
>>>> net/mptcp/protocol.c | 4 +++-
>>>> 1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>>> index 8319e601bc2d..4a8f2476cc75 100644
>>>> --- a/net/mptcp/protocol.c
>>>> +++ b/net/mptcp/protocol.c
>>>> @@ -3013,7 +3013,7 @@ static struct sock *mptcp_accept(struct sock
>>>> *sk, int flags, int *err,
>>>> 		 */
>>>> 		if (WARN_ON_ONCE(!new_mptcp_sock)) {
>>>> 			tcp_sk(newsk)->is_mptcp = 0;
>>>> -			return newsk;
>>>> +			goto out;
>>>> 		}
>>>>
>>>> 		/* acquire the 2nd reference for the owning socket */
>>>> @@ -3025,6 +3025,8 @@ static struct sock *mptcp_accept(struct sock
>>>> *sk, int flags, int *err,
>>>> 				MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);
>>>> 	}
>>>>
>>>> +out:
>>>> +	newsk->sk_kern_sock = kern;
>>
>> Florian -
>>
>> I was about to upstream this for -net, but have another question first.
>>
>> Is there anything else in newsk that needs to be updated when changing
>> sk_kern_sock? sk_alloc() handles some reference counts differently for kern
>> socks, and sock_lock_init() sets things up differently for lockdep.
>
> AFAICS no.
>
> The tcpsk inherits these settings from its parent (listen) sk, so they
> always have 'kern = 1'.
>
> Even before this change, lock depclass is not correct (kernel, not user).
>
> Need to export code from core to change this.
>
> The netns refcount bump is not needed, but at this point it has already
> happened so even if we undo+clear ->sk_net_refcnt it won't buy anthing.
>

Ok, thanks for the background on the refcounts. I also now see the code in 
mtpcp_subflow_create_socket() that already adjusts the refcounts.

> So only alternative I see is to toss this patch and use a different
> sk marker to block mptcp ulp on normal tcp sockets.
>
> This would not change the incorrect lockdep class in this case of course
> but would avoid messing with this.
>
> tp->is_mptcp would come to mind, we only need to set it to 1 before
> adding the mptcp ulp from inside the kernel rather than in the mptcp ulp
> init function.
>

So the question is which inconsistency is better: mismatch between the 
lockdep class and sk_kern_sock bit (the original patch for this email 
thread), or having a sk_kern_sock=1 socket out in usespace (the proposed 
alternative).

Neither seems ideal, but also don't appear to have serious consequences. 
For a -net fix now, this patch (clearing the kern bit) seems like the most 
straightforward for backporting. The lockdep fix could be handled 
independently, as it's a separate existing issue?


I will plan to upstream the existing patches from the export branch on 
Monday if there's no objection posted here!


--
Mat Martineau
Intel

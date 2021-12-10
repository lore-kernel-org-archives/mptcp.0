Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF52468
	for <mptcp@lists.linux.dev>; Fri, 10 Dec 2021 20:48:04 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10194"; a="238665701"
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="238665701"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 12:48:04 -0800
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="581791221"
Received: from dmales-mobl.amr.corp.intel.com ([10.251.4.94])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 12:48:04 -0800
Date: Fri, 10 Dec 2021 12:48:03 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Subject: Re: [PATCH v2 1/2] mptcp: clear 'kern' flag from fallback sockets
In-Reply-To: <d836b98995c155d007f77f028e4c809e3c066fbf.camel@redhat.com>
Message-ID: <e49b85-a488-c48d-91bc-32a4553c5a17@linux.intel.com>
References: <d5c4d25c-7498-46c5-54b6-4fd067d075f2@linux.intel.com>  <20211206212650.1895-1-fw@strlen.de>  <bf919f98-d135-fffe-e586-873810a81f4d@linux.intel.com>  <6c32d24c-d4d-727d-27a9-75478838157e@linux.intel.com>  <20211210090004.GF26636@breakpoint.cc>
 <d836b98995c155d007f77f028e4c809e3c066fbf.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 10 Dec 2021, Paolo Abeni wrote:

> On Fri, 2021-12-10 at 10:00 +0100, Florian Westphal wrote:
>> Mat Martineau <mathew.j.martineau@linux.intel.com> wrote:
>>> On Mon, 6 Dec 2021, Mat Martineau wrote:
>>>
>>>> On Mon, 6 Dec 2021, Florian Westphal wrote:
>>>>
>>>>> The mptcp ULP extension relies on sk->sk_sock_kern being set correctly:
>>>>> It prevents setsockopt(fd, IPPROTO_TCP, TCP_ULP, "mptcp", 6); from
>>>>> working for plain tcp sockets (any userspace-exposed socket).
>>>>>
>>>>> But in case of fallback, accept() can return a plain tcp sk.
>>>>> In such case, sk is still tagged as 'kernel' and setsockopt will work.
>>>>>
>>>>> This will crash the kernel, The subflow extension has a NULL ctx->conn
>>>>> mptcp socket:
>>>>>
>>>>> BUG: KASAN: null-ptr-deref in subflow_data_ready+0x181/0x2b0
>>>>> Call Trace:
>>>>> tcp_data_ready+0xf8/0x370
>>>>> [..]
>>>>>
>>>>> Fixes: cf7da0d66cc1 ("mptcp: Create SUBFLOW socket for incoming
>>>>> connections")
>>>>> Signed-off-by: Florian Westphal <fw@strlen.de>
>>>>> ---
>>>>> v2: also handle early-return
>>>>
>>>> Thanks - v2 looks good to me.
>>>>
>>>> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
>>>>
>>>>>
>>>>> net/mptcp/protocol.c | 4 +++-
>>>>> 1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>>>> index 8319e601bc2d..4a8f2476cc75 100644
>>>>> --- a/net/mptcp/protocol.c
>>>>> +++ b/net/mptcp/protocol.c
>>>>> @@ -3013,7 +3013,7 @@ static struct sock *mptcp_accept(struct sock
>>>>> *sk, int flags, int *err,
>>>>> 		 */
>>>>> 		if (WARN_ON_ONCE(!new_mptcp_sock)) {
>>>>> 			tcp_sk(newsk)->is_mptcp = 0;
>>>>> -			return newsk;
>>>>> +			goto out;
>>>>> 		}
>>>>>
>>>>> 		/* acquire the 2nd reference for the owning socket */
>>>>> @@ -3025,6 +3025,8 @@ static struct sock *mptcp_accept(struct sock
>>>>> *sk, int flags, int *err,
>>>>> 				MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);
>>>>> 	}
>>>>>
>>>>> +out:
>>>>> +	newsk->sk_kern_sock = kern;
>>>
>>> Florian -
>>>
>>> I was about to upstream this for -net, but have another question first.
>>>
>>> Is there anything else in newsk that needs to be updated when changing
>>> sk_kern_sock? sk_alloc() handles some reference counts differently for kern
>>> socks, and sock_lock_init() sets things up differently for lockdep.
>>
>> AFAICS no.
>>
>> The tcpsk inherits these settings from its parent (listen) sk, so they
>> always have 'kern = 1'.
>>
>> Even before this change, lock depclass is not correct (kernel, not user).
>>
>> Need to export code from core to change this.
>
> I personally would go this way, with a separate patch, possibly addinig
> a new helper for that.
>

Are you thinking that would be cleanup for net-next? Or urgent enough for 
-net?

I lean toward net-next, given the likely backporting of this fix.

> Somewhat related: I don't see where the lockdep class for
> sk_callback_lock is set properly for any in-kernel user doing accept()
> on plain TCP socket (I mean: not an mptcp listener!). sk_clone_lock()
> calls sk_init_common() which uses unconditionally the user-space
> lockdep class. ?!?
>

Yeah - af_kern_callback_keys is only referenced in sock_init_data(), which 
always inits the lockdep class for sk_callback_lock for userspace first by 
calling sk_init_common(), then always calls lockdep_set_class_and_name() a 
second time for sk_callback_lock (setting appropriately for kern or 
userspace).

--
Mat Martineau
Intel

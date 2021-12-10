Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C8E2C99
	for <mptcp@lists.linux.dev>; Fri, 10 Dec 2021 01:41:00 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="218271426"
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; 
   d="scan'208";a="218271426"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 17:38:19 -0800
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; 
   d="scan'208";a="543807406"
Received: from gpmelz-mobl2.amr.corp.intel.com ([10.254.64.24])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 17:38:19 -0800
Date: Thu, 9 Dec 2021 17:38:18 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Florian Westphal <fw@strlen.de>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v2 1/2] mptcp: clear 'kern' flag from fallback sockets
In-Reply-To: <bf919f98-d135-fffe-e586-873810a81f4d@linux.intel.com>
Message-ID: <6c32d24c-d4d-727d-27a9-75478838157e@linux.intel.com>
References: <d5c4d25c-7498-46c5-54b6-4fd067d075f2@linux.intel.com> <20211206212650.1895-1-fw@strlen.de> <bf919f98-d135-fffe-e586-873810a81f4d@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 6 Dec 2021, Mat Martineau wrote:

> On Mon, 6 Dec 2021, Florian Westphal wrote:
>
>> The mptcp ULP extension relies on sk->sk_sock_kern being set correctly:
>> It prevents setsockopt(fd, IPPROTO_TCP, TCP_ULP, "mptcp", 6); from
>> working for plain tcp sockets (any userspace-exposed socket).
>> 
>> But in case of fallback, accept() can return a plain tcp sk.
>> In such case, sk is still tagged as 'kernel' and setsockopt will work.
>> 
>> This will crash the kernel, The subflow extension has a NULL ctx->conn
>> mptcp socket:
>> 
>> BUG: KASAN: null-ptr-deref in subflow_data_ready+0x181/0x2b0
>> Call Trace:
>> tcp_data_ready+0xf8/0x370
>> [..]
>> 
>> Fixes: cf7da0d66cc1 ("mptcp: Create SUBFLOW socket for incoming 
>> connections")
>> Signed-off-by: Florian Westphal <fw@strlen.de>
>> ---
>> v2: also handle early-return
>
> Thanks - v2 looks good to me.
>
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
>
>> 
>> net/mptcp/protocol.c | 4 +++-
>> 1 file changed, 3 insertions(+), 1 deletion(-)
>> 
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 8319e601bc2d..4a8f2476cc75 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -3013,7 +3013,7 @@ static struct sock *mptcp_accept(struct sock *sk, int 
>> flags, int *err,
>> 		 */
>> 		if (WARN_ON_ONCE(!new_mptcp_sock)) {
>> 			tcp_sk(newsk)->is_mptcp = 0;
>> -			return newsk;
>> +			goto out;
>> 		}
>>
>> 		/* acquire the 2nd reference for the owning socket */
>> @@ -3025,6 +3025,8 @@ static struct sock *mptcp_accept(struct sock *sk, int 
>> flags, int *err,
>> 				MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);
>> 	}
>> 
>> +out:
>> +	newsk->sk_kern_sock = kern;

Florian -

I was about to upstream this for -net, but have another question first.

Is there anything else in newsk that needs to be updated when changing 
sk_kern_sock? sk_alloc() handles some reference counts differently for 
kern socks, and sock_lock_init() sets things up differently for lockdep.


>> 	return newsk;
>> }
>> 
>> -- 
>> 2.32.0
>> 
>> 
>> 
>
> --
> Mat Martineau
> Intel
>
>

--
Mat Martineau
Intel

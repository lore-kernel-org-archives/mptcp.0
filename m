Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4168C2C9D
	for <mptcp@lists.linux.dev>; Mon,  6 Dec 2021 19:40:04 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="237616251"
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="237616251"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 11:40:03 -0800
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="514891363"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2) ([10.251.18.10])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 11:40:03 -0800
Date: Mon, 6 Dec 2021 11:40:02 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Florian Westphal <fw@strlen.de>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp 1/2] mptcp: clear 'kern' flag from fallback
 sockets
In-Reply-To: <20211206155120.26929-2-fw@strlen.de>
Message-ID: <d5c4d25c-7498-46c5-54b6-4fd067d075f2@linux.intel.com>
References: <20211206155120.26929-1-fw@strlen.de> <20211206155120.26929-2-fw@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 6 Dec 2021, Florian Westphal wrote:

> The mptcp ULP extension relies on sk->sk_sock_kern being set correctly:
> It prevents setsockopt(fd, IPPROTO_TCP, TCP_ULP, "mptcp", 6); from
> working for plain tcp sockets (any userspace-exposed socket).
>
> But in case of fallback, accept() can return a plain tcp sk.
> In such case, sk is still tagged as 'kernel' and setsockopt will work.
>
> This will crash the kernel, The subflow extension has a NULL ctx->conn
> mptcp socket:
>
> BUG: KASAN: null-ptr-deref in subflow_data_ready+0x181/0x2b0
> Call Trace:
> tcp_data_ready+0xf8/0x370
> [..]
>
> Fixes: cf7da0d66cc1 ("mptcp: Create SUBFLOW socket for incoming connections")
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
> net/mptcp/protocol.c | 1 +
> 1 file changed, 1 insertion(+)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 8319e601bc2d..34ea4b25128e 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3025,6 +3025,7 @@ static struct sock *mptcp_accept(struct sock *sk, int flags, int *err,
> 				MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);
> 	}
>
> +	newsk->sk_kern_sock = kern;
> 	return newsk;
> }

Florian -

There's an early return in this function where the newsk from 
inet_csk_accept() is also used. From the WARN_ON_ONCE() for that return, 
it shouldn't happen, and changes to subflow_syn_recv_sock() appear to make 
it impossible and therefore dead code.

Could do one of these:

1. Set sk_kern_sock for the early return for this -net fix, delete the
    dead code path in mptcp-next if needed / agreed upon

2. Delete the early return now


Option 1 seems like the safer approach for -net, do you agree?

--
Mat Martineau
Intel

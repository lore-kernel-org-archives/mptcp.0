Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B4D1C0C
	for <mptcp@lists.linux.dev>; Tue, 21 Jun 2022 22:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655851137; x=1687387137;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=CgLdUOkGbMdyYjIUfBWFflCqQfYYZka8LLF2te5T630=;
  b=Z395bslPot5ASiENHGl+3+pPW/JOZ6TfDrMetn781aHk8fFuOirxrVlG
   5qAbwADpU7zMYKTUjHJW/4dIaUkUGccBP/mTqBFQAAmDYmUvgYvOOT0HX
   tvth61U1aSt95G8G7UyfDPTCZXnmyMKiHixm28cbqx5bXquIQE2PcMCcH
   EPkjSNXE7iz2PkHKIBJzXah74+XiBf8b5Kv8kkaxFIPiQ3BjKy0s0sV1H
   +weawTSlsxyhTppLhMzvfnVZ6FII09aYhEFxOeHvYzPK+VmbRiW9RUayL
   qijpO7yUxAewn8oiDhPCl/aNFoCNka9QcNbgyjXPswL0mQqbem6se0SMA
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="277804785"
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="277804785"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 15:38:56 -0700
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="833794608"
Received: from vanehosx-mobl.gar.corp.intel.com ([10.251.13.241])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 15:38:56 -0700
Date: Tue, 21 Jun 2022 15:38:56 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v4 mptcp-next 4/4] net: remove SK_RECLAIM_THRESHOLD and
 SK_RECLAIM_CHUNK
In-Reply-To: <746be47fdbbf4c5fadb9d5dcb2ee2e9cff0dacf5.1655828070.git.pabeni@redhat.com>
Message-ID: <b324f6a1-6f17-c52b-4725-22893fc13cd4@linux.intel.com>
References: <630f7e13d7226f8c37a9cc0c66008a298c1e6b9e.1655828070.git.pabeni@redhat.com> <746be47fdbbf4c5fadb9d5dcb2ee2e9cff0dacf5.1655828070.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 21 Jun 2022, Paolo Abeni wrote:

> There are no more users for the mentioned macros, just
> drop them.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Looks good:

Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


(even though I'll end up replacing that with a Signed-off-by when 
upstreaming anyway...)


- Mat

> ---
> include/net/sock.h | 5 -----
> 1 file changed, 5 deletions(-)
>
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 5bed1ea7a722..c3ac36b7b7b8 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -1619,11 +1619,6 @@ static inline void sk_mem_charge(struct sock *sk, int size)
> 	sk->sk_forward_alloc -= size;
> }
>
> -/* the following macros control memory reclaiming in mptcp_rmem_uncharge()
> - */
> -#define SK_RECLAIM_THRESHOLD	(1 << 21)
> -#define SK_RECLAIM_CHUNK	(1 << 20)
> -
> static inline void sk_mem_uncharge(struct sock *sk, int size)
> {
> 	if (!sk_has_account(sk))
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel

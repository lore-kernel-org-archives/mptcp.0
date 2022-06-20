Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEB880E
	for <mptcp@lists.linux.dev>; Mon, 20 Jun 2022 20:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655757132; x=1687293132;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=jVQ8iqOFE1SfXenkTRXWnOI87Ujre52Kekk7pNXvE4g=;
  b=LNubP3/+/Ne+mRuOIBga4KIiMuusgSwGszsgOMUoJwZP2fgvnp5xigDz
   Bn5F+GL7F9+SI6Ulnjv8dVjjL9lkOrv2/GCuAoLgaFCA0XNcpAUWCKe+c
   pWc/u4lGdZqAAABjew1mmnPDhDX4J9sDwquQpD8BggTn7K/0VHnTvC0gM
   fTsRfX3dTjYTX4eGS4ZoLSRf/IYNp4xVPcTId0Gu1S2cEKIxFh/j8BEzs
   95IcdDIrQCZJEociHGpBPfMCkzcFx3EdhHE9nWgpUkw7DGMxJSyhOvoKz
   IC/pmoet/OX+B02ntAlnhkC7/qn0/UCwcswwvg8A9S6tTa/INWhaDzfp8
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="277518090"
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="277518090"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 13:32:12 -0700
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="689606963"
Received: from mmachax-mobl.amr.corp.intel.com ([10.212.156.191])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 13:32:12 -0700
Date: Mon, 20 Jun 2022 13:32:11 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH net-next v3 3/3] mptcp: refine memory scheduling
In-Reply-To: <9ab1ce9ee1019cb90181d4e6268c37448c8af46b.1655741931.git.pabeni@redhat.com>
Message-ID: <246f2b96-7e12-ba51-d77f-b38e662eb89@linux.intel.com>
References: <630f7e13d7226f8c37a9cc0c66008a298c1e6b9e.1655741931.git.pabeni@redhat.com> <9ab1ce9ee1019cb90181d4e6268c37448c8af46b.1655741931.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 20 Jun 2022, Paolo Abeni wrote:

> Similar to commit 7c80b038d23e ("net: fix sk_wmem_schedule() and
> sk_rmem_schedule() errors"), let the MPTCP receive path schedule
> exactly the required amount of memory.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/protocol.c | 1 +
> 1 file changed, 1 insertion(+)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index b31bac33f87a..0e295b3bce54 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -326,6 +326,7 @@ static bool mptcp_rmem_schedule(struct sock *sk, struct sock *ssk, int size)
> 	if (size < msk->rmem_fwd_alloc)

With the change below, also would be good to change the above line to:

 	if (size <= msk->rmem_fwd_alloc)

so there's no attempt to allocate 0 new pages.

> 		return true;
>
> +	size -= msk->rmem_fwd_alloc;
> 	amt = sk_mem_pages(size);
> 	amount = amt << PAGE_SHIFT;
> 	if (!__sk_mem_raise_allocated(sk, size, amt, SK_MEM_RECV))
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel

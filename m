Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09302F23
	for <mptcp@lists.linux.dev>; Tue,  8 Feb 2022 01:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644282309; x=1675818309;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=GcqC0J+ExfwbqaVsXksC3pLME/2we7xzZMhL2L9FVgQ=;
  b=G4uxSvrpX2WuIVxBmO35bLkwk45kLwkrkwsjQgrNEgZ6jU0UV+mfrnuq
   Ij4X54SZ/eOmkNoDCEoOc9maoepEJoj53Noq9RfHargi5DSrkBNhdv84o
   yHo5Qh9p8MUqo2kJWb8F7tHSwVCbE4YPBMoJQbQVL9Mc0MHgtrrOR7p0P
   FYuzB8FqqR06rKzpxNoYCawW9fRiV7IydteJe4dVVd9HV9fjBJ+yPaZDB
   4THIRUSKBJ1YmnEaQVMLUkaFIrYwEMTNvrKn7g007Z5x4DkcDQo0f7HkP
   CA7QmWEX4EkE4Cvinf3OyiO++ej1XzKJZuhn+X7s49d0ejI2WXr076rD1
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="273369589"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="273369589"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 17:05:08 -0800
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="540366784"
Received: from ngoyal-mobl1.amr.corp.intel.com ([10.251.4.190])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 17:05:08 -0800
Date: Mon, 7 Feb 2022 17:05:08 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] mptcp: drop unneeded type casts for hmac
In-Reply-To: <5ea29fecc4db9bc0a9a9d5d10e0f2a61d645d46c.1644228345.git.geliang.tang@suse.com>
Message-ID: <ca5a8254-2d29-4227-ee8-25f2c86d1f22@linux.intel.com>
References: <5ea29fecc4db9bc0a9a9d5d10e0f2a61d645d46c.1644228345.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 7 Feb 2022, Geliang Tang wrote:

> Drop the unneeded type casts to 'unsigned long long' for printing out the
> hmac values in add_addr_hmac_valid() and subflow_thmac_valid().
>

The type specifiers are expecting a 64 bit value (on 32 or 64 bit 
platforms), so there isn't a need for the casts that I can see. I pushed 
this to my git.kernel.org repo to trigger a kbuild run across a whole 
bunch of platforms, just in case.

Ok to merge to the export branch:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/options.c | 3 +--
> net/mptcp/subflow.c | 4 +---
> 2 files changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 7b615dc10897..670364cd455f 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1085,8 +1085,7 @@ static bool add_addr_hmac_valid(struct mptcp_sock *msk,
> 				      &mp_opt->addr);
>
> 	pr_debug("msk=%p, ahmac=%llu, mp_opt->ahmac=%llu\n",
> -		 msk, (unsigned long long)hmac,
> -		 (unsigned long long)mp_opt->ahmac);
> +		 msk, hmac, mp_opt->ahmac);
>
> 	return hmac == mp_opt->ahmac;
> }
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 88ee94adc38c..485f00dcaf84 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -344,9 +344,7 @@ static bool subflow_thmac_valid(struct mptcp_subflow_context *subflow)
>
> 	thmac = get_unaligned_be64(hmac);
> 	pr_debug("subflow=%p, token=%u, thmac=%llu, subflow->thmac=%llu\n",
> -		 subflow, subflow->token,
> -		 (unsigned long long)thmac,
> -		 (unsigned long long)subflow->thmac);
> +		 subflow, subflow->token, thmac, subflow->thmac);
>
> 	return thmac == subflow->thmac;
> }
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel

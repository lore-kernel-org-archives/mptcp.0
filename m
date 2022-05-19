Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A1428EE
	for <mptcp@lists.linux.dev>; Thu, 19 May 2022 15:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652972840; x=1684508840;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=25kt8fL0h31Q1rzTeqcKrWJ50kSWKMqCTfmkixVa/qQ=;
  b=dO1yOpR6lNMrcgbtKOBQwkUNGtCdT0NszFR3TjExIkh1nrljFZBdKS0f
   PlxYnbJ71yofWoG8mlk22Iuyx7XSphj+avTa0CfW6ioyCA7+Gstrk2dtE
   ut9yaZyvkFNoaTDiN2nDdjkqqLuUzNpTan3oUgmra8qeauqeVYBI6n0CQ
   t7gjIPcVdFvNjDNHtz+9uplpz55yXxVcyOK6iLGKdbR3zJ9BEXy9CnYDN
   5BmNohZsh7AqlecKTaOyTrGLG23Lg9J0sDUdFT340MQIILm2XXoZC7FD3
   TjezYFlwVg9sxxQ/RxPe5jUmUlvNdv6XYN42H8ipA3+VKxP6M0VdO8NU2
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="259814825"
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="259814825"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 08:06:36 -0700
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="674053917"
Received: from camcconn-mobl1.amr.corp.intel.com ([10.255.229.130])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 08:06:36 -0700
Date: Thu, 19 May 2022 08:06:35 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 01/17] mptcp: move MPTCPOPT_HMAC_LEN to
 net/mptcp.h
In-Reply-To: <9128762ee54d7f8f5755067bbdd7511e1ead1f1a.1652853898.git.geliang.tang@suse.com>
Message-ID: <6c1c291b-43d8-6e86-fcae-582a9ca5632@linux.intel.com>
References: <cover.1652853898.git.geliang.tang@suse.com> <9128762ee54d7f8f5755067bbdd7511e1ead1f1a.1652853898.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 18 May 2022, Geliang Tang wrote:

> Move macro MPTCPOPT_HMAC_LEN definition from net/mptcp/protocol.h to
> include/net/mptcp.h.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>

This one's fine for the mptcp tree (will upstream to net-next):

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

> ---
> include/net/mptcp.h  | 3 ++-
> net/mptcp/protocol.h | 1 -
> 2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index d4ec894ce67b..4713757e36c1 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -39,6 +39,7 @@ struct mptcp_ext {
> 			infinite_map:1;
> };
>
> +#define MPTCPOPT_HMAC_LEN	20
> #define MPTCP_RM_IDS_MAX	8
>
> struct mptcp_rm_list {
> @@ -89,7 +90,7 @@ struct mptcp_out_options {
> 			u32 nonce;
> 			u32 token;
> 			u64 thmac;
> -			u8 hmac[20];
> +			u8 hmac[MPTCPOPT_HMAC_LEN];
> 		};
> 	};
> #endif
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 200f89f6d62f..8f03775a2f22 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -83,7 +83,6 @@
>
> /* MPTCP MP_JOIN flags */
> #define MPTCPOPT_BACKUP		BIT(0)
> -#define MPTCPOPT_HMAC_LEN	20
> #define MPTCPOPT_THMAC_LEN	8
>
> /* MPTCP MP_CAPABLE flags */
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel

Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A4470
	for <mptcp@lists.linux.dev>; Tue, 11 May 2021 00:47:11 +0000 (UTC)
IronPort-SDR: I6VBeeywRsDgmjNxHZPE9H19BXDCwg9Cy5gkx0iUD2DrCzAa1Q0FbSgDKQk+xOTSbqD3yLZmLz
 A0ofvkHabgTg==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="179585190"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="179585190"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 17:47:11 -0700
IronPort-SDR: ig4h7/LMSLB40t4IUPy7W/pPz3S28gxVT/9f6SnBTkoq5o+O4fe3gTBuavIixjZX/p/dMiMsdt
 B1YJZfH08q3g==
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="470959264"
Received: from akalita-mobl1.amr.corp.intel.com ([10.209.125.201])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 17:47:06 -0700
Date: Mon, 10 May 2021 17:47:04 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev
Subject: Re: [MPTCP][PATCH mptcp-next] Squash to "mptcp: add sk parameter
 for mptcp_parse_option"
In-Reply-To: <f3808e3bfccf51a4a41e8ff3c793a464d8c3ae61.1620349748.git.geliangtang@gmail.com>
Message-ID: <d7764cfd-7c46-f28e-1aff-4a59b356be16@linux.intel.com>
References: <f3808e3bfccf51a4a41e8ff3c793a464d8c3ae61.1620349748.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 7 May 2021, Geliang Tang wrote:

> Keep mptcp_parse_option unchanged.
>
> Please update the commit log too:
>
> '''
> mptcp: add sk parameter for mptcp_get_options
>
> This patch added a new parameter name sk in mptcp_get_options().
> '''
>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
> net/mptcp/options.c | 5 ++---
> 1 file changed, 2 insertions(+), 3 deletions(-)
>

Looks good to me, thanks Geliang.

-Mat


> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 8f768c517586..1d360639ca91 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -20,8 +20,7 @@ static bool mptcp_cap_flag_sha256(u8 flags)
> 	return (flags & MPTCP_CAP_FLAG_MASK) == MPTCP_CAP_HMAC_SHA256;
> }
>
> -static void mptcp_parse_option(const struct sock *sk,
> -			       const struct sk_buff *skb,
> +static void mptcp_parse_option(const struct sk_buff *skb,
> 			       const unsigned char *ptr, int opsize,
> 			       struct mptcp_options_received *mp_opt)
> {
> @@ -365,7 +364,7 @@ void mptcp_get_options(const struct sock *sk,
> 			if (opsize > length)
> 				return;	/* don't parse partial options */
> 			if (opcode == TCPOPT_MPTCP)
> -				mptcp_parse_option(sk, skb, ptr, opsize, mp_opt);
> +				mptcp_parse_option(skb, ptr, opsize, mp_opt);
> 			ptr += opsize - 2;
> 			length -= opsize;
> 		}
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel

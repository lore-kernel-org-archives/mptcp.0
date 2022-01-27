Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D912C9D
	for <mptcp@lists.linux.dev>; Thu, 27 Jan 2022 00:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643242946; x=1674778946;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=PHqke19EHWal6jBKG23RGnMeRTgNmSxROula5sTguJc=;
  b=RXn7hgmyp8iW2KRboep3FovM7cky82aLHILVNsfHiCbwLs6WnZ7+Sv7A
   7iVzyriSdXHdDtK8fUK3n2kn3GgLAm5/LHpvfz+0PlAncirrj3v+GdAEU
   xxOjLx8027lj/qmU3hfOczEW03rxk+T90g8m4IH4KDp5NXiCfBfsAz3QM
   1kGLo087vnLG/3YbfhB4QFWq0aws2hA3q5r73zdqdtQ06f/YSqjN/tzwf
   YKakHpubQsra+f7B0queUAY3PDig64DCjPQL7bibwLtyg/IQkB96MsoUo
   1ODm446ZClHCCAu0oFi37VMrGu8wkUWVDiESYSdXibKy2JcqnfYBFAtsD
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="246476006"
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="246476006"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 16:22:25 -0800
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="696427972"
Received: from dhurwitz-mobl.amr.corp.intel.com ([10.209.79.89])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 16:22:25 -0800
Date: Wed, 26 Jan 2022 16:22:25 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] Squash to "mptcp: infinite mapping sending"
 part 2
In-Reply-To: <016f512feb4ebf9a66808074e9b096bc1c3274d5.1643189677.git.geliang.tang@suse.com>
Message-ID: <10704631-c265-f69f-7565-c1f38620952e@linux.intel.com>
References: <016f512feb4ebf9a66808074e9b096bc1c3274d5.1643189677.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 26 Jan 2022, Geliang Tang wrote:

> Fix the checksum value of the infinite map.
>
> mptcp_make_csum() will return a non-zero value when mpext->csum is set to
> zero.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/options.c  | 3 ++-
> net/mptcp/protocol.c | 1 -
> 2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 03c82985dba1..48a805731216 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1339,7 +1339,8 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
> 			ptr += 1;
> 			if (opts->csum_reqd) {

Looks good to me, but I suggest adding a comment here:

                                 /* mp_ext->data_len == 0 is reserved for
                                  * infinite mappings in RFC 8684.
                                  */

> 				put_unaligned_be32(mpext->data_len << 16 |
> -						   mptcp_make_csum(mpext), ptr);
> +						   (mpext->data_len ? mptcp_make_csum(mpext) : 0),
> +						   ptr);
> 			} else {
> 				put_unaligned_be32(mpext->data_len << 16 |
> 						   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 526a0f5ba415..3324e1c61576 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1231,7 +1231,6 @@ static void mptcp_update_infinite_map(struct mptcp_sock *msk,
>
> 	mpext->infinite_map = 1;
> 	mpext->data_len = 0;
> -	mpext->csum = 0;
>
> 	MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPTX);
> 	mptcp_subflow_ctx(ssk)->send_infinite_map = 0;
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel

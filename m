Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CDE168
	for <mptcp@lists.linux.dev>; Thu, 27 Jan 2022 16:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643300646; x=1674836646;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=QdrQN8+xt4zSOyzxVEAif3n50a8JVYYkgJ7Y42L08Wc=;
  b=bXKSEH7Y/BBF5D0DkCeT3rhVthQiNJNBoJgqfj7H6N7eY2pj8a+DPb63
   ic31dGVBm6XV0XBs6vTOO8kseoTPzh+y2aAefq+We7Z1/m95f7nCrEsW7
   05EAdPOtOtTaAkcLa/1IvsNWQGEAPQd3W/WmXXm0r49PvYnC4SK1UnWr5
   efjyYB+HQU3WMUjcO33TXCXGzLs7VDkwtsM66r7RBH6OpirfYPtXmoPKo
   FMWegXpgumPl1LXMmsWamFcl9E0oP1r0CpWaxho9B2Gn/JBdngl8PQ9jA
   lcUm3Bsc+Ga6XYAYezEAIxc2f3Ms0FCqsymQuPL5+GUjpEOXHuEqdmEvs
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="246845427"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="246845427"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 08:24:06 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="477927710"
Received: from mmambros-mobl1.amr.corp.intel.com ([10.209.64.126])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 08:24:06 -0800
Date: Thu, 27 Jan 2022 08:24:05 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2] Squash to "mptcp: infinite mapping sending"
 - fix csum
In-Reply-To: <f2761a60658d4f54e0d39fbf4b4fe45e387e5b32.1643250449.git.geliang.tang@suse.com>
Message-ID: <f4a41e6-d098-13e-f085-8a9f404d8bab@linux.intel.com>
References: <f2761a60658d4f54e0d39fbf4b4fe45e387e5b32.1643250449.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 27 Jan 2022, Geliang Tang wrote:

> Fix the checksum value of the infinite map.
>
> mptcp_make_csum() will return a non-zero value when mpext->csum is set to
> zero.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> v2:
> - add a comment for the checksum value of the infinite mapping.

Thanks! Looks good to me

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

> ---
> net/mptcp/options.c  | 6 +++++-
> net/mptcp/protocol.c | 1 -
> 2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 0d0d2eb8c8ca..7abad31c2b84 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1338,8 +1338,12 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
> 			put_unaligned_be32(mpext->subflow_seq, ptr);
> 			ptr += 1;
> 			if (opts->csum_reqd) {
> +				/* data_len == 0 is reserved for the infinite mapping,
> +				 * the checksum will also be set to 0.
> +				 */
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

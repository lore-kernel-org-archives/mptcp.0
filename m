Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80232C9C
	for <mptcp@lists.linux.dev>; Sat,  8 Jan 2022 00:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641603290; x=1673139290;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=hUqdGvFRIiV92BqFFU5B029B9ZledqKyeN4r90FdgDw=;
  b=OxMw/EY20nn4uT5XV9G8PEd1DDTjy1UyvzgNTDdvLX2phb53eNgkO7lf
   P1F8VV//MJpRd5zqnPAhfumyC+8Ui2fvtQm9TN0U5Bhqv9siJtnWqD5Gm
   l0DCbkm2RQycTIP/wrgbSnHrSZ+99/8Sq0E82HoX4oAdryezqanmPEfOI
   G/njqEnaKocKWTo5Xr85YjHNGVX5HDzL6z8hO3/NMKxLpcBFzhPP2EYZN
   h6g8nleuYF61WPjkf6R/XhCfLaZ8Jv6xdVi9SK1k0JKPdA21Y5H8B3oS/
   IevrhtoSAIywRNHSRCah9MTQLzLXk6NFgA3qlHFJikZYmLvmevMDQ+AZx
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="243166552"
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="243166552"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 16:54:50 -0800
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="489455878"
Received: from illipets-mobl.amr.corp.intel.com ([10.209.112.146])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 16:54:49 -0800
Date: Fri, 7 Jan 2022 16:54:48 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev, Geliang Tang <geliang.tang@suse.com>
Subject: Re: [PATCH mptcp-next v8 4/8] mptcp: reduce branching when writing
 MP_FAIL option
In-Reply-To: <20220105155702.165123-5-matthieu.baerts@tessares.net>
Message-ID: <ebff9b40-1e42-ec9-1cc5-6fbb8b5784dd@linux.intel.com>
References: <20220105155702.165123-1-matthieu.baerts@tessares.net> <20220105155702.165123-5-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 5 Jan 2022, Matthieu Baerts wrote:

> MP_FAIL should be use in very rare cases, either when the TCP RST flag
> is set -- with or without an MP_RST -- or with a DSS, see
> mptcp_established_options().
>
> Here, we do the same in mptcp_write_options().
>
> Co-developed-by: Geliang Tang <geliang.tang@suse.com>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
> net/mptcp/options.c | 39 ++++++++++++++++++++++++---------------
> 1 file changed, 24 insertions(+), 15 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index bbf61dedb4b5..2f94069808a4 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1264,21 +1264,7 @@ static u16 mptcp_make_csum(const struct mptcp_ext *mpext)
> void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
> 			 struct mptcp_out_options *opts)
> {
> -	if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions)) {
> -		const struct sock *ssk = (const struct sock *)tp;
> -		struct mptcp_subflow_context *subflow;
> -
> -		subflow = mptcp_subflow_ctx(ssk);
> -		subflow->send_mp_fail = 0;
> -
> -		*ptr++ = mptcp_option(MPTCPOPT_MP_FAIL,
> -				      TCPOLEN_MPTCP_FAIL,
> -				      0, 0);
> -		put_unaligned_be64(opts->fail_seq, ptr);
> -		ptr += 2;
> -	}
> -
> -	/* DSS, MPC, MPJ, ADD_ADDR, FASTCLOSE and RST are mutually exclusive,
> +	/* DSS, MPC, MPJ, ADD_ADDR, FASTCLOSE and FAIL are mutually exclusive,

Seems like the comment was ok as-is? As you note in the commit message, 
DSS and FAIL can occur together.

> 	 * see mptcp_established_options*()
> 	 */
> 	if (likely(OPTION_MPTCP_DSS & opts->suboptions)) {
> @@ -1336,6 +1322,10 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
> 			}
> 			ptr += 1;
> 		}
> +
> +		/* We might need to add MP_FAIL options in rare cases */
> +		if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions))
> +			goto mp_fail;
> 	} else if (OPTIONS_MPTCP_MPC & opts->suboptions) {
> 		u8 len, flag = MPTCP_CAP_HMAC_SHA256;
>
> @@ -1476,6 +1466,25 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
> 		put_unaligned_be64(opts->rcvr_key, ptr);
> 		ptr += 2;
>
> +		if (OPTION_MPTCP_RST & opts->suboptions)
> +			goto mp_rst;
> +		return;
> +	} else if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions))
> +mp_fail:
> +	{

Formatting quibble: seems better to put the '{' at the end of the line 
before the mp_fail label, like the existing code does just before the 
mp_rst label just below this block of code.

> +		/* MP_FAIL is mutually exclusive with others except RST */
> +		const struct sock *ssk = (const struct sock *)tp;
> +		struct mptcp_subflow_context *subflow;
> +
> +		subflow = mptcp_subflow_ctx(ssk);
> +		subflow->send_mp_fail = 0;
> +
> +		*ptr++ = mptcp_option(MPTCPOPT_MP_FAIL,
> +				      TCPOLEN_MPTCP_FAIL,
> +				      0, 0);
> +		put_unaligned_be64(opts->fail_seq, ptr);
> +		ptr += 2;
> +
> 		if (OPTION_MPTCP_RST & opts->suboptions)
> 			goto mp_rst;
> 		return;
> -- 
> 2.33.1
>
>
>

--
Mat Martineau
Intel

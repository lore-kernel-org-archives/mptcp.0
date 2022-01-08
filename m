Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F682C9C
	for <mptcp@lists.linux.dev>; Sat,  8 Jan 2022 00:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641603598; x=1673139598;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ufj5QbeMZCY0Rp0H4OMU1g2QCJKt90YaK+WC/hPqcu8=;
  b=efq/BoCczauLIoykSpAGbc8uDnS+Hv9ovMip/Gsgj1C2ixcB6Oar4pjn
   kpXkWyRo1k5pui/064eLzISloV4CFa5Y0Hstrg3tQ1ihQ3ognu0xTUd8J
   DlDOCZqm8o8uKNPaPVD1lhHgPx5mErtt2i9BdlByycTjHJ5B5hEY5UvVC
   RA5nUz+oeXimy5CjgruMz+sgnbTXVFgiQcTTeZCzr9vKptTdrIdZzP6nu
   q7U6W0h22nXJEu6gmFS+P0caH7ud+emYaRjp4JGmVXDBV3fFxUCqqK6pQ
   gdmlBLpaG6jthvpW0fV0NC/cgDseRuto9Ekk2vHp1RcdkcBnFuX0vsbZN
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="242920711"
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="242920711"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 16:59:43 -0800
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="668935664"
Received: from illipets-mobl.amr.corp.intel.com ([10.209.112.146])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 16:59:43 -0800
Date: Fri, 7 Jan 2022 16:59:42 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v8 5/8] mptcp: clarify when options can be
 used
In-Reply-To: <20220105155702.165123-6-matthieu.baerts@tessares.net>
Message-ID: <e961b574-b83a-5115-53cf-a9bcf5376b5d@linux.intel.com>
References: <20220105155702.165123-1-matthieu.baerts@tessares.net> <20220105155702.165123-6-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 5 Jan 2022, Matthieu Baerts wrote:

> RFC8684 doesn't seem to clearly specify which MPTCP options can be used
> together.
>
> Some options are mutually exclusive -- e.g. MP_CAPABLE and MP_JOIN --,
> some can be used together -- e.g. DSS + MP_PRIO --, some can but we
> prefer not to -- e.g. DSS + ADD_ADDR -- and some have to be used
> together at some points -- e.g. MP_FAIL and DSS.
>
> We need to clarify this as a base before allowing other modifications.
>
> For example, does it make sense to send a RM_ADDR with an MPC or MPJ?
> This remains open for possible future discussions.
>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
> net/mptcp/options.c | 23 +++++++++++++++++++++--
> 1 file changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 2f94069808a4..8553b928c5bf 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1264,8 +1264,27 @@ static u16 mptcp_make_csum(const struct mptcp_ext *mpext)
> void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
> 			 struct mptcp_out_options *opts)
> {
> -	/* DSS, MPC, MPJ, ADD_ADDR, FASTCLOSE and FAIL are mutually exclusive,
> -	 * see mptcp_established_options*()
> +	/* Which options can be used together?
> +	 *
> +	 * X: mutually exclusive
> +	 * O: often used together
> +	 * C: can be used together in some cases
> +	 * P: could be used together but we prefer not to (optimisations)
> +	 *
> +	 *  Opt: | MPC  | MPJ  | DSS  | ADD  |  RM  | PRIO | FAIL |  FC  |
> +	 * ------|------|------|------|------|------|------|------|------|
> +	 *  MPC  |------|------|------|------|------|------|------|------|
> +	 *  MPJ  |  X   |------|------|------|------|------|------|------|
> +	 *  DSS  |  X   |  X   |------|------|------|------|------|------|
> +	 *  ADD  |  X   |  X   |  P   |------|------|------|------|------|
> +	 *  RM   |  C   |  C   |  C   |  C   |------|------|------|------|
> +	 *  PRIO |  X   |  C   |  C   |  C   |  C   |------|------|------|
> +	 *  FAIL |  X   |  X   |  C   |  X   |  X   |  X   |------|------|
> +	 *  FC   |  X   |  X   |  X   |  X   |  X   |  X   |  X   |------|
> +	 *  RST  |  X   |  X   |  X   |  X   |  X   |  X   |  O   |  O   |
> +	 * ------|------|------|------|------|------|------|------|------|
> +	 *
> +	 * The same applies in mptcp_established_options() function.

This is very helpful! (and makes my comment on the previous patch 
irrelevant :) )

> 	 */
> 	if (likely(OPTION_MPTCP_DSS & opts->suboptions)) {
> 		struct mptcp_ext *mpext = &opts->ext_copy;
> -- 
> 2.33.1
>
>
>

--
Mat Martineau
Intel

Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F22F4C95
	for <mptcp@lists.linux.dev>; Fri, 17 Jun 2022 23:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655507589; x=1687043589;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=6S1FAIaCpHUpZuzVCJ2DFGhwmg9qHL7OV1h3DGClAfE=;
  b=lokcZucBGqMBQPeQnKFy387KykKASjYUmjK+GpqH4jpzZFl+Adrg8sgf
   U31FoYjCIMpQk8NPBalkUW00aTcHJg7aHWcgVXI9+AfRnSoCoQ4d2fu0A
   L0SAlXJ4+uscmSNN1a+UNXrpU2XqYUtmZ3kOIcAxn8ozHLE1fzHWDLxje
   TjwBIuEb73Hpboj6eXtnBlOYSyI+zDDVV4CZjhaOo6nBLxY2X3bCn3IVs
   nhd0sLrZ2l8vKYd9SMY+rnR7zzkHcMpt5XxWJz4jQSXOYnK2B9JDNkamE
   reBaj/7/SVreq5UgHgHYlK2QDvG7VsKYWx2xBsALBk8k/xk2NH4Ipw/US
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="280338426"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="280338426"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 16:13:08 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="642225354"
Received: from theiders-mobl.amr.corp.intel.com ([10.209.81.3])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 16:13:08 -0700
Date: Fri, 17 Jun 2022 16:13:07 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net v3 2/6] mptcp: introduce MAPPING_BAD_CSUM
In-Reply-To: <dd078642fb80c4bb1f3184393cee1907026df46c.1655460262.git.pabeni@redhat.com>
Message-ID: <4a8c5ba-f234-9623-a36-ba3235744bf@linux.intel.com>
References: <cover.1655460262.git.pabeni@redhat.com> <dd078642fb80c4bb1f3184393cee1907026df46c.1655460262.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 17 Jun 2022, Paolo Abeni wrote:

> This allow moving a couple of conditional out of the fast path,
> making the code more easy to follow and will simplify the next
> patch.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

I've had a few rounds of feedback from Jakub about the Fixes: tag in the 
last few months - whether missing for -net or questionable inclusion in 
net-next... So I'd like to get this right :)

Given that this is tied to the following patch ("mptcp: invoke MP_FAIL 
response when needed"), and that patch "Fixes:" a patch that's only in the 
5.19rc series, I don't think a missing tag here is harmful. But I'm not 
sure what Jakub will want.

One option is to duplicate the "Fixes: d9fb797046c5" line from "mptcp: 
invoke MP_FAIL response when needed".

What do you think Paolo?


- Mat

> ---
> net/mptcp/subflow.c | 18 +++++++++---------
> 1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 57d2d8d933d0..98b12a9c4eb5 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -843,7 +843,8 @@ enum mapping_status {
> 	MAPPING_INVALID,
> 	MAPPING_EMPTY,
> 	MAPPING_DATA_FIN,
> -	MAPPING_DUMMY
> +	MAPPING_DUMMY,
> +	MAPPING_BAD_CSUM
> };
>
> static void dbg_bad_map(struct mptcp_subflow_context *subflow, u32 ssn)
> @@ -958,9 +959,7 @@ static enum mapping_status validate_data_csum(struct sock *ssk, struct sk_buff *
> 				 subflow->map_data_csum);
> 	if (unlikely(csum)) {
> 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DATACSUMERR);
> -		if (subflow->mp_join || subflow->valid_csum_seen)
> -			subflow->send_mp_fail = 1;
> -		return subflow->mp_join ? MAPPING_INVALID : MAPPING_DUMMY;
> +		return MAPPING_BAD_CSUM;
> 	}
>
> 	subflow->valid_csum_seen = 1;
> @@ -1178,10 +1177,8 @@ static bool subflow_check_data_avail(struct sock *ssk)
>
> 		status = get_mapping_status(ssk, msk);
> 		trace_subflow_check_data_avail(status, skb_peek(&ssk->sk_receive_queue));
> -		if (unlikely(status == MAPPING_INVALID))
> -			goto fallback;
> -
> -		if (unlikely(status == MAPPING_DUMMY))
> +		if (unlikely(status == MAPPING_INVALID || status == MAPPING_DUMMY ||
> +			     status == MAPPING_BAD_CSUM))
> 			goto fallback;
>
> 		if (status != MAPPING_OK)
> @@ -1223,7 +1220,10 @@ static bool subflow_check_data_avail(struct sock *ssk)
> fallback:
> 	if (!__mptcp_check_fallback(msk)) {
> 		/* RFC 8684 section 3.7. */
> -		if (subflow->send_mp_fail) {
> +		if (status == MAPPING_BAD_CSUM &&
> +		    ((subflow->mp_join || subflow->valid_csum_seen))) {
> +			subflow->send_mp_fail = 1;
> +
> 			if (!READ_ONCE(msk->allow_infinite_fallback)) {
> 				ssk->sk_err = EBADMSG;
> 				tcp_set_state(ssk, TCP_CLOSE);
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel

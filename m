Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C11A7C
	for <mptcp@lists.linux.dev>; Fri, 24 Jun 2022 00:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656032349; x=1687568349;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=IK/FY2rlPHcfuIJFaMxQbuqfmDfj2O4HMWHugegPK6s=;
  b=N9s90TAld/jcd8bpG541+mZQr9S+qlqim52KlHT0L2cEo1PDbLsPCSbr
   Y//3JRjJY9BtbDVZKUhRvvLAGyzHH57X9hmWxp127aEB/qyYyby/ZI8BU
   heP2OkB9PsA/feE80Stw00NVmjY3x3LKcSBG1mAWoResuIJlXUeACaud3
   nD0f3S0Ny1zVSkG2jlkdiJAaN5jNlpMStJf/IQuAsE/UYDj906JYZmee9
   0ST12bOK6GjDMakNbve7lLQdKzLnFvaq8a2S/1aqCes098hHb0/9HkUNy
   XYFnqYcYkFKvygniCe8QJx931L8HXtetOAeSV/QYHa3Eeu+DTizFLFddd
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="261314160"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="261314160"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 17:59:08 -0700
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="915456241"
Received: from jngertso-mobl1.amr.corp.intel.com ([10.212.159.56])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 17:59:08 -0700
Date: Thu, 23 Jun 2022 17:59:07 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v9 2/6] mptcp: accept right edge of mapping
 validating
In-Reply-To: <6f5dffe33bd23ea18ec8cff99c8944e9d0f9c6fe.1655995770.git.geliang.tang@suse.com>
Message-ID: <8e4e2b9f-44e4-adeb-8d3-6a76a7799f3d@linux.intel.com>
References: <cover.1655995770.git.geliang.tang@suse.com> <6f5dffe33bd23ea18ec8cff99c8944e9d0f9c6fe.1655995770.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 23 Jun 2022, Geliang Tang wrote:

> If ssn is at the right edge of DSS mapping (ssn == subflow->map_subflow_seq
> + subflow->map_data_len), it shouldn't be handled as a bad map. This
> happens in the redundant subflows test cases.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/subflow.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 63e8892ec807..69a2c3e6fd76 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -878,8 +878,8 @@ static bool validate_mapping(struct sock *ssk, struct sk_buff *skb)
> 		dbg_bad_map(subflow, ssn);
> 		return false;
> 	}
> -	if (unlikely(!before(ssn, subflow->map_subflow_seq +
> -				  subflow->map_data_len))) {
> +	if (unlikely(after(ssn, subflow->map_subflow_seq +
> +				subflow->map_data_len))) {

I'm not sure this correct.

For example, if subflow->map_data_len == 1, then ssn can only be equal to 
subflow->map_subflow_seq. Changing this to after() allows the skb to 
include an extra byte that isn't covered by the mapping.

> 		/* Mapping does covers past subflow data, invalid */
> 		dbg_bad_map(subflow, ssn);
> 		return false;
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel

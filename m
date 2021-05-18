Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139A072
	for <mptcp@lists.linux.dev>; Tue, 18 May 2021 21:41:21 +0000 (UTC)
IronPort-SDR: 9WYSi6+DgH79OS68+oZO8b5aCT+2Y9JdWguQiSEjdf24vhzLXVb6yyaDb04P1Hg96zS/pSxwp4
 EnkUdR2IMmVA==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="262052749"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="262052749"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 14:41:18 -0700
IronPort-SDR: nD6jrHiQlimgLPem8gmTGu45fAm3n78a/aCGHuuPo2nSIS/ow3iAt5PSUgU0YipkDBKoawyTcp
 Jc61c13uXG2Q==
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="630661117"
Received: from isofinsk-mobl.amr.corp.intel.com ([10.209.83.65])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 14:41:18 -0700
Date: Tue, 18 May 2021 14:41:17 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev
Subject: Re: [MPTCP][PATCH mptcp-next] Squash to "mptcp: add deny_join_id0
 in mptcp_options_received"
In-Reply-To: <b49f8eb27abe177f54ea8d7b746ba02003d49682.1621332197.git.geliangtang@gmail.com>
Message-ID: <fecc3c1-5ac1-5ce7-7c8-8f253c619bb2@linux.intel.com>
References: <b49f8eb27abe177f54ea8d7b746ba02003d49682.1621332197.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 18 May 2021, Geliang Tang wrote:

> Please add this line to the commit log:
>
> '''
> In mptcp_finish_join, add the incomming join address check too.
> '''
>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
> net/mptcp/protocol.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index c725e8f02533..5cebecc838ca 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3116,7 +3116,8 @@ bool mptcp_finish_join(struct sock *ssk)
> 	if (!msk->pm.server_side)
> 		goto out;
>
> -	if (!mptcp_pm_allow_new_subflow(msk)) {
> +	if (!mptcp_pm_allow_new_subflow(msk) ||
> +	    (READ_ONCE(msk->pm.remote_deny_join_id0) && !subflow->remote_id)) {

This checks whether this side received a C==1 bit from the remote - but 
that's already checked in mptcp_pm_create_subflow_or_signal_addr().

What might be needed is a check in the opposite direction: if this side 
*sent* C==1, and the incoming MP_JOIN is for the initial addr/port, that's 
invalid.

Not sure yet how we are going to interpret the RFC on this, will be 
discussing at the meeting tomorrow.


> 		subflow->reset_reason = MPTCP_RST_EPROHIBIT;
> 		return false;
> 	}
> -- 
> 2.31.1

--
Mat Martineau
Intel

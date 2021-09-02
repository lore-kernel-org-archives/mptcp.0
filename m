Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999A73FCD
	for <mptcp@lists.linux.dev>; Thu,  2 Sep 2021 20:12:36 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10095"; a="199463042"
X-IronPort-AV: E=Sophos;i="5.85,263,1624345200"; 
   d="scan'208";a="199463042"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 13:12:27 -0700
X-IronPort-AV: E=Sophos;i="5.85,263,1624345200"; 
   d="scan'208";a="602541447"
Received: from jthackl1-mobl1.amr.corp.intel.com ([10.209.37.18])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 13:12:27 -0700
Date: Thu, 2 Sep 2021 13:12:26 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev, Geliang Tang <geliangtang@xiaomi.com>, 
    Paolo Abeni <pabeni@redhat.com>
Subject: Re: [MPTCP][PATCH v2 mptcp-next] mptcp: use OPTIONS_MPTCP_MPC
In-Reply-To: <10d25ba91ac41cacf02608b9e9a6e884d1eae996.1630573884.git.geliangtang@xiaomi.com>
Message-ID: <3acb33d0-4269-b355-39a9-86512429c28@linux.intel.com>
References: <10d25ba91ac41cacf02608b9e9a6e884d1eae996.1630573884.git.geliangtang@xiaomi.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 2 Sep 2021, Geliang Tang wrote:

> From: Geliang Tang <geliangtang@xiaomi.com>
>
> Since OPTIONS_MPTCP_MPC has been defined, use it instead of open-coding.
>
> Acked-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>

Looks good to me, thanks Geliang.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>



> ---
> v2:
> - switch of yoda-style in mptcp_established_options_mp_prio as Paolo
>   suggested.
> - keep yoda-style in mptcp_write_options, since the other options in
>   this fuction all use the yoda-style conditions.
> ---
> net/mptcp/options.c | 7 ++-----
> 1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 1ec6529c4326..422f4acfb3e6 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -748,9 +748,7 @@ static bool mptcp_established_options_mp_prio(struct sock *sk,
> 	/* can't send MP_PRIO with MPC, as they share the same option space:
> 	 * 'backup'. Also it makes no sense at all
> 	 */
> -	if (!subflow->send_mp_prio ||
> -	    ((OPTION_MPTCP_MPC_SYN | OPTION_MPTCP_MPC_SYNACK |
> -	      OPTION_MPTCP_MPC_ACK) & opts->suboptions))
> +	if (!subflow->send_mp_prio || (opts->suboptions & OPTIONS_MPTCP_MPC))
> 		return false;
>
> 	/* account for the trailing 'nop' option */
> @@ -1327,8 +1325,7 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
> 						   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
> 			}
> 		}
> -	} else if ((OPTION_MPTCP_MPC_SYN | OPTION_MPTCP_MPC_SYNACK |
> -		    OPTION_MPTCP_MPC_ACK) & opts->suboptions) {
> +	} else if (OPTIONS_MPTCP_MPC & opts->suboptions) {
> 		u8 len, flag = MPTCP_CAP_HMAC_SHA256;
>
> 		if (OPTION_MPTCP_MPC_SYN & opts->suboptions) {
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel

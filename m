Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435013481
	for <mptcp@lists.linux.dev>; Thu, 29 Jul 2021 00:23:32 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10059"; a="234663594"
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="234663594"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2021 17:23:27 -0700
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="417447704"
Received: from sghoshal-mobl.amr.corp.intel.com ([10.212.197.34])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2021 17:23:27 -0700
Date: Wed, 28 Jul 2021 17:23:27 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev, Geliang Tang <geliangtang@xiaomi.com>, 
    Paolo Abeni <pabeni@redhat.com>
Subject: Re: [MPTCP][PATCH mptcp-next] Squash to "mptcp: MP_FAIL suboption
 sending"
In-Reply-To: <04121bcd7e28251f4a3e1b17774b8ef5402f2431.1627470720.git.geliangtang@xiaomi.com>
Message-ID: <95cce559-cab1-d010-cf3c-18fbef22cbcf@linux.intel.com>
References: <04121bcd7e28251f4a3e1b17774b8ef5402f2431.1627470720.git.geliangtang@xiaomi.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 28 Jul 2021, Geliang Tang wrote:

> From: Geliang Tang <geliangtang@xiaomi.com>
>
> Drop the use_ack check, and add a likely tag.
>
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
> ---
> net/mptcp/options.c | 12 +++++-------
> 1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 2b15063c8009..6db24cf72ac0 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -788,7 +788,7 @@ static bool mptcp_established_options_mp_fail(struct sock *sk,
> {
> 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
>
> -	if (!subflow->send_mp_fail)
> +	if (likely(!subflow->send_mp_fail))
> 		return false;
>
> 	if (remaining < TCPOLEN_MPTCP_FAIL)
> @@ -835,12 +835,10 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
> 		ret = true;
> 	else if (mptcp_established_options_dss(sk, skb, snd_data_fin, &opt_size, remaining, opts)) {
> 		ret = true;
> -		if (opts->ext_copy.use_ack) {
> -			if (mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts)) {
> -				*size += opt_size;
> -				remaining -= opt_size;
> -				return true;
> -			}
> +		if (mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts)) {
> +			*size += opt_size;
> +			remaining -= opt_size;
> +			return true;
> 		}
> 	}
>
> -- 
> 2.31.1

This looks fine. Please include in future MP_FAIL revs.

--
Mat Martineau
Intel

Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D867E70
	for <mptcp@lists.linux.dev>; Tue, 11 May 2021 00:48:08 +0000 (UTC)
IronPort-SDR: U8A6sbuo/j/M8oZ0RZdDP8mkrtrjg5BhM//eg+r0S/nHn1PcvXDA/90CYnT1B6nNKtrYimdPRh
 rH8KuD8LJxig==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="220274922"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="220274922"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 17:48:08 -0700
IronPort-SDR: BGBqJvxxUYrATVPhbFODFVp7iRuIldxi2nLGll4XeahCtWpNPxXL+bOMeDOB5hgErORPsaWm7C
 5MkmlD71ug1w==
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="470959412"
Received: from akalita-mobl1.amr.corp.intel.com ([10.209.125.201])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 17:48:03 -0700
Date: Mon, 10 May 2021 17:48:01 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev
Subject: Re: [MPTCP][PATCH mptcp-next] Squash to "mptcp: add csum_reqd in
 mptcp_options_received"
In-Reply-To: <9d886bb5015a687a46287accd3a6f1111233eda7.1620349765.git.geliangtang@gmail.com>
Message-ID: <92d1e9-e495-56e1-119c-d49fb6d3e9f@linux.intel.com>
References: <f3808e3bfccf51a4a41e8ff3c793a464d8c3ae61.1620349748.git.geliangtang@gmail.com> <9d886bb5015a687a46287accd3a6f1111233eda7.1620349765.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 7 May 2021, Geliang Tang wrote:

> Init csum_reqd in mptcp_get_options, keep mptcp_parse_option unchanged.
>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
> net/mptcp/options.c | 7 +++----
> 1 file changed, 3 insertions(+), 4 deletions(-)

Looks good to me, thanks.

-Mat


>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 4a74b8bb737f..527affbbeea9 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -24,8 +24,6 @@ static void mptcp_parse_option(const struct sk_buff *skb,
> 			       const unsigned char *ptr, int opsize,
> 			       struct mptcp_options_received *mp_opt)
> {
> -	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
> -	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
> 	u8 subtype = *ptr >> 4;
> 	int expected_opsize;
> 	u8 version;
> @@ -74,7 +72,6 @@ static void mptcp_parse_option(const struct sk_buff *skb,
> 		 * negotiated, the receiver MUST close the subflow with a RST as
> 		 * it is considered broken."
> 		 */
> -		mp_opt->csum_reqd = READ_ONCE(msk->csum_enabled);
> 		if (flags & MPTCP_CAP_CHECKSUM_REQD)
> 			mp_opt->csum_reqd = 1;
>
> @@ -329,6 +326,8 @@ void mptcp_get_options(const struct sock *sk,
> 		       const struct sk_buff *skb,
> 		       struct mptcp_options_received *mp_opt)
> {
> +	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
> +	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
> 	const struct tcphdr *th = tcp_hdr(skb);
> 	const unsigned char *ptr;
> 	int length;
> @@ -344,7 +343,7 @@ void mptcp_get_options(const struct sock *sk,
> 	mp_opt->dss = 0;
> 	mp_opt->mp_prio = 0;
> 	mp_opt->reset = 0;
> -	mp_opt->csum_reqd = 0;
> +	mp_opt->csum_reqd = READ_ONCE(msk->csum_enabled);
>
> 	length = (th->doff * 4) - sizeof(struct tcphdr);
> 	ptr = (const unsigned char *)(th + 1);
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel

Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4AC7C
	for <mptcp@lists.linux.dev>; Wed, 16 Nov 2022 00:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668560156; x=1700096156;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=6rVE/J0HuqwilgWp5RLytieN7CLsrkPGdvx3ypvHvfA=;
  b=FLYtnXaxRz4eT6OS4fW9n+1Uln61HFt2EJsIdQfcfyKRxyN0xDMhxjlc
   ZKpxkuQscrWfCREGo3JtVm1tJS47ZTvASSniR+gXBVkqEKuorvB6mxqo3
   sfRtswa80UEzASAfVoDPxk0deSQ+Gru+b2J4EVVFCv4HM0Z0gvzXpTF+G
   9UfWxVRAsiD4VIjPeSbesMjMjvMJp7vaMI1Rm6SiCfgjQQieqCzvVEm7b
   vTrRYRSGFvEafOvnPt7LSBfTpQ+HYrEWBDtiC8rU3W5RZcFQFgCZg6M5E
   YBtY2UOZyo2Pl9ZAmIRGLcLq2x7WfDVcZqG+isJB1hmSbRNcyuelOhtTJ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="295776268"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="295776268"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 16:55:55 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="813884498"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="813884498"
Received: from trichard-mobl1.amr.corp.intel.com ([10.209.2.82])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 16:55:55 -0800
Date: Tue, 15 Nov 2022 16:55:55 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] mptcp: don't fallback when dss validating
 fails
In-Reply-To: <20221114024005.26661-1-geliang.tang@suse.com>
Message-ID: <73445d23-2060-3d90-cf44-042bcaabf040@linux.intel.com>
References: <20221114024005.26661-1-geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 14 Nov 2022, Geliang Tang wrote:

> When DSS validating fails, just drop this skb and continue, don't
> fallback and reset the subflow.
>
> This patch changes the return value of get_mapping_status() in this
> case from MAPPING_INVALID to MAPPING_EMPTY. With this change, in
> subflow_check_data_avail(), the code will reach 'goto no_data', instead
> of 'goto fallback'.
>
> ---
> This patch could be put into "BPF redundant scheduler, part 2" series.
> It can fix the issue I mentioned in [1].
>
> [1]
> https://patchwork.kernel.org/project/mptcp/patch/b0a39d02796da8a214fb8b8b9a597eef59e3ebd7.1666349129.git.geliang.tang@suse.com/

I don't think this is the solution - the problem is that 
validate_mapping() is finding mappings that don't match with the TCP 
sequence numbers of the packets. This check for the receiver seems ok, 
it's the sender side that needs fixing.

- Mat

> ---
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/subflow.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 97d301d3bfd3..3944ebf492d9 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1128,7 +1128,8 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
> 	 */
> 	if (!validate_mapping(ssk, skb)) {
> 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSTCPMISMATCH);
> -		return MAPPING_INVALID;
> +		sk_eat_skb(ssk, skb);
> +		return MAPPING_EMPTY;
> 	}
>
> 	skb_ext_del(skb, SKB_EXT_MPTCP);
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel

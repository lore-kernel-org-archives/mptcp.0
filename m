Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8932F80
	for <mptcp@lists.linux.dev>; Thu, 10 Jun 2021 21:03:06 +0000 (UTC)
IronPort-SDR: 71aBs3V8MW0DzVDMNs/ggWRyiFrMgn1R0M6e4uceCADFmkcRVg0EhW4KkuAE7ZlQa/00TMgU0c
 zzZB54v0vGlA==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="266555989"
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="266555989"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 14:03:05 -0700
IronPort-SDR: 1wQuHvIWm9SISFlSfN2N9+jNZyM05iVnSv9vl9umssJEQrYz86swhmCq9eZqNtGEA2+Ojg201p
 yxN3XV2hxLUw==
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="403006050"
Received: from ngattu-mobl1.amr.corp.intel.com ([10.209.121.205])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 14:03:05 -0700
Date: Thu, 10 Jun 2021 14:03:04 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: Maxim Mikityanskiy <maximmi@nvidia.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH net v2 2/3] mptcp: Fix out of bounds when parsing TCP
 options
In-Reply-To: <20210610164031.3412479-3-maximmi@nvidia.com>
Message-ID: <82474768-2c86-b2b7-afeb-30618b2ce094@linux.intel.com>
References: <20210610164031.3412479-1-maximmi@nvidia.com> <20210610164031.3412479-3-maximmi@nvidia.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 10 Jun 2021, Maxim Mikityanskiy wrote:

> The TCP option parser in mptcp (mptcp_get_options) could read one byte
> out of bounds. When the length is 1, the execution flow gets into the
> loop, reads one byte of the opcode, and if the opcode is neither
> TCPOPT_EOL nor TCPOPT_NOP, it reads one more byte, which exceeds the
> length of 1.
>
> This fix is inspired by commit 9609dad263f8 ("ipv4: tcp_input: fix stack
> out of bounds when parsing TCP options.").
>
> Cc: Young Xiao <92siuyang@gmail.com>
> Fixes: cec37a6e41aa ("mptcp: Handle MP_CAPABLE options for outgoing connections")
> Signed-off-by: Maxim Mikityanskiy <maximmi@nvidia.com>
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> ---
> net/mptcp/options.c | 2 ++
> 1 file changed, 2 insertions(+)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 6b825fb3fa83..9b263f27ce9b 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -356,6 +356,8 @@ void mptcp_get_options(const struct sk_buff *skb,
> 			length--;
> 			continue;
> 		default:
> +			if (length < 2)
> +				return;
> 			opsize = *ptr++;
> 			if (opsize < 2) /* "silly options" */
> 				return;
> -- 
> 2.25.1

Matthieu -

Could you apply this in mptcp_net-next so it's easier to track when the 
patch finds its way to net-next?

(MPTCP patchwork status set to "queued")

Thanks!

--
Mat Martineau
Intel

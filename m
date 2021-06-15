Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200B52FB8
	for <mptcp@lists.linux.dev>; Tue, 15 Jun 2021 22:45:21 +0000 (UTC)
IronPort-SDR: U0jlCCbtsrxmAopyzAaewS/TKX0bpu4R+sytQn2YUMzEKpJXzqDdkV+nTbRaAGnmOv/ywN7dk5
 FOekf76/7oHQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="185772502"
X-IronPort-AV: E=Sophos;i="5.83,276,1616482800"; 
   d="scan'208";a="185772502"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 15:45:20 -0700
IronPort-SDR: fuZM5wJY6MfrZhUKzDQeNs61Q4nIpoYzyOsE2qm1whGhpVnkUjuEYJYn2ScT5C5yjRTw70MldU
 Zcnlc02ZkWQA==
X-IronPort-AV: E=Sophos;i="5.83,276,1616482800"; 
   d="scan'208";a="404365189"
Received: from reschenk-mobl1.amr.corp.intel.com ([10.255.230.223])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 15:45:20 -0700
Date: Tue, 15 Jun 2021 15:45:19 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, Florian Westphal <fw@strlen.de>
Subject: Re: [RFC PATCH] tcp: consistently disable header prediction for
 mptcp
In-Reply-To: <982d258452274d2b165b07883307c01a44dbf7f7.1623434219.git.pabeni@redhat.com>
Message-ID: <39c13ca2-40db-5be2-732-f460d621943@linux.intel.com>
References: <982d258452274d2b165b07883307c01a44dbf7f7.1623434219.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 11 Jun 2021, Paolo Abeni wrote:

> The MPTCP receive path is hooked only into the TCP slow-path.
> The DSS presence allows plain MPTCP traffic to hit that
> consistently.
>
> Since commit e1ff9e82e2ea ("net: mptcp: improve fallback to TCP"),
> when and MPTCP socket falls back to TCP, we can the receive
> fast path, and delay or stop triggering the event notification.
>
> Address the issue explicitly disabling the header prediction
> for MPTCP sockets.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/200
> Fixes: e1ff9e82e2ea ("net: mptcp: improve fallback to TCP")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> I could not find a reliable way to disable header prediction
> touching the MPTCP code only: the TCP stack can flip header
> prediction on in a bunch of points and I could not find existing
> MPTCP hooks after such check to revert the change.
>
> So I opted for this TCP change, unless we are able to really
> drop TCP fast path ?!? (see commit
> 31770e34e43d6c8dee129bfee77e56c34e61f0e5)
>
> @Florian: WDYT?

I'm also interested in Florian's thoughts.

We need to fix MPTCP fallback whether regular TCP fast path is still 
present or not, so I'm in favor of this patch. Looking at Florian's 
comments on those previous patches (31770e34e43 and the patch it reverts), 
I wonder if anything in the last four years has changed tcp_ack() calls 
enough to affect performance.


Mat

> ---
> include/net/tcp.h | 4 ++++
> 1 file changed, 4 insertions(+)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index e668f1bf780d..17df9b047ee4 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -686,6 +686,10 @@ static inline u32 __tcp_set_rto(const struct tcp_sock *tp)
>
> static inline void __tcp_fast_path_on(struct tcp_sock *tp, u32 snd_wnd)
> {
> +	/* mptcp hooks are only on the slow path */
> +	if (sk_is_mptcp((struct sock *)tp))
> +		return;
> +
> 	tp->pred_flags = htonl((tp->tcp_header_len << 26) |
> 			       ntohl(TCP_FLAG_ACK) |
> 			       snd_wnd);
> -- 
> 2.26.3
>
>
>

--
Mat Martineau
Intel

Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567C62C96
	for <mptcp@lists.linux.dev>; Wed,  3 Nov 2021 22:51:58 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10157"; a="231457507"
X-IronPort-AV: E=Sophos;i="5.87,207,1631602800"; 
   d="scan'208";a="231457507"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 15:51:57 -0700
X-IronPort-AV: E=Sophos;i="5.87,207,1631602800"; 
   d="scan'208";a="501291819"
Received: from crschrol-desk6.amr.corp.intel.com ([10.251.25.129])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 15:51:57 -0700
Date: Wed, 3 Nov 2021 15:51:57 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v2 mptcp-net 1/2] mptcp: fix delack timer
In-Reply-To: <1429df0f9272607ebd8658d9f73e9fbad9165907.1635885975.git.pabeni@redhat.com>
Message-ID: <ad121a8-d16b-d38a-4136-5a74cc4fedd8@linux.intel.com>
References: <cover.1635885975.git.pabeni@redhat.com> <1429df0f9272607ebd8658d9f73e9fbad9165907.1635885975.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 2 Nov 2021, Paolo Abeni wrote:

> From: Eric Dumazet <edumazet@google.com>
>
> To compute the rtx timeout schedule_3rdack_retransmission() does multiple
> things in the wrong way: srtt_us is measures in usec/8 and the timeout
> itself is an absolute vale.
>
> Fixes: ec3edaa7ca6ce02f ("mptcp: Add handling of outgoing MP_JOIN requests")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
> commit message typos added by me

Thanks for the v2 Paolo (both patches). I think they're good for applying 
to the export branch, maybe Matthieu can s/measures/measured/ and 
s/vale/value/ above to restore Eric's spelling :)

Reviewed-by: Mat Martineau <mathew.j.martineau>@linux.intel.com>


> ---
> net/mptcp/options.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 7c3420afb1a0..2ca077fdf10a 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -434,9 +434,10 @@ static void schedule_3rdack_retransmission(struct sock *sk)
>
> 	/* reschedule with a timeout above RTT, as we must look only for drop */
> 	if (tp->srtt_us)
> -		timeout = tp->srtt_us << 1;
> +		timeout = usecs_to_jiffies(tp->srtt_us >> (3-1));
> 	else
> 		timeout = TCP_TIMEOUT_INIT;
> +	timeout += jiffies;
>
> 	WARN_ON_ONCE(icsk->icsk_ack.pending & ICSK_ACK_TIMER);
> 	icsk->icsk_ack.pending |= ICSK_ACK_SCHED | ICSK_ACK_TIMER;
> -- 
> 2.26.3
>
>
>

--
Mat Martineau
Intel

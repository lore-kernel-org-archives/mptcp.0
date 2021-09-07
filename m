Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7D872
	for <mptcp@lists.linux.dev>; Tue,  7 Sep 2021 18:39:55 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10100"; a="219973653"
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="219973653"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 11:39:53 -0700
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="469315470"
Received: from jeanfan1-mobl.amr.corp.intel.com ([10.212.129.129])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 11:39:53 -0700
Date: Tue, 7 Sep 2021 11:39:53 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] Squash-to: "mptcp: stop relying on
 tcp_tx_skb_cache"
In-Reply-To: <a4b897af7a6c7dcf4258d2ad90ddb5a676250ea1.1630921280.git.pabeni@redhat.com>
Message-ID: <262c1539-dbd8-be2-8f5-a94a3930bc1b@linux.intel.com>
References: <a4b897af7a6c7dcf4258d2ad90ddb5a676250ea1.1630921280.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 6 Sep 2021, Paolo Abeni wrote:

> A small cleanup for the tcp_tx_skb_cache removal: we don't
> need to check for skb in zero win probe (matttbe)
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/protocol.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 2a525c7ae920..8c34c6339454 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1336,7 +1336,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
> 	if (copy == 0) {
> 		u64 snd_una = READ_ONCE(msk->snd_una);
>
> -		if (skb || snd_una != msk->snd_nxt) {
> +		if (snd_una != msk->snd_nxt) {
> 			tcp_remove_empty_skb(ssk, tcp_write_queue_tail(ssk));
> 			return 0;
> 		}
> -- 
> 2.26.3

Thanks for the fixup, looks good to squash.

--
Mat Martineau
Intel

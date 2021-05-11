Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C677972
	for <mptcp@lists.linux.dev>; Tue, 11 May 2021 22:39:17 +0000 (UTC)
IronPort-SDR: akvxZv9V1x3aldy/SxYXH0Ibh1Eku+goBe10GdJVa9ddnbI2R9wQ50UXT4XyoKdu5pEo+kN9SL
 6duSTjmLt63g==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="260825201"
X-IronPort-AV: E=Sophos;i="5.82,291,1613462400"; 
   d="scan'208";a="260825201"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 15:39:15 -0700
IronPort-SDR: 6zTuwu3iyCm4uArVWFItl3UeLHxxnf81yU/EuFCJl52X97NI6ZVgqOtb+vsiuHtoWXD2VkdbKD
 feD/Gew0Nlpw==
X-IronPort-AV: E=Sophos;i="5.82,291,1613462400"; 
   d="scan'208";a="408990679"
Received: from kcolwell-mobl.amr.corp.intel.com ([10.251.1.71])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 15:39:14 -0700
Date: Tue, 11 May 2021 15:39:14 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Davide Caratti <dcaratti@redhat.com>
cc: mptcp@lists.linux.dev, Geliang Tang <geliangtang@gmail.com>, 
    Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH net] mptcp: validate 'id' when stopping the ADD_ADDR
 retransmit timer
In-Reply-To: <68c6032edaf880a958bf7f65afc7e9520f39d5cd.1620754971.git.dcaratti@redhat.com>
Message-ID: <e03119dc-67cb-6ac1-67fe-d92a8f954e4@linux.intel.com>
References: <68c6032edaf880a958bf7f65afc7e9520f39d5cd.1620754971.git.dcaratti@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1995879360-1620772754=:79315"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1995879360-1620772754=:79315
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 11 May 2021, Davide Caratti wrote:

> when Linux receives an echo-ed ADD_ADDR, it checks the IP address against
> the list of "announced" addresses. In case of a positive match, the timer
> that handles retransmissions is stopped regardless of the 'Address Id' in
> the received packet: this behaviour does not comply with RFC8684 §3.4.1.
>
> Fix it by validating the 'Address Id' in received echo-ed ADD_ADDRs.
> Tested using packetdrill, with the following captured output:
>
> unpatched kernel:
>
> Out <...> Flags [.], ack 1, win 256, options [mptcp add-addr v1 id 1 198.51.100.2 hmac 0xfd2e62517888fe29,mptcp dss ack 3007449509], length 0
> In  <...> Flags [.], ack 1, win 257, options [mptcp add-addr v1-echo id 1 1.2.3.4,mptcp dss ack 3013740213], length 0
> Out <...> Flags [.], ack 1, win 256, options [mptcp add-addr v1 id 1 198.51.100.2 hmac 0xfd2e62517888fe29,mptcp dss ack 3007449509], length 0
> In  <...> Flags [.], ack 1, win 257, options [mptcp add-addr v1-echo id 90 198.51.100.2,mptcp dss ack 3013740213], length 0
>        ^^^ retransmission is stopped here, but 'Address Id' is 90
>
> patched kernel:
>
> Out <...> Flags [.], ack 1, win 256, options [mptcp add-addr v1 id 1 198.51.100.2 hmac 0x1cf372d59e05f4b8,mptcp dss ack 3007449509], length 0
> In  <...> Flags [.], ack 1, win 257, options [mptcp add-addr v1-echo id 1 1.2.3.4,mptcp dss ack 1672384568], length 0
> Out <...> Flags [.], ack 1, win 256, options [mptcp add-addr v1 id 1 198.51.100.2 hmac 0x1cf372d59e05f4b8,mptcp dss ack 3007449509], length 0
> In  <...> Flags [.], ack 1, win 257, options [mptcp add-addr v1-echo id 90 198.51.100.2,mptcp dss ack 1672384568], length 0
> Out <...> Flags [.], ack 1, win 256, options [mptcp add-addr v1 id 1 198.51.100.2 hmac 0x1cf372d59e05f4b8,mptcp dss ack 3007449509], length 0
> In  <...> Flags [.], ack 1, win 257, options [mptcp add-addr v1-echo id 1 198.51.100.2,mptcp dss ack 1672384568], length 0
>        ^^^ retransmission is stopped here, only when both 'Address Id' and 'IP Address' match
>
> Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>
> ---
> net/mptcp/pm_netlink.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index d094588afad8..4318d4f5902e 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -353,11 +353,11 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
>
> 	spin_lock_bh(&msk->pm.lock);
> 	entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
> -	if (entry)
> +	if (entry && entry->addr.id == addr->id)
> 		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
> 	spin_unlock_bh(&msk->pm.lock);
>
> -	if (entry)
> +	if (entry && entry->addr.id == addr->id)
> 		sk_stop_timer_sync(sk, &entry->add_timer);
>
> 	return entry;

Hi Davide -

The code path for ADD_ADDR echo ignores the return value of 
mptcp_pm_del_add_timer(), so there's no chance there of leaving 
entry->add_timer running if the addr.id doesn't match.

The function is also called by remove_anno_list_by_saddr(), which will 
free 'entry' if a non-NULL value is returned by mptcp_pm_del_add_timer(). 
There's more of a chance here that the sk_stop_timer_sync() would be 
skipped and entry would be freed anyway. Looking at the various paths to 
this in the path manager it seems like it *should* not happen, but I'm not 
convinced it's impossible. Did you look at the effect of this change on 
these other code paths?


--
Mat Martineau
Intel
--0-1995879360-1620772754=:79315--

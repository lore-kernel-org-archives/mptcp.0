Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0BE2FB6
	for <mptcp@lists.linux.dev>; Tue, 18 May 2021 23:06:47 +0000 (UTC)
IronPort-SDR: /Wq2MmyL+vH9/NAPAmN2NDOm06nL9yM6gSjcVXMw5mMbTzykDf2kv+dVdoTzO5YrCh9OsQLron
 pw7NXx0o8Apg==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="198891785"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="198891785"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 16:06:46 -0700
IronPort-SDR: krphjOljU3tSkHg3kMaJM/tPpKvERXUsyX0zSx6mW3PCwewflZRuTxhabD3Po08oeH/8QcrYSj
 zHzWKZJFkxRw==
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="439328070"
Received: from isofinsk-mobl.amr.corp.intel.com ([10.209.83.65])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 16:06:46 -0700
Date: Tue, 18 May 2021 16:06:45 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Davide Caratti <dcaratti@redhat.com>
cc: mptcp@lists.linux.dev, Geliang Tang <geliangtang@gmail.com>
Subject: Re: [PATCH net] mptcp: validate 'id' when stopping the ADD_ADDR
 retransmit timer
In-Reply-To: <876dfafb9ec7b090a1da4c2af777be20973649ec.1621359292.git.dcaratti@redhat.com>
Message-ID: <1b5df243-111f-2c64-9743-4e8f33ce19b@linux.intel.com>
References: <876dfafb9ec7b090a1da4c2af777be20973649ec.1621359292.git.dcaratti@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1181676847-1621379206=:76127"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1181676847-1621379206=:76127
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 18 May 2021, Davide Caratti wrote:

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
> net/mptcp/options.c    | 2 +-
> net/mptcp/pm_netlink.c | 8 ++++----
> net/mptcp/protocol.h   | 2 +-
> 3 files changed, 6 insertions(+), 6 deletions(-)

Thanks Davide - looks good to me.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 3428c163299b..55732b8d7e08 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1067,7 +1067,7 @@ void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
> 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDR);
> 		} else {
> 			mptcp_pm_add_addr_echoed(msk, &mp_opt.addr);
> -			mptcp_pm_del_add_timer(msk, &mp_opt.addr);
> +			mptcp_pm_del_add_timer(msk, &mp_opt.addr, true);
> 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADD);
> 		}
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index d094588afad8..09722598994d 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -346,18 +346,18 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
>
> struct mptcp_pm_add_entry *
> mptcp_pm_del_add_timer(struct mptcp_sock *msk,
> -		       struct mptcp_addr_info *addr)
> +		       struct mptcp_addr_info *addr, bool check_id)
> {
> 	struct mptcp_pm_add_entry *entry;
> 	struct sock *sk = (struct sock *)msk;
>
> 	spin_lock_bh(&msk->pm.lock);
> 	entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
> -	if (entry)
> +	if (entry && (!check_id || entry->addr.id == addr->id))
> 		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
> 	spin_unlock_bh(&msk->pm.lock);
>
> -	if (entry)
> +	if (entry && (!check_id || entry->addr.id == addr->id))
> 		sk_stop_timer_sync(sk, &entry->add_timer);
>
> 	return entry;
> @@ -1070,7 +1070,7 @@ static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
> {
> 	struct mptcp_pm_add_entry *entry;
>
> -	entry = mptcp_pm_del_add_timer(msk, addr);
> +	entry = mptcp_pm_del_add_timer(msk, addr, false);
> 	if (entry) {
> 		list_del(&entry->list);
> 		kfree(entry);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 868e878af526..16e50caf200e 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -693,7 +693,7 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
> bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
> struct mptcp_pm_add_entry *
> mptcp_pm_del_add_timer(struct mptcp_sock *msk,
> -		       struct mptcp_addr_info *addr);
> +		       struct mptcp_addr_info *addr, bool check_id);
> struct mptcp_pm_add_entry *
> mptcp_lookup_anno_list_by_saddr(struct mptcp_sock *msk,
> 				struct mptcp_addr_info *addr);
> -- 
> 2.31.1
>
>

--
Mat Martineau
Intel
--0-1181676847-1621379206=:76127--

Received: from zebra.cherry.relay.mailchannels.net (zebra.cherry.relay.mailchannels.net [23.83.223.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22DB1917F1
	for <mptcp@lists.linux.dev>; Mon, 24 Feb 2025 16:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.195
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740414679; cv=pass; b=ryXhaT2eGSqqFTy2ThagShXrqCCm3VB+wWB3mZroIHc3G7yYPV3SB8Dw+X0ajy8zZelq+ydVjayYRneLCdHmh5fIsLN6jUzLcOREvGCVCz9jumqiXhL3IHDDt2lGoMIiHeAG5hftJUnJuuNtjoCWoYJdcMMTWhFzCWxey0Ps9LA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740414679; c=relaxed/simple;
	bh=sk3TbVUswjxRFIH+N38puUz/rsMd7xLKaDrX1NiQHHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGTb3vJSFimfl9GksZsnBkxj0YDKNVIn3Vug0cdRlTUHdKEJNZv3pTJOg167dy+i/mnnrDF5ejphUEWqKi42jWqYS5Dt6800TeN25Es7X/+C+AW0PobJnmf2XbwYKEZocyuIKtPj3OrzeNayDDso2Rh2vmbmsg7zDlYseE3ThMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com; spf=pass smtp.mailfrom=templeofstupid.com; dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b=TNVk2L8Y; arc=pass smtp.client-ip=23.83.223.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b="TNVk2L8Y"
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 98B95781616
	for <mptcp@lists.linux.dev>; Mon, 24 Feb 2025 16:31:10 +0000 (UTC)
Received: from pdx1-sub0-mail-a227.dreamhost.com (100-100-209-197.trex-nlb.outbound.svc.cluster.local [100.100.209.197])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 286D778118E
	for <mptcp@lists.linux.dev>; Mon, 24 Feb 2025 16:31:10 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1740414670; a=rsa-sha256;
	cv=none;
	b=S4bQXR2/3HZ8IZ4e34uPTfsHo1o/xuzHPSDoAqUjOe02Sq6/u8Wn2tppYa8O2VeU37siYM
	mzAKBhhGIVNEYzb5JOJY7ALTzi76PXYAZ/+o/Ptiwm7Nw5YyCdV0BhzfsH1mnFpmI8A0UX
	n4gb2Ae0Ig43mYg24fQEe/RMtSrXGrwyGwxb/Q6V0iYkBPEANqDUv+APET8g6YnBpQWjSU
	U47qvxxaFtrH2CMbr8qKf2BRFeW5mMV6krnV/TFp5ap5OeHjdJI9yabWQOspT1zV5YHUOJ
	8dE4zgSsFGO+MmPY7AoOmOA//xFzPO2YDbXMbP4Cp8ZxbpC/NrH5+BRmoY5iUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1740414670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=7A0B7SZ9ZZX1urOS6JFPoayhwsj/duuFPdxfuJEFlPw=;
	b=QsuEVYlEZRuyfZRF9twFWbDCySc0BWu6TR5q/EnorMOQxtZ5E8cWXg/PvGzFjzjT8R8N44
	BJ1BQ9qyJNVC7I+YnDAo1Gq3gKKW7szi8c3TIzavSbU17NQoVlMRCbBk5GZrB8uuLsyBUF
	iE2hOPyaNZPnu7wr6AXlc2J6FBfpV9/8ZiTRyPEWi2GskpF7rEC51CPYu/pFgKU5QqW4Tf
	VQy+3E/rBJ0Y1HweNPHym9fo5cu6vxdYIew4T9UJdsHxbjAMXsZNn78YIB6HBNEjnQFN5V
	jBxubvjd2hB2TPT0jVBGEv4qVbNFy9nrZvpxdsPm4YZ4U9P+6SOaTCvzKAE0gQ==
ARC-Authentication-Results: i=1;
	rspamd-6d7cc6b78d-z8454;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Obese-White: 695a3e3f677baeda_1740414670428_3612549005
X-MC-Loop-Signature: 1740414670428:1660487180
X-MC-Ingress-Time: 1740414670428
Received: from pdx1-sub0-mail-a227.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.100.209.197 (trex/7.0.2);
	Mon, 24 Feb 2025 16:31:10 +0000
Received: from kmjvbox.templeofstupid.com (c-73-70-109-47.hsd1.ca.comcast.net [73.70.109.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a227.dreamhost.com (Postfix) with ESMTPSA id 4Z1mSs6QwSzSL
	for <mptcp@lists.linux.dev>; Mon, 24 Feb 2025 08:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1740414669;
	bh=7A0B7SZ9ZZX1urOS6JFPoayhwsj/duuFPdxfuJEFlPw=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=TNVk2L8YremDLPbHyziqnVgUWi0BDA+wYtqN8CMKNE4UD0QetFwftOAWJBbqp6oh/
	 B1WMJhR4QxFeeZKaJUWFomROL38Km1EPOSNnzafvhrI+gBZhB2Rs+ogVd2d06wz1me
	 gGua5G36bkyX5yw/O4aq7sA/CfI37cY09awqU5xrI9rcn4SgiRvdCoStF1o+wXFfAB
	 E9TSvXSY6DuuiL+Q0Tdsa0u3LqPRoM5INY8WG0uKAkO2QaSynCXL3FGBDDx2quaDQI
	 EzyJ6T72MaLWd9Ia3vQ01y9fA9JMI3WG9Eu8DNLYb4+1/BOi7ccmy3HmJcvu3z+OrY
	 hidktXN4s3ykQ==
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e0089
	by kmjvbox.templeofstupid.com (DragonFly Mail Agent v0.12);
	Mon, 24 Feb 2025 08:31:08 -0800
Date: Mon, 24 Feb 2025 08:31:08 -0800
From: Krister Johansen <kjlx@templeofstupid.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp] mptcp: fix 'scheduling while atomic' in
 mptcp_pm_nl_append_new_local_addr
Message-ID: <20250224163108.GA1897@templeofstupid.com>
References: <20250221222146.GA1896@templeofstupid.com>
 <9ef28d50-dad0-4dc6-8a6d-b3f82521fba1@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ef28d50-dad0-4dc6-8a6d-b3f82521fba1@redhat.com>

Hi Paolo,

Thanks for the feedback.

On Mon, Feb 24, 2025 at 11:09:17AM +0100, Paolo Abeni wrote:
> On 2/21/25 11:21 PM, Krister Johansen wrote:
> > If multiple connection requests attempt to create an implicit mptcp
> > endpoint in parallel, more than one caller may end up in
> > mptcp_pm_nl_append_new_local_addr because none found the address in
> > local_addr_list during their call to mptcp_pm_nl_get_local_id.  In this
> > case, the concurrent new_local_addr calls may delete the address entry
> > created by the previous caller.  These deletes use synchronize_rcu, but
> > this is not permitted in some of the contexts where this function may be
> > called.  During packet recv, the caller may be in a rcu read critical
> > section and have preemption disabled.
> > 
> > An example stack:
> > 
> >    BUG: scheduling while atomic: swapper/2/0/0x00000302
> > 
> >    Call Trace:
> >    <IRQ>
> >    dump_stack_lvl+0x76/0xa0
> >    dump_stack+0x10/0x20
> >    __schedule_bug+0x64/0x80
> >    schedule_debug.constprop.0+0xdb/0x130
> >    __schedule+0x69/0x6a0
> >    schedule+0x33/0x110
> >    schedule_timeout+0x157/0x170
> >    wait_for_completion+0x88/0x150
> >    __wait_rcu_gp+0x150/0x160
> >    synchronize_rcu+0x12d/0x140
> >    mptcp_pm_nl_append_new_local_addr+0x1bd/0x280
> >    mptcp_pm_nl_get_local_id+0x121/0x160
> >    mptcp_pm_get_local_id+0x9d/0xe0
> >    subflow_check_req+0x1a8/0x460
> >    subflow_v4_route_req+0xb5/0x110
> >    tcp_conn_request+0x3a4/0xd00
> >    subflow_v4_conn_request+0x42/0xa0
> >    tcp_rcv_state_process+0x1e3/0x7e0
> >    tcp_v4_do_rcv+0xd3/0x2a0
> >    tcp_v4_rcv+0xbb8/0xbf0
> >    ip_protocol_deliver_rcu+0x3c/0x210
> >    ip_local_deliver_finish+0x77/0xa0
> >    ip_local_deliver+0x6e/0x120
> >    ip_sublist_rcv_finish+0x6f/0x80
> >    ip_sublist_rcv+0x178/0x230
> >    ip_list_rcv+0x102/0x140
> >    __netif_receive_skb_list_core+0x22d/0x250
> >    netif_receive_skb_list_internal+0x1a3/0x2d0
> >    napi_complete_done+0x74/0x1c0
> >    igb_poll+0x6c/0xe0 [igb]
> >    __napi_poll+0x30/0x200
> >    net_rx_action+0x181/0x2e0
> >    handle_softirqs+0xd8/0x340
> >    __irq_exit_rcu+0xd9/0x100
> >    irq_exit_rcu+0xe/0x20
> >    common_interrupt+0xa4/0xb0
> >    </IRQ>
> > 
> > This problem seems particularly prevalent if the user advertises an
> > endpoint that has a different external vs internal address.  In the case
> > where the external address is advertised and multiple connections
> > already exist, multiple subflow SYNs arrive in parallel which tends to
> > trigger the race during creation of the first local_addr_list entries
> > which have the internal address instead.
> > 
> > Fix this problem by switching mptcp_pm_nl_append_new_local_addr to use
> > call_rcu .  As part of plumbing this up, make
> > __mptcp_pm_release_addr_entry take a rcu_head which is used by all
> > callers regardless of cleanup method.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: d045b9eb95a9 ("mptcp: introduce implicit endpoints")
> > Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
> 
> The proposed patch looks functionally correct to me, but I think it
> would be better to avoid adding new fields to mptcp_pm_addr_entry, if
> not strictly needed.
> 
> What about the following? (completely untested!). When inplicit
> endpoints creations race one with each other, we don't need to replace
> the existing one, we could simply use it.
> 
> That would additionally prevent an implicit endpoint created from a
> subflow from overriding the flags set by a racing user-space endpoint add.
> 
> If that works/fits you feel free to take/use it.

I like this suggestion.  In addition to the benefits you outlined, it
also prevents a series of back-to-back replacements from getting turned
into a chunk of call_rcu() calls.  Leaving this as a synchronize_rcu is
probably better too, if we can.  I was unsure whether it was acceptable
to skip the replacement in this case.  Thanks for clearing that up.

I'll test this and follow up with a v2.

> ---
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 572d160edca3..dcb27b479824 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -977,7 +977,7 @@ static void __mptcp_pm_release_addr_entry(struct
> mptcp_pm_addr_entry *entry)
> 
>  static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
>  					     struct mptcp_pm_addr_entry *entry,
> -					     bool needs_id)
> +					     bool needs_id, bool replace)
>  {
>  	struct mptcp_pm_addr_entry *cur, *del_entry = NULL;
>  	unsigned int addr_max;
> @@ -1017,6 +1017,12 @@ static int
> mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
>  			if (entry->addr.id)
>  				goto out;
> 
> +			if (!replace) {
> +				kfree(entry);
> +				ret = cur->addr.id;
> +				goto out;
> +			}
> +
>  			pernet->addrs--;
>  			entry->addr.id = cur->addr.id;
>  			list_del_rcu(&cur->list);
> @@ -1165,7 +1171,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock
> *msk, struct mptcp_addr_info *skc
>  	entry->ifindex = 0;
>  	entry->flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
>  	entry->lsk = NULL;
> -	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, true);
> +	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, true, false);
>  	if (ret < 0)
>  		kfree(entry);
> 
> @@ -1433,7 +1439,8 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb,
> struct genl_info *info)
>  		}
>  	}
>  	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry,
> -						!mptcp_pm_has_addr_attr_id(attr, info));
> +						!mptcp_pm_has_addr_attr_id(attr, info),
> +						true);
>  	if (ret < 0) {
>  		GENL_SET_ERR_MSG_FMT(info, "too many addresses or duplicate one: %d",
> ret);
>  		goto out_free;

Thanks,

-K

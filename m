Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12D072
	for <mptcp@lists.linux.dev>; Thu, 10 Jun 2021 10:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1623320388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uOQyEZ7qJ9Ukoi8H2thkKiRyfVO7lzMMlAJFy06V/ck=;
	b=EATogLcyJIOmY+IncEYx4/cWw6oZH5L08nd5WcaYhAYJg0DXjSIipikK2+baPdZjOEz+J6
	HaUED6wk6M1UR5841CFS00YrS8hoLd3uQWu8Dn/HSm2VDeiRtZtTNQu7XLX1HgBSSUGw9l
	z2kX5CGdRzJ613tLUhJzHjAwYbD4ALo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-H9cVxZ4LMpSmI4q0V76LcQ-1; Thu, 10 Jun 2021 06:19:47 -0400
X-MC-Unique: H9cVxZ4LMpSmI4q0V76LcQ-1
Received: by mail-wr1-f70.google.com with SMTP id d5-20020a0560001865b0290119bba6e1c7so652399wri.20
        for <mptcp@lists.linux.dev>; Thu, 10 Jun 2021 03:19:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=uOQyEZ7qJ9Ukoi8H2thkKiRyfVO7lzMMlAJFy06V/ck=;
        b=YaiONFOBpr9gQ0ThbigPWMhkurHP4OM5KJJQ41Wr0lkMW4ZrXX+5nxa60E0j/rPoSO
         6/tK8n4sLQkaJIYYEv2GAxS6M3RLSjB73IilnZsj5WypYLGqEkVXRMlurokP4QBfrPu4
         86zCHAORsUYsS6gLN/6feCOlDPtc7ujy+BU3xJ0Ls412amjOSFXzY2tRyvP9X1Bhwc9s
         1bQPZIZNiQaAmD6OVL7/TjwMAROmiqXB22dwxG2H8l7lGfNCGhF5HdItqTiRQKb0tRpm
         0fIGwi9p1e9aWlZjOC2nMJJoleK18uyuR2tnduhdvu7UfS0Yk85wIqHldMTQB5LzHp35
         7tLw==
X-Gm-Message-State: AOAM5317WsnUKxJ9CCO8cnq7PvTA79nugtT8roNS+3tsXq5yuoBmyN+W
	Lx/p6J+MQi77P9MuKYEEWfe4/iUzKjZRgU1FdwDiYFbv2DoY/yXDxlfBeR1X8k/loz5DE8DXOhG
	nP6BJDJYnWKwQCWU=
X-Received: by 2002:a7b:c1ce:: with SMTP id a14mr14402955wmj.180.1623320386311;
        Thu, 10 Jun 2021 03:19:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAVPYcon4KMFD6LDro9JvdjNP/ChSnPCn5Yd63td+HC7m/ouQ004G7RExkqdKYWlWjPB1Ujg==
X-Received: by 2002:a7b:c1ce:: with SMTP id a14mr14402941wmj.180.1623320386129;
        Thu, 10 Jun 2021 03:19:46 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-109-224.dyn.eolo.it. [146.241.109.224])
        by smtp.gmail.com with ESMTPSA id h9sm9408930wmm.33.2021.06.10.03.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 03:19:45 -0700 (PDT)
Message-ID: <15a6b1e5c726b57359d08318545b83311f6e5f3f.camel@redhat.com>
Subject: Re: [PATCH v2 1/4] mptcp: fix warning in __skb_flow_dissect() when
 do syn cookie for subflow join
From: Paolo Abeni <pabeni@redhat.com>
To: Jianguo Wu <wujianguo106@163.com>, mptcp@lists.linux.dev, "Westphal,
 Florian" <fwestpha@redhat.com>, Mat Martineau
 <mathew.j.martineau@linux.intel.com>
Date: Thu, 10 Jun 2021 12:19:44 +0200
In-Reply-To: <ed5254b2-baa9-ea4c-df45-c61fa00622b9@163.com>
References: <ed5254b2-baa9-ea4c-df45-c61fa00622b9@163.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2021-06-10 at 17:28 +0800, Jianguo Wu wrote:
> From: Jianguo Wu <wujianguo@chinatelecom.cn>
> 
> I got the following warning message while doing the test:
> 
> [   55.552626] TCP: request_sock_subflow: Possible SYN flooding on port 8099. Sending cookies.  Check SNMP counters.
> [   55.553024] ------------[ cut here ]------------
> [   55.553027] WARNING: CPU: 0 PID: 10 at net/core/flow_dissector.c:984 __skb_flow_dissect+0x280/0x1650
> ...
> [   55.553117] CPU: 0 PID: 10 Comm: ksoftirqd/0 Not tainted 5.12.0+ #18
> [   55.553121] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
> [   55.553124] RIP: 0010:__skb_flow_dissect+0x280/0x1650
> ...
> [   55.553133] RSP: 0018:ffffb79580087770 EFLAGS: 00010246
> [   55.553137] RAX: 0000000000000000 RBX: ffffffff8ddb58e0 RCX: ffffb79580087888
> [   55.553139] RDX: ffffffff8ddb58e0 RSI: ffff8f7e4652b600 RDI: 0000000000000000
> [   55.553141] RBP: ffffb79580087858 R08: 0000000000000000 R09: 0000000000000008
> [   55.553143] R10: 000000008c622965 R11: 00000000d3313a5b R12: ffff8f7e4652b600
> [   55.553146] R13: ffff8f7e465c9062 R14: 0000000000000000 R15: ffffb79580087888
> [   55.553149] FS:  0000000000000000(0000) GS:ffff8f7f75e00000(0000) knlGS:0000000000000000
> [   55.553152] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   55.553154] CR2: 00007f73d1d19000 CR3: 0000000135e10004 CR4: 00000000003706f0
> [   55.553160] Call Trace:
> [   55.553166]  ? __sha256_final+0x67/0xd0
> [   55.553173]  ? sha256+0x7e/0xa0
> [   55.553177]  __skb_get_hash+0x57/0x210
> [   55.553182]  subflow_init_req_cookie_join_save+0xac/0xc0
> [   55.553189]  subflow_check_req+0x474/0x550
> [   55.553195]  ? ip_route_output_key_hash+0x67/0x90
> [   55.553200]  ? xfrm_lookup_route+0x1d/0xa0
> [   55.553207]  subflow_v4_route_req+0x8e/0xd0
> [   55.553212]  tcp_conn_request+0x31e/0xab0
> [   55.553218]  ? selinux_socket_sock_rcv_skb+0x116/0x210
> [   55.553224]  ? tcp_rcv_state_process+0x179/0x6d0
> [   55.553229]  tcp_rcv_state_process+0x179/0x6d0
> [   55.553235]  tcp_v4_do_rcv+0xaf/0x220
> [   55.553239]  tcp_v4_rcv+0xce4/0xd80
> [   55.553243]  ? ip_route_input_rcu+0x246/0x260
> [   55.553248]  ip_protocol_deliver_rcu+0x35/0x1b0
> [   55.553253]  ip_local_deliver_finish+0x44/0x50
> [   55.553258]  ip_local_deliver+0x6c/0x110
> [   55.553262]  ? ip_rcv_finish_core.isra.19+0x5a/0x400
> [   55.553267]  ip_rcv+0xd1/0xe0
> ...
> 
> After debugging, I found in __skb_flow_dissect(), skb->dev and skb->sk are both NULL,
> then net is NULL, and trigger WARN_ON_ONCE(!net), actually net is always NULL in this
> code path, as skb->dev is set to NULL in tcp_v4_rcv(), and skb->sk is never set.
> 
> Code snippet in __skb_flow_dissect() that trigger warning:
>   975         if (skb) {
>   976                 if (!net) {
>   977                         if (skb->dev)
>   978                                 net = dev_net(skb->dev);
>   979                         else if (skb->sk)
>   980                                 net = sock_net(skb->sk);
>   981                 }
>   982         }
>   983
>   984         WARN_ON_ONCE(!net);
> 
> So, use 4-tuple derived hash.
> 
> Fixes: 9466a1ccebbe("mptcp: enable JOIN requests even if cookies are in use").
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
> ---
>  net/mptcp/syncookies.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 53 insertions(+), 4 deletions(-)
> 
> diff --git a/net/mptcp/syncookies.c b/net/mptcp/syncookies.c
> index abe0fd0..11721b3 100644
> --- a/net/mptcp/syncookies.c
> +++ b/net/mptcp/syncookies.c
> @@ -35,13 +35,62 @@ struct join_entry {
>  static struct join_entry join_entries[COOKIE_JOIN_SLOTS] __cacheline_aligned_in_smp;
>  static spinlock_t join_entry_locks[COOKIE_JOIN_SLOTS] __cacheline_aligned_in_smp;
> 
> -static u32 mptcp_join_entry_hash(struct sk_buff *skb, struct net *net)
> +static u32 mptcp_join_hashfn(const struct net *net, const __be32 laddr,
> +			     const __be16 lport, const __be32 faddr,
> +			     const __be16 fport)
>  {
> -	u32 i = skb_get_hash(skb) ^ net_hash_mix(net);
> +	static u32 mptcp_join_hash_secret __read_mostly;
> +	u32 i;
> +
> +	net_get_random_once(&mptcp_join_hash_secret,
> +			    sizeof(mptcp_join_hash_secret));
> +
> +	i = jhash_3words((__force __u32) laddr,
> +			 (__force __u32) faddr,
> +			 ((__u32) lport) << 16 | (__force __u32)fport,
> +			 mptcp_join_hash_secret + net_hash_mix(net));
> +
> +	return i % ARRAY_SIZE(join_entries);
> +}
> +
> +static u32 mptcp_join_hashfn_inet6(const struct net *net,
> +				   const struct in6_addr *laddr, const u16 lport,
> +				   const struct in6_addr *faddr, const __be16 fport)
> +{
> +        static u32 mptcp_join_hash_secret_v6 __read_mostly;
> +        static u32 ipv6_hash_secret __read_mostly;
> +        u32 lhash, fhash, ports, i;
> +
> +        net_get_random_once(&mptcp_join_hash_secret_v6,
> +			    sizeof(mptcp_join_hash_secret_v6));
> +        net_get_random_once(&ipv6_hash_secret, sizeof(ipv6_hash_secret));
> +
> +        lhash = (__force u32)laddr->s6_addr32[3];
> +        fhash = __ipv6_addr_jhash(faddr, ipv6_hash_secret);
> +	ports = (((u32)lport) << 16) | (__force u32)fport;
> +
> +	i = jhash_3words(lhash, fhash, ports,
> +			 mptcp_join_hash_secret_v6 + net_hash_mix(net));

The above codes uses spaces instead of tabs. More importantly you can
directly use inet6_ehashfn(), since such function is already visible.

I'm unsure if we could directly use inet_ehashfn() here: it will
require making such function visible, and could affect TCP performances
(in a very minor way) as the compiler may refuse to inline such
function once that is not 'static'

@Florian, @Mat, WDYT?!?

/P


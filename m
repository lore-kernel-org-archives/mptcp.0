Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA8C29CA
	for <mptcp@lists.linux.dev>; Wed,  9 Jun 2021 14:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1623249098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HQaSn2PKjwKdhKHCMrI02Q4ZD1qzZCWhT0QCMyWtJwc=;
	b=ZiHv7v+PO4N6LyFP6jDCvOqzlWHroDjz1PEtkJ/g2C5hGXXojI6BWRPkh/vjWngx1jRJOT
	wtioKgkPUjE5n1MNZxtU92+yd8ZC3HV9V9pmcbUg//6oa9hKZEZTNmROC6a2jI2bqxJT6z
	8YmTFVQB3mHIqwMj92qxpb1N2p7KoU0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-aBHOFabHNx2uip9ho4f-zQ-1; Wed, 09 Jun 2021 10:31:36 -0400
X-MC-Unique: aBHOFabHNx2uip9ho4f-zQ-1
Received: by mail-wm1-f70.google.com with SMTP id j6-20020a05600c1906b029019e9c982271so2700247wmq.0
        for <mptcp@lists.linux.dev>; Wed, 09 Jun 2021 07:31:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=HQaSn2PKjwKdhKHCMrI02Q4ZD1qzZCWhT0QCMyWtJwc=;
        b=DgLh7SpMY3tF1T2JwkVDITwXJ/1C/77/E4UcsVKxerRPd59Jnp8zNG553TBnrke/M6
         shKYj1rgOpLPCpMGnfD9YCzVpVBLKIGTYeGZOMcThA/bma0aPIh1Gd97hVGUzYquBKO6
         uN4QwMynVJkZXoovxpttpzIkDiEKBGEchnOH/53Y7lQXEnvIJVFEDFD8fYcHVHybdMok
         fNddGofVmYPdDelD+YcNIOXAUu8N/0C3ArDz9rp5zTEfDz4Kc2kwNj/2A+mxkughPx4Z
         cchUACK6yR6Kda6tqEeH72uBouadwxe2YnwyAWurE0CcvoL7YfISMi0654wVKLORZIRV
         AWkg==
X-Gm-Message-State: AOAM532kGBDrMf4UpNfdVkfi33N22k3WiDPCAXpxxNstDzdyeRyf4/as
	B4W1yJeNclLf9KpIhYSBQ/5VSsmynFt9+fiyVWI+ok7d8KA348YMkzxFPxbv2yvNGeiWAHT6Amp
	uexvjP+YLc6/HWF4=
X-Received: by 2002:a1c:a516:: with SMTP id o22mr10303447wme.136.1623249095335;
        Wed, 09 Jun 2021 07:31:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLT2Vjgs2DjbwKlOIYxghvIK3817OSEHZ7Wt3u1+wNxw+iW9P6nv8Tg4s+WoXS8BIFhi/a6g==
X-Received: by 2002:a1c:a516:: with SMTP id o22mr10303432wme.136.1623249095127;
        Wed, 09 Jun 2021 07:31:35 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-109-224.dyn.eolo.it. [146.241.109.224])
        by smtp.gmail.com with ESMTPSA id 73sm125951wrk.17.2021.06.09.07.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 07:31:34 -0700 (PDT)
Message-ID: <15fdea5499d7a91b7915a748a433aed27fed6d1b.camel@redhat.com>
Subject: Re: [PATCH 1/3] mptcp: fix warning in __skb_flow_dissect() when do
 syn cookie for subflow join
From: Paolo Abeni <pabeni@redhat.com>
To: Jianguo Wu <wujianguo106@163.com>, mptcp@lists.linux.dev
Cc: Florian Westphal <fw@strlen.de>
Date: Wed, 09 Jun 2021 16:31:33 +0200
In-Reply-To: <b8f6479a-f007-d6be-8d7b-672c707d2823@163.com>
References: <b8f6479a-f007-d6be-8d7b-672c707d2823@163.com>
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

On Wed, 2021-06-09 at 18:39 +0800, Jianguo Wu wrote:
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
> So, if the skb->hash is not available, then fallback to use 4-tuple derived hash.
> 
> Fixes: 9466a1ccebbe("mptcp: enable JOIN requests even if cookies are in use").
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
> ---
>  net/mptcp/syncookies.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/syncookies.c b/net/mptcp/syncookies.c
> index abe0fd0..778bdba 100644
> --- a/net/mptcp/syncookies.c
> +++ b/net/mptcp/syncookies.c
> @@ -35,9 +35,31 @@ struct join_entry {
>  static struct join_entry join_entries[COOKIE_JOIN_SLOTS] __cacheline_aligned_in_smp;
>  static spinlock_t join_entry_locks[COOKIE_JOIN_SLOTS] __cacheline_aligned_in_smp;
> 
> +static u32 mptcp_join_hashfn(const struct net *net, const __be32 laddr,
> +			     const __be16 lport, const __be32 faddr,
> +			     const __be16 fport)
> +{
> +	static u32 mptcp_join_hash_secret __read_mostly;
> +
> +	net_get_random_once(&mptcp_join_hash_secret, sizeof(mptcp_join_hash_secret));
> +
> +	return jhash_3words((__force __u32) laddr,
> +			    (__force __u32) faddr,
> +			    ((__u32) lport) << 16 | (__force __u32)fport,
> +			    mptcp_join_hash_secret + net_hash_mix(net));
> +}
> +
>  static u32 mptcp_join_entry_hash(struct sk_buff *skb, struct net *net)
>  {
> -	u32 i = skb_get_hash(skb) ^ net_hash_mix(net);
> +	u32 i;
> +	struct iphdr *iph = ip_hdr(skb);
> +	struct tcphdr *th = tcp_hdr(skb);
> +
> +	if (!skb_get_hash_raw(skb))
> +		i = mptcp_join_hashfn(net, iph->daddr, th->dest,
> +				      iph->saddr, th->source);

Here we need to handle ipv6 sockets/addresses, too. See sk_ehashfn()
in net/ipv4/inet_hashtables.c for some reference code.

There is an additional caveat I haven't thought before: teorically the
syn and the 3rd ack skbs could be received via different interfaces,
which will produce different skb->hash value. Or the NIC hash could be
teorically disabled (or enabled) in between.

TL;DR: I think we should always use the mptcp_join_hashfn() and never
look at skb->hash.

Sorry for the late feedback,

Paolo


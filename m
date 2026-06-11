Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832B6370AD2
	for <mptcp@lists.linux.dev>; Thu, 11 Jun 2026 07:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781163568; cv=none; b=kmUGmGLqSR9RoVEoo/gvfuWi+y595toyrNfVy2zNoAuoa6jKxc8E4QVQHRjmjifq7tOBkZ4msWv3JA2jp4VhKxhx4pwX++3On1KLa+SQazu9KnuEI8WI6W97ZzQ5l/tZ+oh9snPJEjNc9U2rCuKJaw5TB3vjyzZIVhNlHYb+Gbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781163568; c=relaxed/simple;
	bh=pb4F24C0YjvzzjTcDDVE55NrogH22vK/ATzS7VJJXv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rXNKvchtKsV5Kdxi1Es1wuciorVbZh6CywlE5ZpBgthIFn37pF11IPxFvfl4e6e8aZgxa8+xucFnu1T2YpSvWr9ylYtpmUB1upJtM/sOd2Q4m9q1luYBH2p/bJjeIBUlzVUnL40BYxGq0jrkrnRs7E5UakowtA2YvEfuQ2aHZKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ATnA5osS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ATnA5osS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781163566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D5sG39NXxnvUU37y/twU50S+o8Hi79gl9qFWHRrRzL0=;
	b=ATnA5osSADIETmGwKbLBT4pc1kYh67I3lCMLU0eFAEJShq1tYZiS334GPEIHTqJ22uYw63
	zvxXgNAfnOZ30M9Wp/NE/E+s3Uc48w9PGiKPYnAlAHRgkvE0G3kpQ8wklXCsjNYXD+Sn0K
	HXlflo2if1xFUItt0sRFSPwyB22aHqM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-yc2wEEgTNoaxxzmigcif8A-1; Thu, 11 Jun 2026 03:39:25 -0400
X-MC-Unique: yc2wEEgTNoaxxzmigcif8A-1
X-Mimecast-MFC-AGG-ID: yc2wEEgTNoaxxzmigcif8A_1781163564
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-45efa2f7009so5002647f8f.3
        for <mptcp@lists.linux.dev>; Thu, 11 Jun 2026 00:39:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781163564; x=1781768364;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D5sG39NXxnvUU37y/twU50S+o8Hi79gl9qFWHRrRzL0=;
        b=PoCnVPtdSQ8LuA0S1oqilr/Das/vjvNyfC9NuOuwUWKMdJLnMfOCzwhnWWWtFVMMAE
         qrMXTdU3iE0Z15DDEq0VPwkv+bSeLRvYT/NzJ66qlj62/8uRiLgkwmpHlNC2bku5Wgs3
         ggpu4NCEAGuKB4PD93HRtp5aI3hE7LdL3w0jbGjIPnzNdN7JrB9LIFP8IKZfsugiWIR8
         djewIBgWjYeNUDRU3NZVYQ5aJbBD7/Ke7DIcHUzsTFsTOSKPNOnE0t0A5IH3Rzv0xQW4
         JqJKqZ60ioUWvDhP2UgMqPeZQnHB0ybkRCYytY7fq8z4K3P0pv8P0xegLSYzcf5hTa6o
         8+kQ==
X-Forwarded-Encrypted: i=1; AFNElJ+uFGwJBEjaj1GGjXlfYOFN/qe/5S8QrFWPgG6GvyTPALwBMraHwNaOv75La/Y+x9njmoPFZg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzMkxUlL8Ow0xLUnYUScbI642PXHVC1WKVnqhLPL7y17oF3uAlu
	lK0oMIX+w9suhugHx3x/Ri7DJT1X5sEycBVmTZTdcySsCbBcbuhWhyFMbBbc/QjgMMwh1TONEzN
	fJZOMfCtC6DJ66R2u9+c5sjvOvvpMRD9bEBa2jZTGRrlXgoxvvopnMbVT
X-Gm-Gg: Acq92OFk1UewlZCdDUa2ZphW11dX0lBFrebY0fpXllkuun5y98pd1dC+DhiXXVlVlCc
	oh3+hgNhzoupm1XZ1wQmyxncLtbp4vVT5fNnFHLL/eI9roNcrqqi51aPA4DYRlyWddCaoPmSBCT
	yE6/acD4vEFijY4vB4POXD9sfyK0zJLDWsVvmQZBoD5vOPMrZf1S3kfTGcTN39RclnWru0pqnMa
	R3xiGChQlSMjNbS7HNZgpURljpcuPKWiCp/qcsaFY09kFOwCJ8LnM82KZod5Cmv20niuxEP3eiz
	N9X98/7/85lca74A6zm6jx8MItJeif1tIe7tOQhDbScH5h0/zK/XVMEsgKw2uzQLyx9MEDlcYl+
	lrJZwtXaIT1O468u6imuyZgi2GRp+fqDtxjo5xVA6en6DyP2HgVmWFw9VURXwlWqkQQ==
X-Received: by 2002:a05:6000:2911:b0:460:65bc:780f with SMTP id ffacd0b85a97d-4606758363fmr2377394f8f.13.1781163564000;
        Thu, 11 Jun 2026 00:39:24 -0700 (PDT)
X-Received: by 2002:a05:6000:2911:b0:460:65bc:780f with SMTP id ffacd0b85a97d-4606758363fmr2377333f8f.13.1781163563505;
        Thu, 11 Jun 2026 00:39:23 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46028a6dcbdsm66058292f8f.7.2026.06.11.00.39.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 00:39:22 -0700 (PDT)
Message-ID: <fb96d949-dcf5-494d-8076-eb4a972fa5e4@redhat.com>
Date: Thu, 11 Jun 2026 09:39:21 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 05/15] tcp: allow mptcp to drop TS for some
 packets
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>
References: <20260605-net-next-mptcp-add-addr6-port-ts-v2-0-758e7ca73f4d@kernel.org>
 <20260605-net-next-mptcp-add-addr6-port-ts-v2-5-758e7ca73f4d@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260605-net-next-mptcp-add-addr6-port-ts-v2-5-758e7ca73f4d@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NBkP8Bygy7XWeXdvPhzRaqtuPmgsproEE9qd6Jv5tzQ_1781163564
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Eric,

On 6/5/26 11:21 AM, Matthieu Baerts (NGI0) wrote:
> With TCP-timestamps (padded) taking 12 bytes and ADD_ADDR IPv6 + port
> taking 30 bytes, the 40-byte limit for the TCP options is reached. In
> this case, it is then not possible to send the address signal.
> 
> The idea is to let MPTCP dropping the TCP-timestamps option for some
> specific packets, to be able to send some specific pure ACK carrying >28
> bytes of MPTCP options, like with this specific ADD_ADDR. A new
> parameter is passed from tcp_established_options to the MPTCP side to
> indicate if the TCP TS option is used, and if it should be dropped. The
> next commit implements the part on MPTCP side, but split into two
> patches to help TCP maintainers to identify the modifications on TCP
> side. This feature will be controlled by a new add_addr_v6_port_drop_ts
> MPTCP sysctl knob.
> 
> It is important to keep in mind that dropping the TCP timestamps option
> for one packet of the connection could eventually disrupt some
> middleboxes: even if it should be unlikely, they could drop the packet
> or even block the connection. That's why this new feature will be
> controlled by a sysctl knob.
> 
> Note that it would be technically possible to squeeze both options into
> the header if the ADD_ADDR is first written, and then the TCP timestamps
> without the NOPs preceding it. But this means more modifications on TCP
> side, plus some middleboxes could still be disrupted by that.
> 
> In this implementation, an unused bit is used in mptcp_out_options
> structure to avoid passing an address to a local variable. Reading and
> setting it needs CONFIG_MPTCP, so the whole block now has this #if
> condition: mptcp_established_options() is then no longer used without
> CONFIG_MPTCP.
> 
> About alternatives, instead of passing a new boolean (has_ts), another
> option would be to pass the whole option structure (opts), but
> 'struct tcp_out_options' is currently defined in tcp_output.c, and it
> would need to be exported. Plus that means the removal of the TCP TS
> option would be done on the MPTCP side, and not here on the TCP side.
> It feels clearer to remove other TCP options from the TCP side, than
> hiding that from the MPTCP side.
> 
> Yet an other alternative would be to pass the size already taken by the
> other TCP options, and have a way to drop them all when needed. But this
> feels better to target only the timestamps option where dropping it
> should be safe, even if it is currently the only option that would be
> set before MPTCP, when MPTCP is used.
> 
> Reviewed-by: Mat Martineau <martineau@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> - v2: Avoid passing local variables' addresses to
>   mptcp_established_options not to force the compiler to use a stack
>   canary in this hot function, even for non-MPTCP flows. (Eric Dumazet)
> To: Neal Cardwell <ncardwell@google.com>
> To: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  include/net/mptcp.h   | 13 +++----------
>  net/ipv4/tcp_output.c | 10 +++++++++-
>  net/mptcp/options.c   |  2 +-
>  3 files changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 24d1016a4664..71b9fc5a5796 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -72,7 +72,8 @@ struct mptcp_out_options {
>  	u8 reset_reason:4,
>  	   reset_transient:1,
>  	   csum_reqd:1,
> -	   allow_join_id0:1;
> +	   allow_join_id0:1,
> +	   drop_ts:1;
>  	union {
>  		struct {
>  			u64 sndr_key;
> @@ -153,7 +154,7 @@ bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
>  bool mptcp_synack_options(const struct request_sock *req, unsigned int *size,
>  			  struct mptcp_out_options *opts);
>  int mptcp_established_options(struct sock *sk, struct sk_buff *skb,
> -			      unsigned int remaining,
> +			      unsigned int remaining, bool has_ts,
>  			      struct mptcp_out_options *opts);
>  bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb);
>  
> @@ -269,14 +270,6 @@ static inline bool mptcp_synack_options(const struct request_sock *req,
>  	return false;
>  }
>  
> -static inline int mptcp_established_options(struct sock *sk,
> -					    struct sk_buff *skb,
> -					    unsigned int remaining,
> -					    struct mptcp_out_options *opts)
> -{
> -	return -1;
> -}
> -
>  static inline bool mptcp_incoming_options(struct sock *sk,
>  					  struct sk_buff *skb)
>  {
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index d3b8e61d3c5e..26dd751ec72a 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -1175,6 +1175,7 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
>  		size += TCPOLEN_TSTAMP_ALIGNED;
>  	}
>  
> +#if IS_ENABLED(CONFIG_MPTCP)
>  	/* MPTCP options have precedence over SACK for the limited TCP
>  	 * option space because a MPTCP connection would be forced to
>  	 * fall back to regular TCP if a required multipath option is
> @@ -1183,15 +1184,22 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
>  	 */
>  	if (sk_is_mptcp(sk)) {
>  		unsigned int remaining = MAX_TCP_OPTION_SPACE - size;
> +		bool has_ts = opts->options & OPTION_TS;
>  		int opt_size;
>  
> -		opt_size = mptcp_established_options(sk, skb, remaining,
> +		opts->mptcp.drop_ts = 0;
> +
> +		opt_size = mptcp_established_options(sk, skb, remaining, has_ts,
>  						     &opts->mptcp);
>  		if (opt_size >= 0) {
>  			opts->options |= OPTION_MPTCP;
>  			size += opt_size;
> +
> +			if (opts->mptcp.drop_ts)
> +				opts->options &= ~OPTION_TS;

I'm wondering if you are ok with this patch in the current form?

One thing that was discussed on the mptcp ML was exposing the
tcp_out_options layout so that mptcp_established_options() could receive
such argument and likely clean-up a bit this code.

Not done here because placing tcp_out_options under `include` felt a bit
"too much". Perhaps adding a `net/ipv4/tcp_option.h` header (and
including it from the mptcp code) would be more palatable?

Thanks,

Paolo


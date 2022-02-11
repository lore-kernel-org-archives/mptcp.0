Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A0C2C9D
	for <mptcp@lists.linux.dev>; Fri, 11 Feb 2022 10:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1644575702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cWxNoM703gjPEriEECk3svlTSUeVNGGXwzkBoS1BhUs=;
	b=G/MjF8mn9927omQRrkTLxY6XhS09Cyksz/i8EfeAOVWNKQXSDaea5R2kjqcrxVc8omTMEi
	DWjPY3q8698Y0hnGgsOVJbIYLGr7MMcN0mHAgUxJcTmCGWVW8rF4WF6KRoNrWwYBkyvOSy
	d1wQd2U3UtpYgwpaUnw2b5vib9O/oe8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-7-_ybwkeWlMaaoruTHJOnrhw-1; Fri, 11 Feb 2022 05:35:00 -0500
X-MC-Unique: _ybwkeWlMaaoruTHJOnrhw-1
Received: by mail-wm1-f71.google.com with SMTP id u14-20020a05600c210e00b0037bddd0562eso2351582wml.1
        for <mptcp@lists.linux.dev>; Fri, 11 Feb 2022 02:35:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=cWxNoM703gjPEriEECk3svlTSUeVNGGXwzkBoS1BhUs=;
        b=ACjUkwOhvokqxUjCJU6mykwr8hpPelKkxNiOBd9GKykJzTe7o9zKFLQdyCfaVxCUff
         Y5lIHg8wc9Xz1QVh/q7wrviJHKyi6KdDLTe9ln2tx9ufG0hJzPNMt/9PWNrvA+xKnOma
         8DI8RrbwmS8SV3zRRItxsDKyic1eyniOAIjpfU2oTU4AIJr3gokK/cUGrJAbHLdPjoDC
         zZrmq1bQOZ4CMGpi4EZ71bdLo6V0j3SiRCZctE7UETBzI9DcUxo+9QHEVxQBDHOLWtb0
         KajVTE8z7ctuEcckSLEZaeA6Oo9gnYxJK3xpkNxnyCn6BA0b8lm2gk2HJ8AgFeUtoiAA
         J5/A==
X-Gm-Message-State: AOAM533L+QjDLruqzRbTvzI6J8QWc/FUrIiLvkrxzc/XgI0OqU/12OV5
	Mww91nGJd2QmAXlvibDt6fR2A5sKOaFD16kaSuorDvTpfMLKVCt0QkeMMGXYpN0yTBmRA7lAWUh
	k3PBngAnPxdzCCWc=
X-Received: by 2002:a5d:420f:: with SMTP id n15mr832320wrq.155.1644575699496;
        Fri, 11 Feb 2022 02:34:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJykSpjONmPKbDnw1SVlgftIFJ8PCTZboWRiXL6z9IPuuQk0OZRFoIydCsjbSQfAKlTtkr7tqQ==
X-Received: by 2002:a5d:420f:: with SMTP id n15mr832308wrq.155.1644575699254;
        Fri, 11 Feb 2022 02:34:59 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-96-254.dyn.eolo.it. [146.241.96.254])
        by smtp.gmail.com with ESMTPSA id q13sm21213675wrd.78.2022.02.11.02.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 02:34:58 -0800 (PST)
Message-ID: <71933669ef873e688578ec59b0e98da2f360751b.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 1/4] mptcp: prefer ip address in syn skb
 instead of listen sk bound address
From: Paolo Abeni <pabeni@redhat.com>
To: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Date: Fri, 11 Feb 2022 11:34:57 +0100
In-Reply-To: <20220210152949.19572-2-fw@strlen.de>
References: <20220210152949.19572-1-fw@strlen.de>
	 <20220210152949.19572-2-fw@strlen.de>
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35)
Precedence: bulk
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

On Thu, 2022-02-10 at 16:29 +0100, Florian Westphal wrote:
> Once we change mptcp to use tproxy-like scheme to steer mptcp join
> requests to a special pernet socket, the 'sk bound address' becomes
> meaningless because it will never be identical to the tcp dport/ip daddr
> of the on-wire packet.
> 
> Prepare for this: pass the skbuff and use the packet data instead of
> the address the listener socket is bound to.
> 
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>  net/mptcp/pm_netlink.c | 17 +++++++++++++++--
>  net/mptcp/protocol.h   |  2 +-
>  net/mptcp/subflow.c    |  5 +++--
>  3 files changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 98b485406afa..1696f6fb9baa 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -279,13 +279,26 @@ mptcp_lookup_anno_list_by_saddr(struct mptcp_sock *msk,
>  	return NULL;
>  }
>  
> -bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk)
> +static void skb_address(const struct sk_buff *skb,
> +			struct mptcp_addr_info *addr)

Very minor nit: I would rename the above helper to something more
expressive, alike skb_fetch_src_address() or the like.


/P


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B360C2FB4
	for <mptcp@lists.linux.dev>; Thu, 27 May 2021 09:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1622106344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F0OBodwPZcry4FC3UKU+ClPT/9OYKMb3PA0qpLQo3rI=;
	b=E9zK1MrqCKGrgxDfsL0gherM06LACRY4ubaZ8Nxs+KkaRHEobLXR+uSgA/495kWKeaY0/t
	hscuJLg52EhkaWzLoIQVFmT6HeKM4FDRevkoDiQhlHBzfMFn4wVcKFtuvxzClVSGGFQ2TZ
	ZjjFuCw3ZE9Zy8fyeTGqepjltpA9bJs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-VFBp8UBGOi6LeqH6gY-pwA-1; Thu, 27 May 2021 05:05:42 -0400
X-MC-Unique: VFBp8UBGOi6LeqH6gY-pwA-1
Received: by mail-wm1-f71.google.com with SMTP id r1-20020a05600c35c1b029018ec2043223so1099740wmq.7
        for <mptcp@lists.linux.dev>; Thu, 27 May 2021 02:05:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=F0OBodwPZcry4FC3UKU+ClPT/9OYKMb3PA0qpLQo3rI=;
        b=ChNv+YbAkA1MdqKDU9PmGTJmsbUllcZd249W2YvyBPbBom3XBje4M0WbnSqDhZ4sNx
         4jA3eXfkEwx1DwGKVUDfC+IAW/At/Jz/PKaPF4wuKpovreMJAHsB9RbGy8MPoYnj1bzR
         yvAhzPpWHuHnY3n16ShH4npGttekeeLx//XxW8OrhfvtjvF5QKE9ZlCeLH70/WYoelNw
         wsMnZ5gLbgIaSFy0CwBffKBq0mKSq/xKLZxmGO81Z2ps9IyokMdV9x1h7a0cSnCQ9CKb
         HQ76W4sAdK5gBB8XW4gKRd271Yyrn7wFTd9JxPfqJFW56eHZMngXL7eB/UO9TCJo9F8G
         BBBg==
X-Gm-Message-State: AOAM532Zyn6gb9TMkhxtkq0R6LR/fyKKKR+3mKSsmjjGFf2LvWqqtzjP
	WOCWdWsrwWd0LiXGrusL11mbxe6gz9rEUMNulRogBhI8/FaP8BQrjVhpYcSI6lqzHMEfk2hWmwU
	fVxifo0yPAtRRyzs=
X-Received: by 2002:a5d:52ce:: with SMTP id r14mr2205331wrv.395.1622106341426;
        Thu, 27 May 2021 02:05:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx99O+Loap7XDP+UbjPXkyj8pCHfyuV1P5txqD75Hx9126D5915t3R7zQSmC5tVIYJe+18h7g==
X-Received: by 2002:a5d:52ce:: with SMTP id r14mr2205310wrv.395.1622106341158;
        Thu, 27 May 2021 02:05:41 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-110-123.dyn.eolo.it. [146.241.110.123])
        by smtp.gmail.com with ESMTPSA id l3sm2112081wmh.2.2021.05.27.02.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 02:05:40 -0700 (PDT)
Message-ID: <a0eb5145d2c40058cbb9df418a6e1828002486be.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: try harder to borrow memory from
 subflow under pressure
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Thu, 27 May 2021 11:05:39 +0200
In-Reply-To: <e4ed3091-8734-ff3f-89fd-28ecc5981d5e@linux.intel.com>
References: <bc6471c8f7444b89e7e5f6c8f7713972477fda36.1622045437.git.pabeni@redhat.com>
	 <e4ed3091-8734-ff3f-89fd-28ecc5981d5e@linux.intel.com>
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

On Wed, 2021-05-26 at 21:17 -0700, Mat Martineau wrote:
> On Wed, 26 May 2021, Paolo Abeni wrote:
> 
> > If the host is under sever memory pressure, and RX forward
> > memory allocation for the msk fails, we try to borrow the
> > required memory from the ingress subflow.
> > 
> > The current attempt is a bit flaky: if skb->truesize is less
> > than SK_MEM_QUANTUM, the ssk will not release any memory, and
> > the next schedule will fail again.
> > 
> > Instead, directly move the required amount of pages from the
> > ssk to the msk, if available
> > 
> > Fixes: 9c3f94e1681b ("mptcp: add missing memory scheduling in the rx path")
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > net/mptcp/protocol.c | 10 ++++++----
> > 1 file changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index bb029dd4ff5e..785e74c13b3c 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -286,11 +286,13 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
> > 
> > 	/* try to fetch required memory from subflow */
> > 	if (!sk_rmem_schedule(sk, skb, skb->truesize)) {
> > -		if (ssk->sk_forward_alloc < skb->truesize)
> > -			goto drop;
> > -		__sk_mem_reclaim(ssk, skb->truesize);
> > -		if (!sk_rmem_schedule(sk, skb, skb->truesize))
> > +		int amount = sk_mem_pages(skb->truesize) << SK_MEM_QUANTUM_SHIFT;
> > +
> > +		if (ssk->sk_forward_alloc < amount)
> > 			goto drop;
> > +
> > +		ssk->sk_forward_alloc -= amount;
> > +		sk->sk_forward_alloc += amount;
> > 	}
> > 
> > 	has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
> > -- 
> > 2.26.3
> 
> Looks ok to me - the memory will be reclaimed from the msk later, if I 
> understand correctly.

Yes, sk_forward_alloc will be updated when the skb will be freed at
reception time, and the fwd allocated memory is reclaimed either on
memory pressure or at socket close time. 
> 
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

Thanks!

Paolo


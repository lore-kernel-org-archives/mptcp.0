Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A992FAE
	for <mptcp@lists.linux.dev>; Wed, 26 May 2021 11:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1622027178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=43Po2da8bSA0mbad48QqJVakTYKTLyuREDjnScVD1kY=;
	b=a/UN1xiHhrbDyvTfA3L6vCGSP3o7Arm2N6io6xTdo8hanupB+3bwWuTQBkx+ciK4Gobydj
	wEfvP02yBxEsUUvxQDBVwljw9yqmWtL4jr6Q1eUhInDu1w6OqBj4uQ9yuVvZHTwDgw/yvX
	O+LT+RdVIZyK2t0Ra8J7crU9roNxFvs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-0pITx-o7Om24mL-sHeBHFQ-1; Wed, 26 May 2021 07:06:16 -0400
X-MC-Unique: 0pITx-o7Om24mL-sHeBHFQ-1
Received: by mail-wm1-f70.google.com with SMTP id n2-20020a05600c4f82b0290181c444b9f1so258572wmq.6
        for <mptcp@lists.linux.dev>; Wed, 26 May 2021 04:06:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=43Po2da8bSA0mbad48QqJVakTYKTLyuREDjnScVD1kY=;
        b=RG9WbFRR26y+UmMpH1zpx8KkOjCTQX83izQ22T3hivVHIXwRF3LCCDgrn26ZabBY3t
         xE0ZVAZ9SHCLNh87znSVkqg2tHudMwyENwmIxGBVg8wIlMKdKMEAeQZ2CtrZfHFTqrxu
         6Lpe0b5DPqXrzdO6hFDmCuQTQNDKdsoUR9H+jHj92j4cdDeNCaGohNQHo3v2H6qClB+l
         uS8r+dvMBEedDcUXKOxYMMArtoCighg/OUdYUIZMjssa0hlgP2eAgj26L/tcKxLDmMsy
         wr/UaiwAHDlC0eZ1reDBA2AvkpmwlqoD4kmAMxIj15DwOZHOjImJYBD2bIdlusvgUHWe
         PYMA==
X-Gm-Message-State: AOAM531kiTJJ0fsuMOKo33BdvEpozFagSmL7vGoZ0HwHCq5RAMP3NxqX
	1I0HoBQOEXHXe4MSZkyvckXxe2sPbWoKjWCxVMSMU3jyj6c6RTtqZ+hbiLIYNVz844v/HAycLGq
	Dd/XRmWxWBqfGQ6A=
X-Received: by 2002:adf:fd45:: with SMTP id h5mr31474760wrs.383.1622027174875;
        Wed, 26 May 2021 04:06:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2VT6mGfVTYDAIw4LfRvtrEqxM0uT5iWgmbiRAbFrsy9QWyLtPYnoWfUxfbXwLmIK+rvjVbA==
X-Received: by 2002:adf:fd45:: with SMTP id h5mr31474735wrs.383.1622027174592;
        Wed, 26 May 2021 04:06:14 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-110-123.dyn.eolo.it. [146.241.110.123])
        by smtp.gmail.com with ESMTPSA id c7sm6032019wml.33.2021.05.26.04.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 04:06:14 -0700 (PDT)
Message-ID: <32a776b7dd322f114e385ca406f5ca879c7831cd.camel@redhat.com>
Subject: Re: [PATCH v2 mptcp-next] mptcp: drop tx skb cache
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Wed, 26 May 2021 13:06:13 +0200
In-Reply-To: <e9657dbd-f455-61e9-2118-e2b2443fafb@linux.intel.com>
References: <8dd3343ea83a7a631acfe4940a9dea841b32c52a.1621613936.git.pabeni@redhat.com>
	 <e9657dbd-f455-61e9-2118-e2b2443fafb@linux.intel.com>
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

On Fri, 2021-05-21 at 15:57 -0700, Mat Martineau wrote:
> On Fri, 21 May 2021, Paolo Abeni wrote:
> 
> > The mentioned cache was introduced to reduce the number of skb
> > allocation in atomic context, but the required complexity is
> > excessive.
> > 
> > This change remove the mentioned cache.
> > 
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > v1 -> v2:
> > - drop unused field skb_tx_cache
> 
> There's also a size_goal_cache field in struct mptcp_sock that's now 
> unused.

yep, will do in v3 (sorry, I lost track of this review)

> I like the simplification! Do the self tests trigger enough memory 
> pressure to test allocation in that scenario?

Will ensure that before posting v3

> The commit that introduced the skb_tx_cache did so to allow removal of the 
> skb_ext cache. It looks like both caches are now unnecessary because the 
> skb and skb_ext allocations are handled together in the 
> __mptcp_{do_,}alloc_tx_skb() functions - so an allocation failure can be 
> handled without the complexity of the caches.

The cache goal was avoid/reduce skb allocation in atomic context. That
is still true (e.g. with skb_tx_cache we have less skb allocation in
atomic context, expecially when the transfer is link/pacing/peer
limited). Plain TCP can allocare skbs in atomic context, but that does
not happen often. MPTCP will do that almost for each skb,
when link/pacing/peer limited.

I think we can ignore the above, as e.g. high performance NIC device
driver always allocate skb in atomic context.

>  Does that match your 
> understanding? If so, it would be helpful information for the commit 
> message.

The main trick, imho is that we still use the sk->sk_tx_skb_cache to
prevent the TCP stack from allocating extension-less skb. That trick
was introduced with the mptcp tx_cache.

Not sure if the above clarify anything ?!?

Cheers,

Paolo


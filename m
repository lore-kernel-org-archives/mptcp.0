Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5637070
	for <mptcp@lists.linux.dev>; Fri, 14 May 2021 10:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1620989458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UEl4JYh8OVKbPhzWA9uyXGkARfveQvqAyK0MdPdFtiQ=;
	b=cgrKAdRblhaz6AuJeRV2l+OK2CUe23YO9coCdYpVp8FalfoVgX5waVkwZfTJKeQ80koU3y
	mtAt8CDTzde/GaFtdTtLsjJMe2gdu6ngWCWkw2UlkgIEPu0SjoTn7oQoqwWBLW79U5jGOP
	fqX8Aj+F+bXhICccwzNQF9ErX6us/DI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-UI459avYMOusuHjP_vB5zw-1; Fri, 14 May 2021 06:50:56 -0400
X-MC-Unique: UI459avYMOusuHjP_vB5zw-1
Received: by mail-wm1-f69.google.com with SMTP id v2-20020a7bcb420000b0290146b609814dso741704wmj.0
        for <mptcp@lists.linux.dev>; Fri, 14 May 2021 03:50:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=UEl4JYh8OVKbPhzWA9uyXGkARfveQvqAyK0MdPdFtiQ=;
        b=qgqCy9wxKiPDZYKw2SeENFgN+5ehwE/H0NijC3wSM/FWqKrkU1UXFQsCgFWpEWKjff
         cM0iXRbRKpBg6EaD7IA9+Xx/Ft+mBu1VVFRFtpba6vCvGKXdIB1IEK/deQBJ+0gTXA7l
         WnTO7xtR0TFY3OMl9nvOy2ZiAwHcYzqvd7hw2wmuKny9mgj6c+ri5sYlq/OYhZVCEXYQ
         pQ9xtczZYpWC7oc2gxcbN7uB7NYMMoxywUCtFvhnvZrAHngY7u2+G2Ygf8dvTJk8F2hF
         LEwYFqF7QqBlouRnRPD2MiYjJtReIUDNEQasGjyG7KD55aicG+P/csIxfrn8jYKVh1oj
         Wx1w==
X-Gm-Message-State: AOAM533//9MSQszAPKKIrcpZ6LDnBtS22ceLjRRCIrjctycsQdOb0O+V
	lElIgC24+7ZvJqfK8SvYk5HV1PyNcgR17fSqSb5p7js/qcigvRDzFM0ZX34Hq0vqn3zKs8tNis5
	sSm4e3R6MQLTxOQk=
X-Received: by 2002:a1c:b087:: with SMTP id z129mr8666499wme.67.1620989454866;
        Fri, 14 May 2021 03:50:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx5Tb4pyevzuevDThhvCiZ8GFNLfiyfv1KTjUXIjNj4aCYaSiMd8orG/FMgRPnp7LwdRB90HA==
X-Received: by 2002:a1c:b087:: with SMTP id z129mr8666480wme.67.1620989454630;
        Fri, 14 May 2021 03:50:54 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-238-255.dyn.eolo.it. [146.241.238.255])
        by smtp.gmail.com with ESMTPSA id c14sm6084473wrt.77.2021.05.14.03.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 03:50:54 -0700 (PDT)
Message-ID: <b5a2c0c468b6cf270b4afbd749878fde32c8f3da.camel@redhat.com>
Subject: Re: [PATCH v2 mptcp-next 1/8] mptcp: enable busypoll from mptcp
 receive path
From: Paolo Abeni <pabeni@redhat.com>
To: Florian Westphal <fw@strlen.de>, Christoph Paasch <cpaasch@apple.com>
Cc: mptcp@lists.linux.dev
Date: Fri, 14 May 2021 12:50:53 +0200
In-Reply-To: <c5a5f4c6d85180665fcead4634c9af0fa52fdff0.camel@redhat.com>
References: <20210511133659.29982-1-fw@strlen.de>
	 <20210511133659.29982-2-fw@strlen.de>
	 <83bc7a0dc52a0f362489067babfbbb5c4bd083e6.camel@redhat.com>
	 <20210512100413.GJ4038@breakpoint.cc>
	 <e5bad85c6b9d560f30f094a1b55fa4e901170931.camel@redhat.com>
	 <20210514095730.GA30441@breakpoint.cc>
	 <c5a5f4c6d85180665fcead4634c9af0fa52fdff0.camel@redhat.com>
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

On Fri, 2021-05-14 at 12:35 +0200, Paolo Abeni wrote:
> We will have a N:1 mapping (where N is the number of subflows using the
> code above and could be "optimized" to the number of different napi_id
> in use by such subflows with the changes discussed in the last part of
> my previous email).
> 
> But still should not introuce additional latency. If e.g. we are
> polling on napi_id_1 and packets arrive on napi id_2, since the msk
> socket lock is not held, the rx subflow input path will deliver them to
> the msk receive queue and the:
> 
> 	'if (skb_queue_empty_lockless(&sk->sk_receive_queue))'
> 
> check will terminate the loop as soon as polling no napi_id_1
> completes.
> 
> Well, that could actually introduce some latency, e.g. if napi_id_1 is
> under heavy traffic sent from some different peer. Not 110% sure
> anyway: BP reduce lantency mostly by avoiding tripping on the process
> scheduler, and we will get that part right.
> 
> Assuming this later consideration is correct, we could eventually
> consider always doing busy polling on a single napi instance (belonging
> to an active, non backup subflow) even in presence of multiple active
> subflows, and that should still reduce latency.

If I read correctly, this is roughly the approach used by mptcp.org
> 
> I guess a little experimentation will help ;) 

@Christoph, do you have info/paper/data for BP && mptcp && multiple
napi ids? Or (half-seriously) some university PHD willing do some
academic research on it? ;)))

/P



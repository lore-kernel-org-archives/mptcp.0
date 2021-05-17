Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F2B2FB0
	for <mptcp@lists.linux.dev>; Mon, 17 May 2021 11:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1621251211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V76I9EYPKtTwP+taI6+PUGukmekQbTxU0ZgIiP/You8=;
	b=aD3B4N9IBnU6OLLKaRfZQuRiLbjMoSgXJr4/BO7+MjqlrMlVJBl1DnD0Oc3lpY9iDrlXTN
	AovwmTAeNPqT1pp5Q1m9ZdGtP7+udEluLfQmKnEuOWSF+1myJeRqnoPd1yD2q5diiAcoKH
	M5uL62d6Gw1kNt8yYntaZ6QIagQ69BQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-HeeCUvqYNs67AS98-Ux7Fw-1; Mon, 17 May 2021 07:32:58 -0400
X-MC-Unique: HeeCUvqYNs67AS98-Ux7Fw-1
Received: by mail-wr1-f72.google.com with SMTP id n2-20020adfb7420000b029010e47b59f31so3660412wre.9
        for <mptcp@lists.linux.dev>; Mon, 17 May 2021 04:32:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=V76I9EYPKtTwP+taI6+PUGukmekQbTxU0ZgIiP/You8=;
        b=pOFpAZdhIQ+cOMqxsW1IDiZ5/5OOtTGMavFnEJGshCBWNR1OBCWULL73SVPa1pYb2N
         hiBTjaMf3HuoiRdUtcHlrs+WJCn3PeOcvpoYQlRuIiqoWMtl/oRU9zM9Fx2881/bZcs7
         6AWNJ7wm8ytD3f4J0HNLf3X12FGGcQHK7+8CKPnm+7DkghfD1x1GK0Gxl13Llgu5s37d
         Mx5PWiaSGKDGn6zlBJ+q33SP0Wo1KzEG00zDXVZWPvnYZ0cqrhmjftitbBvK4DJnB3iK
         VV8uPd9tFXaIoLkiRWxiT0eSR7ryFemuClEcunT+9dqr9rrgWb2sH+1WQGQyJfG6h7U+
         w8TQ==
X-Gm-Message-State: AOAM531UjzKl5tLfeC2hwhZ/YP8LkcPZXbUdo8k9dhRkdg5lOpzMILCN
	5uIlpqsqgEvWm5J3uYzC068odwwJ9E7aKAxutlWPOWfueyskDqhPA6lQOXvvmLB43RfnqaAnq6I
	hXa3VjelBmIJm/ARFWUMjI3NCaufEQ2ivObfq+DU6ryT2AD7sn/vMU6rfx3Vk1P+0
X-Received: by 2002:a1c:b7c4:: with SMTP id h187mr62819482wmf.178.1621251177192;
        Mon, 17 May 2021 04:32:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyE+YJTqMdaoBWVlcgvLbUO3b70OlWy6126vkE168quPITiVt7o7oaVq26NBgcxEsdNgQ4uUQ==
X-Received: by 2002:a1c:b7c4:: with SMTP id h187mr62819454wmf.178.1621251176831;
        Mon, 17 May 2021 04:32:56 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-245-104.dyn.eolo.it. [146.241.245.104])
        by smtp.gmail.com with ESMTPSA id w20sm2505363wmc.44.2021.05.17.04.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 04:32:56 -0700 (PDT)
Message-ID: <84d520ef86f7ba9644383f421ea4eb0b62c2cc1c.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: always parse mptcp options for MPC
 reqsk
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev, Mat Martineau
 <mathew.j.martineau@linux.intel.com>,  Christoph Paasch <cpaasch@apple.com>
Date: Mon, 17 May 2021 13:32:55 +0200
In-Reply-To: <024b61f2b46bb7f8d02db1dbdd1c822859b78674.1621248230.git.pabeni@redhat.com>
References: <024b61f2b46bb7f8d02db1dbdd1c822859b78674.1621248230.git.pabeni@redhat.com>
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

On Mon, 2021-05-17 at 12:44 +0200, Paolo Abeni wrote:
> In subflow_syn_recv_sock() we currently skip options parsing
> for OoO packet, given that such packets may not carry the relevant
> MPC option.
> 
> If the peer generates an MPC+data TSO packet and some of the early
> segments are lost or get reorder, we server will ignore the peer key,
> causing transient, unexpected fallback to TCP.
> 
> The solution is always parsing the incoming MPTCP options, and
> do the fallback only for in-order packets. This actually cleans
> the existing code a bit.
> 
> Reported-by:  Matthieu Baerts <matthieu.baerts@tessares.net>
> Fixes: d22f4988ffec ("mptcp: process MP_CAPABLE data option")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/192
> iSigned-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> a note on data ack len: with this patch the server will use
> ack32 for OoO MPC+data pkts, and will move to ack64 ASA will get
> the first in order MPC+data pkt.
> 
> We can clean-up/make more consistent the behavior with some additional
> check in mptcp_sk_clone and/or subflow_syn_recv_sock(), but I prefer
> to not introduce only partially related changes here

I just note the above is not a complete fix for issues/192.

Specifically we can have:

syn +  MPC ->
          <- syn + ack + MPC ACK
ack + MPC -> [not received by the server due to packet loss]
ack + MPC + data -> [not received by the server due to packet loss]
		    [this cover data _after_ the MPC + data above]
ack + DSS(DSS > 1) -> 

Reading the RFC, I think the client is allowed to sending the DSS even
if it did not received anything back from the server yet.

When the server receives the DSS packet, it does not have yet the peer
key, so it can't send any kind of MPTCP level ack, unless it guesses
the IDSN from the incoming DSS, which looks unsafe.

Am I missing something?

For net-next, I think we can "fix" (or at least hide) the issue,
forcing the client to avoid sending any data after the MPC+data block
some if such block is at least partially acked (at the MPTCP level).

But I think a different client not respect the above, and still trigger
the issue.

Another option would be ignoring (for fallback's sake) initial incoming
sack packet not covering the MPC-data mapped data and lacking MPTCP
level ack.

I'm unsure if that will be "safe enough" and/or will cover correctly
the scenario where the server is sending data (DSS) before correctly
receving the peer's key. In such case, could the dack block be omitted
due to lack of TCP option space ??!

Any comments more than welcome.

Thanks,

Paolo


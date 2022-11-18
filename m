Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD46E29A1
	for <mptcp@lists.linux.dev>; Fri, 18 Nov 2022 11:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1668769281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yLZ/YW8NEg7wXaBgoLUdzitAMZE3q5IlaQn/PSupRlU=;
	b=OzZUfqcDhOJlvQEqLhNTTDF2pTmA4Zqbg9gZqGxmxq/R6ByLIN6yptr98xiyCgsD21qGQi
	+e9IA+oxSjmUl5oJO2GCqQoFioQXfblMDLb4DSokN94Ghot3YYXagAKw7+VX4eQmY9k8yl
	PCDx+He7o0XK/urwLF9fQKj/a3zsmyo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-147-tspsGuQfOZqDwRpOm6iECw-1; Fri, 18 Nov 2022 06:01:20 -0500
X-MC-Unique: tspsGuQfOZqDwRpOm6iECw-1
Received: by mail-wm1-f71.google.com with SMTP id l32-20020a05600c1d2000b003cfefa531c9so2500852wms.0
        for <mptcp@lists.linux.dev>; Fri, 18 Nov 2022 03:01:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yLZ/YW8NEg7wXaBgoLUdzitAMZE3q5IlaQn/PSupRlU=;
        b=tgitn9JYTIlFlchcd2Jmey7obFiwuU4Xbl1RPIDZZF1I9IMa1dCwysYaMOPW6T5uhe
         CZF7dHGVYMX7KSA+FM5zoZlphdkOptqI+F6D+Zpd3JA01Mm/tBES5OPsr60pWlNcDf1U
         jhcV+p0vWd016O203PP+Kl/2J1mFc/h7nRIEuKNtrBYsZN3NEapY96q44o8UGI7dJ2NU
         QJIr5LhBTOHBl2CzBmN9Fi9HBBpHJvTCc5nYKs3lBYIjxE6IU9W9ZpKt+7DACWhguPvv
         P37NYL5hJI+TlG4OQo+gCrQ5FeAzRKim/vNco4Z01kcPAsKfxQVYOk7iCuYpetv130EO
         wrag==
X-Gm-Message-State: ANoB5pk5nObeEVbGsfGvEcUQAZb1sHbkYjJIR0Cl1sL/4gPql7O/Yalj
	TkUV3lKMQLKIZOClnfImTUT3zqXBeomLcLFzx5H6msrSmpyyu63dIT5CDidZb9cbHya8mAwX8BY
	LrdA94nX0r7HYV4M=
X-Received: by 2002:a05:6000:1cd:b0:241:930d:6abb with SMTP id t13-20020a05600001cd00b00241930d6abbmr4116676wrx.379.1668769279191;
        Fri, 18 Nov 2022 03:01:19 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7OiSbQ0gJXUegT96y66d5ia94PvDTOgd0a/tOgP+gX6Y+Sjiu1Dp3qkzdpa3bcUouvdqCC/A==
X-Received: by 2002:a05:6000:1cd:b0:241:930d:6abb with SMTP id t13-20020a05600001cd00b00241930d6abbmr4116655wrx.379.1668769278979;
        Fri, 18 Nov 2022 03:01:18 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-120-203.dyn.eolo.it. [146.241.120.203])
        by smtp.gmail.com with ESMTPSA id iv7-20020a05600c548700b003cf87623c16sm10158256wmb.4.2022.11.18.03.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 03:01:18 -0800 (PST)
Message-ID: <ad5539166ad1e68fb2c827911f5ed8740dd26943.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: don't orphan ssk in mptcp_close()
From: Paolo Abeni <pabeni@redhat.com>
To: menglong8.dong@gmail.com, mathew.j.martineau@linux.intel.com, 
	matthieu.baerts@tessares.net
Cc: mptcp@lists.linux.dev, Menglong Dong <imagedong@tencent.com>, Biao Jiang
	 <benbjiang@tencent.com>, Mengen Sun <mengensun@tencent.com>
Date: Fri, 18 Nov 2022 12:01:17 +0100
In-Reply-To: <7e47464d0af8c4c0d02cf332bcefafd8f06fb50e.camel@redhat.com>
References: <20221118072030.3500578-1-imagedong@tencent.com>
	 <7e47464d0af8c4c0d02cf332bcefafd8f06fb50e.camel@redhat.com>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Fri, 2022-11-18 at 11:34 +0100, Paolo Abeni wrote:
> As noted by the CI, this fix causes an UaF, as mptcp_close() frees the
> msk->sk_socket struct, which is also referenced by ssk->sk_socket.

I almost forgot: see mptcp_sock_graft()

> Without orphaning the subflows, later tcp code will use ssk->sk_socket,
> causing the reported splat. Note that there is the same risk with ssk-
> > sk_wq.
> 
> Since:
> * all the network code carefully checks for not NULL value of ssk-
> > sk_socket before accessing it
> * access it directly in context where it can't be NULL
> * uses the same policies to access 'sk_wq'
> * it looks like the SOCK_DONE flag can be set independently from the
> sock_orphan()
> 
> I think mptcp_close() could instead directly clearing ssk->sk_socket
> and ssk->sk_wq - just ' = NULL', no sock_orphan() call

To be explicit, I mean something alike:

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8679eafeeca8..0d5109073e44 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2938,7 +2938,11 @@ bool __mptcp_close(struct sock *sk, long timeout)
                if (ssk == msk->first)
                        subflow->fail_tout = 0;
 
-               sock_orphan(ssk);
+               /* detach from the parent socket, but allow data_ready to
+                * push incoming date into the mptcp stack, to properly ack it
+                */
+               ssk->sk_socket = NULL;
+               ssk->sk_wq = NULL;
                unlock_sock_fast(ssk, slow);
        }
        sock_orphan(sk);

Cheers,

Paolo


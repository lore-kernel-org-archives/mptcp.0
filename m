Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5211672
	for <mptcp@lists.linux.dev>; Mon,  3 May 2021 08:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1620031678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1yb1AfLX7LaKikV5SiX4yKFC5XwNT1KRYmq5jmd50gA=;
	b=Ey1R5B9+NlhryEEF2qpKkjdv9L0MMDrNDtSAPd/WigV0dIvE+C3YkNNOIJBeKOSDO5UkJl
	VIV3k7Xtc6xptBpWbGpfRpHiTkxF7bPBtGy8RzIeewXe7ToSIRAmD2r4Mo7qiTdOZWFxKi
	qtzmgqdBqAmng7orO2Sj9ZuP7Nsu3n4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-CWesox_gPkmkd66QDNRNaw-1; Mon, 03 May 2021 04:47:56 -0400
X-MC-Unique: CWesox_gPkmkd66QDNRNaw-1
Received: by mail-wm1-f69.google.com with SMTP id g199-20020a1c9dd00000b02901355dd71edaso2183975wme.7
        for <mptcp@lists.linux.dev>; Mon, 03 May 2021 01:47:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=1yb1AfLX7LaKikV5SiX4yKFC5XwNT1KRYmq5jmd50gA=;
        b=eWXE8linTkuL2vUu9iFmuuNkqveQxJw9u2r9QRBwJE6dClYvSQRi+0tZqpF7jAAFyi
         CPaGX4j8Vfrq5CfhK+u9Mq2yDfZLRZ/lQCZ7N9GBTElOFGCsyS3tP64vvHZg0yWdXyC8
         jLh2u6pisl0zrDghRU+y3GrxIlqxPWazvqVJQl4MfTNmpGiZc6u02x7nykURitR609GG
         EnPzztrtqwo4W8Dkw4+axVodKzH8d+YauGr0bvgHtW7EHFbezZAhEGVihLZOPXv7ZV7v
         1POIvSO6qg2bDhUGT8H2gRHrV38JRj1GjbQWAFMgXcnh7LHQWBo5Bndj6cuWiIM3cEoj
         TpnQ==
X-Gm-Message-State: AOAM530usf9V4Y+tJC8nlwuJuCqAjYLFn9kNcd9Hf2ypr+WiwVl7W4wX
	tXsJdDKkbBuISK21ero101ZPQcGc+IxUhPLuePp8Z8W3bLdQoLsrvmed0vFDxH09lhyZ15AXc9+
	qIi8FqPylVtCtzhk=
X-Received: by 2002:a1c:804a:: with SMTP id b71mr20805939wmd.82.1620031675216;
        Mon, 03 May 2021 01:47:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvq0GNb1XK3tDn6R3IaLyXuAb9AZDAfmwhXp6ojnD6QPLGcHiu2BDyAX6JleP6GKljUruhog==
X-Received: by 2002:a1c:804a:: with SMTP id b71mr20805928wmd.82.1620031675037;
        Mon, 03 May 2021 01:47:55 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-108-140.dyn.eolo.it. [146.241.108.140])
        by smtp.gmail.com with ESMTPSA id j13sm15353537wrd.81.2021.05.03.01.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 01:47:54 -0700 (PDT)
Message-ID: <365dffafa78e2aa0786ff3ca964b74d882a34ab0.camel@redhat.com>
Subject: Re: [PATCH mptcp] mptcp: fix close of larval mptcp sockets
From: pabeni@redhat.com
To: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Date: Mon, 03 May 2021 10:47:53 +0200
In-Reply-To: <20210429120049.8703-1-fw@strlen.de>
References: <20210429120049.8703-1-fw@strlen.de>
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

On Thu, 2021-04-29 at 14:00 +0200, Florian Westphal wrote:
> If userspace exits before calling accept() on a listener that had at
> least one new connection ready, we get:
> 
>   Attempt to release TCP socket in state 8
> 
> This happens because the mptcp socket gets cloned when the TCP
> connection is ready, but the socket is never exposed to userspace.

The above happens if the client additionally sends a DATA_FIN, while
the msk socket is still unaccepted, right? If so I think the fixes tag
should point to the DATA_FIN state machine introduction.

What about something like the following istead ?

Thanks!

Paolo
---
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 15620bafc544..2aa7fc72a99a 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -547,7 +547,7 @@ static void mptcp_sock_destruct(struct sock *sk)
 	 * Both result in warnings from inet_sock_destruct.
 	 */
 
-	if (sk->sk_state == TCP_ESTABLISHED) {
+	if (((1 << sk->sk_state) & (TCPF_ESTABLISHED | TCPF_CLOSE_WAIT)) {
 		sk->sk_state = TCP_CLOSE;
 		WARN_ON_ONCE(sk->sk_socket);
 		sock_orphan(sk);


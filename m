Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212BC168
	for <mptcp@lists.linux.dev>; Tue, 18 Jan 2022 11:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1642503753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mUY2sCl5lvJy1fa2pdnzmeDJtZq5gM1eH1qe0mHOtW4=;
	b=YstSvcIoG4MuFPo/SIAU8Nm08SXGQxPY5s5v17OOAZCY7/4nIMc2c3IhX1bVe+lZ3ZerYg
	dCoioLeYqvKUZDIqHcfvQCiZbpAQOyNEJWk+ibHWGCrpLjAUwpFkn4T92DkieaXapj1iR6
	QdquS8e693eYq5rj2z9glKBKEWMm+xU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-652-EHdcOQnnMxifMxNKXmTU8A-1; Tue, 18 Jan 2022 06:02:31 -0500
X-MC-Unique: EHdcOQnnMxifMxNKXmTU8A-1
Received: by mail-qv1-f70.google.com with SMTP id ke27-20020a056214301b00b004178da03fd5so17979446qvb.17
        for <mptcp@lists.linux.dev>; Tue, 18 Jan 2022 03:02:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=mUY2sCl5lvJy1fa2pdnzmeDJtZq5gM1eH1qe0mHOtW4=;
        b=HZOOkpowj1cYSHkiqqqx0l8hBK4cATI47ON1L6DceL1rpwC4KGRBsd1L3E8V8ZbX6b
         1V6hLgyBTErmXUe1r1PLP529OwGuCUtSYEvyJNjxoCUkgNNMVcKyx3cfKfo5kPKNZyP1
         TWMA0w4LsiZtwz8cNO4hMx7iSn40vcOD1aH5BGrRERkIyTGMUp3EoaAwgB+pu6HpSK26
         dzNEec7fSXHoPz5qq9poSIqhomOvrbXlKrQNJQXweIMtPcAnPqV4VmNnXCfKDNHfI8qn
         xbUT498m3EWcV9jFvVJVIhCavsg7Z2ZSyytm4i+kmmp/zUCtKfL9aYdjyJYL4lb9DUGw
         ViOw==
X-Gm-Message-State: AOAM530v03Y4DPNBRyGH69Hz24+Qg5r4wlo32CX6JCxhKSNu6Zbocp1o
	Pz60LPPnhnqzpx0Sj6n4iMnt3lfQXg5IdsNY3TolkrecnXO58jN2MkIaxnadpqr94iD+hi1Xo7W
	PDvP3GHAfoAuSzNs=
X-Received: by 2002:a37:a955:: with SMTP id s82mr17020318qke.725.1642503750377;
        Tue, 18 Jan 2022 03:02:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzlDgdYoEL8ZghBYGPEAYzkDrQ/elFEyLEcUnO/BFOEkRws0ChCD6SnqpYVnkcSgw5+YHJ6hQ==
X-Received: by 2002:a37:a955:: with SMTP id s82mr17020292qke.725.1642503750040;
        Tue, 18 Jan 2022 03:02:30 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-96-254.dyn.eolo.it. [146.241.96.254])
        by smtp.gmail.com with ESMTPSA id t11sm9955615qkm.77.2022.01.18.03.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 03:02:29 -0800 (PST)
Message-ID: <3f1ec9d12c7903988639689f3a7568a97ce83ef0.camel@redhat.com>
Subject: Re: [PATCH net-next v2] net: mptcp, Fast Open Mechanism
From: Paolo Abeni <pabeni@redhat.com>
To: Dmytro SHYTYI <dmytro@shytyi.net>, mptcp@lists.linux.dev
Date: Tue, 18 Jan 2022 12:02:26 +0100
In-Reply-To: <7d5bdd13-e565-87fd-2854-7f95487d1157@shytyi.net>
References: <20220116001259.203319-1-dmytro@shytyi.net>
	 <449d3338d759e9f72f33e7c37e1b9956bdda77f4.camel@redhat.com>
	 <9f700f12472bddc0d9d899773d2a211bfe8517f6.camel@redhat.com>
	 <7d5bdd13-e565-87fd-2854-7f95487d1157@shytyi.net>
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35)
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

On Mon, 2022-01-17 at 21:48 +0000, Dmytro SHYTYI wrote:
> Hi Paolo,
> 
> AFAIK, TFO option requires more that 8 bytes, if cookie len is 8 bytes:
> 
> In file /net/ipv4/tcp_output.c (line 689):
> 
> static void tcp_options_write(__be32 *ptr, struct tcp_sock *tp,
>                                struct tcp_out_options *opts)
> ....
> {
>          if (unlikely(OPTION_FAST_OPEN_COOKIE & options)) {
>                  struct tcp_fastopen_cookie *foc = opts->fastopen_cookie;
>                  u8 *p = (u8 *)ptr;
>                  u32 len; /* Fast Open option length */
> 
>                  if (foc->exp) {
>                          len = TCPOLEN_EXP_FASTOPEN_BASE + foc->len;
>                          *ptr = htonl((TCPOPT_EXP << 24) | (len << 16) |
>                                       TCPOPT_FASTOPEN_MAGIC);
>                          p += TCPOLEN_EXP_FASTOPEN_BASE;
>                  } else {
>                          len = TCPOLEN_FASTOPEN_BASE + foc->len;
>                          *p++ = TCPOPT_FASTOPEN;
>                          *p++ = len;
>                  }
> 
>                  memcpy(p, foc->val, foc->len);
>                  if ((len & 3) == 2) {
>                          p[foc->len] = TCPOPT_NOP;
>                          p[foc->len + 1] = TCPOPT_NOP;
>                  }
>                  ptr += (len + 3) >> 2;
>          }
> ...
> 
> Here we do have  "len = TCPOLEN_FASTOPEN_BASE + foc->len" that is 
> slightly more than 8 bytes.
> 
> This is the cause of introducing 4 byte cookie for MPTCP implementation.
> 
> The RFC 8684 B.1. says:
>    This is done with the TCP cookie request/response
>     options, of 2 bytes and 6-18 bytes, respectively (depending on the
>     chosen cookie length).
> 
> So in my understanding, the "selected cookie size + 
> TCPOLEN_FASTOPEN_BASE" = 6, is not prohibited by, and in the allowed 
> range of the RFC 8684.

You are right, I underlooked the TFO option writing.

> As you suggested I will document the size of the cookie, if there is no 
> objections to above information :)

Shrinking the TFO cookie size has both security and functional impact:

- we do not want to change the TFO cookie size for TCP connection in
MPTCP enabled build.
- dynamically selecting the TFO cookie size depending on the specific
rsk type will add more complexity to the TCP code.

rfc8684 suggests we could remove the TS option from the synack packet.
I think it's worthy to try such idea.

To do that, we need to change the 'mptcp_synack_options()' hook
signature, to accept a 'struct tcp_out_options' as the 3rd argument, so
that mptcp_synack_options() can clear the TCPOLEN_TSTAMP_ALIGNED bit
when needed.


Thanks

Paolo


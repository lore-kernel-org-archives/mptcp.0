Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9817168
	for <mptcp@lists.linux.dev>; Fri, 25 Jun 2021 10:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1624617205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WZVGmXuW2KNG+R4+x2llZLkxSIgA+OZ/i2LpYC1YnM0=;
	b=VPWe6Sw3nqemxlvDTbRhn25bNWt/LaLiLv0/CTuUQLtMWzbWzgeQhG+f+jsiyTHGreeJ6O
	OtE9nnmnghshYifbuLoaEUMtcWqYmA6QTCpl3oYzWrqC2OaJTha6Jbzi9Z6TW37hbONHlN
	Y6O6bDQGXc0u/nhXI36Lex+fREZB96k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-FlHjw8-mNBKxRtS8tiZSNw-1; Fri, 25 Jun 2021 06:33:24 -0400
X-MC-Unique: FlHjw8-mNBKxRtS8tiZSNw-1
Received: by mail-wm1-f70.google.com with SMTP id h14-20020a05600c350eb02901dfc071c176so2550449wmq.3
        for <mptcp@lists.linux.dev>; Fri, 25 Jun 2021 03:33:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=WZVGmXuW2KNG+R4+x2llZLkxSIgA+OZ/i2LpYC1YnM0=;
        b=D6qJW2PAQS8U0GE/xrd03j2RfU0kcU/8lDdzWHkIdUIODGA1KWFfVOG4Ck0BN3xZbd
         dfga56LwVtCPlGdSqpZ4uweLJaTELn+5UoBg8h8qkyGfZhZrEL9YQ8sSQ0rrNjvmqMMa
         eVt3ofegdWfM3h4T+biwuL2cbRo8pqG9YmUUtHqvrZkC339ibvCyeGTSc4KZGlMBcMmH
         ZszdfjMGYWZLfKUadgQJhwxp9r9gTnnLHA/E85fP/RZhjIPxL0IlGJIvN6bZQ2A7SlIz
         i+ggbDTMXaRmqB60FeqJkVETldE3WujTky5RAlEqpRoef+Pd7GVoo5FqfaeCpUhZdSzB
         D7Mg==
X-Gm-Message-State: AOAM533d2n4ZRgNGiHdrvAiYJ2e3EhLrxs8PZn4GWj+57AVtJfPNPhMV
	S/yu55GFSC53lCWuyfXY71P/KT+qaSXVlsQKjilfoN4KPLfbxTtKgPsBe819onG0/CF8sQvjBP0
	EnrpUzmz70DBi2WA=
X-Received: by 2002:a5d:6848:: with SMTP id o8mr10368808wrw.352.1624617203334;
        Fri, 25 Jun 2021 03:33:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwk/oPcgpUW4Jl5slWT4C5oP8S1h9z8+gP3X/4aYQLTwp+7LjYrjlQX6I6r6zv+wWDoI1iOww==
X-Received: by 2002:a5d:6848:: with SMTP id o8mr10368792wrw.352.1624617203149;
        Fri, 25 Jun 2021 03:33:23 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-109-224.dyn.eolo.it. [146.241.109.224])
        by smtp.gmail.com with ESMTPSA id d4sm5455082wmd.42.2021.06.25.03.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 03:33:22 -0700 (PDT)
Message-ID: <fb05428dee8741ad8136966b0851dc8e9cf47aa4.camel@redhat.com>
Subject: Re: [bug report] mptcp: refine mptcp_cleanup_rbuf
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, Dan Carpenter
	 <dan.carpenter@oracle.com>
Cc: mptcp@lists.linux.dev
Date: Fri, 25 Jun 2021 12:33:22 +0200
In-Reply-To: <0ed6875f-f88a-ae2f-c568-0cc81467c4ec@tessares.net>
References: <YNWTLmF3Cne09pTT@mwanda>
	 <0ed6875f-f88a-ae2f-c568-0cc81467c4ec@tessares.net>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
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

Hello,

On Fri, 2021-06-25 at 10:47 +0200, Matthieu Baerts wrote:
> Thank you for the good bug report (as always)!
> 
> On 25/06/2021 10:26, Dan Carpenter wrote:
> > The patch fde56eea01f9: "mptcp: refine mptcp_cleanup_rbuf" from Jun
> > 22, 2021, leads to the following static checker warning:
> > 
> > 	net/mptcp/protocol.c:464 mptcp_subflow_could_cleanup()
> > 	warn: masking a bool
> > 
> > net/mptcp/protocol.c
> >    455  static bool mptcp_subflow_could_cleanup(const struct sock *ssk, bool rx_empty)
> >    456  {
> >    457          const struct inet_connection_sock *icsk = inet_csk(ssk);
> >    458          bool ack_pending = READ_ONCE(icsk->icsk_ack.pending);
> >                 ^^^^^^^^^^^^^^^^
> 
> It should be a u8 I presume, no reason to use a boolean here:
> 
> ---------- 8< ----------
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> 
> index ddce5b7bbefd..199a36fe4f69 100644
> 
> --- a/net/mptcp/protocol.c
> 
> +++ b/net/mptcp/protocol.c
> 
> @@ -455,7 +455,7 @@ static void mptcp_subflow_cleanup_rbuf(struct sock *ssk)
> 
>  static bool mptcp_subflow_could_cleanup(const struct sock *ssk, bool
> rx_empty)
> 
>  {
> 
>         const struct inet_connection_sock *icsk = inet_csk(ssk);
> 
> -       bool ack_pending = READ_ONCE(icsk->icsk_ack.pending);
> 
> +       u8 ack_pending = READ_ONCE(icsk->icsk_ack.pending);
> 
>         const struct tcp_sock *tp = tcp_sk(ssk);
> 
> 
> 
>         return (ack_pending & ICSK_ACK_SCHED) &&
> 
> 
> ---------- 8< ----------

Thanks for the report! 

Yes, 'bool' usage is wrong (blame on me!), changing it to u8 should
fix.

@Mat: can you please go ahead with the patch?

Thanks!

/P


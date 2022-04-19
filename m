Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C18AED4
	for <mptcp@lists.linux.dev>; Tue, 19 Apr 2022 10:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1650364955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VV+4D411zsEYcqtEjgCVjs88j0hpM4gmVBZq+INKYbM=;
	b=HwWQN0fAoUfjc89oJFmQOya2v1b7CRHafo8pyKBrTSvwj9SLQfNwfJrZeBtQ2n8T1efYIP
	sOU4NMsJquVOdRa1nhJk7FfLkcZUsc32gcU9+bS9SaWQIhVzgrYm0oPhpaV0Euja/RD6im
	YEN3WEd7FVZtK6CjhyAn/S/PIab9Yc4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-65-ETLlJfU4PYS8TSFnKiUesg-1; Tue, 19 Apr 2022 06:42:34 -0400
X-MC-Unique: ETLlJfU4PYS8TSFnKiUesg-1
Received: by mail-wm1-f71.google.com with SMTP id c62-20020a1c3541000000b0038ec265155fso1126219wma.6
        for <mptcp@lists.linux.dev>; Tue, 19 Apr 2022 03:42:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=VV+4D411zsEYcqtEjgCVjs88j0hpM4gmVBZq+INKYbM=;
        b=DVtLoTWtJ1wfT0WnGMIQdjrGRvibgBM00kBQykXiI5rReaUUbntBhbMTk9JkNlI5dL
         PlkDuVjs6pvO4o4TDwsm6efsZKTIkfz01rRqa1iR/dFP1+T2wt30pcWDNaHG4r5SnQ5V
         EnO/rDmRIXdMEmOHF089IIZyoVjYug5kLghbUOToCSsDgqW5vZH0IGcu/TWaltAFhD9o
         QWBSyqZOXzZ4EcaS0YI9H11ienhfXoCq0+S46OsecOc4+7+iwOfDhC8JbUdeBV/hx3/J
         jhaX07dDZMHIbi+qOwhgDAw2E1EvSR/APjk0t8518q3dT2X6BsadzfX740adaLl6eNWK
         C2Xg==
X-Gm-Message-State: AOAM532FlGxdOtoL6rOC08CHShYp8xOcdZAXbEejT2FRa1/VjQHmMXGT
	QzljYB33s/ZtV0PwIVPwikC2I6C6eo0JhqxIst61YJvileVmOtSeWoQwYD/gY5gEYtmcaUKrmy+
	rJSh8BbGs/JL+XZY=
X-Received: by 2002:a05:6000:1a8b:b0:20a:aaf7:75e8 with SMTP id f11-20020a0560001a8b00b0020aaaf775e8mr311925wry.66.1650364953500;
        Tue, 19 Apr 2022 03:42:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydPiOrJ42vupcwVoYc9dr56tR7UqG35rjJE38v1EANc0bjmvhRSk5JCxrpj6X3QEdMbxJNJA==
X-Received: by 2002:a05:6000:1a8b:b0:20a:aaf7:75e8 with SMTP id f11-20020a0560001a8b00b0020aaaf775e8mr311914wry.66.1650364953291;
        Tue, 19 Apr 2022 03:42:33 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-96-237.dyn.eolo.it. [146.241.96.237])
        by smtp.gmail.com with ESMTPSA id k63-20020a1ca142000000b0038ff2c38e85sm15726376wme.39.2022.04.19.03.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 03:42:33 -0700 (PDT)
Message-ID: <ac9a7c902a51f152abcf0d9d4aeeef606e4eeaf3.camel@redhat.com>
Subject: Re: [PATCH net-next 3/5] tcp: allow MPTCP to update the announced
 window.
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Tue, 19 Apr 2022 12:42:31 +0200
In-Reply-To: <5ec4e9a-e1f5-c698-bdf5-fd7fabc7374@linux.intel.com>
References: <cover.1650034062.git.pabeni@redhat.com>
	 <89b12b9c11c6b35fc507f96d198719394caf6b08.1650034062.git.pabeni@redhat.com>
	 <5ec4e9a-e1f5-c698-bdf5-fd7fabc7374@linux.intel.com>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
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

On Mon, 2022-04-18 at 17:11 -0700, Mat Martineau wrote:
> On Fri, 15 Apr 2022, Paolo Abeni wrote:
> 
> > The MPTCP RFC requires that the MPTCP-level receive window's
> > right edge never moves backward. Currently the MPTCP code
> > enforces such constraint while tracking the right edge, but it
> > does not reflects it back on the wire, as lacks a suitable hook
> > to update accordingly the TCP header.
> > 
> > This change modifiy the existing mptcp_write_options() hook,
> > providing the current packet's TCP header up to the MPTCP protocol
> > level, so that the next patch could implement the above mentioned
> > constraint.
> > 
> > No functional changes intended.
> > 
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > include/net/mptcp.h   |  2 +-
> > net/ipv4/tcp_output.c | 13 +++++++------
> > net/mptcp/options.c   |  2 +-
> > 3 files changed, 9 insertions(+), 8 deletions(-)
> > 
> > diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> > index 877077b53200..6b07011c060d 100644
> > --- a/include/net/mptcp.h
> > +++ b/include/net/mptcp.h
> > @@ -125,7 +125,7 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
> > 			       struct mptcp_out_options *opts);
> > bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb);
> > 
> > -void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
> > +void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
> > 			 struct mptcp_out_options *opts);
> > 
> > void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info);
> > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > index c221f3bce975..27deec41a1f4 100644
> > --- a/net/ipv4/tcp_output.c
> > +++ b/net/ipv4/tcp_output.c
> > @@ -444,12 +444,13 @@ struct tcp_out_options {
> > 	struct mptcp_out_options mptcp;
> > };
> > 
> > -static void mptcp_options_write(__be32 *ptr, const struct tcp_sock *tp,
> > +static void mptcp_options_write(struct tcphdr *th, __be32 *ptr,
> > +				struct tcp_sock *tp,
> > 				struct tcp_out_options *opts)
> > {
> > #if IS_ENABLED(CONFIG_MPTCP)
> > 	if (unlikely(OPTION_MPTCP & opts->options))
> > -		mptcp_write_options(ptr, tp, &opts->mptcp);
> > +		mptcp_write_options(th, ptr, tp, &opts->mptcp);
> > #endif
> > }
> > 
> > @@ -605,7 +606,7 @@ static void bpf_skops_write_hdr_opt(struct sock *sk, struct sk_buff *skb,
> >  * At least SACK_PERM as the first option is known to lead to a disaster
> >  * (but it may well be that other scenarios fail similarly).
> >  */
> > -static void tcp_options_write(__be32 *ptr, struct tcp_sock *tp,
> > +static void tcp_options_write(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
> > 			      struct tcp_out_options *opts)
> 
> Having both th and ptr seems redundant to my eyes. I'd rather just have a 
> th parameter and move the "ptr = (__be32 *)(th + 1);" code inside 
> tcp_options_write().
> 
> If you're thinking/hoping that Eric finds the additional parameter more 
> acceptible, we can go with this patch as-is.

Yep, the main concerns here is obtaining the buy-in from Eric. I hoped
that less differences would help, but likely the code you suggested is
better. I'll send an RFC on netdev with this and the next patch to get
some direct feedback from him.

Thanks!

Paolo


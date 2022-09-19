Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF19E4A1F
	for <mptcp@lists.linux.dev>; Mon, 19 Sep 2022 11:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1663586796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fnecXAQ9cqfJpN0AgJnBN04FqEor6j1U7izV8VzDqAU=;
	b=QDNSa+zOZm9+TrQZtBa/gtea79yjeKsdbuz2vl7bkr54zsuKuVhXUVgWtDHIlzL4tSPbM+
	uplHWADyhV5PXUcJwnHuuCHYTSq48aTJrBg6Yw52o2qvc81O77u0Crm01+XXHddIzPZIhb
	UrVMGuZM7UQxKaooReXUtQod3TqTW48=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-34-lfsDuKwLO0KvgxwfE6mGkQ-1; Mon, 19 Sep 2022 07:26:35 -0400
X-MC-Unique: lfsDuKwLO0KvgxwfE6mGkQ-1
Received: by mail-wm1-f69.google.com with SMTP id i129-20020a1c3b87000000b003b33e6160bdso4517652wma.7
        for <mptcp@lists.linux.dev>; Mon, 19 Sep 2022 04:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date;
        bh=fnecXAQ9cqfJpN0AgJnBN04FqEor6j1U7izV8VzDqAU=;
        b=2zoh0s3TYBNqVRM4h9+s94Yv0gmcu/v1BQ+JwZjwm9x+Od7qT9jShZHNSgs0zszaLE
         NhVY08kyTRd9QcyhO+EOUFdSfhvOTTaIQViAyKsd7g18vNJ2WKPvg9XBFkK9JopF95nF
         KTOSdii3dkEkSUsGt4CyDluIBiogO4EDIAvWitFpgcGTvet+JtvCeDWb3n4Vx7f7GU2G
         qZy49bRDIjax1w+1FaVu9CDyBGVHHPsQIIMOVTJI1wJYsYs202ZSaOV488SsVj6Noe1e
         wu7LHzpZYlylJwDIgX2GU7BoJbY4swq9KzOlWJjfsvMXmXVnQGLkcK/W/GYaTArPGq8a
         48qw==
X-Gm-Message-State: ACrzQf3QQImdC39/6zDNaZV+6078OOEiMARsnf+tdsqWC6VXMAfLXgMS
	N2GOLQr6WMJLmTemp3lIJTFFwe2jcbBbc0fNHLVk7e6cD90RA0qbML2Mk5Cm03OrRAflv0PPvK+
	E2MM1Tb6BdOe1iTE=
X-Received: by 2002:a05:600c:2608:b0:3b4:8dac:342a with SMTP id h8-20020a05600c260800b003b48dac342amr11609480wma.102.1663586794186;
        Mon, 19 Sep 2022 04:26:34 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6N9OovSt+P8KTARD6ffniFb4FqINGSfGVua5YBG68mKlU7JS27AVUPtOMAb96Ldng6fhFHlQ==
X-Received: by 2002:a05:600c:2608:b0:3b4:8dac:342a with SMTP id h8-20020a05600c260800b003b48dac342amr11609462wma.102.1663586793928;
        Mon, 19 Sep 2022 04:26:33 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-114-90.dyn.eolo.it. [146.241.114.90])
        by smtp.gmail.com with ESMTPSA id l7-20020adffe87000000b00228da396f9dsm13322267wrr.84.2022.09.19.04.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 04:26:33 -0700 (PDT)
Message-ID: <d2dbb643e29250730a2610986cde88c188986c3b.camel@redhat.com>
Subject: Re: [RFC PATCH mptcp-next v7 07/11] mptfo variables for msk,
 options. Fix loop retrans
From: Paolo Abeni <pabeni@redhat.com>
To: Dmytro Shytyi <dmytro@shytyi.net>, mptcp@lists.linux.dev, Christoph
 Paasch <cpaasch@apple.com>
Date: Mon, 19 Sep 2022 13:26:32 +0200
In-Reply-To: <be427fe3457391b7b50af213c255d8fd1f3703c7.camel@redhat.com>
References: <20220917222853.2406-1-dmytro@shytyi.net>
	 <20220917222853.2406-8-dmytro@shytyi.net>
	 <be427fe3457391b7b50af213c255d8fd1f3703c7.camel@redhat.com>
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
Content-Transfer-Encoding: 7bit

On Mon, 2022-09-19 at 13:11 +0200, Paolo Abeni wrote:
> On Sun, 2022-09-18 at 00:28 +0200, Dmytro Shytyi wrote:
> > Introduce mptfo variables for msk and options.
> > Also fixe the infinite retransmissions in the end of second session.
> > Suggestion @palbeni (SEP 1) during the meting to 'look at ack'
> > 
> > Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
> > ---
> >  net/mptcp/fastopen.c | 16 ++++++++++++++++
> >  net/mptcp/options.c  |  3 +++
> >  net/mptcp/protocol.h |  6 +++++-
> >  3 files changed, 24 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
> > index 436e773d798a..149a4b1d3dac 100644
> > --- a/net/mptcp/fastopen.c
> > +++ b/net/mptcp/fastopen.c
> > @@ -91,3 +91,19 @@ int mptcp_setsockopt_sol_tcp_fastopen(struct mptcp_sock *msk, sockptr_t optval,
> >  
> >  	return ret;
> >  }
> > +
> > +void mptcp_treat_hshake_ack_fastopen(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
> > +				     struct mptcp_options_received mp_opt)
> > +{
> > +	u64 ack_seq;
> > +
> > +	if (mp_opt.suboptions & OPTIONS_MPTCP_MPC && mp_opt.is_mptfo && msk->is_mptfo) {
> > +		msk->can_ack = true;
> > +		msk->remote_key = mp_opt.sndr_key;
> > +		mptcp_crypto_key_sha(msk->remote_key, NULL, &ack_seq);
> > +		ack_seq++;
> > +		WRITE_ONCE(msk->ack_seq, ack_seq);
> > +		pr_debug("ack_seq=%llu sndr_key=%llu", msk->ack_seq, mp_opt.sndr_key);
> > +		atomic64_set(&msk->rcv_wnd_sent, ack_seq);
> 
> It's not clear to me why the above is needed. According to the RFC we
> should not do additional MPTCP-level key management for TFO' sake ?!?

Addendum: instead here you likely want to setup-up a special DSS
mapping for the TFO data. Such mapping will additionally require some
special handling in  __mptcp_move_skb(), as 'msk->ack_seq' must not be
incremented by the in-sequence TFO data.

@Christoph: AFAICS, even with TFO, the initiator nor the listener can't
send any other data after the syn until the MPC handshake is completed.
Is that correct?

Thanks!

Paolo


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8A372
	for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 10:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1627294020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V6axBv047E6KcRgiAHwowPlUv2xHBOdsNbLEg3Ws6fE=;
	b=gz64G0M8IvqCTAi3JvuI4ObsG4jUUI7PtkKJ/BiSYYiVpjSBP5DO2V9hOv5Y14SHQS69Ag
	9dKMY2+qgSWZe/Rpo9TEDHOcolnSSDPm0kwgMCWEP2OmSapv3bg+VqpFDz5Lc1DVqRRm/P
	W6z4UYmTvW6Rvl6tlMNR6lXULe1ZNOo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-Kaa8AJXxMs2-HWrhwOy3sw-1; Mon, 26 Jul 2021 06:06:58 -0400
X-MC-Unique: Kaa8AJXxMs2-HWrhwOy3sw-1
Received: by mail-wr1-f70.google.com with SMTP id d14-20020adfe2ce0000b029013a357d7bdcso4505760wrj.18
        for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 03:06:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=V6axBv047E6KcRgiAHwowPlUv2xHBOdsNbLEg3Ws6fE=;
        b=WE7320sAO0GzSS9vSwg3RydGHBDlDY/dvxLBYw62t+Fu1BEFQ8z73gmRb7TbA1AmlW
         ePkVK8KhjWIaQDQHthKzd852Y9sIYBLTBo6nwulQY4xr5ZDtTRh2dUbT2F53Kr0l7Q6c
         dbpbsbHAPmd/weXOM1ATmHAL6Ur1341PNh4ycR2fC4nae96ZQI3S7M9mYYtlKy97/KtA
         9s+j1H+aJv12KFd4Vq943PubE+Sk3rmQTW1sJFDRiYfAMWr4uaBdgDNsIz5ZziIIOReo
         Uu+jbzV3mPY0Fg0YdKhTruhuzXX6NFDqoG9UITX7FdyaOni4cFmrEpzL0eOcg+DwkPE4
         ZnEw==
X-Gm-Message-State: AOAM533P+vFpbvwG4Gesy0Rb3ZV5nByNVsaEjdDCu3/0bJO4hzQidgH+
	cfGDfF5EZXo50GAA4Bs1xFQ6yeNV63ve919ApnKDf2txOs4oFwstHHX3u8cfFgCmA16ZgC+5FZ9
	ldxIs+uyysN7UqEE=
X-Received: by 2002:a05:600c:649:: with SMTP id p9mr26182277wmm.151.1627294017549;
        Mon, 26 Jul 2021 03:06:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwm07pR4oHp35OeQ9SnR30xdpN64UhgmcAKHqWBvq6zqlEZTwD05+Sy38Sep/1m28OBHGmK3Q==
X-Received: by 2002:a05:600c:649:: with SMTP id p9mr26182260wmm.151.1627294017337;
        Mon, 26 Jul 2021 03:06:57 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-97-57.dyn.eolo.it. [146.241.97.57])
        by smtp.gmail.com with ESMTPSA id q17sm6744578wre.3.2021.07.26.03.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 03:06:56 -0700 (PDT)
Message-ID: <fa45051b3d450d2ec7445b1cf1d7e20bbfcfa28a.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 1/2] mptcp: optimize out option generation
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>
Cc: mptcp@lists.linux.dev
Date: Mon, 26 Jul 2021 12:06:55 +0200
In-Reply-To: <CA+WQbwsKBpXVVqDX32EDROX8kjo1efcgoPd10kDOt9hCHHNvdA@mail.gmail.com>
References: <cover.1627059686.git.pabeni@redhat.com>
	 <b886e46981b5f02c726f92655fabd054f4dc9217.1627059686.git.pabeni@redhat.com>
	 <CA+WQbwsKBpXVVqDX32EDROX8kjo1efcgoPd10kDOt9hCHHNvdA@mail.gmail.com>
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
Content-Transfer-Encoding: 8bit

On Mon, 2021-07-26 at 11:21 +0800, Geliang Tang wrote:
> Hi Paolo,
> 
> Thanks for this patchset, and I have some small comments.
> 
> Paolo Abeni <pabeni@redhat.com> 于2021年7月24日周六 上午1:06写道：
> > Currently we have several protocol contraint on MPTCP option
> > generation (e.g. MPC and MPJ subopt are mutually exclusive)
> > and some additionall ones required by our implementation
> > (e.g. almost all ADD_ADDR variant are mutually exclusive with
> > everything else).
> > 
> > We can leverage the above to optimize the out option generation:
> > we check DSS/MPC/MPJ presencence in a mutually exclusive way,
> > avoiding many unneeded conditionals in the common case.
> > 
> > Additionally extend the existing constraint on ADD_ADDR opt on
> > all subvariant, so that it become fully mutually exclusive with
> > the above and we can skip another conditional statement the common
> > case.
> > 
> > This change is also need by the next patch.
> > 
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > --
> > side node: we could probably optimize the conditionals in
> > mptcp_established_options()
> > ---
> >  net/mptcp/options.c  | 225 ++++++++++++++++++++++---------------------
> >  net/mptcp/pm.c       |   9 +-
> >  net/mptcp/protocol.h |   1 +
> >  3 files changed, 122 insertions(+), 113 deletions(-)
> > 
> > diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> > index eafdb9408f3a..38f324667761 100644
> > --- a/net/mptcp/options.c
> > +++ b/net/mptcp/options.c
> > @@ -592,6 +592,7 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
> >                 dss_size = map_size;
> >                 if (skb && snd_data_fin_enable)
> >                         mptcp_write_data_fin(subflow, skb, &opts->ext_copy);
> > +               opts->suboptions = OPTION_MPTCP_DSS;
> >                 ret = true;
> >         }
> > 
> > @@ -615,6 +616,7 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
> >                 opts->ext_copy.ack64 = 0;
> >         }
> >         opts->ext_copy.use_ack = 1;
> > +       opts->suboptions = OPTION_MPTCP_DSS;
> >         WRITE_ONCE(msk->old_wspace, __mptcp_space((struct sock *)msk));
> > 
> >         /* Add kind/length/subtype/flag overhead if mapping is not populated */
> > @@ -663,9 +665,9 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
> 
> I think no need to modify the code in mptcp_established_options_add_addr.

Uhmmm... I just noted with need an additional change in there: avoid
clearing 'ext_copy'.

/P


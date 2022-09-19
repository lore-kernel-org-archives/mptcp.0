Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8515C92
	for <mptcp@lists.linux.dev>; Mon, 19 Sep 2022 14:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1663596161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kLSW7js+GHhq3pvtlQbHITZcLyoHvsydFeVQYomLEnc=;
	b=AhAhAk+ie3WTyrE30jG1vtbHrm27OfmzZd+lJ6ZY7jtFsurXa1rm2fbwMalkE0fFUpCczd
	UtDPhBLDkCY39cqvdHqQRaaul67rCs3XXNFrD/3EEdIfdwkhZT9BzqoRyk6Hy3yM0JkKIy
	fXZBhbotftHQPEj9F5euaIKXa4HK2as=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-611-hO8j9pkGMz2UtJHSeE1QMw-1; Mon, 19 Sep 2022 10:02:39 -0400
X-MC-Unique: hO8j9pkGMz2UtJHSeE1QMw-1
Received: by mail-wm1-f71.google.com with SMTP id o25-20020a05600c339900b003b2973dab88so15215373wmp.6
        for <mptcp@lists.linux.dev>; Mon, 19 Sep 2022 07:02:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=kLSW7js+GHhq3pvtlQbHITZcLyoHvsydFeVQYomLEnc=;
        b=Y5bRh/SgY61X38HS4+rkXwphscq9Zh/b2dfCeI3sMc/fv0ieGVYVn66wtChWE53kcV
         YSN22MY1eujZML9u7C4MwSsU38OHGdzv3080/nSeHr4AfWoYNsounleXnEkNb8d8frng
         g+K5yQV3o+a+4L16gyTljbqgJgHgOnVD+dh2rfcR8bTwWzmT9V+y38GYQ5fTXjCejamR
         Te3Rz3kElEnP+2pI31G8j6MlIBXr5VBuHemZU33VQYGKce4j3smeUd1+k4W9dlY5C+A9
         YNz76pxquKVEjeykWRO+oXULvWfPiyk3rrdSPB+8a38eb3ASaMTiSrc7peozax13H5tV
         IWyQ==
X-Gm-Message-State: ACrzQf0d7fBLThOQc8XsFYY+f6Ex4fTLcawXjNc0LakztDb3uxpXuVXk
	rh5LUo/ZGpiULkG0i6QIwcu8e8IVyegTQi4ECUkYYE1zpghCy7ZkbOR6G169GXahVORTH2r57hV
	SdrexONuDb7LSKkI=
X-Received: by 2002:adf:fb10:0:b0:22a:f1d8:18d2 with SMTP id c16-20020adffb10000000b0022af1d818d2mr6579207wrr.483.1663596158570;
        Mon, 19 Sep 2022 07:02:38 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7/1f5vJPaV3S6uWnZVmvqjrbAGlVbVXKtdNaZAolq0ZYLoEkl5fMPLpUIXjde8GRRRmrMiJg==
X-Received: by 2002:adf:fb10:0:b0:22a:f1d8:18d2 with SMTP id c16-20020adffb10000000b0022af1d818d2mr6579172wrr.483.1663596158256;
        Mon, 19 Sep 2022 07:02:38 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-114-90.dyn.eolo.it. [146.241.114.90])
        by smtp.gmail.com with ESMTPSA id y1-20020adfdf01000000b0022a297950cesm14013635wrl.23.2022.09.19.07.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 07:02:37 -0700 (PDT)
Message-ID: <e9876aae93db906138bd090b821c7a5e5554eeae.camel@redhat.com>
Subject: Re: [RFC PATCH mptcp-next v7 08/11] Fix unxpctd val of
 subflow->map_seq(dscrd packet)
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, Dmytro Shytyi
	 <dmytro@shytyi.net>
Cc: mptcp@lists.linux.dev, Benjamin Hesmans <benjamin.hesmans@tessares.net>
Date: Mon, 19 Sep 2022 16:02:36 +0200
In-Reply-To: <48aa48fa-85a7-b391-7095-204efbb63f97@tessares.net>
References: <20220917222853.2406-1-dmytro@shytyi.net>
	 <20220917222853.2406-9-dmytro@shytyi.net>
	 <b83883829f7a8730207223178841f330617a72e4.camel@redhat.com>
	 <48aa48fa-85a7-b391-7095-204efbb63f97@tessares.net>
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

On Mon, 2022-09-19 at 13:31 +0200, Matthieu Baerts wrote:
> Hi Paolo, Dmytro,
> 
> On 19/09/2022 13:27, Paolo Abeni wrote:
> > On Sun, 2022-09-18 at 00:28 +0200, Dmytro Shytyi wrote:
> > > Fix unexpected value of subflow->map_seq (discarded and after
> > > retransmitted 2nd packet)
> > > 
> > > Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
> > > ---
> > >  net/mptcp/subflow.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > > index c7d49fb6e7bd..075c61d1d37f 100644
> > > --- a/net/mptcp/subflow.c
> > > +++ b/net/mptcp/subflow.c
> > > @@ -1077,8 +1077,10 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
> > >  		/* will validate the next map after consuming the current one */
> > >  		goto validate_csum;
> > >  	}
> > > -
> > > -	subflow->map_seq = map_seq;
> > > +	if (msk->is_mptfo)
> > > +		subflow->map_seq = READ_ONCE(msk->ack_seq);
> > > +	else
> > > +		subflow->map_seq = map_seq;
> > >  	subflow->map_subflow_seq = mpext->subflow_seq;
> > >  	subflow->map_data_len = data_len;
> > >  	subflow->map_valid = 1;
> > 
> > 
> > This is likely not needed, if you build a special dss mapping at
> > incoming option processing time.
> 
> Also for this, Benjamin had another approach by delaying MPTCP data_ack
> calculation, see from patch 5/10 from [1]. It might be good to discuss
> about that at the next weekly meeting.

I think that later approach is better. Apropos, regarding the question
raised in patch 6/10 in such series - where to hook for late ack_seq
initialization - I think we could:

- add a 'remote_key_avail' bit in mptcp_subflow_context
- in mptcp_incoming_options(), for MPC_ACK pkts, copy mp_opt->sndr_key
in subflow->remote_key and set  'remote_key_avail'
- in subflow_state_change() when changing to TCP_ESTABLISHED && this is
a TFO passive socket (-> prev state == TCP_SYN_RECV), remote_key_avail
is true, and can_ack == false, do the late ack_seq initialization.

Note that the last quite convoluted condition should catch the
sk->sk_state_change(sk) invocation in tcp_rcv_state_process() for TFO
sockets.

Cheers,

Paolo


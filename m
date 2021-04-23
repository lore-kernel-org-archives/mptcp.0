Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D8671
	for <mptcp@lists.linux.dev>; Fri, 23 Apr 2021 08:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1619168189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HTBz7KD1kAs3ekSo5OLhTTK+1mVTixF4pC+L8Q9knq8=;
	b=XOcDxhBOqzZUdbpILwlJPzzUvU7PUu6gW9QY3DUqfmorm95RgPwD2sy9eNCKaeBD65L6XN
	8ok4vigxKZdHH2LMC5tf1JA780fXhLGObaN7gZu1gX2cdgETsAnDNuYO+bSEcUBIQD8Wbx
	vGwUAIFm1Qtgx0R43nqVFNysKIof0HI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-rcaWPTBtPQ2wFhJws60RsQ-1; Fri, 23 Apr 2021 04:56:27 -0400
X-MC-Unique: rcaWPTBtPQ2wFhJws60RsQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D449283DD23;
	Fri, 23 Apr 2021 08:56:26 +0000 (UTC)
Received: from ovpn-115-60.ams2.redhat.com (ovpn-115-60.ams2.redhat.com [10.36.115.60])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E35C95C3FD;
	Fri, 23 Apr 2021 08:56:25 +0000 (UTC)
Message-ID: <a4b7016cbdc0897eb89433e57cc8991ef4210ad4.camel@redhat.com>
Subject: Re: [PATCH v3 mptcp-next 08/21] Squash-to "mptcp: send out checksum
 for DSS"
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>
Cc: mptcp@lists.linux.dev
Date: Fri, 23 Apr 2021 10:56:24 +0200
In-Reply-To: <CA+WQbwtYA1khkXRZfiCEeTXGDASg+yTv0_S-dwHXVqW9YUApFQ@mail.gmail.com>
References: <cover.1619035356.git.pabeni@redhat.com>
	 <dc70316d43c4344da0e78616d9a9f23640e22c78.1619035356.git.pabeni@redhat.com>
	 <CA+WQbwtYA1khkXRZfiCEeTXGDASg+yTv0_S-dwHXVqW9YUApFQ@mail.gmail.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Fri, 2021-04-23 at 11:41 +0800, Geliang Tang wrote:
> Hi Paolo,
> 
> Paolo Abeni <pabeni@redhat.com> 于2021年4月22日周四 上午4:21写道：
> > Account for csum len in mptcp_established_options_dss()
> > 
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> >  net/mptcp/options.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> > 
> > diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> > index 01caff4cdd25..f8430415a954 100644
> > --- a/net/mptcp/options.c
> > +++ b/net/mptcp/options.c
> > @@ -553,15 +553,17 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
> >         mpext = skb ? mptcp_get_ext(skb) : NULL;
> > 
> >         if (!skb || (mpext && mpext->use_map) || snd_data_fin_enable) {
> > -               unsigned int map_size;
> > +               unsigned int map_size = TCPOLEN_MPTCP_DSS_BASE + TCPOLEN_MPTCP_DSS_MAP64;
> > 
> > -               map_size = TCPOLEN_MPTCP_DSS_BASE + TCPOLEN_MPTCP_DSS_MAP64;
> 
> I want to keep these lines unchanged.

Uhm... I like the new form more ;)
> 
> > +               if (mpext) {
> > +                       if (READ_ONCE(msk->csum_enabled))
> 
> I want to use 'if (opts->csum_reqd)' here instead.

Agreed.

> 
> > +                               map_size += TCPOLEN_MPTCP_DSS_CHECKSUM;
> > 
> > -               remaining -= map_size;
> > -               dss_size = map_size;
> > -               if (mpext)
> >                         opts->ext_copy = *mpext;
> > +               }
> > 
> > +               dss_size = map_size;
> > +               remaining -= map_size;
> 
> And change these two lines as the original order:
> 
>                remaining -= map_size;
>                dss_size = map_size;
> 
> WDYT?

Agreed.

/P


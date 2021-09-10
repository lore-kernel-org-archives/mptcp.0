Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BA43FC3
	for <mptcp@lists.linux.dev>; Fri, 10 Sep 2021 15:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1631287409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XetJ9uX73d5bYqKpKUhEEg03VDWAxTZ1q8cIcgeDMiY=;
	b=HkA4YXSRazBpPuk0+X3OQMpwbojg6Sky6YoQvJeoR2JuSAbXV8Iz6+v/SlMghwmYkvUiKG
	IJ/+tsb8pgVx34Wxvt1WF/vkeTOWD7PuWFcgwgMuqY79tEQsFTfd61bO6h5qyW364sYZnX
	b24rJBvllEOfaHvuiZsa99fGP3XRusc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-hiXxYlacO86L4QULswSG_A-1; Fri, 10 Sep 2021 11:23:28 -0400
X-MC-Unique: hiXxYlacO86L4QULswSG_A-1
Received: by mail-wr1-f71.google.com with SMTP id a27-20020a5d457b000000b0015b11fccc5eso644637wrc.10
        for <mptcp@lists.linux.dev>; Fri, 10 Sep 2021 08:23:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=XetJ9uX73d5bYqKpKUhEEg03VDWAxTZ1q8cIcgeDMiY=;
        b=4fFV4ph+OB+ONLp8vol3ZBeRZZJPNaIpLmYbsFTtRUDVpPbgyCKmVhGsmkSmibZofk
         jJERgTkKfM+UX4ugygtu8vGd2zjdk8Gln/HnokviJu6kdjbTOugIduipI17zlXpMY0ua
         3p49/U8bhFvUCK1Hx7HfOTvyRiCs5QL2F4lDzoxtFews2Y+fwAWDevE+fNE7GjbZTSLK
         NijKOllk+LnzJuZEDJwJfbpjWaz0MFp2FmuUbVWdaL8C4K9qoxJ6uqR7QSeWU0eTEnxu
         5MxUFxOr48UyKmd1OUXnICqpNGspyaYCpY6Y04prvll2X0L3dGTZLW+9eTGMzdXnGQCn
         TkOw==
X-Gm-Message-State: AOAM5320I2rehCJYAggiYtes7prFJxw7hK9oGxGajVRGLTitm6v4f/Fh
	yJd0EbdPEqKRN5k7mnT7Zxf+MLCEqb5BGJ5KEnoG6g8Kbx9XmTwqn5JXY4z1L0lyWSyvFGciGbV
	8A4QIKFciScWwT7w=
X-Received: by 2002:a05:600c:3543:: with SMTP id i3mr9092661wmq.2.1631287406978;
        Fri, 10 Sep 2021 08:23:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPjeM8hryBCxoHRRveV2hSJxEVdYVjtFS81H8wPIKbGLfuEcr4yiyXSvPCeLtcrfKczZakAA==
X-Received: by 2002:a05:600c:3543:: with SMTP id i3mr9092647wmq.2.1631287406747;
        Fri, 10 Sep 2021 08:23:26 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-2.dyn.eolo.it. [146.241.241.2])
        by smtp.gmail.com with ESMTPSA id o14sm4899105wrg.91.2021.09.10.08.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 08:23:26 -0700 (PDT)
Message-ID: <add72c536daafa4fadc76fab88ab437293c163d4.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v2 3/9] mptcp: add MAPPING_INFINITE mapping
 status
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev, Geliang
 Tang <geliangtang@xiaomi.com>
Date: Fri, 10 Sep 2021 17:23:25 +0200
In-Reply-To: <692e5742-1b6c-692d-2927-f0a5aba14ee8@linux.intel.com>
References: <cover.1631188109.git.geliangtang@xiaomi.com>
	  <592427b5a91d5e64e4b96c4c8b8d06264197f1c4.1631188109.git.geliangtang@xiaomi.com>
	 <ba53a5abbb43645efa4038eda3abfb8bb386b09b.camel@redhat.com>
	 <692e5742-1b6c-692d-2927-f0a5aba14ee8@linux.intel.com>
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

On Thu, 2021-09-09 at 17:21 -0700, Mat Martineau wrote:
> On Thu, 9 Sep 2021, Paolo Abeni wrote:
> 
> > On Thu, 2021-09-09 at 19:51 +0800, Geliang Tang wrote:
> > > From: Geliang Tang <geliangtang@xiaomi.com>
> > > 
> > > This patch added a new mapping status named MAPPING_INFINITE. If the
> > > MPTCP_INFINITE_DONE flag is set in get_mapping_status, return this new
> > > status. And in subflow_check_data_avail, if this status is set, goto the
> > > 'infinite' lable to fallback.
> > > 
> > > Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
> > > ---
> > >  net/mptcp/subflow.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > > index 951aafb6021e..ad8efe56eab6 100644
> > > --- a/net/mptcp/subflow.c
> > > +++ b/net/mptcp/subflow.c
> > > @@ -798,6 +798,7 @@ enum mapping_status {
> > >  	MAPPING_INVALID,
> > >  	MAPPING_EMPTY,
> > >  	MAPPING_DATA_FIN,
> > > +	MAPPING_INFINITE,
> > >  	MAPPING_DUMMY
> > >  };
> > > 
> > > @@ -938,6 +939,9 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
> > >  	if (!skb)
> > >  		return MAPPING_EMPTY;
> > > 
> > > +	if (mptcp_check_infinite(ssk))
> > > +		return MAPPING_INFINITE;
> > > +
> > >  	if (mptcp_check_fallback(ssk))
> > >  		return MAPPING_DUMMY;
> > > 
> > > @@ -1121,6 +1125,9 @@ static bool subflow_check_data_avail(struct sock *ssk)
> > > 
> > >  		status = get_mapping_status(ssk, msk);
> > >  		trace_subflow_check_data_avail(status, skb_peek(&ssk->sk_receive_queue));
> > > +		if (unlikely(status == MAPPING_INFINITE))
> > > +			goto infinite;
> > > +
> > >  		if (unlikely(status == MAPPING_INVALID))
> > >  			goto fallback;
> > > 
> > > @@ -1192,6 +1199,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
> > >  		return false;
> > >  	}
> > > 
> > > +infinite:
> > >  	__mptcp_do_fallback(msk);
> > >  	skb = skb_peek(&ssk->sk_receive_queue);
> > >  	subflow->map_valid = 1;
> > 
> > It looks like MAPPING_INFINITE has almost the same behavior
> > of MAPPING_DUMMY.
> 
> This is something else I asked for in the v1 review, to avoid reusing 
> MAPPING_INVALID in a confusing way :)

I read that ;) I thought 'MAPPING_DUMMY' would be less confusing.

> How about using a switch statement after get_mapping_status() instead of 4 
> if's in a row?

Will be mostly the same, from generate code perspective, I think.

What if we rename MAPPING_DUMMY into MAPPING_INFINITE, and we use only
a single value? MAPPING_DUMMY is currently used after a fallback to
implement the sort of infinite mapping we use there.

> > I think we can avoid the new conditional in get_mapping_status().
> > Eventually we could do all the error checking after the 'fallback:'
> > label only if the msk has not fallen back yet:
> > 
> > fallback:
> > 	if (!__mptcp_check_fallback(msk)) {
> > 		/* RFC 8684 section 3.7. */
> > 	        if (subflow->send_mp_fail) {
> > 			...
> > 		if (subflow->mp_join || subflow->fully_established) {
> 
> This condition also needs to check for the infinite mapping case, which is 
> why it seemed useful to have a separate MAPPING_ enum. Fallback is being 
> triggered here in response to the infinite mapping, so the subflow should 
> not be forced to close.

My point is all about avoiding additional conditionals in the 'fast-
path' / default receive path.

I think we still could do that, and being able to discriminate here
between infinite mapping received or not:

- get_mapping_status() returns the same value in the dummy and infinite
mapping case.
- in the infinite mapping case, get_mapping_status() additionally sets
  subflow->map_data_len to 0, 
- in the above code - under 'if (!__mptcp_check_fallback(msk)) {' -
 subflow->map_data_len == 0 implies infinite mapping received, 

WDYT?

Thanks!

Paolo



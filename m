Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471052C82
	for <mptcp@lists.linux.dev>; Wed, 24 Nov 2021 16:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1637771481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/s9cRvFV1tNJFDlhC0mfkyOmPE/gcuwZ+1yoNnMvajE=;
	b=g0/6HeanWN9bHgmqnGdGbQeFZJ/yrH9VYjWv0Em5sVS/eGQh7K5144gwpZHjDAguaVJCve
	bKTBClMKNGoZ3y0uyrEI4kkWD7LQScN1xdOHWeTIXLMoA6UHTQtOpGpzRCi50VSGNkEzq4
	vmA8rdHzruF8t3q1XiehbedlHhWw/BU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-195-8eIbSEdYNF-_m7tQj8d-_A-1; Wed, 24 Nov 2021 11:31:19 -0500
X-MC-Unique: 8eIbSEdYNF-_m7tQj8d-_A-1
Received: by mail-wm1-f70.google.com with SMTP id 69-20020a1c0148000000b0033214e5b021so1591391wmb.3
        for <mptcp@lists.linux.dev>; Wed, 24 Nov 2021 08:31:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=/s9cRvFV1tNJFDlhC0mfkyOmPE/gcuwZ+1yoNnMvajE=;
        b=4Xra4Vr4evg1MlrLmeNSXiEg/t2Ukpn84W4iemAAUgzcX9IFzFVm4T5k58vkzSTpXQ
         0cGxi69yk76sKoujbXltHNmrFUFFE3DwoORu9MBEiIkWVaIKpNMYfHreUheSDAU5M3wQ
         NewcRh0lsnFf2wzsQINcPspkeShYGdMuHOVZm+mHQeKRntHGqlWS/AQRwzT/drIFazQS
         YSQBJMip6wzynppkvIDw2u62WEZh1bnnN6m/mvhLyONXSGfa0x2+J8+hGrRDp07Ndds1
         3iLIiZdoTvrIcgYbDM1MkbVMc4Vd6Yjw/f+wVk1hqJgJ4Bw0pCXH8Sn0utTmERlEcoqZ
         X6qw==
X-Gm-Message-State: AOAM5335WR7ItKMGMMGzBBHyf/Uv56N0dv63gxlaKTk8S6qaGkTJsn3D
	XBh25vR7oy4NJlD5BDUYwUXrGlXOqz90vl7qej4bv2vyp2TNDM4Gp2hf1fIEz+5tNCMjOE79aO9
	qkQ0vMs/58HGyOI4=
X-Received: by 2002:a1c:f018:: with SMTP id a24mr17706502wmb.51.1637771478063;
        Wed, 24 Nov 2021 08:31:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxgEACAN4aSGH4H21gOIr5zHamuG1LrTOIaTgnKeQp4OJ/k6Hb7dysVsgOG83TAkUP58X8zGA==
X-Received: by 2002:a1c:f018:: with SMTP id a24mr17706456wmb.51.1637771477813;
        Wed, 24 Nov 2021 08:31:17 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-229-135.dyn.eolo.it. [146.241.229.135])
        by smtp.gmail.com with ESMTPSA id l7sm354292wry.86.2021.11.24.08.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 08:31:17 -0800 (PST)
Message-ID: <aed0cf82c88d2bec3a5ee54a647632f30281b8c6.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 2/3] mptcp: do not block subflows creation on
 errors
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Phil Greenland <phil@quantulum.co.uk>, mptcp@lists.linux.dev
Date: Wed, 24 Nov 2021 17:31:16 +0100
In-Reply-To: <a715c06d-ed74-8f89-7b5b-eed734efff95@tessares.net>
References: <cover.1637684792.git.pabeni@redhat.com>
	 <c080cc1785cbe3bb3c049a683f2cc6d55f95f17a.1637684792.git.pabeni@redhat.com>
	 <39669a68-eb6f-6602-1469-886266346e48@tessares.net>
	 <d6eb410eafef719adefb61bb584eef1e40c01184.camel@redhat.com>
	 <a715c06d-ed74-8f89-7b5b-eed734efff95@tessares.net>
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35)
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

On Wed, 2021-11-24 at 13:23 +0100, Matthieu Baerts wrote:
> On 24/11/2021 11:09, Paolo Abeni wrote:
> > On Wed, 2021-11-24 at 10:55 +0100, Matthieu Baerts wrote:
> > > Hi Paolo,
> > > 
> > > On 23/11/2021 17:37, Paolo Abeni wrote:
> > > > If the MPTCP configuration allows for multiple subflows
> > > > creation, and the first additional subflows never reach
> > > > the fully established status - e.g. due to packets drop or
> > > > reset - the in kernel path manager do not move to the
> > > > next subflow.
> > > 
> > > Thank you for looking at that!
> > > 
> > > Why the PM could not try to establish all possible paths "in parallel"?
> > > Is it because we have this limit of allowed subflows and we wait to know
> > > if a path is established to count it as used subflow?
> > 
> > IIRC, that design choice is to avoid that an MPTCP endpoint could
> > easily become a DDoS bot, generating "a lot" of syn in response to
> > action from possibly untrusted peer.
> 
> The endpoint will only be able to produce a very few SYN+MPJ depending
> on the limit that is in place.
> 
> Should we maybe do a distinction between local addresses and remote
> ones? I mean when the MPTCP connection is established, the PM could open
> all paths using different local addresses and then the remote ones one
> at a time?
> > > 

I *think* that kind of change will be more invasive - we would have to
revisit the non trivial mptcp_pm_create_subflow_or_signal_addr() and
AFAICS we would still need to cope with subflow creation failure.

All the above IMHO ! 

Cheers,

Paolo


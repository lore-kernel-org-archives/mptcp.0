Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E3529CA
	for <mptcp@lists.linux.dev>; Tue,  7 Dec 2021 11:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1638876519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FQKz71nmXD1JoTSbdttVT6fRqNd+9Fp7JJov935dadc=;
	b=fRRhyiIXBAeFRRpEAx/TS75Wy6I/dd1bdsgev9xaMKInw5bvj9ZUwNbQBamB93Vr2pieTG
	fgU+Pagwt49mBFdCmUZu2D//eNoYIRGCBWeG7MVvJNGhIAgqjgkoHpG7Cb5Mqg0lqEB5fo
	7IbDn0ZvGGp+trE0e0Mc6ivwuwjr/4o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-184-2u0YlArROx2aYq_5Na7jsw-1; Tue, 07 Dec 2021 06:28:37 -0500
X-MC-Unique: 2u0YlArROx2aYq_5Na7jsw-1
Received: by mail-wm1-f72.google.com with SMTP id 144-20020a1c0496000000b003305ac0e03aso1066418wme.8
        for <mptcp@lists.linux.dev>; Tue, 07 Dec 2021 03:28:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=FQKz71nmXD1JoTSbdttVT6fRqNd+9Fp7JJov935dadc=;
        b=3aDaNshqta3i37tBpwA+3aMkXL1Ofo93HzpzQ8xw0rynDPpb2OjUr8p7W+9/NlG+hu
         lu5EVOypcK39it+j6kETBsf5Ddu6S3HXgie5L2IuFncldHDRJRQV61xaNmo0Ybpt6xTp
         xBcmE/lLEpvJTbIlGuQri5lrdxMvv2EtauI4DYJs3sVLo4HfjWMPOwFoRYYYsd8Yx2Px
         uyW6ITjoJaf0KLWDdX38HkONO5HT3dlBbQldOLqhjQoTFQs+lV2tf0rHtow7N5UpJ7fM
         EeU6jp4BoD5UFqQOb8xt/gu8KnIyL2My8CHn3Ht2EWOMHwVfLRKQZEgw97ESHQ1AEZhF
         nBKA==
X-Gm-Message-State: AOAM5315PIHd/IIp4IOp8q1cegzpPXJahp8BATVEzg4rudOs8bv9i7dT
	1YqWr8N56igqGvcLgPk6h3+LRs6Bo6gUkpZCRxKrVHf3nl26eupLZKnJ4t2RbhwPRZTxoQkRJb4
	wtXA/krABFjrWx/o=
X-Received: by 2002:a05:600c:1988:: with SMTP id t8mr6186692wmq.48.1638876516393;
        Tue, 07 Dec 2021 03:28:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyl+SXm3aKOFn9talh8KpWO68P9i2TQVhcERAOLos5xyMhYVGvHtzRshoFtEVt6oTQusTBSEw==
X-Received: by 2002:a05:600c:1988:: with SMTP id t8mr6186664wmq.48.1638876516112;
        Tue, 07 Dec 2021 03:28:36 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-252-1.dyn.eolo.it. [146.241.252.1])
        by smtp.gmail.com with ESMTPSA id o12sm2630254wmq.12.2021.12.07.03.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 03:28:35 -0800 (PST)
Message-ID: <b4d0359bad87ee5bd0431be516aa1fc1574a7851.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v4 3/5] mptcp: keep track of local endpoint
 still available for each msk
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Tue, 07 Dec 2021 12:28:29 +0100
In-Reply-To: <b17fea76ad24e5a1cc6b793427f827ba9ea3c887.camel@redhat.com>
References: <cover.1638544716.git.pabeni@redhat.com>
	 <20e1d11df9396b33ab49b07204bd8b7db2e21a01.1638544716.git.pabeni@redhat.com>
	 <e5ea098-af36-e35-1813-f97d7a187ffa@linux.intel.com>
	 <b17fea76ad24e5a1cc6b793427f827ba9ea3c887.camel@redhat.com>
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

On Mon, 2021-12-06 at 11:18 +0100, Paolo Abeni wrote:
> On Fri, 2021-12-03 at 17:05 -0800, Mat Martineau wrote:
> > On Fri, 3 Dec 2021, Paolo Abeni wrote:
> > 
> > > Include into the path manager status a bitmap tracking the list
> > > of local endpoints still available - not yet used - for the
> > > relavant mptcp socket.
> > > Keep such map updated at endpoint creation/deleteion time, so
> > > that we can easily skip already used endpoint at local address
> > > selection time.
> > > This allows for fair local endpoints usage in case of subflow
> > > failure.
> > > 
> > > As a side effect, this patch also enforces that each endpoint
> > > is used at most once for each mptcp connection.
> > 
> > This seems like a significant change, possibly with unexpected 
> > consequences (but maybe I've misunderstood the new constraint?). 
> > Apparently the topoligies in our self tests happen to work fine!
> 
> Uhmmm... probably less then it may looks like. We already respected the
> above constraint in almost every scenarios. AFAICS, the only exception
> prior to this patch was following scenario:
> 
> 1) subflow is established endpoint A
> 
> 2) the peer closes the additional subflow
> 
> 2) a new local endpoint B is created
> 
> 3) the PM will create the 2nd subflow using again endpoint A. 
> 
> which is arguibly unexpected, as reported by issues/242. 
> 
> > If you have peer A with one interface and peer B with two, it seems like 
> > this should be allowed:
> > 
> > Peer A connects to Peer B endpoint 0
> > Peer B announces endpoint 1
> > Peer A sends an MP_JOIN to Peer B interface 1
> > 
> > From the description above, it sounds like peer A would not be able to 
> > create that second subflow.
> 
> Well, AFAICS the peer A will actually create the subflow, if the limits
> allow that, both with or without this patch.
> Specifically:
> 
> 1) no endpoint configured, add_addr_accepted >=1, subflows >=1 on peer
> A -> the subflow to peer be interface 1 will be created (with or
> without this patch) because we don't have any other additional
> constraint beyond the limits. 
> 
> 2) endpoint configured on peer A matching the MPC subflow source
> address -> again the subflow towards peer B endpoint 1 will be created,
> because that will be the first time the PM will use the peer A
> endpoint.

Thinking again about this last scenario, I think there is something to
improve:

if peer A connects to peer B using the local endpoint address, it can
later use again such address for additional sublflows, as the MPC
subflow is no accounted by the current version of this patch. I'll cook
a v5 adding such account, too - and possibly a related self-tests

Cheers,

/P


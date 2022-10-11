Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468A923A2
	for <mptcp@lists.linux.dev>; Tue, 11 Oct 2022 08:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1665476518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jFKNzvvH4agRJjVheCTFGlwLaasmY2agjbIsYpVzbb8=;
	b=dQyhbt93mjocBMmXTHs9WGFRbP0XTWVAag1ceYCGuH/tUNDAagTZb6dp4p/1xNvyA+bqNU
	oSApygiytUc6zquVdK6+D1Mp3r48DonCC3jMxL0PGXzD3eBb0iARE0bw8wac3ao8caW5sB
	aiqMDWf7wiULIFr7TNvkPQO50b30v5M=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-226-LNM6NajHM3yL0jm30hsvdA-1; Tue, 11 Oct 2022 04:21:57 -0400
X-MC-Unique: LNM6NajHM3yL0jm30hsvdA-1
Received: by mail-qv1-f69.google.com with SMTP id i1-20020a056214020100b004afa3dbf35dso7570247qvt.14
        for <mptcp@lists.linux.dev>; Tue, 11 Oct 2022 01:21:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jFKNzvvH4agRJjVheCTFGlwLaasmY2agjbIsYpVzbb8=;
        b=LvdhbmAj/HWvHUmwDN+MUq66WwhEPX2DVc43d/NPQfCBeAep0Fq13669UlKkRmSj+v
         zgRp69eVB7aMxCF2hDny72rf72ZmwF+NaPpIDrjk59Uw5n/BR31VL/JClBC6EMbi1fda
         pegqJ9Pbiqn5InwffbmnD0MANqUDAzMoM7CPTiiPjJ6btYEnznTpVJpaF98boEPmItC9
         QvwAVweUewKDkzzt7FUSjifpxMy15wtF3EQwArMNa7pPSnCAqcZh/uppNq/rmNTcxYz1
         eiLh2HM5+5hxPs6uqINs5b7qRg2gIt/iFikcPqG+im9TQ72v64Fml0vffNtQMC1cL24X
         k8oQ==
X-Gm-Message-State: ACrzQf0tqBf8tdZOEsco/ng+3VFgjV+bT2Yb1Z3swpDOVRiVSgkhHvkl
	liKiN1nITSuxSO4ZiX8Vn/iJVKZZZrGi5j04HAV+6oGGoXriRyqn1UI8YdWbim1BlMj6/uAyESn
	cLrjbiwEW9raYGHM=
X-Received: by 2002:a05:6214:518b:b0:4b1:dae2:4537 with SMTP id kl11-20020a056214518b00b004b1dae24537mr18073751qvb.2.1665476516088;
        Tue, 11 Oct 2022 01:21:56 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM53SiH+oqtpGbIeRw8umGFbHhDIw2peIRukDQaBwp9pMuPDGXMquzOgIMdmATOW6S29wxJpVQ==
X-Received: by 2002:a05:6214:518b:b0:4b1:dae2:4537 with SMTP id kl11-20020a056214518b00b004b1dae24537mr18073740qvb.2.1665476515769;
        Tue, 11 Oct 2022 01:21:55 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-103-235.dyn.eolo.it. [146.241.103.235])
        by smtp.gmail.com with ESMTPSA id u16-20020a05620a0c5000b006ce441816e0sm12323305qki.15.2022.10.11.01.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 01:21:55 -0700 (PDT)
Message-ID: <56f3f85c531cedf0b4a26f309238833416b96e84.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: set msk local address earlier
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Tue, 11 Oct 2022 10:21:52 +0200
In-Reply-To: <3978422b-52e0-8a1d-e424-541d6ab5c229@linux.intel.com>
References: <f5e8bfe9878d3948df9328870fc35daec6388e2b.1665431162.git.pabeni@redhat.com>
	 <3978422b-52e0-8a1d-e424-541d6ab5c229@linux.intel.com>
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
Content-Transfer-Encoding: 8bit

Hello,

On Mon, 2022-10-10 at 16:38 -0700, Mat Martineau wrote:
> On Mon, 10 Oct 2022, Paolo Abeni wrote:
> 
> > The mptcp_pm_nl_get_local_id() code assumes that the msk local address
> > is available at that point. For passive sockets, we initialize such
> > address at accept() time.
> > 
> > Depending on the running configuration and the user-space timing, a
> > passive MPJ subflow can join the msk socket before accept() completes.
> > 
> > In such case, the PM assigns a wrong local id to the MPJ subflow
> > and later PM netlink operations will end-up touching the wrong/unexpected
> > subflow.
> > 
> > All the above causes sporadic self-tests failures, especially when
> > the host is heavy loaded.
> > 
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/308
> > Fixes: 01cacb00b35c ("mptcp: add netlink-based PM")
> > Fixes: d045b9eb95a9 ("mptcp: introduce implicit endpoints")
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> 
> This has a minor conflict in protocol.h when trying to apply to 
> export-net, but it's easy to resolve (mptcp_get_scheduler is in export 
> but not export-net).
> 
> I ran in to one failure in a test that wasn't mentioned in #308 the first 
> time I tried running "mptcp_join.sh -rp" but couldn't reproduce it:
> 
> 010 flush addresses                      syn[fail] got 2 JOIN[s] syn expected 3
>   - synack[fail] got 2 JOIN[s] synack expected 3
>   - ack[fail] got 2 JOIN[s] ack expected 3
>                                           add[ ok ] - echo  [fail] got 2 ADD_ADDR echo[s] expected 3
>                                           rm [fail] got 2 RM_ADDR[s] expected 3
>   - rmsf  [fail] got 2 RM_SUBFLOW[s] expected in range [3:6]
> 
> but I don't think that's related? 

That *looks* unrelated, and is possibly due to plain slowness
(mptcp_connect is unable to establish all the 3 subflows before the nl
pm starts deleting the addresses).

> (Let me know if the MIB list is useful, 
> I saved that too)

The MIBs could possibly be useful, but I guess not decisive ;)

Thanks,

Paolo



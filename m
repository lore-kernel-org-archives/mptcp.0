Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876FC70
	for <mptcp@lists.linux.dev>; Fri,  9 Jul 2021 07:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1625814263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XKvo5Tb9aJ+M0Bbmf0ecQFM8QaBBJHJD5+kS8y1X2qE=;
	b=AHNlK2FO4kyStxKfF9Ho+fvhroXAgLyZbua83+NjiAlJoBltgGwqgF76G+2UEeZcCRMBSj
	aSjKbvhY6+jqmbrITJiJ/bxkj1+k+hRdC3KxvhuEKjOaDOnS6B7xeq8i3CXeuYwWTYzghR
	7zGqRnnBzDwqQ+j9z6UhvcOi0LAXuOg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-8hSlusFJNI-wiwwuSH9mRg-1; Fri, 09 Jul 2021 03:04:22 -0400
X-MC-Unique: 8hSlusFJNI-wiwwuSH9mRg-1
Received: by mail-wr1-f71.google.com with SMTP id z6-20020a5d4c860000b029013a10564614so2168295wrs.15
        for <mptcp@lists.linux.dev>; Fri, 09 Jul 2021 00:04:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=XKvo5Tb9aJ+M0Bbmf0ecQFM8QaBBJHJD5+kS8y1X2qE=;
        b=RhDJXfd1LbBqGkR8uPiQ8wdug5LZu90hE9p4Xnfir2wGQocCo4A4BwMWypTXnLX0Fp
         a7/CRjlCTXyS8x2817znqU84PBetky2a3CldMs2j6qWSOLXTGbFPkZnU0wPnyHuo77bX
         TO03mZIXAyJr3En3g8zjgqvX1dMfyDRMIIs4QFPVzOzvQFp/Bi14rRCMRotur+/0QkGY
         9fCbNhhSUpvjOZpLFkuWtFMQmxxIf3icEPIXttvxUv2KWXzlJ95b/ON8z15MtsBe5jMj
         euYBSKZeCwnrM/X0mvFyGlaL9HurZcw6YNRzMjxs+65zIW23LNL15+DFx4kuEQRgZtUM
         0XwQ==
X-Gm-Message-State: AOAM532TvVBRRXiblZzb47kvBhw318Ccb0f3DsFFe5JRluz2njK1jnpP
	/L/6Re/toslfrsZi2hOPUaBKMM5ARs1w2JpVxg+Zt2aGu6KXO4wjq7TVg0iN4HUFTWIXx2rLkcE
	luvzxrxE50wAO5FA=
X-Received: by 2002:adf:eb82:: with SMTP id t2mr39095750wrn.337.1625814260998;
        Fri, 09 Jul 2021 00:04:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTUO1dwacqGtN94rPkJsOIE5Ue7yGRI6Ym7AY8pNPXQCv5nqh7ZqmYliDkLM8Ba26Fcx/RiA==
X-Received: by 2002:adf:eb82:: with SMTP id t2mr39095716wrn.337.1625814260794;
        Fri, 09 Jul 2021 00:04:20 -0700 (PDT)
Received: from gerbillo.fritz.box (146-241-112-171.dyn.eolo.it. [146.241.112.171])
        by smtp.gmail.com with ESMTPSA id n18sm9529160wms.3.2021.07.09.00.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 00:04:20 -0700 (PDT)
Message-ID: <97a1fff6a2619dc3b16700252ea5d0167ec98b6b.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 7/7] selftests: mptcp: add testcase for
 active-back
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev, fwestpha@redhat.com
Date: Fri, 09 Jul 2021 09:04:11 +0200
In-Reply-To: <15d981a-acb3-61c0-1a79-ea703b1db2c9@linux.intel.com>
References: <cover.1624895054.git.pabeni@redhat.com>
	 <84049ecdf3185b99e16ffc17be6594cfafd57119.1624895054.git.pabeni@redhat.com>
	 <15d981a-acb3-61c0-1a79-ea703b1db2c9@linux.intel.com>
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

On Thu, 2021-07-08 at 17:51 -0700, Mat Martineau wrote:
> On Mon, 28 Jun 2021, Paolo Abeni wrote:
> 
> > Add more test-case for link failures scenario,
> > including recovery from link failure using only
> > backup subflows and bi-directional transfer.
> > 
> > Additionally explicitly check for stale count
> > 
> 
> I get a lot of intermittent failures due to the expected stale count 
> range, like this:
> 
> 15 multiple flows, signal, bidirectional, link failure syn[ ok ] - synack[ ok ] - ack[ ok ]
>                                          add[ ok ] - echo  [ ok ]
>                                          stale[fail] got 19 stale[s] 18 recover[s],   expected stale in range [1..5],  stale-recover delta 1
> 
> 02 multiple flows, signal, bidirectional, link failure syn[ ok ] - synack[ ok ] - ack[ ok ]
>                                          add[ ok ] - echo  [ ok ]
>                                          stale[fail] got 11 stale[s] 10 recover[s],   expected stale in range [1..5],  stale-recover delta 1
> 
> 02 multiple flows, signal, bidirectional, link failure syn[ ok ] - synack[ ok ] - ack[ ok ]
>                                          add[ ok ] - echo  [ ok ]
>                                          stale[fail] got 51 stale[s] 50 recover[s],   expected stale in range [1..5],  stale-recover delta 1
> 
> 
> and
> 
> 
> 18 backup subflow in use, bidirectional, link failure syn[ ok ] - synack[ ok ] - ack[ ok ]
>                                          add[ ok ] - echo  [ ok ]
>                                          stale[fail] got 8 stale[s] 6 recover[s],   expected stale in range [2..4],  stale-recover delta 2
> 
> 05 backup subflow in use, bidirectional, link failure syn[ ok ] - synack[ ok ] - ack[ ok ]
>                                          add[ ok ] - echo  [ ok ]
>                                          stale[fail] got 8 stale[s] 6 recover[s],   expected stale in range [2..4],  stale-recover delta 2

Ouch, I though I solved these ones :(

I agree not merging before addressing the above. I can't have a look
before next week.

Cheers,

Paolo


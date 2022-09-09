Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBEA4C62
	for <mptcp@lists.linux.dev>; Fri,  9 Sep 2022 16:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1662742704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dw4c+JhZx8fze1RY4PfMHTsXKzsrTtIDePnXY8ncCrU=;
	b=dvrEFuXyyp8CyRDbQoFRTZaPa4Tvn+28XkJ3xSQVRMLKH6OnorCeMRb1xFrD1kOywwcX9T
	1NkRhqCh5jyUrV0PxPskzXpx79J2JtpupJH7+Ld5j2atbYX4QodCgIW6kdOyB90qFoSxYh
	3C0DvO3XhOku2qqTVEKtZDu2CbtT6AA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-573-PZCh9ia8P1C_cpxA7noPBA-1; Fri, 09 Sep 2022 12:58:23 -0400
X-MC-Unique: PZCh9ia8P1C_cpxA7noPBA-1
Received: by mail-wm1-f69.google.com with SMTP id b16-20020a05600c4e1000b003a5a47762c3so1081780wmq.9
        for <mptcp@lists.linux.dev>; Fri, 09 Sep 2022 09:58:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date;
        bh=dw4c+JhZx8fze1RY4PfMHTsXKzsrTtIDePnXY8ncCrU=;
        b=ImmKYwz+nnJjZykYkIKqn2XPMAEDCwEEJPqD1AqTpLphxzKNsig2A8UE6fOJwhbove
         9Kr/v/nqotHxfUmV0aE3au0L3gL7S0WlZkX+roKhtP8LM9bbJsfcrpqMPIN0ij41dEfa
         PTtzXXsPIXKEQtquBxz4IFCYMUo7S8pNvVSG8BEsp6EnC28wuwLxCTxmNTmklgp1Di07
         kg6y+T+JYwgCHx1qTVuangUAlkjv/EM/5oGD7eD7t5EJlZoqG2DCqD1DYLPKYHdmbQKQ
         Izeo4ANAjHuOx9NRkJAM3THgQKPHVT3d3u3mNyo7fb/0XTf3AitGEUkoxregTnlIbObO
         C79g==
X-Gm-Message-State: ACgBeo2JGQfWrFioosBAEMOvo7m+9Obcj9c1/O9oO8ZVVlN3bYdKE0w8
	1zQNhTcJdYtnMdOF5pAdVx8hyj4fIkkDawHIxgvYaXswoEft/5wbn+Z3sHDPcPmcPFSvz2KU8jU
	kit4rL5e6kKFc2ZA=
X-Received: by 2002:a05:600c:1d16:b0:3a6:1fa1:41f7 with SMTP id l22-20020a05600c1d1600b003a61fa141f7mr5884990wms.103.1662742701601;
        Fri, 09 Sep 2022 09:58:21 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5SIY4rB4gc2QVMSTYOVAJKLMB6Eurr1ANToEntA9v0mwPzmMLd9kMQiF5Fw7UeHTbJftg3zA==
X-Received: by 2002:a05:600c:1d16:b0:3a6:1fa1:41f7 with SMTP id l22-20020a05600c1d1600b003a61fa141f7mr5884976wms.103.1662742701375;
        Fri, 09 Sep 2022 09:58:21 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-119-112.dyn.eolo.it. [146.241.119.112])
        by smtp.gmail.com with ESMTPSA id q14-20020adff94e000000b00228c2462a78sm919910wrr.24.2022.09.09.09.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 09:58:20 -0700 (PDT)
Message-ID: <a40cb4016604706ea328f1552d15f012d44e5c9f.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v4 3/3] selftests: mptcp: update and extend
 fastclose test-cases
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Fri, 09 Sep 2022 18:58:20 +0200
In-Reply-To: <8b87693f-66a7-67ce-752e-d98df7162552@tessares.net>
References: <904c47ce96fa8d6d4c961a2480bf3aea702c3a9c.1662713367.git.pabeni@redhat.com>
	 <ccf2c2fc0f7fdca9742c51b3fdc6bb6c5fabec5f.1662713367.git.pabeni@redhat.com>
	 <8b87693f-66a7-67ce-752e-d98df7162552@tessares.net>
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

On Fri, 2022-09-09 at 17:39 +0200, Matthieu Baerts wrote:
> Hi Paolo,
> 
> On 09/09/2022 10:49, Paolo Abeni wrote:
> > After the previous patches, the MPTCP protocol can generate
> > fast-closes on both ends of the connection. Rework the relevant
> > test-case to carefully trigger the fast-close code-path on a
> > single end at the time, while ensuring than a predictable amount
> > of data is spooled on both ends.
> > 
> > Additionally add another test-cases for the passive socket
> > fast-close.
> 
> Thank you for the v4!
> 
> The whole series looks good to me.
> 
> Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> 
> 
> I wanted to apply it but I just realised that like with the previous
> version Patchew didn't apply this v4 as well. Maybe because there is no
> cover-letter?
> 
> I just applied these patches manually and I will wait for the CI to send
> its report before applying them.
> 
> https://github.com/multipath-tcp/mptcp_net-next/commits/patchew/904c47ce96fa8d6d4c961a2480bf3aea702c3a9c.1662713367.git.pabeni@redhat.com

Thanks!

Next time I'll add the cover letter, let's try to track if is really
that to foul patchew.

Cheers,

Paolo


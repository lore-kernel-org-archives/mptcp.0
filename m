Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108DB2F23
	for <mptcp@lists.linux.dev>; Fri,  4 Feb 2022 18:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1643999531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T69elH0VmGaea7ndYxpRZ6t1/dWQ+AZdUHcxW1c8yz0=;
	b=VhbUcZILY/qxUdD51KdNELiIbNEWaqlCB6qrRNGOfFdrud8wkCB4AZVp2invm0kYjht8I0
	4eN67ekcOxqrxdvk011ilMdk1+0cRMXuWejxd/dnY4y0PsDm6Q8VcSa5Ya7vsHCZeBF8WS
	5FF4Hg3zFFpujlC5nwHLBITECKYYtHY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-151-ijWJi9YqOu23DFiq_FDRhg-1; Fri, 04 Feb 2022 13:32:10 -0500
X-MC-Unique: ijWJi9YqOu23DFiq_FDRhg-1
Received: by mail-wm1-f69.google.com with SMTP id m3-20020a7bcb83000000b0034f75d92f27so2733278wmi.2
        for <mptcp@lists.linux.dev>; Fri, 04 Feb 2022 10:32:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=T69elH0VmGaea7ndYxpRZ6t1/dWQ+AZdUHcxW1c8yz0=;
        b=0sTGMrlqb+okwknmQeeakbfh3eVgOvPldu1idwypdyYIOcfHbUUifiMgU11NMtp6RP
         E6sX+KSY7gCEaoxXH8CUV/93uX21lSHsU3WYofLyYffF+0bs5SU/jsEZdGRB3IlU2VZI
         h4IdFG6SQNiDLzhKza5zJvSfpA2mX15C2O7UIT0GGzylWorSZsfcoABQXdAxH0ZQqt8O
         11MCuIFM2/q0DQ0MAUbwz8V2/Hi6pqAfKsnxpWIxoAKIqWmzGfQ27KLDjy0VM2N2B7iv
         y1AsJilbL/XYdlGBHRd6wZOKAE1lj5AWtcvDbiHmtM6bbRigrwitO5Z7abKuTcuugXu5
         pz5Q==
X-Gm-Message-State: AOAM531UjCrKWPnoSz8N+hf0GjM0hKQmBwD2t82cAQc8tHk54QMeizTi
	+VmgVwniSGDsrpNdXpAwpbROerToBsLuVkgvFxJz0NKqg56BuBiBMV6VqJyo2OP94X06dEiHNfG
	hLmBMfYs1WID0hS8=
X-Received: by 2002:a05:6000:184c:: with SMTP id c12mr162319wri.388.1643999529358;
        Fri, 04 Feb 2022 10:32:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw0Yvy2FQiZElAN/ykqGo2vuNI9D0zJUmUwnJz8cXUktSPS8mT+6CenSI4egLnNkd92Woppgg==
X-Received: by 2002:a05:6000:184c:: with SMTP id c12mr162298wri.388.1643999529100;
        Fri, 04 Feb 2022 10:32:09 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-96-254.dyn.eolo.it. [146.241.96.254])
        by smtp.gmail.com with ESMTPSA id j9sm2607530wro.8.2022.02.04.10.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 10:32:08 -0800 (PST)
Message-ID: <cc21c95dccf7768ea9465438520a028e7a42fd5d.camel@redhat.com>
Subject: Re: [PATCH v2 mptcp-next] selftests: mptcp: fix diag instability
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Fri, 04 Feb 2022 19:32:07 +0100
In-Reply-To: <932621cc-7db9-91cb-7daf-e37a4953a43c@tessares.net>
References: <db50196c67b30e7b89d241faffc78e5ffbb04e83.1643976999.git.pabeni@redhat.com>
	 <932621cc-7db9-91cb-7daf-e37a4953a43c@tessares.net>
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35)
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

On Fri, 2022-02-04 at 16:53 +0100, Matthieu Baerts wrote:
> Hi Paolo,
> 
> On 04/02/2022 13:17, Paolo Abeni wrote:
> > Instead of waiting for an arbitrary amount of time for the MPTCP
> > MP_CAPABLE handshake to complete, explicitly wait for the relevant
> > socket to enter into the established status.
> > 
> > Additionally let the data transfer application use the slowest
> > transfer mode available (-r), to cope with very slow host, or
> > high jitter caused by hosting VMs.
> > 
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > v1 -> v2:
> >  - use wait_for_ instead larger sleep
> >  - hopefully better commit message
> 
> Thank you for the new version!
> 
> It is being tested in the background. More than 175 attempts in a slow
> environment with a debug kernel and no failures so far!
> 
> > diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
> > index 2674ba20d524..ff821025d309 100755
> > --- a/tools/testing/selftests/net/mptcp/diag.sh
> > +++ b/tools/testing/selftests/net/mptcp/diag.sh-
> > @@ -119,7 +149,7 @@ for I in `seq 1 $NR_CLIENTS`; do
> >  				./mptcp_connect -p $((I+10001)) -l -w 10 \
> >  					-t ${timeout_poll} 0.0.0.0 >/dev/null &
> >  done
> > -sleep 0.1
> > +wait_local_port_listen $ns $((NR_CLIENTS + 10001))
> >  
> >  for I in `seq 1 $NR_CLIENTS`; do
> >  	echo "b" | \
> 
> Do we need the change the last sleep (sleep 1.5) as well? We could wait
> for a shorter time but well that's only 1.5 second once. And I guess we
> might need to look for each connection because looking at the last one
> might not be enough if there was an issue with a previous one.
> 
> So best to keep the "sleep 1.5"?

We need a more complex test to replace sleep 1.5 reliably. I'll look at
that later, surely in a different patch.
> 
> If yes, do you prefer if the test run for a longer time or can I already
> apply it?

Please, go ahead, thanks!

/P


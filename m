Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF29D70
	for <mptcp@lists.linux.dev>; Thu, 17 Jun 2021 08:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1623919552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=19zR5UBXfWLdkI6TLSU9boIEmI+2+asSFuqt9FHwDEg=;
	b=W945rbQaz4fLOs1PqV3AQXCuZe3zdQw3D/VbGx9sCvqS3oLudKIb6qJVUrzJ9mqyaWIDUd
	WfAQgRBn76e4R8gMuIi5G9pJ0l6REULweCRmjx4Hfhx4tDPLaVwy+6T2lx9nFPU0ktM7s4
	5AHlL2RaWiAf2RLgZ7SKe926vEtrFVY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-536-kG1_D2UtOKmZB4SSf3VmIg-1; Thu, 17 Jun 2021 04:45:50 -0400
X-MC-Unique: kG1_D2UtOKmZB4SSf3VmIg-1
Received: by mail-wm1-f72.google.com with SMTP id o14-20020a1c4d0e0000b029019a2085ba40so453459wmh.1
        for <mptcp@lists.linux.dev>; Thu, 17 Jun 2021 01:45:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=19zR5UBXfWLdkI6TLSU9boIEmI+2+asSFuqt9FHwDEg=;
        b=n6/BCipz2YKVeH5PdObBHfr7QqUvC2SOjSfl7oh4UKe0Z5AO3GHJmmrdOrL7DYagJT
         hymTFd5dUQYGwjUwiLTlFgAinK91vHE1KTUVZAX6jcfqFP3SeMPhhzi7/pI0kxLdnVWD
         OKt9QvWqcTHJQ9vsKfsr2JN7yrEEWGQAt3XM1qyzuzm/IVg7Wok4nTkQhdS8/MJD8myt
         pRhtQuia8LuR52HOiJ84FAJL5DTWKn2RTOIUt0Ca7fPahpanFWANcb+51KEN3w5beMUt
         ONkVCIS4NnC7jndRw/KOc0fgaF842Jpu4vUi3PpP2BhZ0/MTw+5tE2k4c9RkCqB1vB3o
         FL+w==
X-Gm-Message-State: AOAM5332hQYd1NSgwFlsEslgP3meWCKNeY1uwS60QskwZXPJBaNv3/BZ
	P7wvZU/KodQfmJT1R3XznfrenH1FfdTIJL12oJy99im1Gl3o8tQN3TgmTHhc828njSIti8KudTR
	AdhgGAaczQ2rhxzU=
X-Received: by 2002:adf:a4cc:: with SMTP id h12mr4235803wrb.195.1623919549330;
        Thu, 17 Jun 2021 01:45:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTSU+OFpCZZ7cmUjBkCBt+eShmsADnQZvpuKKKf7lhrxCUcw7e5iw7TQAqKuj4iCt+Ae/FeQ==
X-Received: by 2002:adf:a4cc:: with SMTP id h12mr4235791wrb.195.1623919549163;
        Thu, 17 Jun 2021 01:45:49 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-109-224.dyn.eolo.it. [146.241.109.224])
        by smtp.gmail.com with ESMTPSA id u18sm3846406wmj.15.2021.06.17.01.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 01:45:48 -0700 (PDT)
Message-ID: <1c7931970617dc6824753957096c11a9473f2495.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: avoid race on msk state changes
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Thu, 17 Jun 2021 10:45:48 +0200
In-Reply-To: <4b871869-969e-b732-86fb-e970beb4f0d6@linux.intel.com>
References: <ad66de68b4a3abd765da48e0030b08bf852bf9e6.1623849715.git.pabeni@redhat.com>
	 <4b871869-969e-b732-86fb-e970beb4f0d6@linux.intel.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
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

On Wed, 2021-06-16 at 17:38 -0700, Mat Martineau wrote:
> On Wed, 16 Jun 2021, Paolo Abeni wrote:
> 
> > The msk socket state is currently updated in a few spots without
> > owning the msk socket lock itself.
> > 
> > Some of such operations are safe, as they happens before exposing
> > the msk socket to user-space and can't race with other changes.
> > 
> > A couple of them, at connect time, can actually race with close()
> > or shutdown(), leaving breaking the socket state machine.
> > 
> > This change addresses the issue moving such update under the msk
> > socket lock with the usual:
> > 
> > <acquire spinlock>
> > <check sk lock onwers>
> > <ev defer to release_cb>
> > 
> > scheme.
> > 
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/56
> > Fixes: 8fd738049ac3 ("mptcp: fallback in case of simultaneous connect")
> > Fixes: c3c123d16c0e ("net: mptcp: don't hang in mptcp_sendmsg() after TCP fallbac")
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > net/mptcp/protocol.c |  2 ++
> > net/mptcp/protocol.h |  2 ++
> > net/mptcp/subflow.c  | 30 ++++++++++++++++++++++--------
> > 3 files changed, 26 insertions(+), 8 deletions(-)
> > 
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 05c8382aafef..15c3b75516fb 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -2906,6 +2906,8 @@ static void mptcp_release_cb(struct sock *sk)
> > 		__mptcp_clean_una_wakeup(sk);
> > 	if (test_and_clear_bit(MPTCP_ERROR_REPORT, &mptcp_sk(sk)->flags))
> > 		__mptcp_error_report(sk);
> > +	if (test_and_clear_bit(MPTCP_CONNECTED, &mptcp_sk(sk)->flags))
> > +		__mptcp_set_connected(sk);
> 
> Is it worth it to move the MPTCP_CONNECTED handling to be first in 
> mptcp_release_cb()? Some of the other handlers would expect to have the 
> msk connection state set first

Good point! I placed it towards the bottom mainly to avoid processing
such bit before the MPTCP_PUSH_PENDING/MPTCP_RETRANSMIT loop, otherwise
we should check CONNECTED twice.

Double checking the existing code, it looks like
only MPTCP_ERROR_REPORT and MPTCP_CLEAN_UNA depends on it - and the
latter should never be set before MPTCP_CONNECTED, I think.

Moving the MPTCP_CONNECTED before ERROR_REPORT/CLEAN_UNA and
after PUSH_PENDING/RETRANSMIT should fit.

Thanks!

Paolo


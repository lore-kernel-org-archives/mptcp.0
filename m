Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804332F25
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 08:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1644396847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VBs+bpwWrpBpAU74Dpj58e9HsFBpqPSscKXKMNNvxAY=;
	b=g9PriZrQRJHRX9ts9s8AsIbRrlc2oktiTbSeKIEQ1ytCPnUJvn4N+PyTpZSUOENx7E4Zrn
	vPTz4rwcpkO36e6CEExr/ARdNLnPoL6EsbvyCaFFYliBuNTOmjrH0puVDT57iZvHlKiBB7
	94VKtUZ13794Qqm+xanTBYtlnfyQs/0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-30-HqbpowzuMKuQBRpZKUGy5g-1; Wed, 09 Feb 2022 03:54:04 -0500
X-MC-Unique: HqbpowzuMKuQBRpZKUGy5g-1
Received: by mail-wr1-f69.google.com with SMTP id h24-20020adfaa98000000b001e33eb81e71so828835wrc.9
        for <mptcp@lists.linux.dev>; Wed, 09 Feb 2022 00:54:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=VBs+bpwWrpBpAU74Dpj58e9HsFBpqPSscKXKMNNvxAY=;
        b=q8qTYm3PqLfYPSjWvENssAnbQFS0S6nwNFSYYOhaqIfshU1D4YSSKCasyd5BuZ+elf
         fr0BZXE/FrwAKP9b9hjUuL29DrsZ7frUs6Rpfem9LccUtli26uqV4f22LCVrWRbwZKn4
         xY7/v55UX7qMf7rvLEUU7rOQ7ODMqrbfY4LiuzisqpWoGPRRhJ6oHdMP+eZFvesrmaEQ
         ifmNG5/53a0I5OCTfMzpn3PHlnXRpzRFGMQ5bZOtI6aRqV05RL5sFIxlKU6oYeF/e4bP
         AqB/xKrQlegWU3IOfY6Qj+T5/2Io0iqNyL7W7Ez5xbJB7Q8FjSRoiOFiNo1HOM3zAx+8
         f9sQ==
X-Gm-Message-State: AOAM531tVgjCXxp4CvZFoFVr/oAZ0BhW7ePia4vDpQQYK9xYZtI3WrM8
	lGFSIPewsx2a6fgLeSdpvthAg1gQ/QODPSiiUJ/b+mRo0NG0JhA1MQTIthKyxpXGE+zu3UzUCaY
	o95eJf1duNaE87NY=
X-Received: by 2002:a5d:5402:: with SMTP id g2mr1168555wrv.146.1644396843028;
        Wed, 09 Feb 2022 00:54:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzH47rWhtp7jc/a3pZ8C6ggoTupO2WjxbA6WhF3yzo4OJEFh96IS8l6I5m6A889vdCezsQ2HQ==
X-Received: by 2002:a5d:5402:: with SMTP id g2mr1168539wrv.146.1644396842791;
        Wed, 09 Feb 2022 00:54:02 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-96-254.dyn.eolo.it. [146.241.96.254])
        by smtp.gmail.com with ESMTPSA id k6sm6709848wms.14.2022.02.09.00.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 00:54:02 -0800 (PST)
Message-ID: <53f313b91ef91c0bf7764238ec5cba2960450153.camel@redhat.com>
Subject: Re: [PATCH mptcp-net v2 1/4] mptcp: fix race in overlapping signal
 events
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Wed, 09 Feb 2022 09:54:01 +0100
In-Reply-To: <5b78d02e-c47c-7ecb-f0d0-8464f71ed49b@linux.intel.com>
References: <cover.1644346664.git.pabeni@redhat.com>
	 <fe2ee45c579ea83d5aec853c80d6088aebc6ef26.1644346664.git.pabeni@redhat.com>
	 <5b78d02e-c47c-7ecb-f0d0-8464f71ed49b@linux.intel.com>
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

On Tue, 2022-02-08 at 16:54 -0800, Mat Martineau wrote:
> On Tue, 8 Feb 2022, Paolo Abeni wrote:
> 
> > After commit a88c9e496937 ("mptcp: do not block subflows
> > creation on errors"), if a signal address races with a failing
> > subflow creation, the subflow creation failure control path
> > can trigger the selection of the next address to be announced
> > while the current announced is still pending.
> > 
> > The above will cause the unintended suppression of the ADD_ADDR
> > announce.
> > 
> > Fix the issue skipping the to-be-suppressed announce before it
> > will mark an endpoint as already used. The relevant announce
> > will be triggered again when the current one will complete.
> > 
> > Fixes: a88c9e496937 ("mptcp: do not block subflows creation on errors")
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > net/mptcp/pm_netlink.c | 10 ++++++++++
> > 1 file changed, 10 insertions(+)
> > 
> > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > index 93800f32fcb6..fb8d4bfcfbd6 100644
> > --- a/net/mptcp/pm_netlink.c
> > +++ b/net/mptcp/pm_netlink.c
> > @@ -546,6 +546,16 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
> > 	if (msk->pm.add_addr_signaled < add_addr_signal_max) {
> > 		local = select_signal_address(pernet, msk);
> > 
> > +		/* due to racing events on both ends we can reach here while
> > +		 * previous add address is still running: if we invoke now
> > +		 * mptcp_pm_announce_addr(), that will fail and the
> > +		 * corresponding id will be marked as used.
> > +		 * Instead let the PM machinery reschedule us when the
> > +		 * current address announce will be completed.
> > +		 */
> > +		if (msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_SIGNAL))
> 
> There is a helper for this: mptcp_pm_should_add_signal_addr()
> (which also uses READ_ONCE())

I chose to not use it, as the condition I'm really checking is: "is the
PM already processing a signal addr?" which incidentally boils down to
the same code, but the helper name would be misleading IMHO.

I can adapt if there are strong opinion WRT the above. Please let me
know.

Thanks!

Paolo


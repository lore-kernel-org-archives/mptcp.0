Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AE83FC1
	for <mptcp@lists.linux.dev>; Mon,  6 Sep 2021 08:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1630917526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oTunv/R7bx8ZpMlEztklcxRUUnNwnpiXU6PRR0eDhxk=;
	b=MrAQdHc8lKeVaeXbqWfFQgn47G2GFHqkv1qeUOHe6j+qqm5m4afVxWu2LbPVLkL13iZs9p
	pRyqqvkuo3sX/SKCnhnctkeMWnTK/mxSrxrZJq3+F1ZGr1ZrPaZ177k/e107JMXS2b5oWE
	AL/RPxKMIE3SUSGu0ptlTONJxajPVws=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-MUmpHXzrNyyatl5xmq6EBw-1; Mon, 06 Sep 2021 04:38:43 -0400
X-MC-Unique: MUmpHXzrNyyatl5xmq6EBw-1
Received: by mail-wm1-f72.google.com with SMTP id p29-20020a1c545d000000b002f88d28e1f1so2069677wmi.7
        for <mptcp@lists.linux.dev>; Mon, 06 Sep 2021 01:38:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=oTunv/R7bx8ZpMlEztklcxRUUnNwnpiXU6PRR0eDhxk=;
        b=liH2AafqctUqsX3aZqhB60IwbPMXUHHprvPh0ExRbzwehArmq2czxCC5ybYBULvl94
         gVNMyswDAmrLGcikXEvKPDAlUvQxCU9Kf3AiWPHnWL9d3wZOb2WczZyA3jR5p3QH4deQ
         oAOhKafWgPCjlZSB37rTto25K9fyBHgGwEv81OKizouHTTGddr64yYxWqluAh1Gs48Ro
         FpL6TbP366/PDSeAxTEbNHqi2VWpiZkFWZYrKUWSRohugPlgj9MBlG2eWeO0Tsu9eg7Q
         C0WxOYMr1uIc0Sc3CybwKGRC0/cWOLjQNb2MbyvW/H+PWa3tH/Qj3BAacM+qh2gHWRZr
         HGrA==
X-Gm-Message-State: AOAM532KyPI78HMRYEE3jlJh3kQfPvYmsyKStCYTmgtJ+OKywqLSd3yl
	DvCycF46UGTzJjUY4RaahIVMw26mWzGeMNYbQV6azymsQiSPFydMRg8aIt7PmrI2w4WWklspW+6
	BkdV16WhPEpRqE74=
X-Received: by 2002:a5d:6cc5:: with SMTP id c5mr12165226wrc.107.1630917522623;
        Mon, 06 Sep 2021 01:38:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz77+7lRVaMh3uW/Hahosd1iK1yQ/cVSsCqJh6hQkJUGa8HdbMlsZAP00ASnOcI+wOv1DKPpA==
X-Received: by 2002:a5d:6cc5:: with SMTP id c5mr12165199wrc.107.1630917522379;
        Mon, 06 Sep 2021 01:38:42 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-233-185.dyn.eolo.it. [146.241.233.185])
        by smtp.gmail.com with ESMTPSA id j4sm6964829wrt.23.2021.09.06.01.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 01:38:42 -0700 (PDT)
Message-ID: <c0fc73caa4f52bdfc639ea76b552b1bc255eab9b.camel@redhat.com>
Subject: Re: [mptcp-next 2/2] mptcp: re-set push-pending bit on retransmit
 failure
From: Paolo Abeni <pabeni@redhat.com>
To: Florian Westphal <fw@strlen.de>
Cc: mptcp@lists.linux.dev, Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 06 Sep 2021 10:38:40 +0200
In-Reply-To: <20210906075531.GD23554@breakpoint.cc>
References: <20210906060614.25217-1-fw@strlen.de>
	 <20210906060614.25217-3-fw@strlen.de>
	 <aaefcedbe475b6bf060bbb4d6266233d57d59225.camel@redhat.com>
	 <20210906075531.GD23554@breakpoint.cc>
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

On Mon, 2021-09-06 at 09:55 +0200, Florian Westphal wrote:
> Paolo Abeni <pabeni@redhat.com> wrote:
> > > +	/* Set PENDING again in case we found an ssk
> > > +	 * that could not accept more data
> > > +	 */
> > > +	if (unlikely(copied == 0) &&
> > > +	    READ_ONCE(msk->snd_una) == msk->snd_nxt && ssk)
> > > +		mptcp_check_and_set_pending(sk);
> > 
> > @Florian: Why we need to check for ssk != NULL?
> 
> Because I don't think it makes sense to re-try ASAP if we could
> not find a ssk, and instead defer until next firing of rtx timer.

Ok
> 
> > Do we need something similar for __mptcp_subflow_push_pending(), too?
> 
> I don't think so, its thats not invoked from the mptcp-release cb; 

yup, right. To be clear, with "something similar" I also referred to
ensuring the rtx timer is armed.

> also:
> 
> > I'm wondering if this will cause a sort of 'spinning'/busy loop on
> > above condition inside mptcp_release_cb().
> 
> Hmm, right, that might indeed happen.
> It should be sae to remove the above clause and unconditioally wait
> for the reworked rtx timer to assert pending bit again.

+1 :) (assuming s/sae/safe/ :)

Thanks!

Paolo


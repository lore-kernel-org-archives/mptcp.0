Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949DA2C85
	for <mptcp@lists.linux.dev>; Wed, 20 Oct 2021 17:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1634751788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rd66419CkS7TyO5/ue/fPjEHRIaCDDPh60rdR/R59vI=;
	b=SrzBvfjnIVi5gEvShcRqWx+SaOgr2COTwk0t6RY37mYLmI9p/mm9d/PrNtN3K3QJA+tki5
	XJ0cr+yXR8L2tniKDucI2ETUcHY+XFoE8W/eRSu0Bl9a5ONrUlk2KLpqLJqhFjRPqbzvIJ
	LBOd0dcbwzjja0pDQV3eQREevjq5QWk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-ltwUfiySOKiDzO1OZTPe4w-1; Wed, 20 Oct 2021 13:43:07 -0400
X-MC-Unique: ltwUfiySOKiDzO1OZTPe4w-1
Received: by mail-wm1-f69.google.com with SMTP id z26-20020a05600c221a00b0030da55bc454so4609703wml.4
        for <mptcp@lists.linux.dev>; Wed, 20 Oct 2021 10:43:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=rd66419CkS7TyO5/ue/fPjEHRIaCDDPh60rdR/R59vI=;
        b=1NzGkT274RMuC0WFxDvV/OuvAEDVL/jE/H1w8oV9+vkyni4woYHrRK9Ke7Mo0REEu5
         JnQnzpaZ5//UNzW9cFry2AeZsIfeHPdU0cO8nVBErqGRJifGP4N9zbLz7LHzYybtFHlL
         cTR5muisZgm7ISu18oJAGvX2swCJUedq7pgUp4LxmJfeh7/fCPO8MEj1/Gi+DJebiUeO
         GCU4sjDrWjQSRes9J6clfDYqiRbOZeOJlYYWhThOqWctYf2mIrwHcAgN1LgKgZ7N0Czd
         4LMf0f9aWnnT+tad+SOA15fr3URJH+clYFVrJmbu2t7Flvq7OWvG7x46NCAN5TMbMVjq
         t61g==
X-Gm-Message-State: AOAM5320SYnGQfn+YBaa/wtrWxuHu+a7s9eN8z9pmL6ufjW0/G0uK7eh
	jH0S1aAWNpXfLgn8CJdlVxg3Hp6ZaJnY4AS7O2nG9lLGy/CoT+FVTmXSpHQSj3os95keDO3+ksb
	uUFJ2CbD8XoeLKa0=
X-Received: by 2002:a1c:a712:: with SMTP id q18mr742449wme.23.1634751785763;
        Wed, 20 Oct 2021 10:43:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwb5LQzWW7zzEWo8RikqHHgHQRnCrP8gUWo2olawn8hcs/ox4ON2ygJaadtTm1PHO93K4Z6fQ==
X-Received: by 2002:a1c:a712:: with SMTP id q18mr742430wme.23.1634751785524;
        Wed, 20 Oct 2021 10:43:05 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-240-164.dyn.eolo.it. [146.241.240.164])
        by smtp.gmail.com with ESMTPSA id p11sm6739305wmi.0.2021.10.20.10.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 10:43:05 -0700 (PDT)
Message-ID: <1050afc1272cfbc66e91e653ef66462963436c0d.camel@redhat.com>
Subject: Re: [RFC PATCH v2] selftests: mptcp: more stable simult_flows tests
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev, Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 20 Oct 2021 19:43:03 +0200
In-Reply-To: <32692122-28e1-4028-36c4-43649e2fa629@linux.intel.com>
References: <9d66028a72b6807d4dc3397bb70f028cbc78161d.1634310418.git.pabeni@redhat.com>
	 <32692122-28e1-4028-36c4-43649e2fa629@linux.intel.com>
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

On Fri, 2021-10-15 at 17:12 -0700, Mat Martineau wrote:
> On Fri, 15 Oct 2021, Paolo Abeni wrote:
> 
> > Currently the simult_flows.sh self-tests are not very
> > stables, expecially when running on slow VM.
> > 
> > The tests mesures runtime for transfers on multiple subflows
> > and check that the time is nearby the theoretical maximum.
> > 
> > The current test infra introduces a bit of jitter in test
> > runtime, due to multiple explicit delays. Additionally the
> > runtime is measured by the shell script wrapper. On slow
> > VM, the script overhead is measurable and subject to relevant
> > jitter.
> > 
> > One solution to make the test more stable would be adding more
> > slack to the expected time; that could possibly hide reall
> > regressions. Instead move the measurement inside the command
> > doint the transfer, and drop most unneeded sleep.
> > 
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > @matttbe: could you please double check this makes simult_flows
> > tests really more stable in your testbed?
> > 
> > Now the slack is really quite tight, I think we can raise it a
> > little more, without loosing the ability of catching regressions
> 
> I still get occasional failures on my slow desktop VM (lots of debug 
> features turned on), but a little more slack would help. Most of the time 
> all cases succeed. If I see a failure, it's just one test out of the 
> batch. These are each from separate runs of simult_flows.sh:
> 
> unbalanced bwidth                                           transfer slower than expected! runtime 4500 ms, expected 4005 ms max 4005        [ fail ]
> 
> 
> unbalanced bwidth with opposed, unbalanced delay            transfer slower than expected! runtime 4632 ms, expected 4005 ms max 4005        [ fail ]

Let me elaborate a bit more here.

Before this patch, I observed 2 different kind of failures:

- off by few ms. The root cause was the jitter introduced by the
VM/scripts/tests env. That should be resolved now.

- off by a few hundred ms. The root cause is a little more uncertain,
but I think it's due to HoL blocking for the faster subflow. I observe
this kind of failure only when the subflows have different speeds.

Looking at the pcap traces with wireshark, and doing the time-sequence
stream graph (Stevens), the slower subflow has a pretty much constant
slope, while the faster one has some smallish periods with a lower
slope.

I'm experimenting a patch doing HoL blocking estimation in a similar
way to blest. It looks like it improves the situation, but I need do to
 more experiments.

Cheers,

Paolo



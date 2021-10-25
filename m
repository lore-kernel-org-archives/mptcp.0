Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CF472
	for <mptcp@lists.linux.dev>; Mon, 25 Oct 2021 07:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1635148784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nqhId6OVW3kgV2SdgbVvlCyK0KTdlePOT1GoANZQqIY=;
	b=ak4dDjngDo4HrAE+6gBeD4T/0g/WhHmxB9YYiFpOTMVJddaeFKn8pldZze1J+kh8CcWB5a
	XE0wzOOF7wNuvbFqAwJ7Niy6UFNs/vVr/ni/YmHnbakRSCkmgQUY6+KFG6ts3aOMCyYcEQ
	QWD0ZM++D5FDuvUqsB8PUl40LlnrozA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-ANqHhXEfNsOPmR8CLciqXQ-1; Mon, 25 Oct 2021 03:59:42 -0400
X-MC-Unique: ANqHhXEfNsOPmR8CLciqXQ-1
Received: by mail-ed1-f70.google.com with SMTP id k28-20020a508adc000000b003dd5e21da4bso1458517edk.11
        for <mptcp@lists.linux.dev>; Mon, 25 Oct 2021 00:59:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nqhId6OVW3kgV2SdgbVvlCyK0KTdlePOT1GoANZQqIY=;
        b=BKl0crSqnJxA7g6qmkxG0B8BhKf+kA2DO757zk5E0ELXP7w0znXEU4EalsULjoIHo5
         Blc0Xv4y/K8WVqio4dDoGC65K5JB5nrkTeyjPeXY0UlAtKFHEl+DMj4M5uraWo8HYXGZ
         H5xEpVsinsezh15+aExT8Pr2k37FotuesHVqLwe6N8lgYuwhz84eUOfuYQn8eTYhauIi
         kfOwQrrD05UPUvVeHZf+PXvqaRaHVueBBOqocdmtCb8EO4tZei6ZTYerOLeHEhDX2zuI
         P1XsUuOqw4DRac7GVZNjGBKAqWqvWAusrEk/H/6d4aeq3H+AmEIgb6syTPo+/BN9PGYm
         2/6A==
X-Gm-Message-State: AOAM5319T2VqnR+CYH3Oppor+VLA7YYyvkQd34E9sLZzaueR3M4Hq/7H
	PdJrrPc1SignXhHUsDDQhvY9jlmcX4m64oyQLKxTUy1H0GZ1hTyKPdWZP9s5Vh9uwcC7731Xw9p
	bkyTakyUSZ8OstHI=
X-Received: by 2002:a05:6402:402:: with SMTP id q2mr24656611edv.248.1635148781655;
        Mon, 25 Oct 2021 00:59:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxubVla3WzVZR0GC+gfvCFcBxNiog7DTHJ7CwRszJkO5HQ3iBazoh04XuVmzmsTXBsAUUOwWA==
X-Received: by 2002:a05:6402:402:: with SMTP id q2mr24656584edv.248.1635148781410;
        Mon, 25 Oct 2021 00:59:41 -0700 (PDT)
Received: from localhost (net-188-218-17-84.cust.vodafonedsl.it. [188.218.17.84])
        by smtp.gmail.com with ESMTPSA id hp13sm5239779ejc.66.2021.10.25.00.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 00:59:40 -0700 (PDT)
Date: Mon, 25 Oct 2021 09:59:40 +0200
From: Davide Caratti <dcaratti@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-next v7 8/8] DO-NOT-MERGE: mptcp: mp_fail test
Message-ID: <YXZj7LGAmMcXAq6Z@dcaratti.users.ipa.redhat.com>
References: <2e9a15d32cd39483dd1e18174d6c73b33e0566b5.1634531093.git.geliang.tang@suse.com>
 <7e1c37e5-a636-68f1-aaa-329f951b2c55@linux.intel.com>
 <CA+WQbwt4dk5vQyoPgxv7=ctsaNetcbt855Md+SL6juFZcLUPgA@mail.gmail.com>
 <YW6BzNwiyR9i8KSQ@dcaratti.users.ipa.redhat.com>
 <f61714c1-09cb-e4a0-f78c-5294bcaea890@tessares.net>
 <CAKa-r6vQo+=tQDMRkyG2xczR8wMYPufRD4LU7Xj9+xbP2zVWGw@mail.gmail.com>
 <8d7963f3-1983-0086-dcbe-16e950230f0a@tessares.net>
 <YXEwoTyTQxN3dcQx@dcaratti.users.ipa.redhat.com>
 <a025ed1d-eb63-b5df-9f38-77487f72d5e0@tessares.net>
 <CA+WQbwsM-27sNRKbb-whDWbA-+Gg1H=mtjS83ELn3Y+m4Wx=oQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CA+WQbwsM-27sNRKbb-whDWbA-+Gg1H=mtjS83ELn3Y+m4Wx=oQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dcaratti@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 22, 2021 at 03:37:38PM +0800, Geliang Tang wrote:
> Hi Matt, Davide,
> 

[...] 

> > >> The only thing is that netem will introduce errors at random positions,
> > >> maybe in IP/TCP headers but it is maybe not an issue. If the TC filter
> > >> command is enough, it might help to produce more controlled tests.
> > >
> > > maybe TC flower + action is even more accurate then netem: because it leaves
> > > you the freedom to "corrupt" only packets after the 3WHS (or only the 3WHS,
> > > depending on the match arguments of flower).
> > > You can obtain the same randomization as netem by using TC "act_gact" random
> > > feature ("CONFIG_GACT_PROB=y")
> > >
> > >  # tc filter add dev vetha egress protocol ip prio 1001 flower \
> > >   > ip_proto tcp \
> > >   > tcp_flags 0x10/0xff \ <-- only the ACK BIT is set
> > >   > action pass random determ pipe 10 \    <-- 1 packet every 10 goes to pedit, others go out unmodified
> > >   > pedit munge offset 148 u32 invert pipe csum tcp <-- corrupt the payload and recompute checksum
> >
> > Good point!
> > I don't know if Geliang wants to have all packets transporting data that
> > are being corrupted or a random one out of X packets or only a specific one.
> 
> I want to have only a specific packet to be corrupted, like sending 10
> unmodified packets, then sending 1 corrupted packet, then sending 10
> unmodified packets. How can I do this?

you can use TC act_gact "random determ" :

 # tc filter add dev eth0 egress protocol ip <filter params> \
 > action pass          random determ pipe 10  pedit munge ....

          ^^^            ^^^^^^^^^^^^^^^^^^^
        control          alternate control action:
        action:          pipe to pedit 1 packet 
        pass             every 10 packets



then check counters of the 2 actions:

 # for act in gact pedit; do \
 > tc -s action show action $act; \
 > done

and verify that gact packet counters are 10 times bigger than pedit.
Let me know if that works!

-- 
davide
 


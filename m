Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21082F25
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 08:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1644396572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TcjaM5N2FpfiHc76i8LbaQzZxaprNf5IYpzu7lS2oEI=;
	b=MM1aJ+ZHrRdYsNmMTQpvTFkNWXf6y/vT0VyD2vGbT3hcpPZbItrB+DDRlo6YosYeb+WzW7
	aEt3m5KYs5HXsGTXG1tO64vR/EGBwNIaZE5+qpJuy+9sP/x1PB9Kv0cCRNaVD/tDk5OMqk
	Y+qQ6Gqa2fp2tQyGsVR+zlVLMBOXeaw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-facnng-hM3C40gQHompvkA-1; Wed, 09 Feb 2022 03:49:26 -0500
X-MC-Unique: facnng-hM3C40gQHompvkA-1
Received: by mail-wr1-f71.google.com with SMTP id w7-20020adfbac7000000b001d6f75e4faeso830076wrg.7
        for <mptcp@lists.linux.dev>; Wed, 09 Feb 2022 00:49:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=TcjaM5N2FpfiHc76i8LbaQzZxaprNf5IYpzu7lS2oEI=;
        b=Y6I/7hTqf9pj+I1fruMsj9bTP+6LsoxPds3vczAvmv3YIQQilMD/vz4123x+oTmHUO
         INlx0pdE5GEg5bcnoPNJ8TLW6yV5Zcn9UWV58UEgWm7PxfPhmlGETmINX/PHsZj/wwLn
         3V6jDE8sHaSeLytC7BDTZE4476b6Cimg/rUQPQcdNUyAkehAEGBvPtUOWKb9HfKMR7fv
         W/XZgAiRZ6CcNssiDi/7JXSoVDAIT//fHaVSh9oxJQc8vaWVtwuFBJjp2qcF7re81bDf
         nqqoWuxK20Rtwb6mOUnKzTPiADopd7BRn0iAxUmX7TZaxw2WglIx6ARCU3J701U1NZu7
         erIw==
X-Gm-Message-State: AOAM5321Iq05jl3Ogzd126QRp87gnkqDCIe2eLU4H4lXS2rvqBurtx+T
	nH6erEJnfIe93vrR6qnnU1uIg/H0pygDM6vfa1GRaJt7Rdt6rC0LLaa9i1nMSdtAcbKRANOvuh3
	PDT3GtX9hSieln6g=
X-Received: by 2002:a5d:468f:: with SMTP id u15mr1161986wrq.527.1644396565435;
        Wed, 09 Feb 2022 00:49:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyE5ZF8nn9/+cgooPCv+qsR+kt2Yq8yI83NcVzxMD4048EgvR1QiXNj3yVgB/Ge9ijZEVZ9Gg==
X-Received: by 2002:a5d:468f:: with SMTP id u15mr1161974wrq.527.1644396565182;
        Wed, 09 Feb 2022 00:49:25 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-96-254.dyn.eolo.it. [146.241.96.254])
        by smtp.gmail.com with ESMTPSA id y15sm21750601wry.36.2022.02.09.00.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 00:49:24 -0800 (PST)
Message-ID: <4a0db1e5aa0f483de5ccf4e86f05eca5f9d88fce.camel@redhat.com>
Subject: Re: [PATCH mptcp-net v2 2/4] mptcp: fix race in incoming ADD_ADDR
 option processing.
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, Matthieu Baerts
	 <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Date: Wed, 09 Feb 2022 09:49:23 +0100
In-Reply-To: <4bab507-7452-b973-279a-70a3e911906f@linux.intel.com>
References: <cover.1644346664.git.pabeni@redhat.com>
	 <9055dfabebe975c34e5f741885e1c70ecb49da36.1644346664.git.pabeni@redhat.com>
	 <0fcbb69f-1e23-be3c-aea0-86bafb3a68fb@tessares.net>
	 <4bab507-7452-b973-279a-70a3e911906f@linux.intel.com>
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
Content-Transfer-Encoding: 8bit

On Tue, 2022-02-08 at 16:54 -0800, Mat Martineau wrote:
> On Tue, 8 Feb 2022, Matthieu Baerts wrote:
> 
> > Hi Paolo,
> > 
> > On 08/02/2022 20:06, Paolo Abeni wrote:
> > > If an MPTCP endpoint received moltiple consecutive incoming
> > > ADD_ADDR options, mptcp_pm_add_addr_received() can overwrite
> > > the current remote address value after the PM lock is released
> > > in mptcp_pm_nl_add_addr_received() and before such address
> > > is echoed.
> > > 
> > > Fix the issue caching the remote address value a little earlier
> > > and always using the cached value after releasing the PM lock.
> > 
> > Thank you for looking at that!
> > 
> > It seems really helping for me: 500 iterations without issues! I guess
> > we can add:
> > 
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/254
> > 
> > (I guess we don't need Reported/Tested-by tags.)
> > 
> > Not related to that but do you think we could have a similar issue with
> > RM_ADDR (issues/225)?
> > 
> > 
> > But one important thing: this series introduces a regression apparently:
> > packetdrill ADD_ADDR tests are now failing because the port is missing
> > in the echo packet:
> > 
> > ---------- 8< ----------
> > Our CI did some validations and here is its report:
> > 
> > - KVM Validation: normal:
> >  - Unstable: 2 failed test(s): packetdrill_add_addr selftest_mptcp_join 🔴:
> >  - Task: https://cirrus-ci.com/task/5025097999187968
> >  - Summary:
> > https://api.cirrus-ci.com/v1/artifact/task/5025097999187968/summary/summary.txt
> > 
> > - KVM Validation: debug:
> >  - Unstable: 1 failed test(s): packetdrill_add_addr 🔴:
> >  - Task: https://cirrus-ci.com/task/4765935646015488
> >  - Summary:
> > https://api.cirrus-ci.com/v1/artifact/task/4765935646015488/summary/summary.txt
> > 
> > Initiator: Patchew Applier
> > Commits:
> > https://github.com/multipath-tcp/mptcp_net-next/commits/34bad3e35cbc
> > ---------- 8< ----------
> > 
> > This seems to be due to this patch 2/4.
> > 
> > > 
> > > Fixes: f7efc7771eac ("mptcp: drop argument port from mptcp_pm_announce_addr")
> > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > > ---
> > >  net/mptcp/pm_netlink.c | 19 ++++++++++++++-----
> > >  1 file changed, 14 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > > index fb8d4bfcfbd6..4b6aa89d45a5 100644
> > > --- a/net/mptcp/pm_netlink.c
> > > +++ b/net/mptcp/pm_netlink.c
> > > @@ -660,6 +660,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
> > >  	unsigned int add_addr_accept_max;
> > >  	struct mptcp_addr_info remote;
> > >  	unsigned int subflows_max;
> > > +	bool reset_port;
> > 
> > I'm very surprise the compiler doesn't complain about this line because
> > reset_port can be used later while not having been set before. Is it
> > normal with 'bool'?
> > 
> > 
> > Setting it to false by default fixes the issue with packetdrill on my side:
> > 
> > ---------- 8< ----------
> > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > index 4b6aa89d45a5..98b485406afa 100644
> > --- a/net/mptcp/pm_netlink.c
> > +++ b/net/mptcp/pm_netlink.c
> > @@ -660,7 +660,7 @@ static void mptcp_pm_nl_add_addr_received(struct
> > mptcp_sock *msk)
> >        unsigned int add_addr_accept_max;
> >        struct mptcp_addr_info remote;
> >        unsigned int subflows_max;
> > -       bool reset_port;
> > +       bool reset_port = false;
> >        int i, nr;
> > 
> >        add_addr_accept_max = mptcp_pm_get_add_addr_accept_max(msk);
> > ---------- 8< ----------
> > 
> > (I can fix the issue when applying the patch if it is easier)
> 
> With Matthieu's reset_port fix, it's working well for me too.

Whoops, not sure how I forgot the proper initializer, and I'm also
surprised the compiler did not warn (the latter may provide some excuse
for the first ;)

Do you prerfer a formal repost or can you mangle the patch in
patchwork?

Thanks!

Paolo



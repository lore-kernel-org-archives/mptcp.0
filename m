Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DDB2C80
	for <mptcp@lists.linux.dev>; Thu, 21 Oct 2021 09:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1634807437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ah3BT0g3o5HlGFpj2Y+aySnR3Jr/KPY5KEU7KCltwms=;
	b=P+HXZEBJQCsMmfnNeCALc6LRWw2GPmj7fiS+J72+x3NuTX5Pol9SAwcjSyJhp4aEBIdUPF
	bZ66NYmFgizYRsjxtCwCzHCm85rllfv8llye949pPSb531kqLD01sTX5QK9t8sOMXTvGKn
	em6udT28NC8+Zf5VAYC6kZiZpXn/NFU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-HSd6gfU3PsSo_mwVZk_a_g-1; Thu, 21 Oct 2021 05:10:36 -0400
X-MC-Unique: HSd6gfU3PsSo_mwVZk_a_g-1
Received: by mail-wm1-f72.google.com with SMTP id v10-20020a1cf70a000000b00318203a6bd1so25741wmh.6
        for <mptcp@lists.linux.dev>; Thu, 21 Oct 2021 02:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Ah3BT0g3o5HlGFpj2Y+aySnR3Jr/KPY5KEU7KCltwms=;
        b=IYAkPuas7bH9T0ZJYlx/tEQVYC7Bwa24Q/j4tWXtTwOR1O2ISBrxlIUKPTudjXROl8
         RM21qRCKJUdaFt8P7yfeiies8WwiK5kpI8s8UiOSSNObxeXTBAFBzS9IVGafeW3EN9kM
         ZzCrI165aH418bD9dzWCa6Jw2OikRgK1+AXnvLFjIOo7/5iINLQCSMx7x/Fn4HrrvvvP
         RVmlHNOkDI7iTIDRSPbnvCCnPr1fatF1GVpBOhiNWTkzNNxWXJJEOzDFun0gRXc9w70T
         fJR6g544+patwhLXXQ6dFliuTc1hF0cOX5Hp31XQDaO6iQZxFOL24MWYFLMV5772IXZR
         42Bw==
X-Gm-Message-State: AOAM53014xOxdl8+jnU+XmUQqljIKSYkGELC+IFYCd+9CJ0K6DyEyPUc
	WPOcusqYKprN86ggPKyjx14+R0Mz7FEbVta/mjkgQH/PsHP232Og/JmE/IJhJVq24NYOUQhOe8A
	5Dfrb69OF/qBs2UA=
X-Received: by 2002:a05:600c:22d0:: with SMTP id 16mr19983388wmg.35.1634807434937;
        Thu, 21 Oct 2021 02:10:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBVRO3m54CZn4rIs69IwowX8lmbeNfN7ijJKoK9l4cyEH4bPN1Kz2BnJ4AO9TRKYT2APOU/A==
X-Received: by 2002:a05:600c:22d0:: with SMTP id 16mr19983368wmg.35.1634807434689;
        Thu, 21 Oct 2021 02:10:34 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-240-164.dyn.eolo.it. [146.241.240.164])
        by smtp.gmail.com with ESMTPSA id o10sm4844222wmq.46.2021.10.21.02.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 02:10:34 -0700 (PDT)
Message-ID: <6596df94bacc77a9c0a2411817ffae101b4ae30b.camel@redhat.com>
Subject: Re: [RFC PATCH v2] selftests: mptcp: more stable simult_flows tests
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev, Mat Martineau <mathew.j.martineau@linux.intel.com>
Date: Thu, 21 Oct 2021 11:10:33 +0200
In-Reply-To: <a4e38a35-8839-0827-498c-44ab1b724c83@tessares.net>
References: <9d66028a72b6807d4dc3397bb70f028cbc78161d.1634310418.git.pabeni@redhat.com>
	 <32692122-28e1-4028-36c4-43649e2fa629@linux.intel.com>
	 <1050afc1272cfbc66e91e653ef66462963436c0d.camel@redhat.com>
	 <a4e38a35-8839-0827-498c-44ab1b724c83@tessares.net>
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

On Thu, 2021-10-21 at 10:54 +0200, Matthieu Baerts wrote:
> Hi Paolo,
> 
> On 20/10/2021 19:43, Paolo Abeni wrote:
> > On Fri, 2021-10-15 at 17:12 -0700, Mat Martineau wrote:
> > > On Fri, 15 Oct 2021, Paolo Abeni wrote:
> > > 
> > > > Currently the simult_flows.sh self-tests are not very
> > > > stables, expecially when running on slow VM.
> > > > 
> > > > The tests mesures runtime for transfers on multiple subflows
> > > > and check that the time is nearby the theoretical maximum.
> > > > 
> > > > The current test infra introduces a bit of jitter in test
> > > > runtime, due to multiple explicit delays. Additionally the
> > > > runtime is measured by the shell script wrapper. On slow
> > > > VM, the script overhead is measurable and subject to relevant
> > > > jitter.
> > > > 
> > > > One solution to make the test more stable would be adding more
> > > > slack to the expected time; that could possibly hide reall
> > > > regressions. Instead move the measurement inside the command
> > > > doint the transfer, and drop most unneeded sleep.
> > > > 
> > > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > > > ---
> > > > @matttbe: could you please double check this makes simult_flows
> > > > tests really more stable in your testbed?
> > > > 
> > > > Now the slack is really quite tight, I think we can raise it a
> > > > little more, without loosing the ability of catching regressions
> > > 
> > > I still get occasional failures on my slow desktop VM (lots of debug 
> > > features turned on), but a little more slack would help. Most of the time 
> > > all cases succeed. If I see a failure, it's just one test out of the 
> > > batch. These are each from separate runs of simult_flows.sh:
> > > 
> > > unbalanced bwidth                                           transfer slower than expected! runtime 4500 ms, expected 4005 ms max 4005        [ fail ]
> > > 
> > > 
> > > unbalanced bwidth with opposed, unbalanced delay            transfer slower than expected! runtime 4632 ms, expected 4005 ms max 4005        [ fail ]
> > 
> > Let me elaborate a bit more here.
> > 
> > Before this patch, I observed 2 different kind of failures:
> > 
> > - off by few ms. The root cause was the jitter introduced by the
> > VM/scripts/tests env. That should be resolved now.
> 
> Should we already apply your RFC patch in the export branch then?

I'm not 110% sure it has not side effect on the mptcp_join.sh self-
tests. I guess we can go ahead and check that :)

/P


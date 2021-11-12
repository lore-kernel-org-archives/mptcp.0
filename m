Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D3B68
	for <mptcp@lists.linux.dev>; Fri, 12 Nov 2021 15:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1636729581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w2iGf07rwdlbc6S+MxR9T9Ja1Z5aUsiiwXvAfpqR710=;
	b=IGJ1wKEgQwKV65IXguk2T2Pr3ogbjgOBpT4EpRKt+5mk7uA1ulsuXuRbZnmplLUG8iMshu
	8h437lIKAlF+raHzz38uMjtaSe7c48m8Ko3HnBcsZZIqm9pS2ICWo+8jnGye2GosgNtFGp
	lsisraQgV/JF4IN8XcBuQsWASl70bLE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-581-xF_TR1P4NJ2BJp4AUizclw-1; Fri, 12 Nov 2021 10:06:18 -0500
X-MC-Unique: xF_TR1P4NJ2BJp4AUizclw-1
Received: by mail-wm1-f70.google.com with SMTP id 145-20020a1c0197000000b0032efc3eb9bcso6443567wmb.0
        for <mptcp@lists.linux.dev>; Fri, 12 Nov 2021 07:06:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w2iGf07rwdlbc6S+MxR9T9Ja1Z5aUsiiwXvAfpqR710=;
        b=WXlxr+qxjgUKoBOSIvVl8p9PGiDTmHqjIWr5BPxOKNfh/zm1bGFHPV8ffpGjP2UvQE
         43VJ5emgSoKd6oUsvwdk30M0H8veRXsC6aYxwXHaxnPrW4pg6jUyVURUna0XGOM+Lnta
         W2/itRXKDFYKiAUOEurHBKO80+n6nkDGyvpd22WXb0YiArmz/uGvEjehMKtiEzzuhvoJ
         VctYv4MnBNouJMpUEAM5ylTYEbPU26JQ8+p99y2TQiLHC9CV0aSa3jJuqS3/RQWt+919
         kLuiXkOS+Haxp2/dz8fE1MuisLkuOvEIQgvpOCQFUZdGQX5NQ3YqZk8ahmDrfPR/ZEZk
         Eglg==
X-Gm-Message-State: AOAM533umQi5aPfiM74afYbgMKtLf8f/Vtbe56rP9AzQaNV9R8sAnqt/
	vAOvxOipdKgpMpc/fX4cUD81Xuk1+aKzr39z8W5HIjfdA3ptGRsOVKTAfLvla8K/m0jZ78DMl7/
	GpiAVbqgT9RQDE0A=
X-Received: by 2002:adf:d1e2:: with SMTP id g2mr19990130wrd.346.1636729577153;
        Fri, 12 Nov 2021 07:06:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzfekkyjARjPh+wbTTIKk2ydRdFFcZi2s1eGbKI9TnPRxg6wbP1hORowh2IfB3Dd0Z8qPQdFw==
X-Received: by 2002:adf:d1e2:: with SMTP id g2mr19990108wrd.346.1636729576987;
        Fri, 12 Nov 2021 07:06:16 -0800 (PST)
Received: from localhost (net-188-218-25-126.cust.vodafonedsl.it. [188.218.25.126])
        by smtp.gmail.com with ESMTPSA id n1sm6405674wmq.6.2021.11.12.07.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 07:06:16 -0800 (PST)
Date: Fri, 12 Nov 2021 16:06:15 +0100
From: Davide Caratti <dcaratti@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] mptcp: allow changing the "backup" bit by
 endpoint id
Message-ID: <YY6C5wrG94WYonzg@dcaratti.users.ipa.redhat.com>
References: <434d58757c972252e5af7ac2574c3791a9778441.1636628783.git.dcaratti@redhat.com>
 <f468c1e1-ec26-763a-bc3-0b080b7a9db@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <f468c1e1-ec26-763a-bc3-0b080b7a9db@linux.intel.com>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dcaratti@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hello Mat, thanks for reading,

On Thu, Nov 11, 2021 at 04:09:13PM -0800, Mat Martineau wrote:
> On Thu, 11 Nov 2021, Davide Caratti wrote:
> 
> > a non-zero 'id' is sufficient to identify MPTCP endpoints: allow changing
> > the value of 'backup' bit by simply specifying the endpoint id.
> > 
> > Link: https://github.com/multipath-tcp/mptcp_net-next/issues/158
> > Signed-off-by: Davide Caratti <dcaratti@redhat.com>
> > ---
> > net/mptcp/pm_netlink.c | 19 +++++++++++++++----
> > 1 file changed, 15 insertions(+), 4 deletions(-)
> > 
> > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > index 7b96be1e9f14..b4c647e67930 100644
> > --- a/net/mptcp/pm_netlink.c
> > +++ b/net/mptcp/pm_netlink.c
> > @@ -1700,24 +1700,35 @@ static int mptcp_nl_addr_backup(struct net *net,
> > 	return ret;
> > }
> > 
> > +static int mptcp_nl_set_flags_idzero(u8 flags)
> > +{
> > +	return -EOPNOTSUPP;
> > +}
> 
> Hi Davide -
> 
> Is the above function added as a placeholder for something in the future?

yes it's meant to be a placeholder, and I should have mentioned it in the
commit message. Any advice on what should happen from the functional
point of view when we change the "backup" bit for id=0 ?

> Seems like a direct return below would be clearer.

with a TODO comment, also. But just aesthetic, because probably the
compiler should make no difference and inline the call to
mptcp_nl_set_flags_idzero().

-- 
davide



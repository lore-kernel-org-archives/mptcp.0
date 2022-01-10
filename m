Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E312C9C
	for <mptcp@lists.linux.dev>; Mon, 10 Jan 2022 15:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1641830371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hg/imvlmC429uw5j6ItUp+lheVvpWgJvs/0kAMUNAN0=;
	b=hTrZUL9AnqCosPzfmtijlBaz9LK1bwGIaVWhZlu5LZJHVTeJvKF2S07UuX/jxh6NRFEEno
	yMS23/0KvG2J+vz7bO+K5O99KsprUQeKIIZi+9NfGBOii5kB2RX+DirG91ftPh5b6tK6+G
	qiGRIhQGZnAOAVs97v/Vlv8iX2Jj9YM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-34-n4oNeeHgNJixFdGKpl2g8g-1; Mon, 10 Jan 2022 10:59:30 -0500
X-MC-Unique: n4oNeeHgNJixFdGKpl2g8g-1
Received: by mail-qv1-f71.google.com with SMTP id kl5-20020a056214518500b004112e88962cso13544924qvb.4
        for <mptcp@lists.linux.dev>; Mon, 10 Jan 2022 07:59:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Hg/imvlmC429uw5j6ItUp+lheVvpWgJvs/0kAMUNAN0=;
        b=1RPXhRVDfHRe5sbmnSp3JaJJXD7xiSE5N0Si8Xfv2qMYlZsbARPM9NmPmMbJfL826R
         48MCLZ58XDNvsnAxbAfjZz/Hb09Zd9CSfxuLo6sQ+EP0de+lX00Zxq+pzzBr9DUkgVQc
         agI0MtmoFqeoH48ZXLKLRFCaq51w/k8qVNBPjI3dlhiAYEn3PZrdBFw2yM/t3c0C9WKe
         FuJyUNp/a+EEhd4/Nh83sWBpqFJM2puYwJVPtRhzj609qBcsZYMdmOG4SOcWbEat+fwR
         xhjnEvvPWqJb0K9N37k/eNPkOrBu4G9mKjphhfVnnY+hv4YOZudGu88IZAOZGOGFxsol
         ngDA==
X-Gm-Message-State: AOAM533cY8i+22hv4ohXQ7vthiBx2ihYs1+n7eJJ8m+hhN4ukhn2J47e
	UnbipF87fu6jtuwJ3NVtlDYYw2/zCNz3J0ilqppOCiNftmBlROu6p+CmWZBGELW6ncJ0cUSeuIx
	vzE8kIvPcDO828KI=
X-Received: by 2002:ad4:5aa9:: with SMTP id u9mr243719qvg.50.1641830370111;
        Mon, 10 Jan 2022 07:59:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxaU7NBwYlflri9jp2T+uQrK/a+XZRlN+sE0n00qvi4o2QZ1karG9HBM/gOwwHe/UfkPOm1rA==
X-Received: by 2002:ad4:5aa9:: with SMTP id u9mr243703qvg.50.1641830369826;
        Mon, 10 Jan 2022 07:59:29 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-96-254.dyn.eolo.it. [146.241.96.254])
        by smtp.gmail.com with ESMTPSA id m1sm5051751qtk.34.2022.01.10.07.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 07:59:29 -0800 (PST)
Message-ID: <8a502217cfbf1993efcbca0bebbfc8a51d15db44.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 2/7] mptcp: add clear_flags in pm_netlink
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Date: Mon, 10 Jan 2022 16:59:26 +0100
In-Reply-To: <20220110123502.GB3145@bogon>
References: <cover.1641785106.git.geliang.tang@suse.com>
	 <0132f80c0aa9f62deb00c816dab5d51d4032afb1.1641785106.git.geliang.tang@suse.com>
	 <1b01c2a797fad9d2971d485b158d2dbd61d14fec.camel@redhat.com>
	 <20220110123502.GB3145@bogon>
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35)
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

On Mon, 2022-01-10 at 20:35 +0800, Geliang Tang wrote:
> On Mon, Jan 10, 2022 at 12:38:14PM +0100, Paolo Abeni wrote:
> > Hello,
> > 
> > On Mon, 2022-01-10 at 11:30 +0800, Geliang Tang wrote:
> > > Splite set_flags() into two parts, set_flags() and clear_flags(), make it
> > > easy to add new flags to set or clear.
> > > 
> > > This patch added a new PM command MPTCP_PM_CMD_CLEAR_FLAGS, and a new
> > > function mptcp_nl_cmd_clear_flags().
> > > 
> > > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > > ---
> > >  include/uapi/linux/mptcp.h |  1 +
> > >  net/mptcp/pm_netlink.c     | 36 ++++++++++++++++++++++++++----------
> > >  2 files changed, 27 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
> > > index f106a3941cdf..1ca9b13c2ed0 100644
> > > --- a/include/uapi/linux/mptcp.h
> > > +++ b/include/uapi/linux/mptcp.h
> > > @@ -92,6 +92,7 @@ enum {
> > >  	MPTCP_PM_CMD_SET_LIMITS,
> > >  	MPTCP_PM_CMD_GET_LIMITS,
> > >  	MPTCP_PM_CMD_SET_FLAGS,
> > > +	MPTCP_PM_CMD_CLEAR_FLAGS,
> > >  
> > >  	__MPTCP_PM_CMD_AFTER_LAST
> > >  };
> > 
> > I'm unsure if this has already been discussed in some mtg I missed. If
> > so, I'm sorry for the late feedback :(
> > 
> > Looking at the existing netlink interfaces, I *think* the preferred way
> > of handling this would be adding instead a couple of MPTCP address
> > flags:
> > 
> > 	MPTCP_PM_ADDR_FLAG_NOBACKUP,
> > 	MPTCP_PM_ADDR_FLAG_NOFULLMESH
> > 
> > As e.g. IFA_F_NOPREFIXROUTE, IFA_F_NODAD,...
> > 
> > The above should require a similar amount of code and will make it
> > clear that we can't/wan't to flip the SUBFLOW or SIGNAL flags.
> > 
> > WDYT?
> 
> Agree, will update in v2.

[ mostly C&P from IRC ]

I'm sorry for being self-contradictory on this point. Think again about
the above even the 

	MPTCP_PM_ADDR_FLAG_NOBACKUP,
	MPTCP_PM_ADDR_FLAG_NOFULLMESH

thing does look great.

I'm wondering if we could simply extend the current
MPTCP_PM_ADDR_FLAG_BACKUP handling to the MPTCP_PM_ADDR_FLAG_FULLMESH
flag? e.g. set or clear the corresponding entry->flags bit according to
the provided address flag attribute.

Cheers,

Paolo


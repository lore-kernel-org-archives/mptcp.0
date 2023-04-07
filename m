Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3871FD7
	for <mptcp@lists.linux.dev>; Fri,  7 Apr 2023 09:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680861168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fv8sH2BET8VSb8Ldzq5DiMYy8O2E0iX5evUCrTIAvds=;
	b=LMOwzW4cgTv8dJK7C/35s43L3Ta45b0bK+8RMDKk86WSXM3awyuoXZ+Jx4e50KtzeG96Oh
	qwTilbsXJmNd41hPdkNYaCsBWMeA6bKS9DZ6yVBglSm0PizZUKn2Tm2r2LbhMgaIYEBVAs
	JYo90dZqQ5ggSe+3rHKNdcwuZe2Xugs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-RL46qlVNOEaMINe_GsOT6Q-1; Fri, 07 Apr 2023 05:52:47 -0400
X-MC-Unique: RL46qlVNOEaMINe_GsOT6Q-1
Received: by mail-ej1-f71.google.com with SMTP id x3-20020a1709060a4300b00948c0473396so1360091ejf.10
        for <mptcp@lists.linux.dev>; Fri, 07 Apr 2023 02:52:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680861166; x=1683453166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fv8sH2BET8VSb8Ldzq5DiMYy8O2E0iX5evUCrTIAvds=;
        b=g8Nlde1MJAn3ITyrrgaEr8E0K6IIu7QqjnA2SEVmbRCZHVv7KI9fclbqxX2RD0cQye
         nm2gBmgEugYCAKgZFHBRe8VLJEEX19OQI21Ewbv+VgtJ0fIAU3VU1yrWiUaz0WIrTiLW
         N7dyKFk5YvKKbtqxr0QCs0gEbU52yAtL2LTxCJryhErrS87BgPeQqTnV5SAK6uCXTgdt
         xA6Tnh7ly1oOBAC1g1h0x23J7aPZWmVSTvi570arAOGPl1UPNanceYZSs+AWAOEHFfWw
         a2ZiwtvC8bETzAm1/7XtzLKAk511o8QEAEK06FszDDK5xkb7KMoOSMGLuThzTqMP6X7U
         RXyg==
X-Gm-Message-State: AAQBX9dANrhW5/Hj/z0jk9chG2o0QMqMpubbAY1QnClUGS/AwFVtjIXp
	72Jf3SMtuZ8fw5QztXgVFmXAuEvmdxAPcaVfCPHBYmJEFCC2Q7Qv5WgT9xHoOyevj73fFDiz+vb
	XSUuYHEouqZZFKDs=
X-Received: by 2002:a17:906:c799:b0:933:4ca3:9678 with SMTP id cw25-20020a170906c79900b009334ca39678mr2316126ejb.24.1680861166197;
        Fri, 07 Apr 2023 02:52:46 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y0UhDOCPzURb/eFStjX8y9kXNewuc8WpOPulTHlkzqHfsN2yaaacVFGYgNCwwd9GByvQ24lw==
X-Received: by 2002:a17:906:c799:b0:933:4ca3:9678 with SMTP id cw25-20020a170906c79900b009334ca39678mr2316104ejb.24.1680861165875;
        Fri, 07 Apr 2023 02:52:45 -0700 (PDT)
Received: from localhost (net-37-119-203-146.cust.vodafonedsl.it. [37.119.203.146])
        by smtp.gmail.com with ESMTPSA id f13-20020a170906c08d00b0092f289b6fdbsm1869764ejz.181.2023.04.07.02.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 02:52:45 -0700 (PDT)
Date: Fri, 7 Apr 2023 11:52:44 +0200
From: Davide Caratti <dcaratti@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH RFC mptcp-net-next 3/5] Documentation: netlink: add a
 YAML spec for mptcp
Message-ID: <ZC/n7GM/hsIAO3kQ@dcaratti.users.ipa.redhat.com>
References: <cover.1680801697.git.dcaratti@redhat.com>
 <cb2ed01dd8797078c39c014e8c19eab5ddf1f0f2.1680801697.git.dcaratti@redhat.com>
 <7bc87c2f4acbe8157414b11936072efb07ad7f50.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <7bc87c2f4acbe8157414b11936072efb07ad7f50.camel@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hello Paolo, thanks for looking at this!

On Fri, Apr 07, 2023 at 09:56:39AM +0200, Paolo Abeni wrote:
> On Thu, 2023-04-06 at 19:31 +0200, Davide Caratti wrote:
> [...]
> > +attribute-sets:
> > +  -
> > +    name: addr
> > +    name-prefix: mptcp_pm_addr_attr_
> > +    attributes:
> > +      -
> > +        name: unspec
> > +        type: unused
> > +        value: 0
> 
> This entry should not be needed, the tool should add it by default and
> keep the first item with value == 1.

wouldn't this would break the uAPI? I mean, in the current one we have
MPTCP_PM_ADDR_ATTR_UNSPEC equal to zero. Removing the whole element would
make MPTCP_PM_ADDR_ATTR_UNSPEC disappear and potentially break the build
of userspace programs that use it. See below:

 $ git diff 
diff --git a/Documentation/netlink/specs/mptcp.yaml b/Documentation/netlink/specs/mptcp.yaml
index 910307b021ba..12974bf0cf10 100644
--- a/Documentation/netlink/specs/mptcp.yaml
+++ b/Documentation/netlink/specs/mptcp.yaml
@@ -91,10 +91,6 @@ attribute-sets:
     name: addr
     name-prefix: mptcp_pm_addr_attr_
     attributes:
-      -
-        name: unspec
-        type: unused
-        value: 0
       -
         name: family
         type: u16
 $ ./tools/net/ynl/ynl-gen-c.py --mode uapi  \
 > --spec Documentation/netlink/specs/mptcp.yaml --header \
 > | grep -B1 -A1 -i addr_attr_family
enum {
         MPTCP_PM_ADDR_ATTR_FAMILY = 1,
         MPTCP_PM_ADDR_ATTR_ID,

[...]

> > +      -
> > +        name: addr_remote
> > +        type: nest
> > +        nested-attributes: addr
> 
> Is this the definition requiring patch 2/5 ?

yes! I replied to your comment to patch 2/5 (and hopefully didn't mess with the names ;) )
 
> Are there other attribute set requiring such change?

currently ynl-gen-c.py supports only a single attribute-set for
each list of operations - but the effect on the generated code is
not relevant AFAIU.

-- 
davide


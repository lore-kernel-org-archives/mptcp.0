Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D401FBC
	for <mptcp@lists.linux.dev>; Fri,  7 Apr 2023 08:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680857629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1En/IUEMeMru2kNtL2zmYkwOZLasRrPkvr+koFX2DlI=;
	b=aMmuP/EfWCSV7Cn3OFrYr385uKlN2caTrRNp8TVnslBGw93w5/fQQIJyb1BRc2GPWqKsrp
	upN4DU8o+xbJMzbNz+rHmPZTB93upMmoAQ/Em1q968HlV9eOAFiJh8kNwWAL/kmoXRD5wg
	/sGY/VQlrqmxe8t/kigaIMnsLQoFWMI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-NecUrkt8Ocm8qUFGRn4iXA-1; Fri, 07 Apr 2023 04:53:47 -0400
X-MC-Unique: NecUrkt8Ocm8qUFGRn4iXA-1
Received: by mail-ej1-f70.google.com with SMTP id sz19-20020a1709078b1300b009497c250e96so193254ejc.15
        for <mptcp@lists.linux.dev>; Fri, 07 Apr 2023 01:53:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680857625; x=1683449625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1En/IUEMeMru2kNtL2zmYkwOZLasRrPkvr+koFX2DlI=;
        b=PJmXRmovdUGQMT9Ya21Ow2FuEuswgBEFcjlmI6ai36XStHOb7Kv4iAAZjesJQ7Nvf7
         B3UCxsjHGKhboS65oI77H7QxIvJP4XQeU3Jc5oEfpmHoGS4s81wJatUEKm4cB4OysMWU
         A4BsDF8ymXTfWw8RTMpU0BzMDwk7qHl+grTcSTGvPd3x+ylvQScr0Exb5ocObg+av/U1
         LR+a/ND9niFEOiLl8hLRT0gGtz8S4ytLOwdiF7EYDmiAbGBcygPn3DqOj4kk4UeKAE5f
         EgiVoU2dLF3mWeV3M6MFC0f7B4wfb+vRq7r3JQ/L8uEIPv3bgPGo+OUH3sDNU/SyBcww
         NQaA==
X-Gm-Message-State: AAQBX9fLNWIPvEzdxGf7APY4+0QPAR9dXfmR5qwxIyVvnRRpmq7txAev
	iHYFvf4Pt6UVPm2EcInyn2DogM/iUCS5dZQiz3s/WeyRkDZzrLafn74rGgRHXpXcn1wdrYh6xjG
	lV1o+9oyae8/itWmp3/J0lqUO3g==
X-Received: by 2002:a17:906:66d9:b0:930:f953:962c with SMTP id k25-20020a17090666d900b00930f953962cmr2125723ejp.1.1680857625227;
        Fri, 07 Apr 2023 01:53:45 -0700 (PDT)
X-Google-Smtp-Source: AKy350aUQJhlLIp2Q6p5/8gEyDOAS8ZNHnrlQ2sxB3NVliax970v14XdvCK0qagxJKSsTWlQcWSrqg==
X-Received: by 2002:a17:906:66d9:b0:930:f953:962c with SMTP id k25-20020a17090666d900b00930f953962cmr2125704ejp.1.1680857624896;
        Fri, 07 Apr 2023 01:53:44 -0700 (PDT)
Received: from localhost (net-37-119-203-146.cust.vodafonedsl.it. [37.119.203.146])
        by smtp.gmail.com with ESMTPSA id n20-20020a170906725400b0093295ea18c4sm1832825ejk.67.2023.04.07.01.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 01:53:43 -0700 (PDT)
Date: Fri, 7 Apr 2023 10:53:43 +0200
From: Davide Caratti <dcaratti@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH RFC mptcp-net-next 2/5] tools: ynl: fix bug in case of
 multiple nested attributes of the same type
Message-ID: <ZC/aF9ZEhwkKLOkR@dcaratti.users.ipa.redhat.com>
References: <cover.1680801697.git.dcaratti@redhat.com>
 <9414bdc6d3d0212238cec12d4f2d80894910e944.1680801697.git.dcaratti@redhat.com>
 <85d65b14b0550b284bf641ca0db55c550e23b251.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <85d65b14b0550b284bf641ca0db55c550e23b251.camel@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hi Paolo,

thanks a lot for looking at this!

On Fri, Apr 07, 2023 at 10:00:43AM +0200, Paolo Abeni wrote:
> On Thu, 2023-04-06 at 19:31 +0200, Davide Caratti wrote:
> > when a policy contains multiple nested attributes of the same type, avoid
> > re-initializing .request and .reply members.
> 
> It's unclear to me why we need to avoid such re-init...

*disclaimer*: this will sound as a giant word pun, since "pm", "addr" and
"attr" are used in any combination in the current netlink API :)

That said:

"attr" has two nested attributes, "addr" and "remote_addr", of the same
type "addr". When ynl-gen-c.py  parses "addr" (e.g. in the block
describing the "add_addr" operation), it sets

	self.pure_nested_structs['addr'].Request

equal to True, because at least on operation needs it. Then, when it
parses "remote_addr", the call to

	Struct(self, nested, inherited=inherit)

will reset the above variable to 'False'. As a consequence, when it comes
to print the nla_policy struct, the following code will run:

2127     if args.mode == "kernel":
2128         if args.header:
2129             for _, struct in sorted(parsed.pure_nested_structs.items()):
2130                 if struct.request:
2131                     cw.p('/* Common nested types */')
2132                     break
2133             for attr_set, struct in sorted(parsed.pure_nested_structs.items()):
2134                 if struct.request:
2135                     print_req_policy_fwd(cw, struct)
2136             cw.nl()

since struct.request has become True and then resetted to False,
ynl-gen-c.py refuses to print the nla_policy of the nested attribute.
Like I mentioned in the cover letter, changing the yaml spec in a way that
at least one operation requires 'remote_addr' in the attribute-set will
make this issue disappear; anyway, I think that the current behavior of
ynl-gen-c.py is not intentional, that's why I did this fix attempt.

[...]

> > diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
> > index cc2f8c945340..ba55f217a006 100755
> > --- a/tools/net/ynl/ynl-gen-c.py
> > +++ b/tools/net/ynl/ynl-gen-c.py
> > @@ -812,7 +812,8 @@ class Family(SpecFamily):
> >                      inherit = set()
> >                      nested = spec['nested-attributes']
> >                      if nested not in self.root_sets:
> > -                        self.pure_nested_structs[nested] = Struct(self, nested, inherited=inherit)
> > +                        if nested not in self.pure_nested_structs:
> > +                            self.pure_nested_structs[nested] = Struct(self, nested, inherited=inherit)
> 
> ... and is unclear to me how the above produces the effect described in
> the commit message :)

this hunk avoids re-initializing

self.pure_nested_structs['addr'].{request,reply}

when it has already been parsed once. If at least a nested attribute sets
'request' to True, then 'request' remains True also when other nested
attributes of the same type are found. 

-- 
davide


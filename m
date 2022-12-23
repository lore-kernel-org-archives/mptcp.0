Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C7A8F63
	for <mptcp@lists.linux.dev>; Fri, 23 Dec 2022 16:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1671811303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dt7dba+xyzGWTTUk55oCyaFiPJzsfCya2TZCsPd57Hs=;
	b=FY1jNICWXJoDO+XVyOq8CcTNSplTxBD3aBrXJBEMadiGbWRhbhsVWVObRyy+zcaUa9DL8G
	cwoKaf2Ahi8Z+8JcEOnHqzFbEkDroyLJnlV/1CDGHZJFaSZpLrnwnlaNhDUIYcSkCIzlAh
	Ay4NjJimwqyWX+iZ75PNkaLGoAgVwyk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-412-Pi1cfI0WNMCisZWE83IzBA-1; Fri, 23 Dec 2022 11:01:42 -0500
X-MC-Unique: Pi1cfI0WNMCisZWE83IzBA-1
Received: by mail-wm1-f71.google.com with SMTP id bi19-20020a05600c3d9300b003cf9d6c4016so4003691wmb.8
        for <mptcp@lists.linux.dev>; Fri, 23 Dec 2022 08:01:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dt7dba+xyzGWTTUk55oCyaFiPJzsfCya2TZCsPd57Hs=;
        b=vmz6iZR25KKkehkrJ+XqegvIoA5HnIFa3gqmaT4yy7YmHcOD9NhhVpTp7dGWVDvYXC
         32Bvm0y1e3YuypJONAm8eK6+hHJYglT38alHKaBIsYMGdCjXCaV6GibHwsj8HTqG46VF
         ZyTgswSBSDycasqR1SLLUiX2FG6WmzBsAGYOPjVCrcknBhr1Nye72jk6ncObZcoGDruw
         JKUMxquHLtvAUtqTY7mMwB1H3F9y9Ap0JtzxcOhdVdZfhJghErKGQBQJewQ2JP5Hm9hr
         A65PZgHb5ekWT7bdVEgye6E8EqShShXS5EHOGcQSqISVv61b7d0marhcOKGJkLYAX7mj
         gsiA==
X-Gm-Message-State: AFqh2kpTUVbKhM+g94Gx0lMDv0N58JhA9E35sTxPVOQ4sx7F/Do025jN
	zbp8SRr7NS4c22d3etWZooa7a0MdPxgTtp0cCBv1VZbpZCw3u6bXc77ihuv+k1XOn/+Mz4GCL7m
	fULdAWCIsg+Y1HV8=
X-Received: by 2002:a05:600c:5554:b0:3cf:8e5d:7184 with SMTP id iz20-20020a05600c555400b003cf8e5d7184mr7711252wmb.28.1671811300708;
        Fri, 23 Dec 2022 08:01:40 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtyOxpM9n510FETrOAu9Tsdcs1zM9PpNlVXZZfvUQEB8RTr6WP9/1T0bKC/e6cDgmSXRQst4Q==
X-Received: by 2002:a05:600c:5554:b0:3cf:8e5d:7184 with SMTP id iz20-20020a05600c555400b003cf8e5d7184mr7711228wmb.28.1671811300480;
        Fri, 23 Dec 2022 08:01:40 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-101-173.dyn.eolo.it. [146.241.101.173])
        by smtp.gmail.com with ESMTPSA id hg15-20020a05600c538f00b003d971a6c513sm806962wmb.25.2022.12.23.08.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 08:01:39 -0800 (PST)
Message-ID: <a9cddc311804ebc183c0b1568c296b23932d7dd4.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 1/3] mptcp: explicitly specify sock family at
 subflow creation time
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Fri, 23 Dec 2022 17:01:38 +0100
In-Reply-To: <93c4e8a6-4797-9c10-5ae5-7499d6e2bed4@tessares.net>
References: <cover.1671799401.git.pabeni@redhat.com>
	 <7d3aae6493caa1563d1aaadc79d299c01077f28a.1671799401.git.pabeni@redhat.com>
	 <93c4e8a6-4797-9c10-5ae5-7499d6e2bed4@tessares.net>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2022-12-23 at 15:35 +0100, Matthieu Baerts wrote:
> Hi Paolo,
> 
> On 23/12/2022 13:51, Paolo Abeni wrote:
> > Let the caller specify the to-be-created subflow family. No
> > functional change intended, will be leveraged by the next
> > patch.
> 
> (...)
> 
> > @@ -1673,8 +1675,7 @@ int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock)
> >  	if (unlikely(!sk->sk_socket))
> >  		return -EINVAL;
> >  
> > -	err = sock_create_kern(net, sk->sk_family, SOCK_STREAM, IPPROTO_TCP,
> > -			       &sf);
> > +	err = sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP, &sf);
> 
> Mmh, I don't know if we can do that: it means we no longer inherit the
> 'sk_family'. With the modification, it means if the initial socket is
> created in v4 only (AF_INET), we will still be able to create subflows
> in IPv6, right?

Yes. That was my understanding of issues/269 goal.

> Somehow, I like the idea because with today's Internet, it is normal for
> a client to have both IPv4 and IPv6 addresses. Then we avoid people
> creating AF_INET sockets and complaining they cannot have additional
> IPv6 subflows.
> 
> But on the other hand, there is no more way to force having v4 only
> subflows, no?
> And I guess listening sockets will have to be created with AF_INET6 to
> accept additional v6 subflows.
> 
> WDYT?

I'm not sure I understand. Do you mean that we should allow mixed
ipv4/ipv6 subflows only if mptcp family is ipv6? that is doable, I
think, just slightly different from what is implemented here.

Cheers,

Paolo


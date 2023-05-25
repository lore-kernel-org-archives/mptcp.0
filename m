Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17011D2B8
	for <mptcp@lists.linux.dev>; Thu, 25 May 2023 16:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1685032201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WV0c88WwsRw4FhJ1FKqXeBbcYm1+DWs1UkwXWjackkM=;
	b=fLemHnIVQiroM3YchE+tNSPjxnzn1g50yvN6bi+dliaiDvG7pCKDl0aQSEVFlOXxAickXC
	1m+9hDRlK2UL9V3pVq/cYagubCWuCgl8gVqPZ6Pn5y+vP/j95r+avA+olooqPZeg9RLzrn
	o8uaen27nNaVaT7Z/K2Uip2+1z+dk94=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-WJHexCQFOC6uhKNCBKkJfw-1; Thu, 25 May 2023 12:29:59 -0400
X-MC-Unique: WJHexCQFOC6uhKNCBKkJfw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f603380047so2694015e9.1
        for <mptcp@lists.linux.dev>; Thu, 25 May 2023 09:29:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685032198; x=1687624198;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XSHfeU8tsd80mJL+aBjIeLBPfuqF2s23ScI9xYzGlPc=;
        b=faLx4NLcUbnHWzWEW3YCrX5Ub+vB+iIM2SRexY0w/GwcpQKae6GJYSAzy478y+ZT0n
         yTuL1zgSOqbDxwbB+ax0X96RiCVu9TTdvbcj8qBNh6FyyGvuphEHng+O9ALNqQ5U291U
         Dx9VHAk9XQ+sg2RQ6HZIGWHy7T5RVQRfyyooFzia5Gp2ZkX3nL3Eeu4wj4IOVFoiFGyj
         8DIlyFMB/kUpl72rmk6T3wjRvHtanGG0KVySa3N+8/+eilo1KbvvmP6kFNJHOe/dThYR
         3mO5ppSYBMdUbIdmqe6QPVM+vMyVDRSlLhGx0NcFDWf3tS0BQ/At4Q+MVcUAcY5DhKMS
         pnmg==
X-Gm-Message-State: AC+VfDw0Umm6Dd+vm0+5SLzaqSJ8aCEFJoMS37Fro7tmTs3yMbEgCvV8
	gb1mnyAkpU/UbFjMMwse8mp8GDRI5c3H4Lvl/dH1iDkSvzteyMhkVX9UpDmAFbE72OTB9CXAZCA
	0oi64ZKTudfEQ+s8=
X-Received: by 2002:a05:600c:3c86:b0:3f5:f543:d81f with SMTP id bg6-20020a05600c3c8600b003f5f543d81fmr15235305wmb.3.1685032198254;
        Thu, 25 May 2023 09:29:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4M9cWxj2igL+7CI4rsOxlS+8CBJJZOVrrnkimAq8Nr9xFoflf9dfdrbMaDtPElj+qgyPTcjg==
X-Received: by 2002:a05:600c:3c86:b0:3f5:f543:d81f with SMTP id bg6-20020a05600c3c8600b003f5f543d81fmr15235291wmb.3.1685032197920;
        Thu, 25 May 2023 09:29:57 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-242-207.dyn.eolo.it. [146.241.242.207])
        by smtp.gmail.com with ESMTPSA id w8-20020a1cf608000000b003f18b942338sm2601426wmc.3.2023.05.25.09.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 09:29:57 -0700 (PDT)
Message-ID: <256e36764a7ee5821fdcc52c406b6dd6cd5f24e5.camel@redhat.com>
Subject: Re: [PATCH v6 mptcp-next 5/6] mptcp: introduce MPTCP_FULL_INFO
 getsockopt
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Cc: Florian Westphal <fw@strlen.de>
Date: Thu, 25 May 2023 18:29:56 +0200
In-Reply-To: <da4cf0aa-04b7-007e-0905-c3710f0fa08b@tessares.net>
References: <cover.1684997011.git.pabeni@redhat.com>
	 <6445ff289e2784aca7f93847fea85abf304c9d50.1684997011.git.pabeni@redhat.com>
	 <da4cf0aa-04b7-007e-0905-c3710f0fa08b@tessares.net>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2023-05-25 at 17:20 +0200, Matthieu Baerts wrote:
> Hi Paolo,
>=20
> On 25/05/2023 09:17, Paolo Abeni wrote:
> > Some user-space applications want to monitor the subflows utilization.
> >=20
> > Dumping the per subflow tcp_info is not enough, as the PM could close
> > and re-create the subflows under-the-hood, fooling the accounting.
> > Even checking the src/dst addresses used by each subflow could not
> > be enough, because new subflows could re-use the same address/port of
> > the just closed one.
> >=20
> > This patch introduces a new socket option, allow dumping all the releva=
nt
> > information all-at-once (everything, everywhere...), in a consistent
> > manner.
> >=20
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > v5 -> v6:
> >  - fix compiler warning - unused variable
> >=20
> > v4 -> v5:
> >  - full_info struct re-design (Florian)
> >  - fix build issue on 32 bit hosts
>=20
> Thank you for the update! I find the new version clearer, hopefully
> easier to maintain and to use from the userspace side.
>=20
> (...)
>=20
> > diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> > index 770279e0a598..bfbe0378e997 100644
> > --- a/net/mptcp/sockopt.c
> > +++ b/net/mptcp/sockopt.c
> > @@ -14,7 +14,8 @@
> >  #include <net/mptcp.h>
> >  #include "protocol.h"
> > =20
> > -#define MIN_INFO_OPTLEN_SIZE=0916
> > +#define MIN_INFO_OPTLEN_SIZE=09=0916
> > +#define MIN_FULL_INFO_OPTLEN_SIZE=0940
> > =20
> >  static struct sock *__mptcp_tcp_fallback(struct mptcp_sock *msk)
> >  {
> > @@ -977,7 +978,8 @@ static int mptcp_put_subflow_data(struct mptcp_subf=
low_data *sfd,
> >  }
> > =20
> >  static int mptcp_get_subflow_data(struct mptcp_subflow_data *sfd,
> > -=09=09=09=09  char __user *optval, int __user *optlen)
> > +=09=09=09=09  char __user *optval,
> > +=09=09=09=09  int __user *optlen)
>=20
> Do you mind if I undo this modification when applying the patch?
> Or did you do that on purpose?

Oops, landed there unintentionally. Thanks for spotting. Please restore
the original code, thanks!

/P


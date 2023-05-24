Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3240160874
	for <mptcp@lists.linux.dev>; Wed, 24 May 2023 13:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684935322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=zCDOKyN0r/L0XZvY/9Wc3rZWVgLoorOmNHjRcMJtck8=;
	b=LOKT1H/XJ1+fAuidpJDRZ4/yLWHvwGeJ3q6uTtkqyjGOHvIayH4scbU1PtKCA/o7tIu/tP
	N6SqQavNsGLg5ot7xH5SVlv5INXR4hcG5YW9s7x0oBTRxlzVgEwqNcnzRcasT/5Lm2AQtw
	7Sw/i51N/amxIy7fA74yYU/IshqbUVI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-zcxU7Jk-PF-uK2PEgqxK0A-1; Wed, 24 May 2023 09:35:19 -0400
X-MC-Unique: zcxU7Jk-PF-uK2PEgqxK0A-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f4fffe7883so1693865e9.0
        for <mptcp@lists.linux.dev>; Wed, 24 May 2023 06:35:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684935317; x=1687527317;
        h=mime-version:user-agent:content-transfer-encoding:references:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UEQZwDlAe1e2lzw7RC292ZOrpG2mO4rpWe5Ir91Hsww=;
        b=JdFnJTDxxxyA6cGm8X5wzSubcg2Ttf7sS3Tf8moicUNmRA3OnunqNF1d+G2akqbZNq
         5gmPDjM5jMX+AmR5g+LfCbGQrN6dCJ5b0s7wCZeYqf7g+xUTWm7daH4xqNPcF7DkoCy7
         wcGuYE31eD+F7pVwxUzrxrSbd7tFtC//3SfswjTnF1HRwSrBkM9pW+O08ZyraH9Y3fXN
         pry1naeIV0tx25Z2JCKymhlaQiZYOwFuZ1cpm7d1Uabwx+4bEkZx2zzLy5dokRD1GgKr
         exP9Rc0I7TLyr6HL9VqTKkF6kNT7Ay7Fj+hH5UuEJ6phoKZbApoJlI2f0qOamnJTixJT
         /8zQ==
X-Gm-Message-State: AC+VfDwiRh61vZ+mAgV/vxnIBSZ3ugY7Jq6utFK0PhDVDa013nGCAmSh
	lJ9+RLnFc7PCFU9E16GYqI4nfZHwYqugSvSxwowJPoDkCFAVwEIHhfsABhoCJrZjmENfcvfxBZo
	E0KL4E085mcLyqvZgDbSFvnBmzYNW8ilb/3GFYuVUplGF4Ojs7QQSZdFpmBSyDZdvw5r0BykE
X-Received: by 2002:a05:600c:3b19:b0:3f6:8a3:8e59 with SMTP id m25-20020a05600c3b1900b003f608a38e59mr5859344wms.1.1684935317673;
        Wed, 24 May 2023 06:35:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7xSgdBZoTk4XrEGFjA1y0PbnUSea1WEbPXgWP3+eoVBXcDQJx4+hpLxpVyWjQb1BQsPsXJGQ==
X-Received: by 2002:a05:600c:3b19:b0:3f6:8a3:8e59 with SMTP id m25-20020a05600c3b1900b003f608a38e59mr5859325wms.1.1684935317279;
        Wed, 24 May 2023 06:35:17 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-242-207.dyn.eolo.it. [146.241.242.207])
        by smtp.gmail.com with ESMTPSA id n20-20020a1c7214000000b003f60482024fsm2359522wmc.30.2023.05.24.06.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 06:35:16 -0700 (PDT)
Message-ID: <53030866af889e674647a02c37b0909ee395c9f5.camel@redhat.com>
Subject: Fwd: Re: [PATCH v3 mptcp-next 2/6] mptcp: introduce MPTCP_FULL_INFO
 getsockopt
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>, Florian Westphal
	 <fw@strlen.de>
Date: Wed, 24 May 2023 15:35:15 +0200
References: <9c4f161a53250127f0634359433ee51934606342.camel@redhat.com>
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

oops, Matttbe noted I omitted a few recipients, re-sending...

-------- Forwarded Message --------
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH v3 mptcp-next 2/6] mptcp: introduce MPTCP_FULL_INFO
getsockopt
Date: 05/24/2023 12:20:25 PM

On Wed, 2023-05-24 at 11:12 +0200, Matthieu Baerts wrote:
> On 24/05/2023 10:53, Paolo Abeni wrote:
> > On Wed, 2023-05-24 at 10:13 +0200, Matthieu Baerts wrote:
> > > (If we add mptcp_info (cf Paolo's email), better to strip 'subflow')
> > >=20
> > > > =09__u32=09=09size_subflow_full_info;         /* size of this struc=
ture in userspace */
> > >=20
> > > Why do we need this field? Can we not use the option length (int __us=
er
> > > *optlen) provided by the userspace?
> >=20
> > With this we can append arbitrary/variable size mptcp_info at the end.
>=20
> I guess either we use a dedicated field for mptcp_info or we infer its
> value by looking at size_full_info or optlen. It looks clearer to me
> from the userspace point of view to have a dedicated size for mptcp_info
> than giving twice sizeof(mptcp_subflow_tcp_info) but I'm probably
> missing something :)

Currently, with the existing sockopt we have the optvat pointing to
something alike:

> hdr_size | hdr | more storage |

and optlen specifying the whole optval data. We need the explicit the
header size field, as optval must specify the whole size of the user-
provided buffer and we need to know which part of such buffer has been
filled by the user-space.

In this case:

"hdr_size" =3D=3D mptcp_subflow_full_info.size_subflow_full_info
"hdr" =3D=3D mptcp_subflow_full_info
"more storage" =3D=3D mptcp_info

We could add a (rendundant) field inside mptcp_subflow_full_info to
specify the user-space mptcp_info size, but that would be ...
rendundant. Unless we drop the hdr_size and we compute that from optlen
and the new mptcp_indo_size_user field, but that would be IMHO counter-
intuitive.

Cheers,

Paolo



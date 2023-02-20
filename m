Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2462D3201
	for <mptcp@lists.linux.dev>; Mon, 20 Feb 2023 11:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1676893877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=90rSD/L47uIEMdTGFSkGiUDrT14QjgzqzgyJxOPUtBU=;
	b=Oxp2enN9bkpq7585bPD3s6rSJbm9JGnXLyglQy1gDJ4AQJu2354PimEjy+K5yG1prRkWzo
	gREXESC0jKjVSNRNvgVqgxjQbq++4+owYu6RWj963/X9nNwo8WLCivh/+ksLjQEEDEhawB
	UeZelvVO1OJ/Zw/l2kxf3RrDTN2su44=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-12-Vd5HP215MEWAWJ_Veq2cpA-1; Mon, 20 Feb 2023 06:51:15 -0500
X-MC-Unique: Vd5HP215MEWAWJ_Veq2cpA-1
Received: by mail-qv1-f70.google.com with SMTP id pp11-20020a056214138b00b0056c228fa15cso88977qvb.4
        for <mptcp@lists.linux.dev>; Mon, 20 Feb 2023 03:51:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=90rSD/L47uIEMdTGFSkGiUDrT14QjgzqzgyJxOPUtBU=;
        b=esJLBr4RaFx4V6J4qdKmECCG9yEUebaR8PpTiswM9pNx3Zm8+/KvxYu2cLyBjIQcT5
         cEqiB3AD0EO7m+S8xKeMFbhBUasQHtOsh66cxQcyTAfup66YPqFh1WtmP7/ei8b5l2Lc
         RLWvqJRlbhFHZj3UMJN2OTiT8/k6PiItR9Ipgm1vOXB+vOW4vlgJQDGR56HtBrfra+5Y
         n996H7fzyeUKXabgngxA6gmpL2AbiuddDwbDcLxmqLqg7yLDp1BRX/0OqgGyo61pmqnd
         duSsn+1FL8pRPUEjNxvFZO4klCr/eDFPJatiRan0ACnU6r+DyWbLxDxOU03//vYXj8Kp
         bFtw==
X-Gm-Message-State: AO0yUKU2VWHZpnlzDjAaq7tv31PKVT32QxLENe7jtS9jgwfQcterz5sD
	bMYLwey7klQOSgwV3vYWkupiFUCQncdbd7VzDtAeIrKvs5WduVeIBEdzDZ0tqPOZiVnFW+kG5D6
	YvqBtrZV9B9KVNjc=
X-Received: by 2002:ac8:4e95:0:b0:3bd:142d:64dd with SMTP id 21-20020ac84e95000000b003bd142d64ddmr2085653qtp.3.1676893875440;
        Mon, 20 Feb 2023 03:51:15 -0800 (PST)
X-Google-Smtp-Source: AK7set/ronkSdVKlQ9mlEsJISVNNDcOP+tWHaNtT86h4I9XS2pw9jZ7JNS+dRgnLu6eO6kgfh2uNAQ==
X-Received: by 2002:ac8:4e95:0:b0:3bd:142d:64dd with SMTP id 21-20020ac84e95000000b003bd142d64ddmr2085636qtp.3.1676893875115;
        Mon, 20 Feb 2023 03:51:15 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-121-8.dyn.eolo.it. [146.241.121.8])
        by smtp.gmail.com with ESMTPSA id t65-20020ae9df44000000b0073b2f1c8329sm8864079qkf.28.2023.02.20.03.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 03:51:14 -0800 (PST)
Message-ID: <531ceec4b5af0abe463e80a19d98752ed1074aad.camel@redhat.com>
Subject: Re: [PATCH v2 mptcp-net 2/2] mptcp: fix UaF in listener shutdown
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
Date: Mon, 20 Feb 2023 12:51:11 +0100
In-Reply-To: <5eb0dec3-172a-953d-110d-009cadaa711f@tessares.net>
References: <b5b35cfd2d10179fc81643e601e125aa881f7c79.1675968499.git.pabeni@redhat.com>
	 <ad634b00b9c4cfb0f8cd6c8ec57d1a7405ba3799.1675968499.git.pabeni@redhat.com>
	 <7c02bf27-2de1-cea8-691a-120c988c4da0@tessares.net>
	 <5eb0dec3-172a-953d-110d-009cadaa711f@tessares.net>
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

On Mon, 2023-02-20 at 12:14 +0100, Matthieu Baerts wrote:
> Hi Paolo,
>=20
> On 17/02/2023 18:58, Matthieu Baerts wrote:
> > Hi Paolo,
> >=20
> > On 09/02/2023 19:48, Paolo Abeni wrote:
> > > As reported by Christoph, the mptcp listener shutdown path is prone
> > > to an UaF issue.
> >=20
> > Again, thank you for the two patches!
> >=20
> > Now in our tree (fixes for -net) with my RvB tag.
> >=20
> > I had a few conflicts when applying them on -net (and later when
> > propagating them to our tree, see below), I hope that's OK but don't
> > hesitate to double check if you have the opportunity :)
>=20
> I probably didn't resolve the conflicts properly (or maybe some
> adaptations are needed on -net) because this introduce some regressions
> on export-net (not on net-next):
>=20
> Any idea what could cause that?
>=20
> https://github.com/multipath-tcp/mptcp_net-next/issues/361

I *think* it's not a conflict resolution issue; patch 1/2 here
functionally depends on ("mptcp: refactor passive socket
initialization") which let msk take a reference on unaccepted MPC
subflows, so that incoming reset will not free such subflow via
inet_child_forget().

I *think* the easier solution is moving this patches on export-next
after ("mptcp: refactor passive socket initialization"), mentioned
explicitly the functional dependency

WDYT?

Thanks,

Paolo


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA6D28682
	for <mptcp@lists.linux.dev>; Mon, 16 Oct 2023 13:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EcB8z/Nw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697464220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I0yVBB+ZFwAZ9a0eBjy+nYsixi98F/0TPzD+sNiwRDU=;
	b=EcB8z/NwrguNMe6AuE/0gQzth2sYauvHj4omKeBeTkVrKyszY6RhC2aDDTHGkVruRDUB7T
	dqz9SsQKzcZfsRVsO2Hf6NrqcF3tHEXtKOXyiTSltKd97WCy5QBR2awbAQX1dZFTNYcMMw
	Axd5Nm1B0OByrebvXU48dc047TRNxNE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-ltGNVKD-PdOfiEIrDLcgow-1; Mon, 16 Oct 2023 09:50:16 -0400
X-MC-Unique: ltGNVKD-PdOfiEIrDLcgow-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9c45a6a8832so17003066b.1
        for <mptcp@lists.linux.dev>; Mon, 16 Oct 2023 06:50:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697464215; x=1698069015;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KiGCfWwKQMNJgQOhTbdNHuHo2dJTwantXptdD2baz3U=;
        b=OMkNpAGGnzqyAS1mDkvIS8xgofO7I1IUQrgCpxdYCZyvRTiRPvxQd4phyhUDvd+IBI
         DtgDSi3BLE8AvLyoldEtOXj76g0BBLBwHxPzzsa72SoLhI9Aa+wNY8JQWVyNPvr/XJ/G
         ldMHYW50j16QFZdcvG8qwtMV/EgMzO+SrFyfU91l3BUZ1L0pwZU2FZhrtd58RsYy810r
         yFLKHGG5h+vd/ch7IujF8TKKSFxXHlXaJHubrQjuxAU0oqDYR22KC1t5YA/1qrkDwV6v
         3CFI0dirlIPGt4/XOjhskpb8e5oLl/RjMoR8PYeQ3DECOvJjK+vu5GVLxHLci+cszIsG
         kVTg==
X-Gm-Message-State: AOJu0Yzmt4sazFoHtMzj6UYFJ5sNW8DKXRPVIYyJKJQ0S52iiXe+Wqfa
	KgzRLSqmMbtHt8dUzuHztrIJ6+N+LuYyIZCY2so1J2Ju1uSLRyivvhP5h4ve3idV5y0yRAVXtcp
	1IJelzNIwF70kQVg=
X-Received: by 2002:a17:906:ce:b0:9b2:bf2d:6b66 with SMTP id 14-20020a17090600ce00b009b2bf2d6b66mr23188091eji.7.1697464215753;
        Mon, 16 Oct 2023 06:50:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXlPjazmiT3koBQ8zFnEEkvmIFpPFyMLjIAEbR3Xz1W09AVejDr4zdSeet1vWIZujdsj8eJw==
X-Received: by 2002:a17:906:ce:b0:9b2:bf2d:6b66 with SMTP id 14-20020a17090600ce00b009b2bf2d6b66mr23188072eji.7.1697464215371;
        Mon, 16 Oct 2023 06:50:15 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-231-136.dyn.eolo.it. [146.241.231.136])
        by smtp.gmail.com with ESMTPSA id ks13-20020a170906f84d00b009b8a4f9f20esm4083311ejb.102.2023.10.16.06.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 06:50:14 -0700 (PDT)
Message-ID: <87c2af7f16c03e093fc6efc4be0e022f85be5323.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v16 3/8] Squash to "mptcp: add
 mptcpi_subflows_total counter"
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Date: Mon, 16 Oct 2023 15:50:13 +0200
In-Reply-To: <68dcded0-6821-4c51-9031-f3cce40d98ce@kernel.org>
References: <cover.1697175899.git.geliang.tang@suse.com>
	 <4f136ef2b23fb55e2e42397f1e07e74b355d5f61.1697175899.git.geliang.tang@suse.com>
	 <e3769002c1ff6139f9359413cd1ad415e593a3f2.camel@redhat.com>
	 <b7f0d827-ff8f-4348-be2b-c33e56b736ff@kernel.org>
	 <5f72f297be7687b86eec5ac19ef51c8a3df98048.camel@redhat.com>
	 <68dcded0-6821-4c51-9031-f3cce40d98ce@kernel.org>
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

On Mon, 2023-10-16 at 13:53 +0200, Matthieu Baerts wrote:
> On 13/10/2023 17:35, Paolo Abeni wrote:
> > On Fri, 2023-10-13 at 12:46 +0200, Matthieu Baerts wrote:
> > > On 13/10/2023 12:32, Paolo Abeni wrote:
> > >=20
> > > > You can list explicitly add the valid states with something alike:
> > > >=20
> > > > =09(1 << inet_sk_state_load(ssk)) & (TCPF_ESTABLISHED |
> > > > TCPF_SYN_SENT | TCPF_SYN_RECV | TCPF_LISTEN | TCPF_CLOSE_WAIT)
> > > >=20
> > > > I'm unsure if we should include CLOSE_WAIT here: the remote has shu=
t
> > > > down, but this end can still send data...
> > >=20
> > > Maybe better, no? As long as the behaviour is similar to the one with
> > > 'msk->pm.subflows'.
> >=20
> > If we keep the way we account for MPJ subflows as a reference
> > CLOSE_WAIT status must be excluded. I agree/now see it's the better
> > option.
>=20
> OK, so no CLOSE_WAIT, right?

Exactly, no CLOSE_WAIT

> I suggest to also modify the title, something like:
>=20
>     mptcp: avoid sending RST when closing the initial subflow
>=20
> And this Fixes tag:
>=20
>     Fixes: c2b2ae3925b6 ("mptcp: handle correctly disconnect() failures")

Fine by me.

Thanks!

Paolo


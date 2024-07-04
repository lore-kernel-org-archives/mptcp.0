Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474DE47A64
	for <mptcp@lists.linux.dev>; Thu,  4 Jul 2024 17:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720114365; cv=none; b=ksDlqaZ2fdCxpIAWJ7tSMeljjHov8JGa68ngUKuyIFo3ICAGukRfiKiBLb2cc4HDaTFdBftL88t8OBZSxN0QLJlhN3wI18BkyvT9rd/H2fJOeJ1CAeboG/ixpX94YmNvY9q+l/d9rqvANZIrnbavhfFf3qSjNAg7y9ozdebyJMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720114365; c=relaxed/simple;
	bh=acjokpofh2uPqk3cMRlyKiLtrhfX+I01WDZLlhPp3UQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C7FjzqQPwOZwGGrBhbW55OdrIBObJ0IQsqj0cD4Vb2GmKVDNa5BTAtfQtql5aBnzeQTprS6/45QYpBkH8hnhMWz3AO1S4d2RHHKVqsfeBeepoLVH7xiyuTu+PIvLuCKGH+8n0x9LxppSLTYKkQDd87k4TcoLCl1mZQYoeqxmIN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ilvf/AUs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ilvf/AUs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720114363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jyhGfiY7Y/sZRo83xCirWLAa4jrchcOhsg2Tv8CrPSI=;
	b=Ilvf/AUsjXK+d1Pmk0w8/HnRRXSgB+9EHQSxWO/f/tYf0JxhgMhpNyyeEcHTkl5naz6F+3
	8mihFCkLbg+wmbz5wc3zY2pkS6LYSuuW7N+UFyCiagq7feAU0uWZlJVVhkofo2wp3CUOoc
	s7eaXOCFkcZOj7UEDvzfO5xofgHI/zc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-Kp-rWv21N4-ZL1PSZdd_6Q-1; Thu, 04 Jul 2024 13:32:41 -0400
X-MC-Unique: Kp-rWv21N4-ZL1PSZdd_6Q-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4211239ed3dso1548775e9.1
        for <mptcp@lists.linux.dev>; Thu, 04 Jul 2024 10:32:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720114360; x=1720719160;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jyhGfiY7Y/sZRo83xCirWLAa4jrchcOhsg2Tv8CrPSI=;
        b=fp+6CQIh+gKVyxD9/VNIGqQ591OapNPBycKIMCIulkYQ5FK4fPoTv4Iq5JjPFKExLw
         whP+ccVLVdgSHGW2owrICyAExNe0J79lb/BAqaP9gptGsi/BlDQU95j2aZV7MlRAPaAE
         bLeNz77ykLLwFLJNp1KDNaMQqYGK6qsoTRcV5Api4urPYWtQ+jTFqyDSph2Qy8V1kKOz
         l9pSCD8wJ7pOxgrNw3MydESdt84tqPRvwDywR4tJAGmLvN0ymxCZFf57Otf+3jac6os1
         7jjU6gmVOX+4IJRYTJzDSchdyB6R30tmcKIiFaA+xMPSK16xq/zBR12qZikZ27z7JBgR
         jAjg==
X-Forwarded-Encrypted: i=1; AJvYcCWt6ip3taco/taTcxwHav5qr2N7GZGG0PF5f1lk2vW+5uE5RObUMmr8MtMO6fSUR8BTRcQWmfuktPzI52GNWm+IkP5ZBKw=
X-Gm-Message-State: AOJu0Yz4osKI3gk30BxsF8e3sdRecUPuqyd0sFkSJSbysGXvkwt0Bs4F
	WzR80hh88L+DGUQ5QlVkVne3cZd5qqZphDmdZ3T7AQq2/vHQ9adP8LrUkmw7T6X/UhZj3un3Zcy
	ZqpnwTiE3a/JsAnGt/cTVOArSAJUGaURww1Igk0NrItId45sg/lba+eQATdS2
X-Received: by 2002:a05:6000:400e:b0:367:95e3:e4c6 with SMTP id ffacd0b85a97d-3679dd12d7fmr1625881f8f.1.1720114360238;
        Thu, 04 Jul 2024 10:32:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeS4IB66hDWuNcKPkCwZX04E1Pw9BKJ73kdT2mZJDNwBrB43yhrujYSMFYQ8/NX22UXWzIrQ==
X-Received: by 2002:a05:6000:400e:b0:367:95e3:e4c6 with SMTP id ffacd0b85a97d-3679dd12d7fmr1625867f8f.1.1720114359741;
        Thu, 04 Jul 2024 10:32:39 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:172b:1510::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36791d7a93bsm5067493f8f.81.2024.07.04.10.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 10:32:39 -0700 (PDT)
Message-ID: <fcbd0bd9b0c108a810b22bcd4c55c7e212bd3ecc.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 0/4] mptcp: fix endpoints with 'signal' and
 'subflow' flags
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Thu, 04 Jul 2024 19:32:38 +0200
In-Reply-To: <1eb24454-8e21-448e-9cbf-a36f0de6f474@kernel.org>
References: <20240621-mptcp-pm-avail-v1-0-b692d5eb89b5@kernel.org>
	 <39995512b9a2240114fc1a1cd65bbaba2ca996c8.camel@redhat.com>
	 <1eb24454-8e21-448e-9cbf-a36f0de6f474@kernel.org>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39)
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

On Thu, 2024-07-04 at 18:43 +0200, Matthieu Baerts wrote:
> Hi Paolo,
>=20
> On 04/07/2024 17:47, Paolo Abeni wrote:
> > Hi,
> >=20
> > On Fri, 2024-06-21 at 13:39 +0200, Matthieu Baerts (NGI0) wrote:
> > > When looking at improving the user experience around the MPTCP endpoi=
nts
> > > setup, I noticed that setting an endpoint with both the 'signal' and =
the
> > > 'subflow' flags -- as it has been done in the past by users according=
 to
> > > bug reports we got -- were resulting on only announcing the endpoint,
> > > but not using it to create subflows: the 'subflow' flag was then
> > > ignored.
> > >=20
> > > My initial thought was to modify IPRoute2 to warn the user when the t=
wo
> > > flags were set, but it doesn't sound normal to ignore one of them. I
> > > then looked at modifying the kernel not to allow having the two flags
> > > set, but when discussing about that with Mat, we thought it was maybe
> > > not ideal to do that, as there might be use-cases, we might break som=
e
> > > configs, and it was working before apparently. So instead, I fixed th=
e
> > > support by splitting the previously shared 'available IDs' bitmap.
> > >=20
> > > While at it, I added a new selftest (patch 4) to validate this case -=
-
> > > including a modification of the chk_add_nr helper to inverse the side=
s
> > > were the counters are checked (patch 3) -- and allowed ADD_ADDR echo
> > > just after the MP_JOIN 3WHS.
> > >=20
> > > The selftests modification don't have a Fixes tag, because backportin=
g
> > > will not be easy: on some versions, the backport will not generate
> > > conflicts, but the test will fail because some helpers are not
> > > available. That's OK, many CIs will use the selftests from the last
> > > stable version to validate previous stable releases.
> >=20
> > I'm sorry for the large latency.
>=20
> No problem, thank you for your reply!
>=20
> > I think the above is more a new feature than a fix, I would avoid
> > including fixes tag, to prevent stable backports.
>=20
> My main goal here is to reduce frustration from users who are (certainly
> "badly") setting both the 'signal' and 'subflow' flags on new endpoints.
> In the different doc we have, we mention what does 'signal' and
> 'subflow', but nothing about using them together. For us, it seems
> obvious not to set the two flags together. But if you are new to MPTCP,
> I can understand that "signalling doesn't seem to hurt", and both
> 'subflow' and 'signal' flags are used.
>=20
> (Note that in the mptcp.org implementation, the fullmesh PM was sending
> ADD_ADDR and establishing new subflows, just because "it doesn't hurt to
> announce all addresses" :) )
>=20
> Currently, if we use the two flags together, the 'subflow' flag is
> ignored. I added the Fixes tag in patch 2, because it sounds like a bug
> not to create subflows when the 'subflow' flag is set. And also because
> it was working before the mentioned 'Fixes' commit which has
> accidentally removed this support.

Ah, my bad! I underlooked the commit message and missed this part.

> > I am a bit doubtful about having endpoint with both subflow | signal,
> > do we want encourage such bogus setup? What if the endpoint specify a
> > port, too?=C2=A0
> >=20
> > AFAICS it can not work, as the port-based signal endpoint will create a
> > listener on <IP>:<port> and later on the 'subflow' flag will try to
> > bind on the same <IP>:<port>, failing, while creating the outgoing
> > connection.
>=20
> What about returning an error when a port is given with the 'subflow' fla=
g?
>=20
> Currently, we do:
>=20
>   if (addr.addr.port && !(addr.flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
>       return -EINVAL;
>=20
> We could add "(... || addr.flags & MPTCP_PM_ADDR_FLAG_SUBLFOW)".

IMHO if we deny SIGNAL | SUBFLOW for a subset of the possible
configuration, than is better to be consistent and deny them for all
the conf.

> > What about just documenting the existing behavior?
>=20
> I don't think we should document that "setting both the 'signal' and
> 'subflow' flags is allowed, but in fact the 'subflow' flag is ignored in
> > =3D 5.17 versions", no? :)

Yup, I missed the regression part of it.

If possible, I would be happy to reduce complexity by preventing signal
and subflow flags together.

> I initially looked at adding a warning in IPRoute2, but then I failed to
> explain when setting these two flags can be justified. (And the new
> warning would take time to arrive in Linux distro currently ignoring the
> 'subflow' flag in this case.)

Well, distro problems are distro problems, I'm sure we can ignore the
distro lifecycle problems here. Should be addressed by a completely
different set of persons ;)

Indeed the ip-mptcp man page could help some significant rewording,
what about starting from there?

PORT description implicitly refers to 'signal' endpoint without
mentioning such fact. Also it has effect for subflow endpoint, not
mentioned there

/P


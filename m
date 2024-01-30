Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04862628C
	for <mptcp@lists.linux.dev>; Tue, 30 Jan 2024 08:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706603913; cv=none; b=cH6hz3QS7awQmMU/w/gmx/z8E4li1Z3EOiXjSJMIUJYRsjzVnH87KBHYYXpjFpU628sI6k3balJYhrZ9KUGUtaT9NvrOQ0qhhqPt4BJriGLV4/FGCMuSyugutDxPG8eZ1NQdaIE//TYZgY35vOEIw7xnA0EoWD2gOX7Bw/w1CR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706603913; c=relaxed/simple;
	bh=GLm0ZtaDbqk5QUmWrH0R5MJPU8FMiscvYFCoom14ZpM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZcCQJf9Qr3sxiAlbUeE4GHmj4bd9uxxJ75BfjvxZq4kXwk0/SyoOeGCPSXwcNQTsH5LbEpwEVPBb8AM/iArWjnMBwvJptCjIWF0ACgZw+XeN2qjXYqi6GFXBUIv3vIl4ifpNLUDXmLAxginl2DvFD0Ez2jVfbQktbUNM0QNORcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aabegm7P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aabegm7P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706603910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ysN/r9SjtTG1qwVS1VinJDnSOpXdRAhmk09y24T6R+c=;
	b=aabegm7PiCEFtq9C3JybjV8J4OBgmEvFNMtyyVxkI9qgsouWTDVjwW2IM35mgh/BFVkDNU
	+xdyIZGkPyOkRMqgV4bWR24JJlLO1CX25LfqHDVfolF15rTxP8ppwcvnkc3sTd653t9Cr6
	QwW4lw0ZPGwMHj/G6/qtHwREmLOZF+4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-r3axNLBNMEm7w9MJ1IPrqw-1; Tue, 30 Jan 2024 03:38:28 -0500
X-MC-Unique: r3axNLBNMEm7w9MJ1IPrqw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40ef88ff82aso3419595e9.0
        for <mptcp@lists.linux.dev>; Tue, 30 Jan 2024 00:38:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706603907; x=1707208707;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ysN/r9SjtTG1qwVS1VinJDnSOpXdRAhmk09y24T6R+c=;
        b=dYX5zEWGQVUJ/j8KD4aktPIhjKpUBGcwBktD8V85DU/CBGiACKsbSdBQoU9HQjqtsP
         Y2OkrDkM7m+rd0gbRJElkGL1HNGs9r5kFtFR0FhH/YBn8X2yJxMRg+RFdnU5CC3kHgsv
         4XjT2PEUnsl1qxCmDvgVWTkEh5Qk1Z/KKfTOgFshOUp63kPcoAseBg7laf25d2cwWXB0
         uj7HyRJc9JBcH12A4gAKRKUUTriQdHeb11atEJJRZka3jpZGTFsK+U2eF0ZcR0wFrk8y
         Ky0VfB/sfAhJVyY1DCqeq4R0OqccCN5MjIejDdQYOdRMBYEUagd9EVO7LtTGeoKfE01H
         AsZQ==
X-Gm-Message-State: AOJu0YzqOcG1tATy73VcHhbAMhs9BmWb0RZup2nbVSkkfItltcKWWouu
	Bkw0yIEHPT6CpNLSgmpgXPeKG46y44ixFiGbbTeWU6dsZVOrPb4Dxf7fEbKmLmj48an+pS//cFC
	oe6WJRcVUUA3FAxyqmaN7krWGHlqDINJYirfKwj6eLfny5OR7y0Lv
X-Received: by 2002:a05:600c:5185:b0:40e:f9ff:f80a with SMTP id fa5-20020a05600c518500b0040ef9fff80amr2859326wmb.0.1706603907792;
        Tue, 30 Jan 2024 00:38:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKdaRSFHtqbUqXSDwaXlXNVoeqEyKgcRq6FFyqW1+p81A2BBg+duZTillFrn5RfAzShHRAew==
X-Received: by 2002:a05:600c:5185:b0:40e:f9ff:f80a with SMTP id fa5-20020a05600c518500b0040ef9fff80amr2859313wmb.0.1706603907323;
        Tue, 30 Jan 2024 00:38:27 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-232-203.dyn.eolo.it. [146.241.232.203])
        by smtp.gmail.com with ESMTPSA id g9-20020a05600c310900b0040ef2e7041esm7066166wmo.6.2024.01.30.00.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 00:38:26 -0800 (PST)
Message-ID: <9acbd2da82d6fe9c385fc06ed359607f485d8935.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: really cope with fastopen race.
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
Date: Tue, 30 Jan 2024 09:38:25 +0100
In-Reply-To: <32222760-1d3f-5acb-63b5-774e7968741c@kernel.org>
References: <02fe7afaec6fac65fc2da5922efe25d6ebdebc88.1706132185.git.pabeni@redhat.com>
	 <89ef77af-b4b5-8674-52e0-92405a0c0ea9@kernel.org>
	 <482549332bcc96a8b4dd37292cb289b271b49511.camel@redhat.com>
	 <32222760-1d3f-5acb-63b5-774e7968741c@kernel.org>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39)
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

On Mon, 2024-01-29 at 11:16 -0800, Mat Martineau wrote:
> On Mon, 29 Jan 2024, Paolo Abeni wrote:
>=20
> > On Fri, 2024-01-26 at 17:18 -0800, Mat Martineau wrote:
> > > On Wed, 24 Jan 2024, Paolo Abeni wrote:
> > >=20
> > > > Fastopen and PM-trigger subflow shutdown can race, as reported by
> > > > syzkaller.
> > > >=20
> > > > In my first attempt to close such race, I missed the fact that
> > > > the subflow status can change again before the subflow_state_change
> > > > callback is invoked.
> > > >=20
> > > > Address the issue additionally copying with all the states directly
> > > > reachable from TCP_FIN_WAIT1.
> > > >=20
> > > > Fixes: 1e777f39b4d7 ("mptcp: add MSG_FASTOPEN sendmsg flag support"=
)
> > > > Fixes: 4fd19a307016 ("mptcp: fix inconsistent state on fastopen rac=
e")
> > > > Reported-by: syzbot+c53d4d3ddb327e80bc51@syzkaller.appspotmail.com
> > > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > >=20
> > > I wasn't able to reproduce the CI failure, and the change looks good =
to
> > > me. We'll see if CI is happy when this is applied to export-net.
> >=20
> > I used the repro provided by syzbot upstream:
> >=20
> > https://lore.kernel.org/netdev/000000000000e8ecae060fae7a47@google.com/
> > https://syzkaller.appspot.com/x/repro.c?x=3D17abc23be80000
> >=20
> > with my default debug config, and here it reproduced the issue reliably
> > on the unpatched kernel (and no splat with the patched one).
> >=20
>=20
> I was not very specific in my wording: I was referring to the CI failures=
=20
> when it applied this patch to export-net:
>=20
> https://lore.kernel.org/mptcp/482549332bcc96a8b4dd37292cb289b271b49511.ca=
mel@redhat.com/T/#mfb81b40b8a42912362eede622b5a15b17313d2a2

Ah, that one!

I think it's caused by:

commit 198bc90e0e734e5f98c3d2833e8390cac3df61b2
Author: Zhengchao Shao <shaozhengchao@huawei.com>
Date:   Thu Jan 18 09:20:19 2024 +0800

    tcp: make sure init the accept_queue's spinlocks once

and fixed by:

commit 435e202d645c197dcfd39d7372eb2a56529b6640 (net68/tmp_png)
Author: Zhengchao Shao <shaozhengchao@huawei.com>
Date:   Mon Jan 22 18:20:01 2024 +0800

    ipv6: init the accept_queue's spinlocks in inet6_create

Cheers,

Paolo


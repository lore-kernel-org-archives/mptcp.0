Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3817B132139
	for <mptcp@lists.linux.dev>; Fri,  5 Jul 2024 08:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720167609; cv=none; b=KaMGsJB3aCJ81OZL/YM3i6djCWlPRwoErprTIkviaF7EBhXoN9Grr95n4T/maursDMN3nYubp7L+7MWJWf+k6255MLjdvhD4M51bncMVLtbFWt7o1IvFjYEhkXwH/2FSMLTJfXSksil62w8yhX2NUzelT7S0g1l2kS0hvQHm5/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720167609; c=relaxed/simple;
	bh=Vs1t6HZY2L2AU+IHWGV9sd8SZt4amJfrokQ9o9t2q1U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l8ixLFxAQ7N4AcS7xrK67w8+VSvhA2hMEr7ee8ljHKRgm2x9sfbiBtD+2sYe5dURRUxuEHSIdXOjIJvKc9DVaqKNzCiOh/+t0R6bqWEuyGYmNIemCeT1aSpsI/1p6kuNJ42HKkyMAz86z5S35HduOZDScif3bJe4V0nSMMT4RmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IwC1snRb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IwC1snRb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720167606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Vs1t6HZY2L2AU+IHWGV9sd8SZt4amJfrokQ9o9t2q1U=;
	b=IwC1snRbhEEzgBNfnQVqDQiASqLw6G/tJJhR01KqqCFb4UIj+4ghciAOM3fsyFHYTreqC1
	YpSaY2DXtrStsD0YbH3w8rfI0NvPX6ecJOuqzIuw8TZyftduxY9cYV04Go02ost7U8BCwB
	RvEGCF0XRlPSWvJGi6YmDsNuACkO1qQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-c_RzBg9COzqLFcYHvkzG6Q-1; Fri, 05 Jul 2024 04:20:04 -0400
X-MC-Unique: c_RzBg9COzqLFcYHvkzG6Q-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-367895ae92dso332779f8f.3
        for <mptcp@lists.linux.dev>; Fri, 05 Jul 2024 01:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720167603; x=1720772403;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sCuEsMHzqcNT9Ue9eSoz8VdhhBB38hI+OGEOzVKi/Hc=;
        b=I3Eb93X+ApLNZs7dGvGVb0OWoEHIzVFA4XGJGxSmtdgtyeJivzMBfE6++s4fFAThPb
         KrC2/ag38WGui70cHPQyMLLT1pCxRcKQORhXqBRmvH7PvtsQOCG1txruy5nTyKIB/v4v
         ZPFWZJnw8bwoYeKqkS+vjx1gk1x8OZlKkAjt3Bg4T4eH6I6gEIdqiFmYeIIJ/ejCLPiG
         h69uJmXOa9vAdFJRgawtkUXcuv3pdrARFHVqQWSWBM7aVVtfUOo6KIsezBusoUAZ56/+
         PZuTUHgTocOj8jvGRnHSNUWjyKNmFC3L34DCxbggYLCbOCC61oIaCUAjqOYIhrSQkvjl
         +BZw==
X-Gm-Message-State: AOJu0YyosA0VuvnS3vQg8PkaxC0MoaxjspvUasJ+1WmawnFgOcp7IgGm
	l6n808UUvN9VBGXuUt3/Z0qEibYo4jINrWC1ZagQ931JRBoZrAWjn2tR/UNvthmIRuStNlK57nR
	PVNE6Z8XMEN51zuC2VJmyNCOg20iiHpfSelBdf+gVOzDxViZXsh1cSbEBO0Eb
X-Received: by 2002:a05:600c:5127:b0:425:6742:9942 with SMTP id 5b1f17b1804b1-4264a3f616cmr27686715e9.2.1720167602949;
        Fri, 05 Jul 2024 01:20:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgbPbmQ/KBlfzvy+kYIleHDioANAu0RHrOYSVHvuimC9izKQ6usODP3PZu9Mcikt7taMcKrg==
X-Received: by 2002:a05:600c:5127:b0:425:6742:9942 with SMTP id 5b1f17b1804b1-4264a3f616cmr27686565e9.2.1720167602528;
        Fri, 05 Jul 2024 01:20:02 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:1712:b10:dc4e:8e03:a5d:f914])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2ca492sm51753615e9.34.2024.07.05.01.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 01:20:02 -0700 (PDT)
Message-ID: <257091ee7be591bcb9aafa0ab4caa4dbca11e4e1.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 0/4] mptcp: fix endpoints with 'signal' and
 'subflow' flags
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Date: Fri, 05 Jul 2024 10:20:00 +0200
In-Reply-To: <f3293bfa-fb51-478e-bdb8-1841c9d3714e@kernel.org>
References: <20240621-mptcp-pm-avail-v1-0-b692d5eb89b5@kernel.org>
	 <39995512b9a2240114fc1a1cd65bbaba2ca996c8.camel@redhat.com>
	 <1eb24454-8e21-448e-9cbf-a36f0de6f474@kernel.org>
	 <fcbd0bd9b0c108a810b22bcd4c55c7e212bd3ecc.camel@redhat.com>
	 <f3293bfa-fb51-478e-bdb8-1841c9d3714e@kernel.org>
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

On Thu, 2024-07-04 at 22:02 +0200, Matthieu Baerts wrote:
> > > I don't think we should document that "setting both the 'signal' and
> > > 'subflow' flags is allowed, but in fact the 'subflow' flag is ignored=
 in
> > > > =3D 5.17 versions", no? :)
> >=20
> > Yup, I missed the regression part of it.
> >=20
> > If possible, I would be happy to reduce complexity by preventing signal
> > and subflow flags together.
>=20
> Do you think it would be OK to backport that? How to know if this=C2=A0
> configuration is not already used for valid use cases?

I guess that what worry me most is the addition of another large field
to the msk "just" to track (again) endpoints.

Thinking again about it, perhaps we don't need it. Something alike the
following should be sufficient to replace patch 2/4 here:

---
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ea9e5817b9e9..24e18cd43f48 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -513,8 +513,8 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct=
 mptcp_addr_info *info)
=20
 static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 {
+=09struct mptcp_pm_addr_entry *local, *signal_and_subflow =3D NULL;
 =09struct sock *sk =3D (struct sock *)msk;
-=09struct mptcp_pm_addr_entry *local;
 =09unsigned int add_addr_signal_max;
 =09unsigned int local_addr_max;
 =09struct pm_nl_pernet *pernet;
@@ -568,14 +568,27 @@ static void mptcp_pm_create_subflow_or_signal_addr(st=
ruct mptcp_sock *msk)
 =09=09if (msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_SIGNAL))
 =09=09=09return;
=20
-=09=09if (local) {
-=09=09=09if (mptcp_pm_alloc_anno_list(msk, &local->addr)) {
-=09=09=09=09__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
-=09=09=09=09msk->pm.add_addr_signaled++;
-=09=09=09=09mptcp_pm_announce_addr(msk, &local->addr, false);
-=09=09=09=09mptcp_pm_nl_addr_send_ack(msk);
-=09=09=09}
-=09=09}
+=09=09if (!local)
+=09=09=09continue;
+
+=09=09/* If the allocation fails we are on memory pressure, it looks
+=09=09 * not worthy try any forther later action, that will likely fail
+=09=09 * And if local has both the SIGNAL and SUBFLOW flags, and the
+=09=09 * by bad luck the later subflow creation is successfully, the
+=09=09 * msk will end-up not signaling this address; not even
+=09=09 * re-attempting to do it.
+=09=09 * Likely worthy incrementing a new MIB here
+=09=09 */
+=09=09if (!mptcp_pm_alloc_anno_list(msk, &local->addr))
+=09=09=09return;
+
+=09=09__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
+=09=09msk->pm.add_addr_signaled++;
+=09=09mptcp_pm_announce_addr(msk, &local->addr, false);
+=09=09mptcp_pm_nl_addr_send_ack(msk);
+=09=09if (local->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)
+=09=09=09signal_and_subflow =3D local;
+=09=09break;
 =09}
=20
 =09/* check if should create a new subflow */
@@ -585,9 +598,14 @@ static void mptcp_pm_create_subflow_or_signal_addr(str=
uct mptcp_sock *msk)
 =09=09bool fullmesh;
 =09=09int i, nr;
=20
-=09=09local =3D select_local_address(pernet, msk);
-=09=09if (!local)
-=09=09=09break;
+=09=09if (signal_and_subflow) {
+=09=09=09local =3D signal_and_subflow;
+=09=09=09signal_and_subflow =3D NULL;
+=09=09} else {
+=09=09=09local =3D select_local_address(pernet, msk);
+=09=09=09if (!local)
+=09=09=09=09break;
+=09=09}
=20
 =09=09fullmesh =3D !!(local->flags & MPTCP_PM_ADDR_FLAG_FULLMESH);
---
that is, when we use a signal endpoint, if that has the subflow flag,
use additionally to create the subflows, without doing an additional
search.

WDYT?

Thanks!

Paolo

p.s. Jakubs report the upstream mptcp_connect() st are flacky:

https://netdev.bots.linux.dev/contest.html?executor=3Dvmksft-mptcp-dbg&test=
=3Dmptcp-connect-sh

can you see that in our CI?


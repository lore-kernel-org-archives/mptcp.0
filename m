Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F0A1B1419
	for <mptcp@lists.linux.dev>; Thu,  4 Jul 2024 15:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720108752; cv=none; b=FHSuhYiCqLj4Vql+Zpmzr6ouVz5/go2kgtTKHg+12lywzv4yCyhDjeDEs1ReGcgai4LgqsuIuDaRMNq1a1pjhvNkHWsWF6Ca2B7SRgAfDIGWVbRgvTbnZCi4jGRgkpKiqc5Xd0w+XhFUkWM+VDJa1Pdy9OLtq/r2BuvNsceucOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720108752; c=relaxed/simple;
	bh=Y8NUzKyZjosSN7OruLBAI1WDwDhtGG428vxv36JUSw0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y0yplT39iBadtkKwmk5Ha5a1ifYCT5grkGnTx1NEYh4rzHFW8L17grBW9RuMaavjjhmRRTZUMOCQz+cO3OjSyV1Wv0lw/bManbE1FMtNmFZ5c4r57hHEFoeNsF5tWtr5b9BLg9TkZOzDdprWmvR+EQxv8rxOtQAS1XfWenwles0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C+Z4ADSy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C+Z4ADSy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720108749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Itwd+fi2HBxvGIm5VcCoPi3VWRqY7gVhPwCQbjGa+HE=;
	b=C+Z4ADSylAOuWUkEmW6nqZ44KUAfhbwmG3U82D9InL733pANrdIcj/Kp7MphoAIWk15r3k
	2rcb2OkwG06B8WqWXrVEW3w+PU17IVohH2mbULVUaZhPCNJU1/8aixqsJy8ItNpsvjEVQO
	z6sfvUU5n5F7Bfp3vC+sBfm8xeHwze8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-w-MSXIi9PKi69gfqGbC1pg-1; Thu, 04 Jul 2024 11:59:08 -0400
X-MC-Unique: w-MSXIi9PKi69gfqGbC1pg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4210e98f8d7so1404925e9.3
        for <mptcp@lists.linux.dev>; Thu, 04 Jul 2024 08:59:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720108746; x=1720713546;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2h+z4scRZWQ8UAIB5RtBPnLCMgtBVplNMgJaj9NniLc=;
        b=PhcInPPDbWbudk6eTWeeeG2Zw5otS6W7ZSIiL1kysR2MJ9BRagedMxoIdS5K6MWQyI
         sKWpWcXbZYKIrHIu3fKRtbkizbcjC+bakc5ebZMvLFH0THTmsaD1v4XmWyN1Fn6In27r
         Qa6zFNfbE6VANzKlwF3ejcitYRzyz+a3Rx0yJcTIqOp1KEPK62kDUnGNEXKOAwIS+Rzz
         1CuchBDlGt5r3Z5O8JGVJ1VLF9lay8UF53/SOpsxY8sFTu2c9+lnunPikb8D0i2X368r
         zYfSRFK4j/EBc+YmnskKauZ3YsTRvphxP296PylrHvbLrIH6FkVfMiyMjIRCBW66xlEN
         DiSA==
X-Gm-Message-State: AOJu0YwaQ6+dwep+MFQ6LLwVjivCiCf9Lrz0AfMVW5y9l5/ijGcOjwFm
	sM/vWWys/UwC5YJLfpcA1Cw1OXGoBJHLf97xyABDY939umTl0jXOjHjVy9au9NZlISHHGNAD99p
	9M0AnygfHV8CK/7v3t4sBRnlNzO6/dLEfOBu8XOBRHFXvH+47fNhCZh68bEto
X-Received: by 2002:a05:6000:1842:b0:367:90a8:4d3b with SMTP id ffacd0b85a97d-3679dd66e25mr1677820f8f.3.1720108746442;
        Thu, 04 Jul 2024 08:59:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMgg3ULrsnVmgUF65bAxX7NMbduTz0/4nIYnbENFHpjU5FyqF/W2MRYOXrW+S6hcfdPYLlqA==
X-Received: by 2002:a05:6000:1842:b0:367:90a8:4d3b with SMTP id ffacd0b85a97d-3679dd66e25mr1677812f8f.3.1720108746091;
        Thu, 04 Jul 2024 08:59:06 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:172b:1510::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367957d3451sm4191148f8f.101.2024.07.04.08.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 08:59:05 -0700 (PDT)
Message-ID: <7b81ac9af01cc3a6f0235d2d3e15316946072bdd.camel@redhat.com>
Subject: Re: [PATCH mptcp-net 2/3] selftests: mptcp: add explicit test case
 for remove/readd
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Date: Thu, 04 Jul 2024 17:59:04 +0200
In-Reply-To: <3eff208d-f3e2-411a-9f72-faa9ae6560b2@kernel.org>
References: <cover.1719589916.git.pabeni@redhat.com>
	 <1d4a6ebd0f843910f35a842673af55fca6962b8e.1719589916.git.pabeni@redhat.com>
	 <3eff208d-f3e2-411a-9f72-faa9ae6560b2@kernel.org>
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

On Tue, 2024-07-02 at 11:01 +0200, Matthieu Baerts wrote:
> Hi Paolo,
>=20
> On 28/06/2024 17:54, Paolo Abeni wrote:
> > Delete and re-create a signal endpoint and ensure that the PM
> > actually deletes and re-create the subflow.
> >=20
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> >  .../testing/selftests/net/mptcp/mptcp_join.sh | 28 +++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >=20
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/te=
sting/selftests/net/mptcp/mptcp_join.sh
> > index 108aeeb84ef1..228fecee61f9 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > @@ -3526,6 +3526,34 @@ endpoint_tests()
> >  =09=09chk_mptcp_info subflows 1 subflows 1
> >  =09=09mptcp_lib_kill_wait $tests_pid
> >  =09fi
> > +
> > +=09# remove and re-add
> > +=09if reset "delete re-add signal"; then
>=20
> In the previous tests -- "delete and re-add", we added:
>=20
>   mptcp_lib_kallsyms_has "subflow_rebuild_header$"
>=20
> At the beginning of the endpoint_tests() function there is this comment:
>=20
>   # subflow_rebuild_header is needed to support the implicit flag
>=20
> Maybe I put the same check on "delete and re-add" by mistake. I don't
> think this test depends on the "implicit" type. Or maybe it is, because
> its introduction is also linked to some big modifications on the PM
> side. In this case, should we have the same check?
>=20
>   && mptcp_lib_kallsyms_has "subflow_rebuild_header$"

Uhmm... sounds a little too much defensive programming, but I guess I
can add the test here

Thanks!

Paolo


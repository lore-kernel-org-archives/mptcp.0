Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793195676;
	b=rCtvfQy4pPBxnv5qU1hhM2dzKXMcCRqeJPTDDDQP1qC1Yb2PYVdMo1sB95mYwQOAcWDa
	 t3CPwwPihpVGYrfCul4VXJi2F7e6beBpfZru0meNEGGGEYCZYwH2Fn1gEbKQgF5o8kdvQ
	 gTNTplvrRjBOSiKdWPRiKP7W3CNy4UNbL/CQV7/8EExwbPbH65bMoTkB/3hFbwt7WMLdt
	 Cty1i+z0Aucg1biDzYKw3rHiteG3ErocK0gY4RvJD0rICFk4zAdcYE3FyZsE0dfiNR6Ce
	 XCTswOnO8ifhxjuaO4b44Y+JcFP1IrlYhbIKMMbNR+TmLktp2cm9V5u/birHSxlBjvA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793195676;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=FrHo7Qkiab7upMciYX+4ZM1HRc3ihXAUiouxL7q47ys=;
	b=r+Tg+YbbVI0ZDJpQN5yBSU+hvQIiZQy8PVB2kd3UFklpB4J4i49wEfel6JOGbEhWV5a+
	 Yj8nTfcqPtYJ5cfNVsa0Xv3ryYP2Z4GpyfledzZX/NLeAzHf9SmL3F4dYSR3tvBZG2kOe
	 tq+szSTbQzbxyJ8U7W4TjAA0BMKX2oGT4vu5y6tULOdvcIL0RTns9kkUUnoZ6kQ2M+NNH
	 5c5R+nQIo4divGZdM1ZaRLTxAzzCLtbWTvs8UsGnEizXCaUCt2/2ZS0GmnnRKlvMq2uxv
	 bzQE3WU9dURHAwzdyTN6miTDM1dIhbURK60xprUxRkBX9p0XQM9PjLaDaPmycnyB7gg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wN7oRwns;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80F8606A31D
	for <mptcp@lists.linux.dev>; Wed, 28 Oct 2026 13:54:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D80F8606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wN7oRwns
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b0a28a720aso10082337b3.2
        for <mptcp@lists.linux.dev>; Wed, 28 Oct 2026 06:54:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793195675; cv=none;
        d=google.com; s=arc-20260327;
        b=n1zQbmFHUX/zmPgaaDsTHc1uH5zL/E9PL3CA4qpl9jSi7TYbS5izAji/8t1GDSsmoE
         ir4IciCUpt0yajlhxk6m8wK3mpewqzvyixHGsqddWNdYR9OK7rpT2P/dFX3nGogDhR4K
         Q3TAIF4QRTM400c8u+yPFwG7O78Dn3HgcCY7wvt/2Ud3PxJc3o17WFWTFYWBb/2YWfV0
         mvaMV6w+91qVy6gVevYLj7+w9i7CfYLlHEq+8aGRDwuI7yd6YxY3Uk9FPqT7dIYgWb4P
         eDBrDN/0Vi7z1qtVNIdPllJieLr8uRtpdyOOscUVUrZsJ+JpNFIS86jp74rjefSA2+Sk
         s/WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FrHo7Qkiab7upMciYX+4ZM1HRc3ihXAUiouxL7q47ys=;
        fh=IwXVHCKCrY/jZHyAj7jyBDjdyZ2bL37PrmmNIE51HO0=;
        b=nMTzFMqG61QvKzjOzxwJmN9YYIQc1CvYQ3rTHtwFtfWRC5YkvaHi8JKWVDS0Lw0XK3
         +YF48DKDVgm2I331VfYSyvj4Cki1Ua3phYFwIEz4u8DbGSr8pFtl2f4roJQS8xkC39EM
         k/oBZ0TaSnT10dHwJxe8OcNod6r1iL+ATXEWcQs9wNmYUop50mtK4V583QK6ySauPM0C
         YP1Txlr4o+gvB33y4jDEtIByj+Gvl/XDt/AShfxJIKgEOqZjER6bGqwFk/4z1kymJnzX
         zDOO3U4AeJZivy4S+ItwLfBv7sJqueeN+q2EuL8DANNqzYhBpZAWdBlagHDEN6K0iCO9
         W4Cg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793195675; x=1793800475; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FrHo7Qkiab7upMciYX+4ZM1HRc3ihXAUiouxL7q47ys=;
        b=wN7oRwnsjwPpunVSyxZOTVd+p4hgNiCJKv8EQNvTie8QS4Ef2nnUQb3pbeKZCfEJkk
         mVp6qlqpVneWNq04ZfdOvU7Zje40dNMptmMpkskB3sr43K9gq1UpQQTZ5Io8N9wvh3/o
         TWoTQAMo/kTH11GkOjQe6VQR6m7pzbV1wRU1FRM2r53PXIurtcpuFMcbErfc6ESvDhbA
         orq+lZqJO2pChU99PwbUsSLz+cKO9jKpaPatKiIYLpBYGyeJy80RBkCIlga4riVapB7i
         lWaQyfscoHkYqQ/wXs+t0t2P5bTp2cMUvJ/D6TZpHBY0KwPFlrgHyJPWdA2bSnfsExgy
         XBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793195675; x=1793800475;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FrHo7Qkiab7upMciYX+4ZM1HRc3ihXAUiouxL7q47ys=;
        b=wlbnhxolhS5G06DLcyUE6fRWE4OZ6ybuxlSMN55Kxjjn32UvgBKDdrz0AYv7NqniI4
         6hbgLJqHWnop6R960bfuSbTIPbQ1Ya1HODLm52xsx1Niyg7hfA9P1BdnFSsdqYY0IrNU
         IxULE5MQqeqRCfrkvSnqnlNTrtzY/WrUOY9SAK089pJubD9Qfj38sr+r4KPOZef/BEgU
         +pSxxiB7FVdfricsLElwRrlmAT8UpCZtpCiUVi3GCaP2Guam7I1VFTElzWFnDXQEFD7o
         Q3LaFLUTd+OjsAra/hQ35JqmXWIeLn6InpxwXj+Kqo8HZIi0d/zYSnh9vmUolPLBPEcv
         ADag==
X-Forwarded-Encrypted: i=1; AKwUvBygcZ8cex6s/AKQTfJ1GTEVc0bZ1UI3ZNUyNftb5Ky2g6LaUUDsKTtBcitlsb5UlnDD5pzkwA==@lists.linux.dev
X-Gm-Message-State: AFq9FYK6QhZOyr75HSnDJe/cMiZbXxsfXouetESHPtvhD5pmwiefT7nZ
	eIxdOOv343x3FwYxUBASZpJIkGmbmw8Y5qbfb6W3i8yATULAIevjnoEjGVZlBBPkLrEKuaNqDg8
	Q+ZrJFN7AWoR1x/WWVj5Z8rjR0JbqC/c=
X-Gm-Gg: AYBFou3Av6zhFXV2kqxQSr0Ai3xX+98jgp611PyOZcOV9CJa8G9s+Ne0L7LxXZo2ChJ
	xzjnj+XdC/m4Cmmrl9N/CBTasn4Si4cd1BVEYRsuqQng6Yq/fysFfeEdNKNHMdQLkAfsGPo1ORx
	Nke9F8ovak9WGOhCjcfrIWdfcAaInFBf3FBm+MkOtM28//1i9xTc08eSBYOhSjUgMil1gU8h4gW
	CLRhTiDJUPxVIZvySE5HGVa+oygLLSBz4WyadNHp4AMMphziUCY4zROuOU2nW4X+XeErDxLRHJj
	wRnZrgOj4UNNY0zvXAhszSdoemEkE7HqC/iEeCafK0DbcQmFFP+FuTqWQtHNKC8Amt0t80JAKry
	VTsUe4dKfJbOVyOu6xxus+WCLFvzvVho7Zd9DBKmGzAKWyOL4RwrpuZTIZZon
X-Received: by 2002:a05:690c:660c:b0:8b0:dabe:cf4b with SMTP id
 00721157ae682-8b1b5ad911fmr15793197b3.37.1793195674929; Wed, 28 Oct 2026
 06:54:34 -0700 (PDT)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <pm-mptcp-objects-candidate-0066-v3-73df72b7a543d4cada0e@gmail.com>
 <CAL4WiiqEHwZRhSRXqFOtF3OYsX_v3519Ey8AEknbaZKFNogeJA@mail.gmail.com>
 <CAFRLqsU2QHD2Ta2aL_qSVr9nVFrn6mXV_nZ987+oqHUbCa7ZSw@mail.gmail.com>
 <f88992ae9b2dc51fd3a0ba2f9c23a29a91660877@linux.dev> <076d9826-4441-4098-9d35-c568d38ccfc6@kernel.org>
In-Reply-To: <076d9826-4441-4098-9d35-c568d38ccfc6@kernel.org>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Wed, 28 Oct 2026 21:54:23 +0800
X-Gm-Features: AclHuK96TKMNuEl2guOSVTAwQGGwPjpr-G-orF3Zt_JaeFaiaOl8rCyoCelvGm8
Message-ID: <CAFRLqsX9cBqrJn94wF-q5NyzoA9tuA72LV00yBYLv5fm7xs=zQ@mail.gmail.com>
Subject: Re: [PATCH net] mptcp: protect listener backlog reads in diagnostics
To: Matthieu Baerts <matttbe@kernel.org>
Cc: gang.yan@linux.dev, martineau@kernel.org, geliang@kernel.org, 
	mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt, Gang,

Thanks for the  review and guidence.

Matthieu Baerts <matttbe@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=8827=E6=
=97=A5=E5=91=A8=E4=BA=8C 19:37=E5=86=99=E9=81=93=EF=BC=9A
>
> > Also, could you send v3 separately to the MPTCP mailing list? It seems =
the
> > CI checks were not triggered this time. I guess it might be because the
> > patch was not based on the export branch of the mptcp repo on GitHub, s=
o
> > you can generate the patch based on that branch
> > (multipath-tcp/mptcp_net-next, branch export).
>
> @Cen: just to be clear: don't send a v3 just to fix the CI issue, except
> if a reviewer asks you too.
>

Understood. Thanks for applying v2 manually and the guidence.


> > Two notes for next time (Important):
> > 1. For MPTCP-only patches, it is enough to send them to the MPTCP list
> >    only, no need to CC netdev.
>
> Small note: for "urgent" patches, it is fine to send them to Netdev as
> well, following what's in the MAINTAINERS file. For new features and
> non-urgent fixes, it is better to send them to the MPTCP list only to
> reduce the traffic on the Netdev list.
>
> > 2. If a new version is needed, please wait 24 hours before sending it.
>
> (or more: wait for the Netdev Sashiko review)

Thanks for the clarification. I will follow it in the future.

Best regards,
Cen Zhang

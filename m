Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447D11DDD3
	for <mptcp@lists.linux.dev>; Wed, 17 Jan 2024 10:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705487432; cv=none; b=KYIf/cz1+HVeZ7cdCpZ33PsrOMbmWHXTi9qtGS5Nil39+OxwC93O9jGGZtYgX1CbDTAbuPnaw2SfJoLxQSJxoc5WNhZq1Mvqhsa1wMX+jIjI3R4TXk9yO7CKFWC7r/UIVt3Z1NHktBuSJZdZ3fjr57JiqiBeyR7ztEPxPo0gbmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705487432; c=relaxed/simple;
	bh=4yIaf1vacX6Q5hiiUmC9maibvSSF0CnF2qeGmIkTkOM=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:Received:Message-ID:Subject:From:
	 To:Cc:Date:In-Reply-To:References:Autocrypt:User-Agent:
	 MIME-Version:X-Mimecast-Spam-Score:X-Mimecast-Originator:
	 Content-Type:Content-Transfer-Encoding; b=PRE69GpV0ZW4P9FvKH4AGYk2BmaZHcNDBKCPQS+eMOMBv60A72R6qYzvwhYTHPpxawsT24WeTyh6rKS+6B3e7juB0Ff74tIGU/2ziqKqVXjRrS94MBESyhvs8ak9GdG8aGG25QU4QUkBNDil5TedBbX76/y7qf3V3/YcK6EaarA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QD/sf/9N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QD/sf/9N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705487429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qg2kv7Bgc0nF9Nb+gEhXPFI8phQqe4Lh5fB8g5hH6/8=;
	b=QD/sf/9NKU4jeoP+idC7vE+3bEZ62YjiXZWtnUufe031H7bdM5WZ3F6/d2pCjom2ZI04fx
	6cpte3GZHydRm/tJlfv7JmAlNArGMuPbO6TvWjryiSVa/09U2wKUnCRNGjSXue/6p4dluv
	CGGLsCPtUedK1bBUDNa7EDap8jXlFqw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-KysqvMndOwe1YsWyF2KQ5A-1; Wed, 17 Jan 2024 05:30:28 -0500
X-MC-Unique: KysqvMndOwe1YsWyF2KQ5A-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33710c9d4afso1111796f8f.0
        for <mptcp@lists.linux.dev>; Wed, 17 Jan 2024 02:30:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705487426; x=1706092226;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1p3QS8TdOgLuseg9LshWDBL4YCywiu4w9CSv/N9R8eo=;
        b=TpjfUTpm+26xup/IZdb5iQ1EMLCeNVFXPQ4y7b0z3qC5M1kZbZhC+XOcukoHI8EnUh
         /Yp8z7A8uFB9EHqSlOYoaNNVxrFjBX8Brja35Q50T6AXU7aTO1a6WRt2UlDNk4Tl6TFu
         p219mWm0DPqcLwx3p3VPjEspHjnoVutBGoTmkrUiNVA7vcbqFVr4fSw5eMLtOS8hoUGC
         M4hA5rErKiIG/uSLaG6JOuCJ8CvTpS+Uc7n7EeORVqodS47Iv7mB9QZzwdGlu6D3acLB
         OyQglJSi29s8G9cMP+0HNuIdtkCErlr8BBbl3WfVEpS3VVOmRvuj7nXk16OCgoIkhdZi
         Frsg==
X-Gm-Message-State: AOJu0YzCOj2/tAdxIvY2KeL3BrgpAj7wrGkPZnAGv8pm34t0J1zZbDqS
	upWSPNfa6GEFewWFPqu6PCQ7ufVhmW7oeVzhteszbffe9wAyhRubjMskwyV1P/C+yPegcL8OkNh
	LrnPu1te3stuU2GxLt4+oLHrK48ELRtM=
X-Received: by 2002:adf:a41e:0:b0:337:bdf1:61de with SMTP id d30-20020adfa41e000000b00337bdf161demr2917178wra.5.1705487426693;
        Wed, 17 Jan 2024 02:30:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHd1EB7JpYI6C6VhKlADaWqitZJx7AdvxjjoN7fLgIaCAL5mAxpV2BHtO5CW+8/NNKgnwTv1A==
X-Received: by 2002:adf:a41e:0:b0:337:bdf1:61de with SMTP id d30-20020adfa41e000000b00337bdf161demr2917161wra.5.1705487426356;
        Wed, 17 Jan 2024 02:30:26 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-242-208.dyn.eolo.it. [146.241.242.208])
        by smtp.gmail.com with ESMTPSA id n13-20020a5d51cd000000b0033673ddd81csm1313696wrv.112.2024.01.17.02.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 02:30:25 -0800 (PST)
Message-ID: <ee3335b1976cdb401fd177651c02ce6abad4388c.camel@redhat.com>
Subject: Re: [PATCH mptcp-net 0/4] mptcp: locking cleanup
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
Date: Wed, 17 Jan 2024 11:30:24 +0100
In-Reply-To: <fb88e379-a40d-0b8a-d64c-0f5957c85c81@kernel.org>
References: <cover.1705331716.git.pabeni@redhat.com>
	 <fb88e379-a40d-0b8a-d64c-0f5957c85c81@kernel.org>
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

On Tue, 2024-01-16 at 18:32 -0800, Mat Martineau wrote:
> On Mon, 15 Jan 2024, Paolo Abeni wrote:
>=20
> > This is a preparatory work for the TCP_NOTSENT_LOWAT support. The latte=
r
> > will need tracking more state under the msk data lock.
> >=20
> > Since the locking msk locking schema is already quite complex, do a lon=
g
> > awaited clean-up step, moving several confusing lockless initialization
> > under the relevant locks.
> >=20
> > Note that patches 2-4 carry fixes tag, and could target the net tree,
> > but AFACIS no real race could really happen even prior to such patches
> > as the MPTCP-level state machine implicitly ensure proper serialization
> > of the write accesses, even lacking explicit lock.
> >=20
> > Patch 1 has no fixes, but still is logically tied to the other patches.
> > Possibly we could target net-next for the whole series.
> >=20
> > Paolo Abeni (4):
> >  mptcp: drop the push_pending field
> >  mptcp: fix rcv space initialization
> >  mptcp: fix more tx path fields initialization
> >  mptcp: corner case locking for rx path fields initialization
> >=20
>=20
> Hi Paolo -
>=20
> The series LGTM, assuming the CI failure is the issue fixed by "mptcp:=20
> relax check on MPC passive fallback":

AFAIK, they are: I tested locally this series on top of the fixes,
without any problem.

> Reviewed-by: Mat Martineau <martineau@kernel.org>

Thanks!

Paolo


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103AE52F86
	for <mptcp@lists.linux.dev>; Fri,  8 Mar 2024 09:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709889271; cv=none; b=p1wERMYxTLdkUFaUtxH8KsSi6UP4yUrQPqlxjYMgdpW4yswalCh4ltjUxx+e34lzvJi8EvyzQA6Chq8IGdNtor8i/GIg74j3kjkFnHhwiTl78T8Zr+G1w4KOoJg9p28TStW4XRY+1HKJHqLYu9+4Vb9N8HS+RBdabkQDQu1YXl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709889271; c=relaxed/simple;
	bh=OqFoVgTgVV9llVxAuwehf5o87yFpIjDMcyyli17P40E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=trFlfhNJdtQjbTBXU1/HlwPrqWKDKNmi38tXaA+s2o7JX6dFb7Ip1EUxTOCnYik0SHzRyQ2KeudgpnSyJc61mP2bBTR8DfTXdHSwkPrlmVFrO3ZONGiowql1a1u2BdrOPQTxIPd35qKnWIbOCwoxZEkjqncRYFneDx8Fq3ltUBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QVciA5C9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QVciA5C9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709889268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OqFoVgTgVV9llVxAuwehf5o87yFpIjDMcyyli17P40E=;
	b=QVciA5C9YxN5P1oZxIyXUAUU2VeHiaVv31wMBM0V9CueSa3cBum8KOGgpibukq54TrOnls
	p3MSNUEbrmjQKan7g2txV99CxZFtWJw3Xi+tYrCRO6KUkGndB+Jt+nrTMdqsz/AuqET3lh
	7f4SZAVoBCgR9RUZKU0OGAW3m2kGIxE=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-USSb4fCSNh2OlD4QMhEYgA-1; Fri, 08 Mar 2024 04:14:27 -0500
X-MC-Unique: USSb4fCSNh2OlD4QMhEYgA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2d401e3e388so12825001fa.1
        for <mptcp@lists.linux.dev>; Fri, 08 Mar 2024 01:14:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709889266; x=1710494066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OqFoVgTgVV9llVxAuwehf5o87yFpIjDMcyyli17P40E=;
        b=wX0+iL/kXOJ5YbRdYFVjA/71sBrQQM2L6ESp0KvRDxpmwiGVX6PYRc7BCSXpxg1Fbe
         nIB1GFXNC5BHfyhibX+yipBzNXVdHXtqI90Baata1Wfdl4jvO86UMwWDNZM2PDBLAn4Q
         HQImN3Xuo8LrY7Ea+EKbz4g33yUgfQm0pAHkKUFk3sD5z1OZ72StMSItcfSpq2Nx2ty8
         Dmqhz10EoMeYLLgIWbfSlEtwORkEwpxtMYZ5z1fLnCN429sqT5LYRcpu71htIvKMQ3dM
         9kcGhCPF9hqhaWYFqeigSybZbyTX+WC1X66sFafRfzU9KgrWWNpJOjAes1mTXg/CqNPm
         x0Hw==
X-Forwarded-Encrypted: i=1; AJvYcCXn7aRZdf5gxF9LKPnZqPJ6OzJ2DMcwgmi+IVcWb1iSyoN/q2CUMERgxNgiR75RVWaNs7Ew6zzx5vs5CQBYpZPZJLaue28=
X-Gm-Message-State: AOJu0YyJbhD5DBOlxOAk8rWAw8TM8MdniULMBfLCAo6BbRtnbYxVeC7p
	Sq1PZj+lJRuH4tWk+WLR93rg7vkfHmU3XdMCtMEkAvw1vye+6gnlq99FyvWUlvLueyltcMTe4C1
	qCwuR5EDPI/Lj2BaJNwiGuYiTGRnPgrkoiV62VGTdelRpmOUEuSqX6OC3cuUHKTNT5NINB57OUw
	n+2OxiPHPAQyXGMGNhSdlAy3wJYQ4=
X-Received: by 2002:a2e:9619:0:b0:2d4:1452:6018 with SMTP id v25-20020a2e9619000000b002d414526018mr1988533ljh.27.1709889265636;
        Fri, 08 Mar 2024 01:14:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKmgZA+wjEI6RYbBydwhYOOesjKqm8cc4jAM6fAkGwBXNkY45dkWtzoQGWeB+OasFGzxtz3fjbcuyGvcyHqH8=
X-Received: by 2002:a2e:9619:0:b0:2d4:1452:6018 with SMTP id
 v25-20020a2e9619000000b002d414526018mr1988509ljh.27.1709889265075; Fri, 08
 Mar 2024 01:14:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <be9176dac04b292242d6afc2eefc0c931d21b0cd.1709651670.git.dcaratti@redhat.com>
 <62dd5009-fd83-4cd6-b7b1-8afff28a575c@kernel.org> <ZenfkXU_zYb0AcR8@dcaratti.users.ipa.redhat.com>
 <07323939-df11-4a2c-950e-de1412bb32b6@kernel.org>
In-Reply-To: <07323939-df11-4a2c-950e-de1412bb32b6@kernel.org>
From: Davide Caratti <dcaratti@redhat.com>
Date: Fri, 8 Mar 2024 10:14:13 +0100
Message-ID: <CAKa-r6uQmQO+vD0UnkOHNbR-2EdxWoJArTpxMwJAiV7xC2Yz3A@mail.gmail.com>
Subject: Re: [PATCH mptcp-net v2] mptcp: don't account accept() of non-MPC
 client as fallback to TCP
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Christoph Paasch <cpaasch@apple.com>, mptcp@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 5:33=E2=80=AFPM Matthieu Baerts <matttbe@kernel.org>=
 wrote:
>
> Hi Davide,
>
> >
> > and I mixed variable names while cleaning up pr_debug()s. Non-MPC conne=
ction
> > attempts (pure TCP, but also MPTCP with pathological MP_CAPABLE
> > sub-options) have fallback equal to false here. Will fix this in v3.
>
> Maybe it also means it would be good to add a check in the selftests (in
> mptcp_connect.sh?) to make sure it is doing the right thing (and there
> is no regressions later) :)


I can push a PR for packetdrill's 'mp_capable' v1_bind_*.pkt
scenarios, is that ok?
--=20
davide


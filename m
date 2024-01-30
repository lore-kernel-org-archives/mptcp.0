Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C947E79930
	for <mptcp@lists.linux.dev>; Tue, 30 Jan 2024 18:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706641014; cv=none; b=l/1xpg4o57OYpYh9EDLMa1HcIVo/wMRjfEkTOOm/AHWwGExPiakAt+S46hXssYjQOqtWn6UM29TXahaX/yLsrYfjxz3q9OSjkLTQ/IIl6KZdfY1dUCNEpNxPpA6QQZ2rj4YFTdUvuDSUmb3Nx0d1Tk3ATK7mTWarU4/Q8JFerMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706641014; c=relaxed/simple;
	bh=GlE3N4XDj0MXCvgplom5A9Lp89QrCkivVCEFrxDvZqU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vyyb7DekCLJGtz1u+CGIrWyRSizwrcQAHctfpffe5xANOc0LgtSIsCiYqr/IJrh4sWBu7ViAIwSJ2KC07ErYdnWHwP0m/KnFa+mcHIRD2VR9wQrXGnCFvKK0kdFyJLDd18wrTkVtGUavvTvAWfzZX3eY1jtJXKGDaFRggfRutRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TWg0Oeyd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TWg0Oeyd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706641011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GlE3N4XDj0MXCvgplom5A9Lp89QrCkivVCEFrxDvZqU=;
	b=TWg0OeydZ3Tc7ln68vi42YUD5xsrDpgjFrKUmne3/j4LzsJrL0qM2mZargaRvj50mIPUZ3
	XUmUUYk06UjWcKk2Td6YM+MeE9bNbXYva5ONDolA/Mg7GA2hEmsysdHkr/zRrKXmJMb6Tm
	MijRhs29l6So82wKIPjBGtdObzfFE6k=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-HS-Lw4UaOSmhYt9kbc_3xA-1; Tue, 30 Jan 2024 13:56:50 -0500
X-MC-Unique: HS-Lw4UaOSmhYt9kbc_3xA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5111de3fc23so125365e87.1
        for <mptcp@lists.linux.dev>; Tue, 30 Jan 2024 10:56:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706641008; x=1707245808;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GlE3N4XDj0MXCvgplom5A9Lp89QrCkivVCEFrxDvZqU=;
        b=tM0RWTu32jTxzk+aGOyKjXnUR8UWJ7Kz22RUKS067pBDMuwh1NPfrhOhlirMi18h6w
         TxC7xkunvXWNgdY4W2gxMl9N72u/X7A3EhYRVeHO5UJaFgVTeuNOMWPutY63qopLLvI6
         eGlvvCqrEtYVJKqYM8Xi/t3o98GahenrkfdMOfBS5M47uV4H966qbvswmJ651IZuqjez
         COTxorK2P5Mz1ERn6tggRw8jomF30XR8YZ+75d78sO44A9CD/mmUvmf1zAgHcdK7cx7F
         wnN9OxkN3YxkWjMj/YsMqDxYaoId64zo7NOkVJXQwbNhaJRPcKcjHOwo62SP9GsLPnOP
         0E2g==
X-Gm-Message-State: AOJu0YxPWz4mKCOMbQjDBs60xgqpbNaA4P/QbpMST8XnW0dgWkbaKGjr
	bod//fxyvK5bnKoIXLuMotFtPLTgkpJum4G/1aWkok3LN3uQz29Xvuk6/WejvVxyF6Qxq3BZ6xy
	T/rSay/6nFFJDJfoZyeaC7n5sjn04pdu9t9XChPWlrlT1xMZ1lnzyRcNk4F/S
X-Received: by 2002:a19:4f57:0:b0:510:16ae:52e with SMTP id a23-20020a194f57000000b0051016ae052emr6999141lfk.2.1706641008239;
        Tue, 30 Jan 2024 10:56:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNFemvQPeoOy9yXU+V81pI87wdidbC//b7q2b/8dDolJG+U1QBbS/PdECQ2xphTRAAhZJDYA==
X-Received: by 2002:a19:4f57:0:b0:510:16ae:52e with SMTP id a23-20020a194f57000000b0051016ae052emr6999121lfk.2.1706641007675;
        Tue, 30 Jan 2024 10:56:47 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-232-203.dyn.eolo.it. [146.241.232.203])
        by smtp.gmail.com with ESMTPSA id az11-20020a05600c600b00b0040fb30f17e8sm30551wmb.38.2024.01.30.10.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 10:56:47 -0800 (PST)
Message-ID: <69dd139b2240fd9ef704a130a952d9643f2148ed.camel@redhat.com>
Subject: Re: [PATCH mptcp-stable] mptcp: introduce explicit flag for first
 subflow disposal
From: Paolo Abeni <pabeni@redhat.com>
To: Christoph Paasch <cpaasch@apple.com>
Cc: mptcp@lists.linux.dev
Date: Tue, 30 Jan 2024 19:56:46 +0100
In-Reply-To: <9B692AAE-74A8-4101-9CDA-2580FCBAC7F0@apple.com>
References: <a1503ab571c8c076de62b872437d220a2260d2a5.1706094997.git.pabeni@redhat.com>
	 <9B692AAE-74A8-4101-9CDA-2580FCBAC7F0@apple.com>
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

On Wed, 2024-01-24 at 09:51 -0800, Christoph Paasch wrote:
> On Jan 24, 2024, at 3:35=E2=80=AFAM, Paolo Abeni <pabeni@redhat.com> wrot=
e:
> > This is targeting _stable_ and specifically 6.1.65.
> > I tested vs the repro in:
> >=20
> > https://github.com/multipath-tcp/mptcp_net-next/issues/466
> >=20
> > and WFM. @Christoph could you please validate this in your testbed, too=
?
>=20
> Yes, this fixes both #466 and #465.
>=20
> I=E2=80=99m updating syzkaller and if it=E2=80=99s happy I can push it to=
 upstream.

Thanks for testing and doing the process!

I'm wondering if there are other pending issues that impact your
deployment someway?

Cheers,

Paolo


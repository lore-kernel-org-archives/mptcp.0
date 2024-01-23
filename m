Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D9A443E
	for <mptcp@lists.linux.dev>; Tue, 23 Jan 2024 20:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706043249; cv=none; b=nzIL1ch5uf/5MoOd0ABYPNE8Z2gL8w3UsCMER92B1UqGF+frVj1u/UvbW63PEnZdpZwUfxlEJkLkLc36UhDygUxPsDuA+LGTT0NPnI45PayWG2Fr0UKUBzBSvgl7LG8mdSYJ1Ei4fRQab/3Ess5gSqWNavGD3kQ9CZBuLtkXjOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706043249; c=relaxed/simple;
	bh=I6BHKbaovRnAI5Qitb+MYWbC1cJbGclKw/yaHKYrIqY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UMpKyrtnrWXZJ9EnQ5+vHgQSH6K52/ru/pp2q3mcPuC4n+2Xqvi5jgfrAN2GBYntY5iO0vVOH9hok0jN9K9MZ6ckVnQLQYD15n3mzaFrctJxShgU4aXRDomiSyOLibbXwyOuoAnurYAGeGeE1w+ckYbiVODy9L21geUWXBGGvks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XFo5gQ8m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XFo5gQ8m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706043246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eB5Oj4UwuMNKrEV1mFfMHMBFeoo4vXbFK0fd3eiYH5U=;
	b=XFo5gQ8mgP/pMfubHcbAI5iTN+ZjWWEOtVsaz/irL6hpk17vx239teCbaxRLcC9PbhWHap
	CED8ojmaGfJPpbmekJ4RXpRDbfkd4bR7YSr5LeRLBcv5omVDzFsakn2xOO8nSZhXP6Vx7Z
	QvawsErg9s3OGfG3UnZ01BJriZz3/44=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-wbgPAtGIOCGJXCZptVSqLA-1; Tue, 23 Jan 2024 15:53:47 -0500
X-MC-Unique: wbgPAtGIOCGJXCZptVSqLA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40eaaaefbf5so5713505e9.0
        for <mptcp@lists.linux.dev>; Tue, 23 Jan 2024 12:53:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706043226; x=1706648026;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eB5Oj4UwuMNKrEV1mFfMHMBFeoo4vXbFK0fd3eiYH5U=;
        b=hDBNxOlcDUjVY6CeH0ltmNH9RrJ9Picx8KKYXIt8ai1ljSqiedrk7VbiohewlThstv
         wUzZPFZWDyjrDJ3sR9wq3IlCydgFeK/da2M8Q5cRKqSpImZ43dT2FnqdZg5/gv29fWmg
         +nLdh8JGRbLOkzp9xAlw8ZtiqnI3bT8/cqajFhCbnlsusoLz07AigYCDxymBAahvrqB5
         xEqcs8Jj7sUeLxD1OPnwoR81Y7RsLAsfojtK85Pgs5dVtkITAkOLSr8Kij9Ojr8L587M
         yCTBuhxbZrX5KMyI/eLdo7NeuIgYBsJJkYlg9B2x8spujnzBfNe2koJ9qkH95jZgsDZP
         JI7Q==
X-Gm-Message-State: AOJu0Yz1IX5biZXCWtFqeKAb53w1fl0WKO10ObstEaoQ4wfiNq7TrTgo
	aOMsySCagodpjSpoFlnqdtL1v8C+vy3uQcRQSHNZH+xQAP5O92G3Solj05CNzqb4dAbs6i22q7E
	I5zcEi8ENN7c9CitYuvSpllU33ln3UwxenGvsXGRpHiGD1cyHGAIT/BTVEUIx
X-Received: by 2002:a05:600c:1d1d:b0:40e:89ad:8b77 with SMTP id l29-20020a05600c1d1d00b0040e89ad8b77mr124766wms.3.1706043226453;
        Tue, 23 Jan 2024 12:53:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/vi0TVQZZUysah6zRFm6Rv09+IVzd3DcULBhc0h19/wWNAhaxjfo1rdklp1YPo8KTf36z4w==
X-Received: by 2002:a05:600c:1d1d:b0:40e:89ad:8b77 with SMTP id l29-20020a05600c1d1d00b0040e89ad8b77mr124761wms.3.1706043225900;
        Tue, 23 Jan 2024 12:53:45 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-245-66.dyn.eolo.it. [146.241.245.66])
        by smtp.gmail.com with ESMTPSA id i17-20020a05600c355100b0040d5f466deesm43357987wmq.38.2024.01.23.12.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 12:53:45 -0800 (PST)
Message-ID: <1a92e50d9a0e2a4189db6a14e6ccf3318f0e7c8c.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 4/7] selftests: mptcp: increase timeout to 30
 min
From: Paolo Abeni <pabeni@redhat.com>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Tue, 23 Jan 2024 21:53:44 +0100
In-Reply-To: <20240118-selftests-mptcp-simult-slack-qemu-no-kvm-v1-4-f3a4db41c3be@kernel.org>
References: <20240118-selftests-mptcp-simult-slack-qemu-no-kvm-v1-0-f3a4db41c3be@kernel.org>
	 <20240118-selftests-mptcp-simult-slack-qemu-no-kvm-v1-4-f3a4db41c3be@kernel.org>
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

On Thu, 2024-01-18 at 19:27 +0100, Matthieu Baerts (NGI0) wrote:
> On very slow environments -- e.g. when QEmu is used without KVM --,
> mptcp_join.sh selftest can take a bit more than 20 minutes. Bump the
> default timeout by 50% as it seems normal to take that long on some
> environments.
>=20
> When a debug kernel config is used, this selftest will take even longer,
> but that's certainly not a common test env to consider for the timeout.
>=20
> The Fixes tag that has been picked here is there simply to help having
> this patch backported to older stable versions. It is difficult to point
> to the exact commit that made some env reaching the timeout from time to
> time.
>=20
> Fixes: d17b968b9876 ("selftests: mptcp: increase timeout to 20 minutes")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  tools/testing/selftests/net/mptcp/settings | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/testing/selftests/net/mptcp/settings b/tools/testing/s=
elftests/net/mptcp/settings
> index 79b65bdf05db..abc5648b59ab 100644
> --- a/tools/testing/selftests/net/mptcp/settings
> +++ b/tools/testing/selftests/net/mptcp/settings
> @@ -1 +1 @@
> -timeout=3D1200
> +timeout=3D1800

Nice! the upstream CI is hitting this limit, too, and 1800 should avoit
that timeout.

Acked-by: Paolo Abeni <pabeni@redhat.com>


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6153813A27D
	for <mptcp@lists.linux.dev>; Fri, 19 Apr 2024 16:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713545902; cv=none; b=dMwu4zWtaDGMZDTbSSHPRTFKbIIx0HACHaZ4UfxP2JQWo1XveeXKSTDGb6AKu2sAmnfk/9ZuoKTqJgxiId3+LuxPkfJ2sNVqkbiIWNyFWQwG0xFwClkGpc42jTnAAIfbaqm3PgveN9V8ZfOCC7BjHo3S7x9NOm1uzyBLEaXVtQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713545902; c=relaxed/simple;
	bh=fxjbUsx/UxfRAVUEoW/xQodCX5hr8LcIxERPtmiJasc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mJ5jG7l86xIDPPy9M8gV7toCztASAQZ4x5JWvCUsIGJHt8WL6tYjLd9Wp6DjiCvWnqplduklPT+FFyBFvAcBtB1ftfDQIkvbY9lHPGnXXsWuiuVguOrt27OO56ZmNuxgyYubuhNbNra/Y0Xwjt9RSt1NvJFiMwf9UHEOWvS5F3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bWUZp4iw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bWUZp4iw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713545900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4HsDcfj1bUW7rutzTCsQj6DcDbxWRVBLmYJSWrpp9Xw=;
	b=bWUZp4iw61ma7MMrU5XkiOEx9L0UHgDJIsILgao+ewpS5hF3mr6gYR1VNz0b5UFnoAI4K3
	dmTcuxt4lX37hCdkLRQmENuE2DSRh8Ww1fzKPvQAKk4OabuXRKmBOMChc/bAmXnehKiq/j
	kqymM2GTX5zQjtKbsk+L9o9FS3f5sq4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-8IOTeZPiPzahY0q7bVC22Q-1; Fri, 19 Apr 2024 12:58:19 -0400
X-MC-Unique: 8IOTeZPiPzahY0q7bVC22Q-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-34a62c37dbcso111940f8f.0
        for <mptcp@lists.linux.dev>; Fri, 19 Apr 2024 09:58:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713545897; x=1714150697;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4HsDcfj1bUW7rutzTCsQj6DcDbxWRVBLmYJSWrpp9Xw=;
        b=H1wsLVJO60oxLB8AtgmBmCg11KnrKnqxy64FCif9aUk7pa30hdC3S2dxiiqEqpVhHi
         FCD/7tKSZilKL2g886cDIGhXm+OoZkk8mNemdxoqFPXGhOQDzjIqYmuDtoaaZY9X4P1f
         kDcEDk/r0BAc7Joiln6daFQtvsmvRxFa45EMOMWVGmj9zDI58TS5CMkVUGB+6vCeBshG
         gR3bvB3WjF3vqI3k8bmdrwMkKIPn8ufUIa6E8pg1GONuJtcfw4cWA90hb+jkJ6ObmLJp
         vKP50L0bGH7WI6giMnoqWoKbxNTsbvpk5eptDMuCcngGSJJXSRqpJ+KGGCGTIQ03uycH
         uvrA==
X-Forwarded-Encrypted: i=1; AJvYcCVxkqzCke3CL/PUDij55QFSeJlkG/ma/ZzJACZyVhcFB1ifGeTtugQMSiqYwTOLDs+DOX2nd92Q4G0Ey7/1f0B+SzYrRN8=
X-Gm-Message-State: AOJu0YxlK0Rxj1wLlSUEwlOkfIY1182L6VuKZq9fNEDaFa6id1hdV+w7
	1bjQ0eTml6aIBKscBq0CmmezUtLENdKWXrUfOxh9AS5O9zqjcAeF83uC4V3ncblGWYmrnZDUKTB
	WoZtAszXyndLXQc0NBWbp/23Gv1Yf9/C1cLI6D09qifFF1DXs4MfgWUoQYx5r
X-Received: by 2002:a05:600c:5113:b0:416:7b2c:df05 with SMTP id o19-20020a05600c511300b004167b2cdf05mr1848460wms.1.1713545897538;
        Fri, 19 Apr 2024 09:58:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNrpb/+KZ2kpR9F93oPrPrngaeOjM79UMHFTRiKNl4k63dowl+Wxxe1Ii035pZYbgw+wBzZA==
X-Received: by 2002:a05:600c:5113:b0:416:7b2c:df05 with SMTP id o19-20020a05600c511300b004167b2cdf05mr1848445wms.1.1713545897142;
        Fri, 19 Apr 2024 09:58:17 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-227-179.dyn.eolo.it. [146.241.227.179])
        by smtp.gmail.com with ESMTPSA id bi8-20020a05600c3d8800b00419c8e27f75sm1214640wmb.16.2024.04.19.09.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 09:58:16 -0700 (PDT)
Message-ID: <b41d1e68d1010c4735ea0d596c814168cd79f5d8.camel@redhat.com>
Subject: Re: [PATCH mptcp-net v3] mptcp: ensure snd_nxt is properly
 initialized on connect
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Christoph Paasch <cpaasch@apple.com>, mptcp@lists.linux.dev, Mat
 Martineau <martineau@kernel.org>
Date: Fri, 19 Apr 2024 18:58:15 +0200
In-Reply-To: <f979f4ba-d075-4ec7-95b9-3edfa0fb354b@kernel.org>
References: <3b0ca23eaa8906f967a841f55bafed48d0f895cb.1713367699.git.pabeni@redhat.com>
	 <f979f4ba-d075-4ec7-95b9-3edfa0fb354b@kernel.org>
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

On Fri, 2024-04-19 at 17:15 +0200, Matthieu Baerts wrote:
> Hi Paolo, Mat, Christoph,
>=20
> On 18/04/2024 09:44, Paolo Abeni wrote:
> > Christoph reported a splat hinting at a corrupted snd_una:
> Thank you for the patch, the review, and the bug report + test.
>=20
> I forgot to send a notification after I applied this patch. In between,
> the CI already validated this, and both the build for export and
> export-net have the same issue with Packetdrill (fastopen):
>=20
> - export:
>=20
> > not ok 32 packetdrill: mptcp/fastopen/server-TCP_FASTOPEN-cookie-req.pk=
t (ipv4-mapped-v6)
> > # server-TCP_FASTOPEN-cookie-req.pkt:23: error handling packet: live pa=
cket field ipv4_total_length: expected: 48 (0x30) vs actual: 64 (0x40)
> > # script packet:  0.660855 . 1:1(0) ack 1 <dss dack4 3007449510 flags: =
A>
> > # actual packet:  0.651162 . 1:1(0) ack 1 win 256 <dss dack4 3007449509=
 dsn8 4250179620018965011 ssn 0 dll 1 no_checksum flags: MmAF,nop,nop>
>=20
>  https://github.com/multipath-tcp/mptcp_net-next/actions/runs/8752422517
>=20
> - export-net:
>=20
> > not ok 32 packetdrill: mptcp/fastopen/server-TCP_FASTOPEN-cookie-req.pk=
t (ipv4-mapped-v6)
> > # server-TCP_FASTOPEN-cookie-req.pkt:23: error handling packet: live pa=
cket field ipv4_total_length: expected: 48 (0x30) vs actual: 64 (0x40)
> > # script packet:  0.667029 . 1:1(0) ack 1 <dss dack4 3007449510 flags: =
A>
> > # actual packet:  0.665988 . 1:1(0) ack 1 win 256 <dss dack4 3007449509=
 dsn8 4812888791396531368 ssn 0 dll 1 no_checksum flags: MmAF,nop,nop>
>=20
>  https://github.com/multipath-tcp/mptcp_net-next/actions/runs/8752426856
>=20
> Do you think this is linked?

I hope it's not, but the timing hints otherwise :( I'll try to have a
better look.

Thanks for the head-up!

Paolo


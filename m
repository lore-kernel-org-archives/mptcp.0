Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AE91EB46
	for <mptcp@lists.linux.dev>; Fri, 10 May 2024 08:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715329985; cv=none; b=AHfbIFeOdgYPqP7rvsx6llC/j0X3FJwJLaYqCPBWi+hkU8OZk07jC+p7M9fqMY87UAZfI3xCP62iDA+nvoIUOZi0BJAI9RWmMpUTVQzzUfM+1CqSX5A+laJ9GjmHEEpqpSSI8xxeR24pRmi9stm1vkn69pOHmbVunULd5IZz8LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715329985; c=relaxed/simple;
	bh=CmJTtcORWUXSe7NROzYP9zEt8UD4yZt/PArBU2LF0kM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SamCj93QU5hMG9fdG3/g7hq0A15blsVnkljVZeFm6si2TbQEDGX+s0fqrFB3HO75BgXA528gNk+P7hElqPI4WMHXlq5vaAQNdErNRN09X8CU60w+IVFTIY7+XI6E+Bhmdqovcikr7XHFx7AmWjrfeS62G6pbaLzYRhB4VUPjBqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RUFBj9JI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RUFBj9JI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715329982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hxu7RkwDKHST6AtYDY+AnW9MBNMvPtUFWrVqp7DGjEg=;
	b=RUFBj9JInu6/LG2HZJXdMhTarMnIGgGTY+D/jQtwAKMk6s0aJ+fJ4WRz6mv704jv9gvBQu
	fulLDFprcrSEeMz539o/DG0cgNtYEyG0mHSk+HiBSXS4VXcivyqaqUzOPav8aChLX6fwA6
	2cOm55hjNsyabxuWNwpItQBT4jSB0n4=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-rOzwmOMgNV2q4T-UaQPQ-w-1; Fri, 10 May 2024 04:33:01 -0400
X-MC-Unique: rOzwmOMgNV2q4T-UaQPQ-w-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2e226454713so2949701fa.0
        for <mptcp@lists.linux.dev>; Fri, 10 May 2024 01:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715329980; x=1715934780;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hxu7RkwDKHST6AtYDY+AnW9MBNMvPtUFWrVqp7DGjEg=;
        b=gobMMYl54vvape0hPdDrNbq3a/WQh8xJc8XIJ61COgXb8BtRecVtvJLk2HgA1eORbZ
         Rn+q8tj8En3eKoEP015TEM6r1fmBJKRvBJeVoH54/Er+1yJJhcitLQ2e97lTMi7Lhkbc
         jubCFSucRuOmZXRBZqmaZ79/ls7XkpTnlj19UDGwU4e8/vnpt6QPGToWRFvBJ3xfrXWU
         X3efIag07iHmzEFInYnI3yFxwCj+2045cJPEeleZGR8yHwJR9QyMP+LiXQ42tmRGAshh
         z7KNhThc5FFBzdwgSgvEpCFNxfoSdV/Gfmz5q8gtBxXtLDuo7L3acSwuLWL1wGIFtAkc
         oTDw==
X-Forwarded-Encrypted: i=1; AJvYcCXTyemm2W9n4eubWJbpNWbPsHb/BZfsqLaK1w1g7fLZZ9nBpIicQyDqNeoh1pH/NsdfnJVIcFp23Xzfyko+4qV5ImcqoHk=
X-Gm-Message-State: AOJu0YyyqAEonWdreWR3O+MQAwO2YSWuJcEF4mJthx01ACkQCfYgrvcn
	7qx9FvijYO4R7TeE53WuA9VNR9NxRXpvssO3ipKqcvz2UwYDDXIQCJOew85Bkc3//OKnhoEmJxi
	tNx5YzNOFiVBmuZTDbyTQuB/p1osY5S9voqTIikEDYe9dPY4nwfpX
X-Received: by 2002:a2e:b015:0:b0:2e3:ba0e:de02 with SMTP id 38308e7fff4ca-2e5205eb315mr11872541fa.5.1715329979948;
        Fri, 10 May 2024 01:32:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQio35LmajPVJED4hZ/tON/RK4gJZdc1fB8twTFOu6ZgfIrermVE6cGAryt3Rfje8xjhbRhA==
X-Received: by 2002:a2e:b015:0:b0:2e3:ba0e:de02 with SMTP id 38308e7fff4ca-2e5205eb315mr11872451fa.5.1715329979452;
        Fri, 10 May 2024 01:32:59 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:1b68:1b10::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccee9318sm55108445e9.30.2024.05.10.01.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 01:32:59 -0700 (PDT)
Message-ID: <e5f65112c385549b57a53075db4a73ac728f4f79.camel@redhat.com>
Subject: Re: [PATCH mptcp-net v2 0/2] mptcp: getsockopt(SO_KEEPALIVE) and
 TCP_KEEP* sockopts
From: Paolo Abeni <pabeni@redhat.com>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Fri, 10 May 2024 10:32:58 +0200
In-Reply-To: <20240509-mptcp-tcp-keepalive-sockopts-v2-0-5f97067847a2@kernel.org>
References: <20240509-mptcp-tcp-keepalive-sockopts-v2-0-5f97067847a2@kernel.org>
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

On Thu, 2024-05-09 at 12:48 +0200, Matthieu Baerts (NGI0) wrote:
> This is linked to a discussion we had a few weeks ago: not supporting
> TCP_KEEP* socket options is preventing MPTCP to be used in some apps or
> libraries like it was the case in GoLang recently.
>=20
> Supporting them is not difficult, it should have probably done before,
> when SO_KEEPALIVE support has been added. Supporting them is easy and
> isolated from the rest, it sounds safe enough to add a Fixes tag, and
> check with the stable team to backport them. I understand it can be a
> bit controversial, but it would unnecessary delay (1 or 2 years?) some
> deployments, for something that simple.
>=20
> While at it, getsockopt(SO_KEEPALIVE) is now returning the expected
> value.
>=20
> The manipulation of these different socket options can be verified with
> this simple packetdrill test:
>=20
>   --tolerance_usecs=3D100000
>   `../common/defaults.sh`
>=20
>   0.0    socket(..., SOCK_STREAM, IPPROTO_MPTCP) =3D 3
>   +0     setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
>   +0     bind(3, ..., ...) =3D 0
>   +0     listen(3, 1) =3D 0
>=20
>   +0       <  S   0:0(0)         win 8000  <mss 1024, sackOK, nop, nop, n=
op, wscale 0, mpcapable v1 flags[flag_h] nokey>
>   +0       >  S.  0:0(0)  ack 1            <mss 1460, nop, nop, sackOK, n=
op, wscale 8, mpcapable v1 flags[flag_h] key[skey]>
>   +0.01    <   .  1:1(0)  ack 1  win 8000                                =
             <mpcapable v1 flags[flag_h] key[ckey=3D2, skey]>
>   +0     accept(3, ..., ...) =3D 4
>=20
>   // Set and check the different Keep-Alive options.
>   +0     getsockopt(4, SOL_SOCKET, SO_KEEPALIVE, [0], [4]) =3D 0
>   +0     setsockopt(4, SOL_SOCKET, SO_KEEPALIVE, [1], 4) =3D 0
>   +0     getsockopt(4, SOL_SOCKET, SO_KEEPALIVE, [1], [4]) =3D 0
>=20
>   +0     getsockopt(4, SOL_TCP, TCP_KEEPIDLE, [7200], [4]) =3D 0
>   +0     setsockopt(4, SOL_TCP, TCP_KEEPIDLE, [7200], 4) =3D 0
>   +0     getsockopt(4, SOL_TCP, TCP_KEEPIDLE, [7200], [4]) =3D 0
>=20
>   +0     getsockopt(4, SOL_TCP, TCP_KEEPINTVL, [75], [4]) =3D 0
>   +0     setsockopt(4, SOL_TCP, TCP_KEEPINTVL, [10], 4) =3D 0
>   +0     getsockopt(4, SOL_TCP, TCP_KEEPINTVL, [10], [4]) =3D 0
>=20
>   +0     getsockopt(4, SOL_TCP, TCP_KEEPCNT, [9], [4]) =3D 0
>   +0     setsockopt(4, SOL_TCP, TCP_KEEPCNT, [2], 4) =3D 0
>   +0     getsockopt(4, SOL_TCP, TCP_KEEPCNT, [2], [4]) =3D 0
>=20
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

LGTM, thanks!

Acked-by: Paolo Abeni <pabeni@redhat.com>


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8422B188
	for <mptcp@lists.linux.dev>; Mon, 11 Sep 2023 07:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694415727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=URS2PRQSwgTcDezanmr8czd/BjjjuTE7I1YosJhoGjQ=;
	b=ZK4bQKAav+Dg+KMXAeNeq9KYfM0DCL683BmYtDl8m/QlbM37HmR/JQ2gTyILQJQ8e16LZA
	f/L7nrMd6WiHyBqUjgRNIHoau6n4JSlKtZxkwgiheeq+tVjDta46GpSsjODpfJbBG7Fd+Q
	OFAYagiEriE2zgPQxJ9RTT/u208Ucbw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-H6sxj_ArMo6nNHHbqo9meA-1; Mon, 11 Sep 2023 03:02:06 -0400
X-MC-Unique: H6sxj_ArMo6nNHHbqo9meA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9a1aaaf6460so93627866b.1
        for <mptcp@lists.linux.dev>; Mon, 11 Sep 2023 00:02:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694415724; x=1695020524;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AJYzofkSeWgDDu1AYOCE/AxSUFoswtxFveYffjzV77E=;
        b=OKOR9jJn2AEj8w3Uz1za380h49c6X2BSQt7NaOb5LFSjwOOABpb6ugXftn43nwUpv2
         8o+6oXiSSqxLG78iAl+hxVVgoAWNHdZrGEle6TaaykMZ2TLbxSrVaDu206/rRfnWAk9c
         ROlHnm1q1fJ6Ykvo8IAg7ek7pAfRuvnWkH/7wRSzDPRR8Wb0QbwukXO0BX6LFT0fUg+w
         6F0z/MTidSl7zhQn/xmhm9VmC14Zgh+6s5u0s23KKHV2n/E4Iu8QJe1kQf3H6IZfyY9P
         i1j2+XVqDa57b43sRdtPWLhJHyYQc1KCjz6opjim7rzuhh40aVCsCWvZmyMl6k2jML1i
         mLQQ==
X-Gm-Message-State: AOJu0YyrtMSgfFIneDEAhwMLle+CSUENSn5rLPpYszg5L+2W2wd6HBiO
	10l2ckM5SubPi9ysNpRMm+o7gcrk4QYINfGcRZVpDAIZjMpXTh1q0nA82Z+TiD9G0JhMilSqLGj
	2yL91qkbHQlU1tu0u/55UFVQ=
X-Received: by 2002:a17:906:7398:b0:9a1:ddcc:3a04 with SMTP id f24-20020a170906739800b009a1ddcc3a04mr7897560ejl.5.1694415724729;
        Mon, 11 Sep 2023 00:02:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2TIpoVHWy4QwMyT3LS+ekthu7qudNOo/cn5qb6pVMwBEmQVsCWR4vLwuOYTeLP2hRRl7r1g==
X-Received: by 2002:a17:906:7398:b0:9a1:ddcc:3a04 with SMTP id f24-20020a170906739800b009a1ddcc3a04mr7897539ejl.5.1694415724307;
        Mon, 11 Sep 2023 00:02:04 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-243-166.dyn.eolo.it. [146.241.243.166])
        by smtp.gmail.com with ESMTPSA id l1-20020a170906938100b009a16975ee5asm4834427ejx.169.2023.09.11.00.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 00:02:03 -0700 (PDT)
Message-ID: <d25792cb9d89788d85b22565e331270559b517ef.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v2] mptcp: add a new sysctl for make after
 break timeout
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
Date: Mon, 11 Sep 2023 09:02:02 +0200
In-Reply-To: <6598f7cf-3d75-3d99-2458-6c0bc8f08a51@kernel.org>
References: <dfadc0c4a9bf4649c01e09d675f4de59eb409f5d.1693841118.git.pabeni@redhat.com>
	 <6598f7cf-3d75-3d99-2458-6c0bc8f08a51@kernel.org>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
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

On Tue, 2023-09-05 at 14:43 -0700, Mat Martineau wrote:
> On Mon, 4 Sep 2023, Paolo Abeni wrote:
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 80d06cab8bc7..735ff5cda940 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -2501,7 +2501,7 @@ static bool mptcp_close_tout_expired(const struct=
 sock *sk)
> > =09=09return false;
> >=20
> > =09return time_after32(tcp_jiffies32,
> > -=09=09  inet_csk(sk)->icsk_mtup.probe_timestamp + TCP_TIMEWAIT_LEN);
> > +=09=09  inet_csk(sk)->icsk_mtup.probe_timestamp + mptcp_close_timeout(=
sk));
>=20
> There's some logic to also fix up in __mptcp_close_ssk()'s SOCK_DEAD code=
=20
> path, one lingering instance of TCP_TIMEWAIT_LEN there to switch to=20
> mptcp_close_timeout().

Right you are! thanks for catching that. I'll swap the sock_flag and
mptcp_set_close_tout() to ensure the timeout is always consistent.

Thanks,

Paolo


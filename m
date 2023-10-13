Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0099134C3
	for <mptcp@lists.linux.dev>; Fri, 13 Oct 2023 10:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bwcF9fN3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697193169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZNwjB4WmSHxup+Mpb6E6ku//WoRUw/Oem8unbKbSCLI=;
	b=bwcF9fN336V7nRIRl4vKL7qz8qWdxJMg56nzKS4Pv6YQ0ev+XOFdDX5X4pSP4o5U6i18iX
	HGsQ5loFMFJzUmgf/LyBnfVSE0/0AGPJlguhvgaW5P36bFAGeiyBE2W/XX6zhiA3SNJl/l
	AlKF/Ust18Fk3s5fgwEG52v/6L/hy2w=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-9k4Ui_Y2N2Wi1Bw-89aRfA-1; Fri, 13 Oct 2023 06:32:48 -0400
X-MC-Unique: 9k4Ui_Y2N2Wi1Bw-89aRfA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9ae5101b152so25778366b.1
        for <mptcp@lists.linux.dev>; Fri, 13 Oct 2023 03:32:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697193166; x=1697797966;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u5SfYyzG//wHOoBQ9y0+HU9Jts3xt3XBaiKe0/YrUXs=;
        b=CfoBS2OHu5rwLwIPzsOzIJ39InPRb9vAM8/a1THM5FKvd1CRiYJeHeDqhdvIvkBfCI
         AvYuGxB1btmFp2OsOsRIAOk4Z/LgsgQwkrIoDO4BZ7NH/kYOGuiJ7XTan/b5Y20nwwx/
         3Wwgd6fXURnOaXipig24wg83yccXUmDH2jZrnErBXDe+YLPleV5RumyNdaJOgmBan5IF
         HeNt1t1kq676HLCDF+OATiXpij/0SaeZ+3eHyChB5t/pij/yvkxti2ScVmc8+ozXDeKh
         ZaHE6Uzk9j5p+thNGMzaGKoWy6FFn6ERU0xaR2oyR64JPDJOXSzVSHFHi2hsZd7Haohn
         JBig==
X-Gm-Message-State: AOJu0Yz+0otQmRTbuzDSomcJqefkOrGG8Vz4GTFqFvF/n+vvX6sUTglT
	bgXZyg3gLf415/wWR9bIpP6JDtA7z/xs7htmFQ5bsnKe2AFXsXzbr83pBiBTO1I1EbtModMMypU
	I/BBlKSYly1/TPUNBysNKi1A=
X-Received: by 2002:a17:906:738a:b0:9b2:b149:b819 with SMTP id f10-20020a170906738a00b009b2b149b819mr20726788ejl.6.1697193166749;
        Fri, 13 Oct 2023 03:32:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhnOpJuf78t7ROz8+YMAKQ8vBmZZ0yY75Y04IwYjw8q8cYg2m0UPIbQw7d6cDxHmlRp+qu9g==
X-Received: by 2002:a17:906:738a:b0:9b2:b149:b819 with SMTP id f10-20020a170906738a00b009b2b149b819mr20726771ejl.6.1697193166331;
        Fri, 13 Oct 2023 03:32:46 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-235-54.dyn.eolo.it. [146.241.235.54])
        by smtp.gmail.com with ESMTPSA id u2-20020a17090617c200b009ad8084e08asm12045360eje.0.2023.10.13.03.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 03:32:45 -0700 (PDT)
Message-ID: <e3769002c1ff6139f9359413cd1ad415e593a3f2.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v16 3/8] Squash to "mptcp: add
 mptcpi_subflows_total counter"
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Date: Fri, 13 Oct 2023 12:32:44 +0200
In-Reply-To: <4f136ef2b23fb55e2e42397f1e07e74b355d5f61.1697175899.git.geliang.tang@suse.com>
References: <cover.1697175899.git.geliang.tang@suse.com>
	 <4f136ef2b23fb55e2e42397f1e07e74b355d5f61.1697175899.git.geliang.tang@suse.com>
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

Hi,

On Fri, 2023-10-13 at 13:46 +0800, Geliang Tang wrote:
> Update __mptcp_has_initial_subflow().
>=20
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  net/mptcp/protocol.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 6508179e94a6..1fb4ac3727c4 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -1081,7 +1081,7 @@ static inline bool __mptcp_has_initial_subflow(cons=
t struct mptcp_sock *msk)
>  {
>  =09struct sock *ssk =3D READ_ONCE(msk->first);
> =20
> -=09return ssk && inet_sk_state_load(ssk) !=3D TCP_CLOSE;
> +=09return ssk && inet_sk_state_load(ssk) =3D=3D TCP_ESTABLISHED;

I think the above is not correct, __mptcp_has_initial_subflow() will
return false before connect completes and/or for listener sockets.

You can list explicitly add the valid states with something alike:

=09(1 << inet_sk_state_load(ssk)) & (TCPF_ESTABLISHED |
TCPF_SYN_SENT | TCPF_SYN_RECV | TCPF_LISTEN | TCPF_CLOSE_WAIT)

I'm unsure if we should include CLOSE_WAIT here: the remote has shut
down, but this end can still send data...

Side important note: you are too fast :) There are a lot of in-flight
patches, and it's difficult to follow each series consistently. I
suggest to focus on a small subset - possibly on a single series at the
time.

e.g. The first 2 patches in this series are IMHO ready to be merged
[*]. If Mat could apply them, you could follow-up with the remaining
bits of this series.

Cheers,

Paolo

[*] modulo some expansion to the changelog of patch 1, but that could
happen even after merging IMHO.


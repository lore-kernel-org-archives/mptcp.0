Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E1727462
	for <mptcp@lists.linux.dev>; Tue, 10 Oct 2023 16:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S31ZMwMD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696954850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iYDuCyH9aEYPWXeNX8cJKmgs3dctwHQMuZQqdFN0i7k=;
	b=S31ZMwMDdXVjxBFABqTq4lvwBCiKOw6Ejr546s99oOcKQ8f7r7FTNGkidq8qWLmChvDnFp
	mUrcawTRtQte/ELiTeSKPDXqHc1m/wi366rDl+rqWphfbi2923+veoXluda+FfI48qIKso
	JXEZ8agrAaqeF98dGvVuueKrzWDdUXI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-nAxgrwybMm2tDYFo34_KlA-1; Tue, 10 Oct 2023 12:20:48 -0400
X-MC-Unique: nAxgrwybMm2tDYFo34_KlA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9b989422300so109146666b.0
        for <mptcp@lists.linux.dev>; Tue, 10 Oct 2023 09:20:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696954847; x=1697559647;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H2gqHOhI44Gw6Qnwf/ErnkFRglnVAgxvLrl+7qeIrdA=;
        b=VODHzeO2Nzs8YF/j89CGMIuPiU/l8IxnkIzstGIYhvpGevh5aHpkYkqVmlU3kTytDv
         M+/XIR4xN/jNO5bnVKAKOhCIMtktKVgNF7WczTE/+O36nhGvk8Z7w4/TAcHlJP66S9Yj
         PUZ/ARxANPvAU1bh2Q9/EZ9wHwfY0lFf0cWohbFOKYVkiZR4sGfusGjLz6BlkISzWKxs
         y1z092yYWjM43Ya0RpGKWbMkpkT1sHR3qYJSJnt/0rwG8GTtU8AHEVj5vSkGg+VNQ3V1
         c/j3ZxtQBsypELalkK8wfcsKHV/lAiXigQN+PpwTUCJaMifGBRbxPZKp1/o2Fh87vsA6
         5caA==
X-Gm-Message-State: AOJu0YyJQK/TOq+1u0DPqbt+aMfrr/pzCw3nJ6s2u+ZvDjJ8owyRJvcG
	Zjijiint8YBG9aURHIn8GiGak1jxqaPKeOqcfvhBe+uSGn1M2l6spLBHYd8te426x/9aU3tTfNo
	pl2LENcKjX8Xbp5sYVaremc8=
X-Received: by 2002:a17:906:100c:b0:9ae:6da8:181c with SMTP id 12-20020a170906100c00b009ae6da8181cmr14456996ejm.7.1696954847325;
        Tue, 10 Oct 2023 09:20:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDAMYBd6UjX+QjZxCjAvgd9wD/p0/ZxWRshcBDaJIRwNWUdjVApMNsDykjAxU4TOqumkOscw==
X-Received: by 2002:a17:906:100c:b0:9ae:6da8:181c with SMTP id 12-20020a170906100c00b009ae6da8181cmr14456981ejm.7.1696954846950;
        Tue, 10 Oct 2023 09:20:46 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-228-243.dyn.eolo.it. [146.241.228.243])
        by smtp.gmail.com with ESMTPSA id jp20-20020a170906f75400b0099bcb44493fsm8688727ejb.147.2023.10.10.09.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 09:20:46 -0700 (PDT)
Message-ID: <2cd57e92348cea6c9cb00eca44b29c5286023955.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v12 1/5] mptcp: avoid resetting when another
 subflow available
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Date: Tue, 10 Oct 2023 18:20:45 +0200
In-Reply-To: <2b69fa22510db02a12eb101c3e8173dda76f8133.1696831239.git.geliang.tang@suse.com>
References: <cover.1696831239.git.geliang.tang@suse.com>
	 <2b69fa22510db02a12eb101c3e8173dda76f8133.1696831239.git.geliang.tang@suse.com>
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

On Mon, 2023-10-09 at 14:02 +0800, Geliang Tang wrote:
> When closing the msk->first socket in __mptcp_close_ssk(), if there's
> another subflow available, it's better to avoid resetting it.
>=20
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  net/mptcp/protocol.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 30e0c29ae0a4..6346a164ed66 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2396,7 +2396,7 @@ static void __mptcp_close_ssk(struct sock *sk, stru=
ct sock *ssk,
>  =09=09goto out_release;
>  =09}
> =20
> -=09dispose_it =3D msk->free_first || ssk !=3D msk->first;
> +=09dispose_it =3D msk->free_first || ssk !=3D msk->first || !list_is_sin=
gular(&msk->conn_list);
>  =09if (dispose_it)
>  =09=09list_del(&subflow->node);

I'm sorry for the late feedback.

We can't do the above,=C2=A0Syzkaller already hit us in the past while
attempting that thing.

We need to be msk->first !=3D NULL and a valid, derefereciable pointer up
to mptcp_destroy() - that is, up to when the msk socket is freed -
otherwise we will hit a number of UaF in many places.

Note that claring msk->first here, and add check for 'msk->first !=3D
NULL' before every msk access, will not save us, sometimes msk->first
is tested without the msk socket lock.=20

I think there are 2 options here:

- the caller (PM NL/PM userspace) could explicitly avoid calling
mptcp_close_ssk() when removing subflow 0 (just shut it down)

- Add a new flags MPTCP_NO_DISCONNECT, and let the caller pass it here.
  When MPTCP_NO_DISCONNECT is set, we invoke tcp_shutdown() instead of
tcp_disconnect()

Both options are actually quite similar, the 2nd is possibly the
cleanest.

Note that looking here for 'this is the last subflow' and avoid the
disconnect otherwise, does not look correct/safe: we want to invoke
tcp_disconnect() even when first is _not_ the last subflow and we are
reaching mptcp_close_ssk() from a different caller - e.g. from
mptcp_disconnect()

/P


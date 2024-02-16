Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F3C1BC3E
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 09:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708076406; cv=none; b=Ifg6aaAJqYvzsgDDcPgi9blMD7IDk4/60EdgtbZwJelm+ExTzOsdOD3nxTFqfmgLxxTda9/GaYdn34bsRI0HToaSTh8iQ/+T5YJMJWZ1IOzGWX3kWgGdp6Az3L9XAIRBRlH883m3NhcZddAgni8jiPKHJgw5rIujNeDyWII90sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708076406; c=relaxed/simple;
	bh=RCpKgKmKNWfz/GHdxgqdIXKSD8XGKXBtp2ZTVAq7tAg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CaCJI9kcqLrBD8fyNsFV9ntzvLdRsBqFudKlwk8dDWs2XBygfZ9dPWNnbgkELkiLSScjW+GiOwCIV0q+mlSu9F+aFNrQfeZvgXno5rcauT/wfP/I2ITNhhVi5ZIMCyVnrHKEJo9X9/A1QklsJvRC7IOzZ8ZvR4/JUjAME09z+Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y0pCj0ND; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y0pCj0ND"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708076402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1MN0q3dE79TGn7QEakKQP1hnC8F/vz1OX1m33L6KFV8=;
	b=Y0pCj0NDKsgqQ7NRVfIaeUgZ/iFrj36890LGYp6iaXuximIDMVfv2aD/mei8G0tQHL5aGw
	8YuU/NqbmMzO3ZbMjk1JiIoIUv+0vwLZYlOwX3GI3WLPcL8pW4EsanzXomTLupP4e/tlhF
	EzfPog+IxuE1aD8l4IyMdBdBaji8W3Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-VrI5i2xxM-KS42fUPr8n3w-1; Fri, 16 Feb 2024 04:40:01 -0500
X-MC-Unique: VrI5i2xxM-KS42fUPr8n3w-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-411e27d561dso4240985e9.0
        for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 01:39:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708076398; x=1708681198;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aJ9Mt6mxSMqKqgMYvLS/EIiDVvkcfrFeiYKXLeCJNa0=;
        b=Cb3kBTUXNoe0u0Rq8y6KLYTfTCWZkpn7hAE1XADGtzN0w0036yeQHnHb1j7geWRrBL
         16xgp5YnRG5ipVgurF2G64BdI1YW8e831Vrjqz5L4zX0wVxksEO4XjBDmUm8/RTzvfJs
         qUZdUn0XYomxmVzxPdVsEnWpyzCvJRVd7ml/uRvMKYEh3Seb0Bd4BHD8VSODUbRZY/Yr
         nw1wUdDCHqD2mQjnNPoMBf6CAQxHq24jnzuVgOcHqn/VMOEHIMA1Crn+OWWLNXoy3FkY
         g31mkpTubNpiALKuT8QvcRwgVvtoFQyN1TeKTcdja2uqePWy45hocM3nh2eZdyrkRYKL
         jrtQ==
X-Gm-Message-State: AOJu0Yzzj0Jx/wFqSSc6Pkx5bfAw01ykjS+ZH66AlpqUEi24SCJYAB3s
	KVfSAacid52CdXF1imyVgk67vRc1KmHmWSG+XuRwML0g3SA9z1pL6JoUORgFhu7RhcLxqchFBiW
	0A1lxTstaoe4AyctXfa8soQy7fzYA3gsrEpleSB24pM1kffwQBrFl+yWQ4rDY
X-Received: by 2002:a05:6000:382:b0:33b:3104:c29 with SMTP id u2-20020a056000038200b0033b31040c29mr3687211wrf.3.1708076398675;
        Fri, 16 Feb 2024 01:39:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlmDV2c72sgZhW2P8AbffkkYsBGlc/QTKXN5iEniugSrSFfT5UUU9KDvgnQrycufoC0Ys8XA==
X-Received: by 2002:a05:6000:382:b0:33b:3104:c29 with SMTP id u2-20020a056000038200b0033b31040c29mr3687199wrf.3.1708076398282;
        Fri, 16 Feb 2024 01:39:58 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-239-108.dyn.eolo.it. [146.241.239.108])
        by smtp.gmail.com with ESMTPSA id bj15-20020a0560001e0f00b0033b3ca3a255sm1729899wrb.19.2024.02.16.01.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 01:39:57 -0800 (PST)
Message-ID: <c802e45d4a9011b8344f428aa0757792de6fdacd.camel@redhat.com>
Subject: Re: [mptcp-next v2 3/7] mptcp: fix potential wake-up event loss
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
Date: Fri, 16 Feb 2024 10:39:56 +0100
In-Reply-To: <27696500-0456-ef2d-164b-d6c7a30a459e@kernel.org>
References: <cover.1707739536.git.pabeni@redhat.com>
	 <78924a15f3d86f989fa286f10ef88670b790eb89.1707739536.git.pabeni@redhat.com>
	 <27696500-0456-ef2d-164b-d6c7a30a459e@kernel.org>
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

On Thu, 2024-02-15 at 14:20 -0800, Mat Martineau wrote:
> On Mon, 12 Feb 2024, Paolo Abeni wrote:
>=20
> > After the blamed commit below, the send buffer auto-tuning can
> > happen after that the mptcp_propagate_sndbuf() completes - via
> > the delegated action infrastructure.
> >=20
> > We must check for write space even after such change or we risk
> > missing the wake-up event.
> >=20
> > Fixes: 8005184fd1ca ("mptcp: refactor sndbuf auto-tuning")
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > net/mptcp/protocol.h | 27 ++++++++++++++++++++-------
> > 1 file changed, 20 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index 486fff865803..2e197262a42e 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -797,6 +797,16 @@ static inline bool mptcp_data_fin_enabled(const st=
ruct mptcp_sock *msk)
> > =09       READ_ONCE(msk->write_seq) =3D=3D READ_ONCE(msk->snd_nxt);
> > }
> >=20
> > +static inline void mptcp_write_space(struct sock *sk)
> > +{
> > +=09if (sk_stream_is_writeable(sk)) {
> > +=09=09/* pairs with memory barrier in mptcp_poll */
> > +=09=09smp_mb();
> > +=09=09if (test_and_clear_bit(MPTCP_NOSPACE, &mptcp_sk(sk)->flags))
> > +=09=09=09sk_stream_write_space(sk);
> > +=09}
> > +}
> > +
> > static inline void __mptcp_sync_sndbuf(struct sock *sk)
> > {
> > =09struct mptcp_subflow_context *subflow;
> > @@ -815,6 +825,7 @@ static inline void __mptcp_sync_sndbuf(struct sock =
*sk)
> >=20
> > =09/* the msk max wmem limit is <nr_subflows> * tcp wmem[2] */
> > =09WRITE_ONCE(sk->sk_sndbuf, new_sndbuf);
> > +=09mptcp_write_space(sk);
> > }
> >=20
> > /* The called held both the msk socket and the subflow socket locks,
> > @@ -845,14 +856,16 @@ static inline void mptcp_propagate_sndbuf(struct =
sock *sk, struct sock *ssk)
> > =09local_bh_enable();
> > }
> >=20
> > -static inline void mptcp_write_space(struct sock *sk)
> > +static inline void __mptcp_sync_sndnxt(struct sock *sk, u64 new_snd_nx=
t)
>=20
> Hi Paolo -
>=20
> I think you missed my comment on this in v1, __mptcp_sync_sndnxt() isn't=
=20
> called anywhere.

Indeed! sorry for missing it, and thank you for persisting. Yes, I must
drop the function definition. FTR, it's a left-over of a previous
implementation attempt.

Thanks!

Paolo


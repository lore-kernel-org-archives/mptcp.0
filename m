Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E868D3FB2A
	for <mptcp@lists.linux.dev>; Thu, 23 Nov 2023 16:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QgXef2JB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700757699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dveXkQFj9YpNm9gTpPYjeIznUd8V0p5NkAse+FXzZ5Q=;
	b=QgXef2JBmmSGZujUWjGiHhgWUJw6p/6WNS4cI10dl8Cjr1Tu3Vsz8yZN/XR6eVANEy3TAi
	C+8d0sPd2Vi5lNcYyfjIkEvlGFBRRgVXVGCFZUDBMKXfYxEVpoFMstgvPEaoiuo0nXzNJC
	LnGeVsYzxUH7sXZIVhKN/zDDCek6QbQ=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-8qZ5HeiTOfui57jUP3cZGQ-1; Thu, 23 Nov 2023 11:41:36 -0500
X-MC-Unique: 8qZ5HeiTOfui57jUP3cZGQ-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1f93a01ef88so431964fac.1
        for <mptcp@lists.linux.dev>; Thu, 23 Nov 2023 08:41:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700757695; x=1701362495;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CvhyGiocd9S/WTnrqejrqxwkYC77vaP/alpx7EwV9GM=;
        b=uZ63Ad9HpiVyQYc/pJT7cKLcUcBMlU8hjy2eu7x/zrswZURHH/Zqq5I93yviTqIDHK
         XNEv+c2RxXOJDjuU/iRCFNaOTQUppaNUq4cnAvawPvGi2VHuYI8WQ1Ds6/UgwV/mBK0A
         dgr3u+wVsuHV2thIr6Am2yM23FAQUebEjqwgaFHm4fPWl17e2kt2GLupfP5mpPYOdMGm
         KW76tgoiH3Axdi/bwiQdiXGgROUgz8TCUbn40fe1hq/U+h4NB3qR78qTCf9dxWu+S23T
         8pmTUQMAl6Flt3NoawRjL9GZ12qqyUigv8T0ggseNTIWpBrAS6bk/U2ILadJHlvOWbtp
         HF/w==
X-Gm-Message-State: AOJu0Yz+CTTeEiD67BYnhGvit+kWzR2I4Rvg69kbpHDEJghTawIYkpBm
	kh5BcjxJlmga9UVj6z9g6MeCGzOQvd7myas7CPUsAdArXCpow/qyu5SBmLt7i+9U0sbdovYWkHU
	dMqo9pw2x6WNs9R4=
X-Received: by 2002:a05:6871:7a0:b0:1e9:8a7e:5893 with SMTP id o32-20020a05687107a000b001e98a7e5893mr7587431oap.5.1700757695793;
        Thu, 23 Nov 2023 08:41:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+04e1Vh52SolmH+Vji6UaC0k0qOLwcDodNnPANnkt/IexnCF9rxr6HrQ6ayqhb8e6Z3MdsQ==
X-Received: by 2002:a05:6871:7a0:b0:1e9:8a7e:5893 with SMTP id o32-20020a05687107a000b001e98a7e5893mr7587413oap.5.1700757695521;
        Thu, 23 Nov 2023 08:41:35 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-241-213.dyn.eolo.it. [146.241.241.213])
        by smtp.gmail.com with ESMTPSA id o3-20020ac86d03000000b0041abcc69050sm582431qtt.95.2023.11.23.08.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 08:41:35 -0800 (PST)
Message-ID: <c1f1f869346f4d6fc90eac6d131454b85fa676be.camel@redhat.com>
Subject: Re: [PATCH] mptcp: fix uninit-value in mptcp_incoming_options
From: Paolo Abeni <pabeni@redhat.com>
To: Edward Adam Davis <eadavis@qq.com>, 
	syzbot+b834a6b2decad004cfa1@syzkaller.appspotmail.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
 linux-kernel@vger.kernel.org, martineau@kernel.org,
 matthieu.baerts@tessares.net,  matttbe@kernel.org, mptcp@lists.linux.dev,
 netdev@vger.kernel.org,  syzkaller-bugs@googlegroups.com
Date: Thu, 23 Nov 2023 17:41:31 +0100
In-Reply-To: <tencent_B0E02F1D6C009450E8D6EC06CC6C7B5E6C0A@qq.com>
References: <000000000000545a26060abf943b@google.com>
	 <tencent_B0E02F1D6C009450E8D6EC06CC6C7B5E6C0A@qq.com>
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

On Thu, 2023-11-23 at 09:23 +0800, Edward Adam Davis wrote:
> Added initialization use_ack to mptcp_parse_option().
>=20
> Reported-by: syzbot+b834a6b2decad004cfa1@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  net/mptcp/options.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index cd15ec73073e..c53914012d01 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -108,6 +108,7 @@ static void mptcp_parse_option(const struct sk_buff *=
skb,
>  =09=09=09mp_opt->suboptions |=3D OPTION_MPTCP_DSS;
>  =09=09=09mp_opt->use_map =3D 1;
>  =09=09=09mp_opt->mpc_map =3D 1;
> +=09=09=09mp_opt->use_ack =3D 0;
>  =09=09=09mp_opt->data_len =3D get_unaligned_be16(ptr);
>  =09=09=09ptr +=3D 2;
>  =09=09}

LGTM, and syzbot tested it.

Acked-by: Paolo Abeni <pabeni@redhat.com>

@Edward: for future similar patches, please add also the=C2=A0tested tag
from syzbot, will make tracking easier.

Thanks!

Paolo


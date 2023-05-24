Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FA419534
	for <mptcp@lists.linux.dev>; Wed, 24 May 2023 14:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684939804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=URxzmFlzU0NFWsixQhWby/jafc4EqR7wGMoxXNdumKI=;
	b=Bz81MNxGLD7sNLjM69x3qBnPXn+x6e2bxSVdaHkXGHVdNGZ9beNZJV3VG4aoMB89YrOCTU
	YoyD9KT6JXh3jb588pCFag5N8z7bJpzOW1sfAdSYKRF6T3QgREqp6d+rN/iWD0ARTitzvy
	YsESfKQcwMGvGRKwcmG4cxwHUzNyBlc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-E97b7mNkMB6vPQUhG6uJNA-1; Wed, 24 May 2023 10:50:03 -0400
X-MC-Unique: E97b7mNkMB6vPQUhG6uJNA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f607da7cdbso1798855e9.0
        for <mptcp@lists.linux.dev>; Wed, 24 May 2023 07:50:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684939802; x=1687531802;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/pq6Ox6/T+o8797dorLINAeAPjgei3elCt/UkEcIjSM=;
        b=H2a70eLXfo1wbkDSM3ofsSDqr8HjH0gG+tX/gtSmBM+cMuU8I2lScMmAPVAg+7Jp2x
         oaYH/TGpzUOegLNu+oJggIsccJA6ruzyECCsEnC14X//o/kh/vCAOOKSYdhrYB+Re2s7
         JCfTjEC3z0Jk/MqQc5LcI/R5moKKAGl1OWL1XnpEN0sQ0G0NDVCRjUOl1JRPocoqBvQG
         2hzRaCErXkMBZFPRXrFgT4eOD4yTTivBl7Y/AAxEOYsvMoZnxKAWujUAqKEearwMxrm1
         APlDBbL0qtt/qOS12gKv1JllFtowbXLUX6i9hKOrpXuYnAoTRvlW93Yfux/WuQTzNzqz
         Sh/w==
X-Gm-Message-State: AC+VfDwGveencxV8uE1raCahgz9/3ORuKMqeKS1VdaZf+26LxkCa46I/
	TOKFsByI9EFa1QnEjrMIm44F1I+KGkDYEuCj/UFsvDp15SdI+Bc1QIV3/kvJC/0DFlqZOL3gAwH
	eQQxA9r8SHOqXHH0Khl53I7C4mlEHbxaJLpp2Sq+QeHZ+Ivs+OYFlShEHwOE5ZGWU8hClA/Rr
X-Received: by 2002:a05:600c:4189:b0:3f4:27ff:2ed7 with SMTP id p9-20020a05600c418900b003f427ff2ed7mr2310942wmh.4.1684939801920;
        Wed, 24 May 2023 07:50:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6PJruvupZrgZ+GajcPsxv0wc/QR/Wps5Czdw7/3t9V4kM9Vyq0FDthJsaKueDW2CHtzDFi5g==
X-Received: by 2002:a05:600c:4189:b0:3f4:27ff:2ed7 with SMTP id p9-20020a05600c418900b003f427ff2ed7mr2310932wmh.4.1684939801588;
        Wed, 24 May 2023 07:50:01 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-242-207.dyn.eolo.it. [146.241.242.207])
        by smtp.gmail.com with ESMTPSA id i1-20020a05600c354100b003f61177faffsm4601881wmq.0.2023.05.24.07.50.00
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 07:50:01 -0700 (PDT)
Message-ID: <597bc9dfa8e519d699d612160de7e2fe02c28ac7.camel@redhat.com>
Subject: Re: selftests: mptcp: add MPTCP_FULL_INFO testcase: Build Failure
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Date: Wed, 24 May 2023 16:50:00 +0200
In-Reply-To: <c37731c9-6c19-8ec3-69e0-db770312a397@gmail.com>
References: <930270fbc3358d0c423357f770b679745f8dc4a8.1684935727.git.pabeni@redhat.com>
	 <c37731c9-6c19-8ec3-69e0-db770312a397@gmail.com>
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

On Wed, 2023-05-24 at 14:17 +0000, MPTCP CI wrote:
> Hi Paolo,
>=20
> Thank you for your modifications, that's great!
>=20
> But sadly, our CI spotted some issues with it when trying to build it.
>=20
> You can find more details there:
>=20
>   https://patchwork.kernel.org/project/mptcp/patch/930270fbc3358d0c423357=
f770b679745f8dc4a8.1684935727.git.pabeni@redhat.com/
>   https://github.com/multipath-tcp/mptcp_net-next/actions/runs/5069697633

sigh, 32 bit issue with:

=09sfinfoptr =3D (void __force __user *)sffi.subflow_info_addr;

I need to use u64_to_user_ptr()

I'll repost in a little time (hopefully we don't have the 24h ban
period ;)

/P


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289056AB8
	for <mptcp@lists.linux.dev>; Tue,  4 Apr 2023 13:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680613939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EJJRq81vhsNE/gImmH2RxKELKk1yC6+HtkrDkDbI6Po=;
	b=R45BpqrDKYiBRrfNZTQ9suvSPF6VUxLhnZ7tySidqiDKT3ZAI29ijUb3q+K7Ma4iD7PI5N
	baVYmLQsHJTb2dxDnoAqMHmCsU6X6pIFx8A24MdIdl/9X+6nixNtJ3hqS3jqKrx/xxjolQ
	43SCMsNWCX0cAwDxw5b383RGGtL3Tfw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-ZNN0xWtfNm20gf3SJmHOYg-1; Tue, 04 Apr 2023 09:12:17 -0400
X-MC-Unique: ZNN0xWtfNm20gf3SJmHOYg-1
Received: by mail-qk1-f197.google.com with SMTP id x80-20020a376353000000b0074681bc7f42so14668549qkb.8
        for <mptcp@lists.linux.dev>; Tue, 04 Apr 2023 06:12:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680613937;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EJJRq81vhsNE/gImmH2RxKELKk1yC6+HtkrDkDbI6Po=;
        b=ovqP+8kGS2fPShxOV04wCwk1OpC3AX+ncqp7PEjLwXaGm5tM0SxpD18K0yl3Oc2/Um
         2MK65M6ENMcp870Jh1XPStddz55j+oFvb7LTR552ZGuDD76wrxFrDJyyYG1wuqb735Cy
         yT3Z/pRzyCijSj2Qay43/kWnEXdZhVguC0uSYiFJIhG16gH8sp0fl1+lVqo0eJxXQNpb
         xK+/Dq1TLe98VCOGlna9WRZxSNp22iXOQ3q/eIiuO6jHpnqr41PDyFIhGiRbReinHJVH
         wrUso4KylT+ikjsJihZwuH/wp6daMvIJl2cs4Y2fiDAGAR4Kc1dyE9Ad3oj0YDUKOczo
         YlKg==
X-Gm-Message-State: AAQBX9fEXEBjH19oZzThgjO3OW1gb+XLPa/DangVnFaIqqDx9+CtDnMD
	OZaofB7Ti3SgEZGyJIEjDPAp2ES6b0tIDnO+qjZjB1LUXamx6//xgYsUXWAY/6JxWlosT9s1rm4
	ka01xo19obUfHEf09h28tLM80q74SltKo3GrO0C8EvVBfCHmeBhk/oX06AkouomqYaT7W3swj
X-Received: by 2002:a05:622a:1826:b0:3bf:c458:5bac with SMTP id t38-20020a05622a182600b003bfc4585bacmr3647755qtc.0.1680613936814;
        Tue, 04 Apr 2023 06:12:16 -0700 (PDT)
X-Google-Smtp-Source: AKy350bKqyM9dtWwH0iAPtBDtMoFcT/Wt/H6Ar+vtniEPdXU3cMnjMzxd/Idf7/xAW3faLYnmt5cYw==
X-Received: by 2002:a05:622a:1826:b0:3bf:c458:5bac with SMTP id t38-20020a05622a182600b003bfc4585bacmr3647698qtc.0.1680613936357;
        Tue, 04 Apr 2023 06:12:16 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-227-151.dyn.eolo.it. [146.241.227.151])
        by smtp.gmail.com with ESMTPSA id i25-20020ac860d9000000b003bd0f0b26b0sm3225502qtm.77.2023.04.04.06.12.15
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 06:12:15 -0700 (PDT)
Message-ID: <495fc443773ca7618dbf0f5f2ea6e744dad2581f.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 0/3] mptcp: add more mibs
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Date: Tue, 04 Apr 2023 15:12:13 +0200
In-Reply-To: <cover.1680544063.git.pabeni@redhat.com>
References: <cover.1680544063.git.pabeni@redhat.com>
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

On Tue, 2023-04-04 at 13:41 +0200, Paolo Abeni wrote:
> dumb cover letter for CI's sake.
>=20
> Slould be applied only after the current tree has been crunched
> by syzkaller for a little bit, as this will likely change quite
> a bit the timings of some critical path, possibly hiding old races
> and make more easy to reach other ones
>=20
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/378
>=20
> Paolo Abeni (3):
>   mptcp: introduces more address related mibs
>   selftests: mptcp: add explicit check for new mibs
>   selftests: mptcp: centralize stats dumping
>=20
>  net/mptcp/mib.c                               |   6 +
>  net/mptcp/mib.h                               |  14 +++
>  net/mptcp/options.c                           |   5 +-
>  net/mptcp/pm.c                                |   6 +-
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 112 +++++++++---------
>  5 files changed, 87 insertions(+), 56 deletions(-)
>=20
oops, I sent out an old version. I'll send a v2 soon.

Paolo


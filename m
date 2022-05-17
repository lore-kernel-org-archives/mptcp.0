Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF96C1103
	for <mptcp@lists.linux.dev>; Tue, 17 May 2022 05:28:31 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id f10so4471923pjs.3
        for <mptcp@lists.linux.dev>; Mon, 16 May 2022 22:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vP2k6p1hXL/OnkjVPsFTw8t7G/cPhv7l7SOpeW4rWUU=;
        b=I2rvfgNTS1KaPUcJiLVL4cAa81QPYVNiowH0MijXKJ3X2yCxIHPMOjoHCTL5rtnoQb
         KzT1PKy1phYNYWW6m/n8ZEpQzXm664fMOjfgNhNOO2BDLCl6h/KewlRCq3ZyQTWLLX9f
         3lyPBt02YPYR0trEEUTYl+iozOIyFQrxkyuMfk0tLWDjVXmgCKB8faQyS3o2QTyCWASY
         /w9qrfu5njUTS9/n26l/BqElecspO6m8OLnu/Y5K3XTACsmkGNdoEwhoiTQaC4CsmRE7
         Ty3ovD3oQFOAu5f1c54K/js3xjlZXUvGOjKXfUJ7Smvo/3ZZgAcfISkDIB+F52GBRk85
         U+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vP2k6p1hXL/OnkjVPsFTw8t7G/cPhv7l7SOpeW4rWUU=;
        b=VrqY7NvA+meBCT1LHmr192LGR688yRiTWtBi8zdiiaMxu5GDkAQfdhDistliqdIDoA
         82NQl1McVZ7YCIG5Rx/8WH9zYCKyQ+FuTExgaRDh/SqZLO76Psh5+rYEg9O3XcY33Vn4
         qrRh9tQ458wdnCITNKkFAL09VO53HZ/Kf4B03CtZULduz6FprKvDiAtT7hYLOO2musKc
         Pm8IEHS2TK+JSE9ktJxOUGNvZIHFcbieP6x/6dJDa1lJfXUYDVnEvYdQpYl2qeeV0bvd
         2zWUi+iebPW4uaV2Epyj2xJUFX1jBPwQZG2PfGiYtxqHIRCgi8pAL2bmKWrXdaaanGZj
         LOFw==
X-Gm-Message-State: AOAM530862o1GqgQbzdGfVlWQ1X08HYjYpzxBOFRHMYKD2fdvySv9Yvu
	GNzTdWH6Z8mMGm3AN/0TLugnPNCXCyvL+7e+h+c=
X-Google-Smtp-Source: ABdhPJyTNzdqhLvBp4cczPPOplblciEaWtgUvU1QlaJW8AbyVmp7lQzCkJGJ+O+cbe9vDlmtBMHwieVsFtIDiW6vuzE=
X-Received: by 2002:a17:90b:384d:b0:1dc:a631:e356 with SMTP id
 nl13-20020a17090b384d00b001dca631e356mr34007202pjb.82.1652765311273; Mon, 16
 May 2022 22:28:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220513224827.662254-1-mathew.j.martineau@linux.intel.com>
 <20220513224827.662254-4-mathew.j.martineau@linux.intel.com> <20220517011827.6pk2ao23tb4xjuap@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220517011827.6pk2ao23tb4xjuap@kafai-mbp.dhcp.thefacebook.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Tue, 17 May 2022 13:28:33 +0800
Message-ID: <CA+WQbwtnvGO+NpVwHHPxp+wQW5vZYHPHydGZ6cjNnNGhFw1zmg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/7] selftests/bpf: add MPTCP test base
To: Martin KaFai Lau <kafai@fb.com>
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>, Networking <netdev@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Nicolas Rybowski <nicolas.rybowski@tessares.net>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, MPTCP Upstream <mptcp@lists.linux.dev>, 
	Matthieu Baerts <matthieu.baerts@tessares.net>, Geliang Tang <geliang.tang@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Martin KaFai Lau <kafai@fb.com> =E4=BA=8E2022=E5=B9=B45=E6=9C=8817=E6=97=A5=
=E5=91=A8=E4=BA=8C 09:18=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, May 13, 2022 at 03:48:23PM -0700, Mat Martineau wrote:
> [ ... ]
>
> > @@ -265,7 +282,7 @@ int connect_to_fd_opts(int server_fd, const struct =
network_helper_opts *opts)
> >       }
> >
> >       addr_in =3D (struct sockaddr_in *)&addr;
> > -     fd =3D socket(addr_in->sin_family, type, 0);
> > +     fd =3D socket(addr_in->sin_family, type, opts->protocol);
> ops->protocol is the same as the server_fd's protocol ?
>
> Can that be learned from getsockopt(server_fd, SOL_SOCKET, SO_PROTOCOL, .=
...) ?
> Then the ops->protocol additions and related changes are not needed.

Yes, I will update this in v5.

>
> connect_to_fd_opts() has already obtained the SO_TYPE in similar way.
>
> >       if (fd < 0) {
> >               log_err("Failed to create client socket");
> >               return -1;
> > @@ -298,6 +315,16 @@ int connect_to_fd(int server_fd, int timeout_ms)
> >       return connect_to_fd_opts(server_fd, &opts);
> >  }
> >
> > +int connect_to_mptcp_fd(int server_fd, int timeout_ms)
> > +{
> > +     struct network_helper_opts opts =3D {
> > +             .timeout_ms =3D timeout_ms,
> > +             .protocol =3D IPPROTO_MPTCP,
> > +     };
> > +
> > +     return connect_to_fd_opts(server_fd, &opts);
> > +}
> > +
> >  int connect_fd_to_fd(int client_fd, int server_fd, int timeout_ms)
> >  {
> >       struct sockaddr_storage addr;
> > diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/test=
ing/selftests/bpf/network_helpers.h
> > index a4b3b2f9877b..e0feb115b2ae 100644
> > --- a/tools/testing/selftests/bpf/network_helpers.h
> > +++ b/tools/testing/selftests/bpf/network_helpers.h
> > @@ -21,6 +21,7 @@ struct network_helper_opts {
> >       const char *cc;
> >       int timeout_ms;
> >       bool must_fail;
> > +     int protocol;
> >  };
> >
> >  /* ipv4 test vector */
> > @@ -42,11 +43,14 @@ extern struct ipv6_packet pkt_v6;
> >  int settimeo(int fd, int timeout_ms);
> >  int start_server(int family, int type, const char *addr, __u16 port,
> >                int timeout_ms);
> > +int start_mptcp_server(int family, const char *addr, __u16 port,
> > +                    int timeout_ms);
> >  int *start_reuseport_server(int family, int type, const char *addr_str=
,
> >                           __u16 port, int timeout_ms,
> >                           unsigned int nr_listens);
> >  void free_fds(int *fds, unsigned int nr_close_fds);
> >  int connect_to_fd(int server_fd, int timeout_ms);
> > +int connect_to_mptcp_fd(int server_fd, int timeout_ms);
> >  int connect_to_fd_opts(int server_fd, const struct network_helper_opts=
 *opts);
> >  int connect_fd_to_fd(int client_fd, int server_fd, int timeout_ms);
> >  int fastopen_connect(int server_fd, const char *data, unsigned int dat=
a_len,
>

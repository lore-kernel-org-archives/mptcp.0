Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0AB1103
	for <mptcp@lists.linux.dev>; Tue, 17 May 2022 05:30:35 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id 202so16004014pgc.9
        for <mptcp@lists.linux.dev>; Mon, 16 May 2022 22:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=obywfqk9oJja4pcyG2JCoT8f80P7RWNK9ejKqX7Reh4=;
        b=n6QQQ+olQLaA+fOpu8+My/p5+D9AwV9UsZd3J3nrPT+eKzxycWcS7yMUb/I8KmTfPz
         49qdTres2/LX5D8uPcVh53fl+Noa3lq8x/6mA4FNdpd2lvya4xpuoOEiJAw9fUHKYTt+
         M1H9MUeJyRNUoJF60EecbiOHLTdetJDInwzxaRln+jNHO3CjKw64IOtRm9Bmn0Y/l/8N
         HVt9QIvl00qBmGs8QJN7wAOAcFxqubMNQkorgvOimwjSqVWwHZyTWRgxAbBEwlOe8F+I
         pAyc3TVg0ZdwIH7emSSiSNKqNpBESMn5991cwX5Fl4T2jjhPaI1B+nmZKziibu4868Tf
         MTTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=obywfqk9oJja4pcyG2JCoT8f80P7RWNK9ejKqX7Reh4=;
        b=iGVBZnrdill94qgWh2NaeboJnZOVC55QUWupvgZvC8mTwUMd5h1loDZepMMmD9/2vR
         ctsoJny2FNNWAHdYZxRxvo0wtvom6zIlZxZY73HoOXPWGTiy0Xhvo4aZzK65f5sydUho
         UmQzYvTDKYpqdFh0iiR/vPNbSIgG+Pw+y9FqbxTpABRcYqut1CdbVFtI34TxWrldqK+l
         b0hplG35i/JqiWvM1SG7mOW7p/g0IMheZDP0UutmRFawTnaLEuH5WVxW9c+bmhJWT6N+
         5hU0VIwIYtMlHtGiFwjvB3EjVqWM7YB3hMgG9z6dF+Rd52jRljfOlH9aZNGILYICsYXK
         PgaQ==
X-Gm-Message-State: AOAM530nC2auKStlhYHCJh2h0yKmrol9ZPeRaoW43Usu+G9P7m9JOzWX
	cvAGeXF/j54p22CUn8DCnS+mMOr4G0HvXYkXV28=
X-Google-Smtp-Source: ABdhPJwma/IiU4cj7MYZyl6cozA+54IXwpn0lzxVulzpwWintiZd/xZ+IMG5BPOm/9aktHuVuw2NYV0IpQ0HzVBpy6Q=
X-Received: by 2002:a05:6a00:1946:b0:4fe:309f:d612 with SMTP id
 s6-20020a056a00194600b004fe309fd612mr20859751pfk.10.1652765435372; Mon, 16
 May 2022 22:30:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220513224827.662254-1-mathew.j.martineau@linux.intel.com>
 <20220513224827.662254-4-mathew.j.martineau@linux.intel.com> <CAEf4Bzbn8DSwxt7WdWhNmfAP_NU8gmnJmFzSzO2kt=ZNSt1gUQ@mail.gmail.com>
In-Reply-To: <CAEf4Bzbn8DSwxt7WdWhNmfAP_NU8gmnJmFzSzO2kt=ZNSt1gUQ@mail.gmail.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Tue, 17 May 2022 13:30:37 +0800
Message-ID: <CA+WQbwvUcPVWxd8YB_NgEHjfBYr92fD_AkOPGwiG+_uL9cAjCQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/7] selftests/bpf: add MPTCP test base
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>, Networking <netdev@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Nicolas Rybowski <nicolas.rybowski@tessares.net>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, MPTCP Upstream <mptcp@lists.linux.dev>, 
	Matthieu Baerts <matthieu.baerts@tessares.net>, Geliang Tang <geliang.tang@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Andrii Nakryiko <andrii.nakryiko@gmail.com> =E4=BA=8E2022=E5=B9=B45=E6=9C=
=8817=E6=97=A5=E5=91=A8=E4=BA=8C 06:43=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, May 13, 2022 at 3:48 PM Mat Martineau
> <mathew.j.martineau@linux.intel.com> wrote:
> >
> > From: Nicolas Rybowski <nicolas.rybowski@tessares.net>
> >
> > This patch adds a base for MPTCP specific tests.
> >
> > It is currently limited to the is_mptcp field in case of plain TCP
> > connection because there is no easy way to get the subflow sk from a ms=
k
> > in userspace. This implies that we cannot lookup the sk_storage attache=
d
> > to the subflow sk in the sockops program.
> >
> > v4:
> >  - add copyright 2022 (Andrii)
> >  - use ASSERT_* instead of CHECK_FAIL (Andrii)
> >  - drop SEC("version") (Andrii)
> >  - use is_mptcp in tcp_sock, instead of bpf_tcp_sock (Martin & Andrii)
> >
> > Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> > Co-developed-by: Geliang Tang <geliang.tang@suse.com>
> > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > Signed-off-by: Nicolas Rybowski <nicolas.rybowski@tessares.net>
> > Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> > ---
> >  MAINTAINERS                                   |   1 +
> >  tools/testing/selftests/bpf/bpf_tcp_helpers.h |   1 +
> >  tools/testing/selftests/bpf/config            |   1 +
> >  tools/testing/selftests/bpf/network_helpers.c |  43 ++++--
> >  tools/testing/selftests/bpf/network_helpers.h |   4 +
> >  .../testing/selftests/bpf/prog_tests/mptcp.c  | 136 ++++++++++++++++++
> >  .../testing/selftests/bpf/progs/mptcp_sock.c  |  53 +++++++
> >  7 files changed, 231 insertions(+), 8 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/mptcp.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/mptcp_sock.c
> >
>
> Seems like bpf_core_field_exists() works fine for your use case and CI
> is green. See some selftest-specific issues below, though.
>
> [...]
>
> > +static int run_test(int cgroup_fd, int server_fd, bool is_mptcp)
> > +{
> > +       int client_fd, prog_fd, map_fd, err;
> > +       struct bpf_program *prog;
> > +       struct bpf_object *obj;
> > +       struct bpf_map *map;
> > +
> > +       obj =3D bpf_object__open("./mptcp_sock.o");
> > +       if (libbpf_get_error(obj))
> > +               return -EIO;
> > +
> > +       err =3D bpf_object__load(obj);
> > +       if (!ASSERT_OK(err, "bpf_object__load"))
> > +               goto out;
> > +
> > +       prog =3D bpf_object__find_program_by_name(obj, "_sockops");
>
> can you please use BPF skeleton instead of doing these lookups by
> name? See other tests that are including .skel.h headers for example

Sure, I will update this in v5.

>
> > +       if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name")) {
> > +               err =3D -EIO;
> > +               goto out;
> > +       }
> > +
>
> [...]
>
> > +void test_base(void)
> > +{
> > +       int server_fd, cgroup_fd;
> > +
> > +       cgroup_fd =3D test__join_cgroup("/mptcp");
> > +       if (CHECK_FAIL(cgroup_fd < 0))
> > +               return;
> > +
> > +       /* without MPTCP */
> > +       server_fd =3D start_server(AF_INET, SOCK_STREAM, NULL, 0, 0);
> > +       if (CHECK_FAIL(server_fd < 0))
> > +               goto with_mptcp;
> > +
> > +       CHECK_FAIL(run_test(cgroup_fd, server_fd, false));
>
> please don't add new uses of CHECK_FAIL()
>
> > +
> > +       close(server_fd);
> > +
>
> [...]
>

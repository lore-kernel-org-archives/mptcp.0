Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D61282F3B
	for <mptcp@lists.linux.dev>; Mon, 29 Jun 2026 18:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782756790; cv=pass; b=bkja9dBiK0XH/3y24KWmDaHBdQz1BSID2eChTMJOAjdK66wNwUSUiMAM08zoy8EVLsZ2PWWbYPkzz/mQ07V2Rqh6FSUyUemX/I3pKbgfhM3UFQmwlwn6LYVg+3aZpeX8lZZ0iDalzObAWo+jxSDCKxSN0fwB5h/2qiyoeFvHynM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782756790; c=relaxed/simple;
	bh=YsBJ5rLzCHNROrpoUXAG2+olo/jg6vCTJlr1rdi8LKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z6lo3bylONKltWwIu0LW4frEfuP2JN3KgGATSedViIdLMMcQhNHNzXdWsw5XW3SJWEQM8VWN1xfGCb2pXwobXFKCBpFr/V4BMdJBdHBm5eOHYn2Omjo36SamL3NKrYik3p0HFmDButqM+xjVWoQ144j+7glGkwc/ubdSvOUXx0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pe7fQLzb; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pe7fQLzb"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-80a123ef90aso41010127b3.0
        for <mptcp@lists.linux.dev>; Mon, 29 Jun 2026 11:13:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782756787; cv=none;
        d=google.com; s=arc-20260327;
        b=gBZIEc7ZIDDTbYghgJRE+3kFqJvdIiIzfwXuB2IznTkJlGrLQTng0zaYbv8AEjUNWx
         UDTkWb/yRY/SeZz9maf5J6VWJLgxbZvPJyglIrzULdEQu5FToRxCDJWI2MZ1hatMy7Eb
         sF1ntVqK1BhzYBzinvo0KEgsOyQPZ0lPMo/U1dJNWSNfW8e/9MCZEo4tvQFGA/nMADyw
         Wy0OCD1rbSRT81mVXvLJyyXQi9Chs0BYYgMoDPpy/LdisrvIdIzYOeInfjiyyfpCd6vD
         LmADz6xqAP9Tg1KpvegOpU8412LO/8wW2hhebUld5OciSx6KBJ8W7T86CUlIj0zKu08Z
         +6bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SmmYAil1f9hLMNCPLSvS+Czx4YqCWUlhWfkBPgyh9NY=;
        fh=uB4w/lmF72lp/pkFPtA2ZBHMc4WjRsLm1w8jrEk0+94=;
        b=lHgORjISJZUwRSNzdWBu0LQKRJLa3Qdr+BzmWk4h5fOHb+QFzCnyjAOoGgZgRCBPWQ
         GxDJnhpLiEZwzGfx3kNgg52GeLf0+xQWVC4zU4xv209dOCNcUAIHjFKa0H7erCMWxsKR
         pP4YHgzM45fHQDstx1y0ocG8ueQjmKYyZk3dQ/7r7v3ogRe+C2rjRp+NzaTJv8V2mX+N
         KnH0Nv8VzcQWbmOs5uaPPt8XZdSMI+KdVRuktnvzCCg/ukPB7wPlovXAx/xW1szUxAdC
         XGAYBUjbFL3e2sZ82Pj7Tc4dWBkPJ2hUwZxAecYU8xIxFPIywIo33iiXbmVGUt2mbHf2
         WBAA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782756787; x=1783361587; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmmYAil1f9hLMNCPLSvS+Czx4YqCWUlhWfkBPgyh9NY=;
        b=Pe7fQLzbtJvb9qHNwpr5UqbPPfm1BVE1rzb0to8TaMo3ANBt8flpUYNWxicE3cD8zu
         6wfS3or9Y7btgcCA+teEjGv39v5rqBlkp5jw8Q1wNDY0xn2sTRoe3L+CqwrC+GqnOW6x
         4NHzf3Wd4ITJ7vZZ3ZYZYRH++G1xjbvZcNjxL8p0zCQnS8U0NBnyGqpSTf7FQ97P6/O2
         pBBGMm+MfgsQLqtAbT9uasxm9hLixBcuQu5i/V4SE2gF9+LP28aP7UOVoTJXpv7HNkU0
         g+XHThU4vbHrbdbaIrLyjJa6FmDmogbtbM6WMWJeEHCqybCcY9Pb6wyhjs1o7RZCuA6c
         DWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782756787; x=1783361587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SmmYAil1f9hLMNCPLSvS+Czx4YqCWUlhWfkBPgyh9NY=;
        b=pWeN2PoNvD4dbGVhpT2rkykJizQ0dwFiI/MxZLISeBCg1wAVcY+/atnOOmNV4yVkDG
         eozVP2WgKIUNv3pU4rPAunJtH0F7FjZ8NStfpQpxic3tDqpbA8mYAnKrYHSrYpRW5iLX
         K58xXTngZHpnXJsG0l6vM4npJD0N5Muo4fUiiKhrOrHQRuXMyZ/TZkmRLajcv8UceqJt
         JHGC15ANNi5HflmT/U8D+S0JI49sB0fDWUX4sHilERfKPZ2ICqvAxPZtriXHokUE1W0W
         SKjVq4I2lgsaF1QjQ5FrHDI7uEqUIsjR3zIwgv872FQA8vJBHmb88JpUOz4vvYQNmgWn
         kbGA==
X-Forwarded-Encrypted: i=1; AHgh+RqVXk0eVclFUo52QnamyKI8wkaqkyt1iVdT5xnzeZ2cyXPo40GpOy2pzDPgjSiXDpwiwFT9aA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwX5Vy71RXU25l/4syboLQQzEHSFvbVqasMRqZhNosMqEZN4lLt
	a+mJN1wF+pqyndQtCg7DiKVlBgVzygn6q0uAYbbEzv05BLXpwkuFzof+iurGMsDntZE8OyFT3bK
	1a4f8BN4gypGzL2VHXCj9hqHjBdZiXls=
X-Gm-Gg: AfdE7clY9I4bwdo0iT4cmvdjrZhsXyxuCBmostWej3QXZqqC/At7OhnEd/33quWpfHy
	11ikznHsF27fDr7NFcpE+PRqS9XlP+KgrhR0H5VsxR9Lcyo78KTdOc9bHlwY1Hac7ZsMibFBSzI
	2aptDSw4dI98bEqo/97WyJwy0dytH2fXaUOmbFG4NFiJKkKINnRH1iWBIMKvueqq9IDLE32tWhh
	Nf0M3DpCZBTeK1EjIwpGXDc1DyRDcUNuzO/zlbErNCvm0rZzA2fRj/LNSu0bA+wwDVxToA8q9j/
	wpdNO/203lSf
X-Received: by 2002:a05:690c:dcd:b0:80b:1616:5c0e with SMTP id
 00721157ae682-810e984a566mr3240827b3.20.1782756787534; Mon, 29 Jun 2026
 11:13:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260629125637.384923-1-layus.on@gmail.com>
In-Reply-To: <20260629125637.384923-1-layus.on@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 29 Jun 2026 11:12:54 -0700
X-Gm-Features: AVVi8CdW3Ek5fAOq0hw_26M9hi49cDbrZRotwx5VJpI7hZNDTSnWdF5fckFOukc
Message-ID: <CAMB2axM=utfi11L1e2-yMgCiSEZ=QrZAPrcFLwk44hNqyT1qJQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: Mask socket type flags in mptcpify prog
To: "Guillaume @layus Maudoux" <layus.on@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 6:19=E2=80=AFAM Guillaume @layus Maudoux
<layus.on@gmail.com> wrote:
>
> The mptcpify BPF prog hooks update_socket_protocol() to rewrite
> eligible TCP socket() calls to IPPROTO_MPTCP. It only does so when the
> socket type is exactly SOCK_STREAM:
>
>         type =3D=3D SOCK_STREAM
>
> The problem is that update_socket_protocol() in __sys_socket() is
> called on the raw type argument as passed from userspace, before
> __sys_socket_create() strips the flag bits with
> "type &=3D SOCK_TYPE_MASK". The type argument may therefore carry
> SOCK_CLOEXEC and/or SOCK_NONBLOCK in its upper bits, and the equality
> check above then fails.
>
> As a result, any socket created with e.g.
> socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, 0) -- which is what common
> libraries do by default -- is silently left as plain TCP instead of
> being upgraded to MPTCP. This was observed in practice with curl,
> whose connections were not upgraded to MPTCP despite the prog being
> attached.
>
> The impact reaches beyond the test, because mptcpify.c is referenced
> as example code for users who want to transparently enable MPTCP. The
> same mistake is therefore likely to be copied into real deployments,
> where it fails the same way and is hard to diagnose.
>
> The fix is to mask off the flag bits before comparing, mirroring what
> the socket core does:
>
>         (type & SOCK_TYPE_MASK) =3D=3D SOCK_STREAM
>
> Since SOCK_TYPE_MASK is not exposed through vmlinux.h, define it in
> bpf_tracing_net.h.
>
> To exercise the regression directly, extend the mptcpify test to also
> create the server socket with SOCK_CLOEXEC and SOCK_NONBLOCK set.
> Routing a flagged type through start_server() then revealed a second
> instance of the same pattern: start_server_addr() compared the type
> against SOCK_STREAM for equality to decide whether to set SO_REUSEADDR
> and call listen(), and so would skip listening for a flagged type.
> Mask the type there as well. As SOCK_TYPE_MASK is not exposed by
> glibc's <sys/socket.h> either, define it in network_helpers.h,
> mirroring prog_tests/socket_helpers.h.
>
> Fixes: ddba122428a7 ("selftests/bpf: Add mptcpify test")
> Signed-off-by: Guillaume @layus Maudoux <layus.on@gmail.com>

Hello,

You will need to use your real name in the SOB. At least "@" caused
some problems when I downloaded the patch.

Please also include "bpf-next" in your subject prefix so that the CI
can properly test it.

> ---
>  tools/testing/selftests/bpf/network_helpers.c |  4 ++--
>  tools/testing/selftests/bpf/network_helpers.h |  5 +++++
>  .../testing/selftests/bpf/prog_tests/mptcp.c  | 20 +++++++++++++++----
>  .../selftests/bpf/progs/bpf_tracing_net.h     |  3 +++
>  tools/testing/selftests/bpf/progs/mptcpify.c  |  2 +-
>  5 files changed, 27 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testin=
g/selftests/bpf/network_helpers.c
> index b82f572641b7..db935a9d9fc1 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c
> @@ -111,7 +111,7 @@ int start_server_addr(int type, const struct sockaddr=
_storage *addr, socklen_t a
>         if (settimeo(fd, opts->timeout_ms))
>                 goto error_close;
>
> -       if (type =3D=3D SOCK_STREAM &&
> +       if ((type & SOCK_TYPE_MASK) =3D=3D SOCK_STREAM &&
>             setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &on, sizeof(on))) {
>                 log_err("Failed to enable SO_REUSEADDR");
>                 goto error_close;
> @@ -128,7 +128,7 @@ int start_server_addr(int type, const struct sockaddr=
_storage *addr, socklen_t a
>                 goto error_close;
>         }
>
> -       if (type =3D=3D SOCK_STREAM) {
> +       if ((type & SOCK_TYPE_MASK) =3D=3D SOCK_STREAM) {
>                 if (listen(fd, opts->backlog ? MAX(opts->backlog, 0) : 1)=
 < 0) {
>                         log_err("Failed to listed on socket");
>                         goto error_close;
> diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testin=
g/selftests/bpf/network_helpers.h
> index 79a010c88e11..75133119c04a 100644
> --- a/tools/testing/selftests/bpf/network_helpers.h
> +++ b/tools/testing/selftests/bpf/network_helpers.h
> @@ -25,6 +25,11 @@ typedef __u16 __sum16;
>  #define VIP_NUM 5
>  #define MAGIC_BYTES 123
>
> +/* include/linux/net.h */
> +#ifndef SOCK_TYPE_MASK
> +#define SOCK_TYPE_MASK 0xf
> +#endif
> +
>  struct network_helper_opts {
>         int timeout_ms;
>         int proto;
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testi=
ng/selftests/bpf/prog_tests/mptcp.c
> index 8fade8bdc451..faa001ea84ab 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -264,7 +264,7 @@ static int verify_mptcpify(int server_fd, int client_=
fd)
>         return err;
>  }
>
> -static int run_mptcpify(int cgroup_fd)
> +static int run_mptcpify(int cgroup_fd, int type)
>  {
>         int server_fd, client_fd, err =3D 0;
>         struct mptcpify *mptcpify_skel;
> @@ -280,7 +280,7 @@ static int run_mptcpify(int cgroup_fd)
>                 goto out;
>
>         /* without MPTCP */
> -       server_fd =3D start_server(AF_INET, SOCK_STREAM, NULL, 0, 0);
> +       server_fd =3D start_server(AF_INET, type, NULL, 0, 0);
>         if (!ASSERT_GE(server_fd, 0, "start_server")) {
>                 err =3D -EIO;
>                 goto out;
> @@ -307,7 +307,18 @@ static int run_mptcpify(int cgroup_fd)
>  static void test_mptcpify(void)
>  {
>         struct netns_obj *netns =3D NULL;
> -       int cgroup_fd;
> +       int cgroup_fd, i;
> +       int types[] =3D {
> +               SOCK_STREAM,
> +               /* userspace sets these flags together with the type, and=
 the
> +                * BPF prog must still upgrade the socket to MPTCP. See
> +                * update_socket_protocol() in net/socket.c, which runs b=
efore
> +                * the type is masked with SOCK_TYPE_MASK.
> +                */
> +               SOCK_STREAM | SOCK_CLOEXEC,
> +               SOCK_STREAM | SOCK_NONBLOCK,
> +               SOCK_STREAM | SOCK_CLOEXEC | SOCK_NONBLOCK,
> +       };
>
>         cgroup_fd =3D test__join_cgroup("/mptcpify");
>         if (!ASSERT_GE(cgroup_fd, 0, "test__join_cgroup"))
> @@ -317,7 +328,8 @@ static void test_mptcpify(void)
>         if (!ASSERT_OK_PTR(netns, "netns_new"))
>                 goto fail;
>
> -       ASSERT_OK(run_mptcpify(cgroup_fd), "run_mptcpify");
> +       for (i =3D 0; i < ARRAY_SIZE(types); i++)
> +               ASSERT_OK(run_mptcpify(cgroup_fd, types[i]), "run_mptcpif=
y");

nit: testing all four type combinations adds little value here. I'd
drop array+loop and keep two. For example:

  ASSERT_OK(run_mptcpify(cgroup_fd, SOCK_STREAM), "run_mptcpify");
  ASSERT_OK(run_mptcpify(cgroup_fd, SOCK_STREAM | SOCK_CLOEXEC),
"run_mptcpify_cloexec");

>
>  fail:
>         netns_free(netns);
> diff --git a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h b/tools/=
testing/selftests/bpf/progs/bpf_tracing_net.h
> index d8dacef37c16..c4b438854565 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
> @@ -8,6 +8,9 @@
>  #define AF_INET                        2
>  #define AF_INET6               10
>
> +/* include/linux/net.h */
> +#define SOCK_TYPE_MASK         0xf
> +
>  #define SOL_SOCKET             1
>  #define SO_REUSEADDR           2
>  #define SO_SNDBUF              7
> diff --git a/tools/testing/selftests/bpf/progs/mptcpify.c b/tools/testing=
/selftests/bpf/progs/mptcpify.c
> index cbdc730c3a47..e3f8cb54dbe9 100644
> --- a/tools/testing/selftests/bpf/progs/mptcpify.c
> +++ b/tools/testing/selftests/bpf/progs/mptcpify.c
> @@ -15,7 +15,7 @@ int BPF_PROG(mptcpify, int family, int type, int protoc=
ol)
>                 return protocol;
>
>         if ((family =3D=3D AF_INET || family =3D=3D AF_INET6) &&
> -           type =3D=3D SOCK_STREAM &&
> +           (type & SOCK_TYPE_MASK) =3D=3D SOCK_STREAM &&
>             (!protocol || protocol =3D=3D IPPROTO_TCP)) {
>                 return IPPROTO_MPTCP;
>         }
> --
> 2.54.0
>
>

Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDDE33F6
	for <mptcp@lists.linux.dev>; Wed, 17 May 2023 08:48:17 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-3f41dceb9d1so4832225e9.1
        for <mptcp@lists.linux.dev>; Wed, 17 May 2023 01:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684313296; x=1686905296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ytoBHADfA+Ijt+15woYCdCOcVO1wHv/9fVT5N8L6m8=;
        b=QtVEAjGnhNhR4wvDrVS9gOESfZAdbxHSTwW4TnKjWEm+6dF07to4e/GNW5z50G8aA2
         xnne+JhEB0jZ3MNbY16tmnhlEZ1LsfQQ9TMUp4+XVD20eIZFPzQN505pa8/LmazcchzC
         y1hbfqSznLGo3cdbhk0dnrLVU1DHiOhZIh6D8E2Hr/JeECA+ahKQJtykjCqPYinXOJwb
         hOFKQoX/HDGbhz+GYkz7wuPTCGhmNlI5q+6NI/L/SoFojYIQQzsg5AwSB2jMKf/8Ec8H
         KeVWFo4l+/rnKIKR29j2Y3wQ8chk/KRzOCUVEVrll4AuGAR5pg1vDxVGOcpvINuKJT/H
         0juQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684313296; x=1686905296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ytoBHADfA+Ijt+15woYCdCOcVO1wHv/9fVT5N8L6m8=;
        b=Y3xEB59ySx8HEtvyLkzriXMCgC3kIw/BIMKkZ1Iin9hOQJKRz7Kn/ChX5EBi3RvwKP
         Pc6f2eCFUQn9cexlASqRBj1S75WXChJoiONxv2qDWuDA9Hqq6OT3s3Z/yuXTPEsfqVl3
         bo6vDlVn1buWqRNhka7rtbkCjs9+RNRCtkKjbQQ8b/eCrtGJzoLHpe7kf9y23d8KbsPT
         eqEXtMIULPRCO8JIBlA6MB5gVQDE9y+t2eZtVRI2CUZbU8jA93R6gXwljtExoMzDWVjj
         GAJgwuePFjKDHsi1D93OWi0Jb4hf/Yqtl1kQDUeElnT04eTRMkBYIkniWwmMxscnHYJv
         Pdbg==
X-Gm-Message-State: AC+VfDzq8UrBUQTXudhvwx+g8M55IgTe+68Sk66yWYTxiL8kbgP96vjd
	RIvH5Ii8FoKHOyqUs2T+enrMhbOMJVUsrsco43Q=
X-Google-Smtp-Source: ACHHUZ5JTXcXzETy13QnyXyOBkDbHbAyQgGkCAllDJVOt1Gv9vcPEt2WckERL+iOa+5r6WhH4bADTVi8XGgDfuiFwfA=
X-Received: by 2002:a1c:f703:0:b0:3f1:979f:a733 with SMTP id
 v3-20020a1cf703000000b003f1979fa733mr29629505wmh.31.1684313295843; Wed, 17
 May 2023 01:48:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <a7aff063bf87d2d86207cb8fe7394251aaffd93c.1684312574.git.geliang.tang@suse.com>
 <29ad15cb28f6a38244d401ed80bb17e289aaf5fc.1684312673.git.geliang.tang@suse.com>
In-Reply-To: <29ad15cb28f6a38244d401ed80bb17e289aaf5fc.1684312673.git.geliang.tang@suse.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Wed, 17 May 2023 16:48:08 +0800
Message-ID: <CA+WQbwu_ckQkS3jMAu3okvq+_JL_zrT6SqRt1WNJ_A-x3FLrww@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v2] Squash to "selftests/bpf: Add bpf_red test"
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev, Matthieu Baerts <matthieu.baerts@tessares.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Geliang Tang <geliang.tang@suse.com> =E4=BA=8E2023=E5=B9=B45=E6=9C=8817=E6=
=97=A5=E5=91=A8=E4=B8=89 16:41=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Matthieu Baerts <matthieu.baerts@tessares.net>

Sorry, my bad. This line shouldn't be here:)

>
> Run mptcp sched test in a dedicated netns.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/mptcp.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testi=
ng/selftests/bpf/prog_tests/mptcp.c
> index f0f9aa517ec1..83af690facef 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -376,7 +376,7 @@ static void test_rr(char *ns)
>         mptcp_bpf_rr__destroy(rr_skel);
>  }
>
> -static void test_red(void)
> +static void test_red(char *ns)
>  {
>         struct mptcp_bpf_red *red_skel;
>         int server_fd, client_fd;
> @@ -392,17 +392,17 @@ static void test_red(void)
>                 return;
>         }
>
> -       sched_init("subflow", "bpf_red");
> +       sched_init(ns, "subflow", "bpf_red");
>         server_fd =3D start_mptcp_server(AF_INET, ADDR_1, 0, 0);
>         client_fd =3D connect_to_fd(server_fd, 0);
>
>         send_data(server_fd, client_fd);
> -       ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr 1");
> -       ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr 2");
> +       ASSERT_OK(has_bytes_sent(ns, ADDR_1), "has_bytes_sent addr 1");
> +       ASSERT_OK(has_bytes_sent(ns, ADDR_2), "has_bytes_sent addr 2");
>
>         close(client_fd);
>         close(server_fd);
> -       sched_cleanup();
> +       sched_cleanup(ns);
>         bpf_link__destroy(link);
>         mptcp_bpf_red__destroy(red_skel);
>  }
> @@ -430,7 +430,7 @@ void test_mptcp(void)
>         if (test__start_subtest("rr"))
>                 test_rr(NS_TEST);
>         if (test__start_subtest("red"))
> -               test_red();
> +               test_red(NS_TEST);
>
>         if (nstoken)
>                 close_netns(nstoken);
> --
> 2.35.3
>
>

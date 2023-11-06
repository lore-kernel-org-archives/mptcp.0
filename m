Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05FB9471
	for <mptcp@lists.linux.dev>; Mon,  6 Nov 2023 08:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5af5b532d8fso47753797b3.2
        for <mptcp@lists.linux.dev>; Mon, 06 Nov 2023 00:06:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699257988; x=1699862788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GEegE8ckZG10k1Ra1Y/drVVKgI3ZUf2FMeALzLcJgsk=;
        b=d6QDOw3qc5Iiw3hxRU5IhOszskpEUuQKr++erYtNwNAoeiiZ2xvAkANYefCWONtPNq
         wW+6n166qzujnwTFVmLYfrGmV6zE6MI1FdEtVraO8AluEg2SmQEhtGRoKM5qoEWkwWNn
         +PGaWDm8zkmFxfjrD1tDuf0vWZvN8HbhgGkzaWcmuYlBbygQ5VZC3tzE3NM3iIjRk+O7
         KDA5WsMcVlcNfF9eT8tvtKBIIv4HjXP3f524OP+5FQ60plyQ4APHFcZ8k+GmwEIs4iH6
         qOtCKI1sRlH7dSGhV5ktEGnBDBcEg9ULtr5b9M/vhBf5stdcIgH2gH9ZHAiddLiSl0py
         y0dA==
X-Gm-Message-State: AOJu0YxZcay5G41oPdzvnTU64xV5V3q+7fI4cNpDOToXk/sHkHjum6Zy
	8k9ESygRbt9oexkfgP4ECDJ0gV224/M94w==
X-Google-Smtp-Source: AGHT+IGkztefUv8tnwmmyV+tTtPJaj7aJhExzoHwqT/ecIVBOOw37Nna3ASX/U6o/mf5sR2z/GN5NA==
X-Received: by 2002:a81:5c02:0:b0:595:be7:a38 with SMTP id q2-20020a815c02000000b005950be70a38mr10112921ywb.49.1699257988341;
        Mon, 06 Nov 2023 00:06:28 -0800 (PST)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id d15-20020a0ddb0f000000b0059bd8447721sm3967796ywe.21.2023.11.06.00.06.27
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 00:06:27 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-d852b28ec3bso4458135276.2
        for <mptcp@lists.linux.dev>; Mon, 06 Nov 2023 00:06:27 -0800 (PST)
X-Received: by 2002:a5b:748:0:b0:d9a:4bc3:226d with SMTP id
 s8-20020a5b0748000000b00d9a4bc3226dmr29092496ybq.34.1699257987652; Mon, 06
 Nov 2023 00:06:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231101181601.1493271-1-jolsa@kernel.org>
In-Reply-To: <20231101181601.1493271-1-jolsa@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 6 Nov 2023 09:06:15 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUK4iRF7rTrSypEcbGTO0SnBUFDqT_HA9B7Pj62wTbYAw@mail.gmail.com>
Message-ID: <CAMuHMdUK4iRF7rTrSypEcbGTO0SnBUFDqT_HA9B7Pj62wTbYAw@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next] bpf: fix compilation error without CGROUPS
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, kernel test robot <lkp@intel.com>, bpf@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Yafang Shao <laoar.shao@gmail.com>, 
	Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	MPTCP Upstream <mptcp@lists.linux.dev>, Matthieu Baerts <matttbe@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 1, 2023 at 7:16=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
> From: Matthieu Baerts <matttbe@kernel.org>
> Our MPTCP CI complained [1] -- and KBuild too -- that it was no longer
> possible to build the kernel without CONFIG_CGROUPS:
>
>   kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_new':
>   kernel/bpf/task_iter.c:919:14: error: 'CSS_TASK_ITER_PROCS' undeclared =
(first use in this function)
>     919 |         case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
>         |              ^~~~~~~~~~~~~~~~~~~
>   kernel/bpf/task_iter.c:919:14: note: each undeclared identifier is repo=
rted only once for each function it appears in
>   kernel/bpf/task_iter.c:919:36: error: 'CSS_TASK_ITER_THREADED' undeclar=
ed (first use in this function)
>     919 |         case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
>         |                                    ^~~~~~~~~~~~~~~~~~~~~~
>   kernel/bpf/task_iter.c:927:60: error: invalid application of 'sizeof' t=
o incomplete type 'struct css_task_iter'
>     927 |         kit->css_it =3D bpf_mem_alloc(&bpf_global_ma, sizeof(st=
ruct css_task_iter));
>         |                                                            ^~~~=
~~
>   kernel/bpf/task_iter.c:930:9: error: implicit declaration of function '=
css_task_iter_start'; did you mean 'task_seq_start'? [-Werror=3Dimplicit-fu=
nction-declaration]
>     930 |         css_task_iter_start(css, flags, kit->css_it);
>         |         ^~~~~~~~~~~~~~~~~~~
>         |         task_seq_start
>   kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_next':
>   kernel/bpf/task_iter.c:940:16: error: implicit declaration of function =
'css_task_iter_next'; did you mean 'class_dev_iter_next'? [-Werror=3Dimplic=
it-function-declaration]
>     940 |         return css_task_iter_next(kit->css_it);
>         |                ^~~~~~~~~~~~~~~~~~
>         |                class_dev_iter_next
>   kernel/bpf/task_iter.c:940:16: error: returning 'int' from a function w=
ith return type 'struct task_struct *' makes pointer from integer without a=
 cast [-Werror=3Dint-conversion]
>     940 |         return css_task_iter_next(kit->css_it);
>         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_destroy':
>   kernel/bpf/task_iter.c:949:9: error: implicit declaration of function '=
css_task_iter_end' [-Werror=3Dimplicit-function-declaration]
>     949 |         css_task_iter_end(kit->css_it);
>         |         ^~~~~~~~~~~~~~~~~
>
> This patch simply surrounds with a #ifdef the new code requiring CGroups
> support. It seems enough for the compiler and this is similar to
> bpf_iter_css_{new,next,destroy}() functions where no other #ifdef have
> been added in kernel/bpf/helpers.c and in the selftests.
>
> Fixes: 9c66dc94b62a ("bpf: Introduce css_task open-coded iterator kfuncs"=
)
> Link: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/666520=
6927
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202310260528.aHWgVFqq-lkp@i=
ntel.com/
> Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
> [ added missing ifdefs for BTF_ID cgroup definitions ]
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Thank you, this (finally, reported first on Oct 20!) fixes the build of
e.g. m68k/defconfig.

Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

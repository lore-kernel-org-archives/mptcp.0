Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473501841
	for <mptcp@lists.linux.dev>; Wed,  1 Nov 2023 03:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxSuRFmk"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-32f78dcf036so260230f8f.0
        for <mptcp@lists.linux.dev>; Tue, 31 Oct 2023 20:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698810908; x=1699415708; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JB0/maXrKhTyio7d/n+oJLiXoE4Nk47OqpdEbHEpM+Q=;
        b=UxSuRFmkd/HcDXrQTYlZc0l6qwagnxBxkjzR0PXO4oHdseXE1vv8aXtN6urJp2YbxY
         VVIvJSWib5XM49ace9uNBVMatkUUQvGbrCN6oFeu26L9M9I5hoqCvd39QEWoyelfFXJG
         EMFFnwdj57JQQOqev7BNprbJ30uMOYH6BrQ5NSf5EgXJ0WtHgE50IEFWU0Qvf5KC5fVG
         ZboR/36J3YCtz6W6HFZ/6inXwK+Hpuc1puRfWUmgLC3yhhGrg9eOFW5Vx27rDD5wse9y
         kvwHQbfkouIxZQDMLpPTBYlRozeNjh65ZgJqrQyKfrINN/dwoOkEghSsnvC0rm6560pT
         hr0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698810908; x=1699415708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JB0/maXrKhTyio7d/n+oJLiXoE4Nk47OqpdEbHEpM+Q=;
        b=UOsj577iXfKQfCkuy4thtJ8Ju5pZmZre1QCMEzGcfNhMd7I4xLeCtkFxDD+XefkIAM
         bMxz9RHmmquF8eUf2B+aoH7e431QFNqEoeQZKuaas+Hf1c3M5tOB3FR0JzFcUNKfOmfi
         x1+dRFYLzV9aQA5vTztDahfJ2XlntlqROMbbPNBU0sEebTW9sIIjApbDPWGbZwah9bHa
         ekhaS45561vrD4UikNaxIpNMu7F3qZ/vEXRis1Kwxk5Wi5upXOgfWYdY+/gAj/u/g23a
         N3OSp17EMExxPZANjI/Zj3TskeEMJlVvXRQsdStEYujFTGE3bPJu7FlYsIFcrPiXGtNc
         gj5A==
X-Gm-Message-State: AOJu0YzEfpoJWU28vBNQvpfLUOyr3+gTmd3vIedIQhXw8EAG7eAm44lk
	7eKPDZW82F65PzyZo1+v0cmhAY3EEQRbd1kgnCk=
X-Google-Smtp-Source: AGHT+IEr7KyXAJEpInft+c9ZhQlYvVmFJWyLpzhcsVLEkhcHWsrXKsLbILhZlE1rMBSUuUxgrsGXTN9cMIGNRYTrhyM=
X-Received: by 2002:a05:6000:154b:b0:32f:811c:dfc4 with SMTP id
 11-20020a056000154b00b0032f811cdfc4mr5397720wry.4.1698810907910; Tue, 31 Oct
 2023 20:55:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231031-bpf-compil-err-css-v1-1-e2244c637835@kernel.org> <ZUEzzc/Sod8OR28B@krava>
In-Reply-To: <ZUEzzc/Sod8OR28B@krava>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 31 Oct 2023 20:54:56 -0700
Message-ID: <CAADnVQKCNFxcpE9Y250iwd8E4+t_Pror0AuRaoRYepUkXj56UA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: fix compilation error without CGROUPS
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Matthieu Baerts <matttbe@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Chuyi Zhou <zhouchuyi@bytedance.com>, 
	Tejun Heo <tj@kernel.org>, bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	MPTCP Upstream <mptcp@lists.linux.dev>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 10:05=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wro=
te:
>
> On Tue, Oct 31, 2023 at 04:49:34PM +0100, Matthieu Baerts wrote:
> > Our MPTCP CI complained [1] -- and KBuild too -- that it was no longer
> > possible to build the kernel without CONFIG_CGROUPS:
> >
> >   kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_new':
> >   kernel/bpf/task_iter.c:919:14: error: 'CSS_TASK_ITER_PROCS' undeclare=
d (first use in this function)
> >     919 |         case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
> >         |              ^~~~~~~~~~~~~~~~~~~
> >   kernel/bpf/task_iter.c:919:14: note: each undeclared identifier is re=
ported only once for each function it appears in
> >   kernel/bpf/task_iter.c:919:36: error: 'CSS_TASK_ITER_THREADED' undecl=
ared (first use in this function)
> >     919 |         case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
> >         |                                    ^~~~~~~~~~~~~~~~~~~~~~
> >   kernel/bpf/task_iter.c:927:60: error: invalid application of 'sizeof'=
 to incomplete type 'struct css_task_iter'
> >     927 |         kit->css_it =3D bpf_mem_alloc(&bpf_global_ma, sizeof(=
struct css_task_iter));
> >         |                                                            ^~=
~~~~
> >   kernel/bpf/task_iter.c:930:9: error: implicit declaration of function=
 'css_task_iter_start'; did you mean 'task_seq_start'? [-Werror=3Dimplicit-=
function-declaration]
> >     930 |         css_task_iter_start(css, flags, kit->css_it);
> >         |         ^~~~~~~~~~~~~~~~~~~
> >         |         task_seq_start
> >   kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_next':
> >   kernel/bpf/task_iter.c:940:16: error: implicit declaration of functio=
n 'css_task_iter_next'; did you mean 'class_dev_iter_next'? [-Werror=3Dimpl=
icit-function-declaration]
> >     940 |         return css_task_iter_next(kit->css_it);
> >         |                ^~~~~~~~~~~~~~~~~~
> >         |                class_dev_iter_next
> >   kernel/bpf/task_iter.c:940:16: error: returning 'int' from a function=
 with return type 'struct task_struct *' makes pointer from integer without=
 a cast [-Werror=3Dint-conversion]
> >     940 |         return css_task_iter_next(kit->css_it);
> >         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_destroy':
> >   kernel/bpf/task_iter.c:949:9: error: implicit declaration of function=
 'css_task_iter_end' [-Werror=3Dimplicit-function-declaration]
> >     949 |         css_task_iter_end(kit->css_it);
> >         |         ^~~~~~~~~~~~~~~~~
> >
> > This patch simply surrounds with a #ifdef the new code requiring CGroup=
s
> > support. It seems enough for the compiler and this is similar to
> > bpf_iter_css_{new,next,destroy}() functions where no other #ifdef have
> > been added in kernel/bpf/helpers.c and in the selftests.
> >
> > Fixes: 9c66dc94b62a ("bpf: Introduce css_task open-coded iterator kfunc=
s")
> > Link: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/6665=
206927
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202310260528.aHWgVFqq-lkp=
@intel.com/
> > Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
>
> Acked/Tested-by: Jiri Olsa <jolsa@kernel.org>

I believe this patch has the same issue as Arnd's patch:
https://lore.kernel.org/all/CAADnVQL-zoFPPOVu3nM981gKxRu7Q3G3LTRsKstJEeahpo=
R1RQ@mail.gmail.com/

I'd like to merge the fix asap. Please make it a complete fix.

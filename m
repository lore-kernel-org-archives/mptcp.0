Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973376FB8
	for <mptcp@lists.linux.dev>; Mon, 18 Sep 2023 13:26:42 +0000 (UTC)
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-99c3c8adb27so593835266b.1
        for <mptcp@lists.linux.dev>; Mon, 18 Sep 2023 06:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695043601; x=1695648401; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J8DqzhvzyGA39Yvgz+zBRm+sIYZErBZTUzgkb6fr790=;
        b=ZZGuY2DIQwAxnWRpyZ+R3K+FDEkv9nx7RnUaB4GZ+U10gckUcqi2kADf+6ZK0OOZUA
         d5JF3oHB5G3Sa0HL31k1pOfrG1oHh2hsUrWm9vfrqQfl19OTHOcc4iRceSimfp3QfQh7
         ZDCZh7GAgSV5MmDwDLviFojzw+qHHJ635Ff7wtdjgQCnLG1/9BwqORKkHrsAhsqCmzY0
         EBDzOW3GPejeg+zQE4cjKM+/gF3x877h15i/b0i4cwpT97Hsu7P/M4Eol0g39TBaJB9/
         gdv24/NwETvD48s01sM/wlEUnu+wpiCvIrD+NJ8PhSsNRPnIVGMyMBxw4BaUAx3icUbK
         kmaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695043601; x=1695648401;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J8DqzhvzyGA39Yvgz+zBRm+sIYZErBZTUzgkb6fr790=;
        b=vQDYlFjfVT+NWzwwxnkuBLavIn09MfdsecPiWzuUlrk+Bs6vSq8A+INE7WlZuE0AYj
         IXDbS8++Wh4Nf/mrb+gqiGFEfiSzB6SYDRfG0p9n0M8I0+6EAlro07zfca1g/wEHdbj1
         FDyu+R2zv0+fOoiYD8LrxbMdqJvNNWp1xERFqv+zdTNHbJG8ATB+CCMQ4a1u70JOsG3o
         2zWZwftMr9qbW15qy1qRQuromQwXo3leF5qogq3bx1e0gb7AtwyUb+LHOKbBW3wFk8pA
         4GfKlL6HRxWShaaV1yYjT8v+GWlI/GLKXI6akxM/R7fO48tQox4xWMTOMasY0516uQVK
         d4Gw==
X-Gm-Message-State: AOJu0YxFxtQ81i5GUFxw+PKphuT0ajlsTIIL9xrgs8Wf+AcCpujFSeZc
	DeF642vUdgdawF+iWE0BbG+7LyVponHiyOL6D103Ep/utk0=
X-Google-Smtp-Source: AGHT+IGv+cuS54y/ErE5nGFW0PhBBF5V5HKYi2enBs4vIQaNjWZXZ6zmR+tedv60Zzbf/GLfnsSHAJ6CT+JRpZdhNeA=
X-Received: by 2002:a17:906:20f:b0:9ad:8c4f:1f1a with SMTP id
 15-20020a170906020f00b009ad8c4f1f1amr8325459ejd.30.1695043600498; Mon, 18 Sep
 2023 06:26:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230912233214.1518551-1-memxor@gmail.com> <20230912233214.1518551-11-memxor@gmail.com>
 <fb51f3ed-a8aa-42f1-b649-eb684235323a@tessares.net>
In-Reply-To: <fb51f3ed-a8aa-42f1-b649-eb684235323a@tessares.net>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 18 Sep 2023 15:26:04 +0200
Message-ID: <CAP01T76ivGmVai3WbYo3D2jiz=rLubAHEpzihYinbKYKvGpViA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 10/17] bpf: Prevent KASAN false positive with bpf_throw
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: bpf@vger.kernel.org, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Yonghong Song <yonghong.song@linux.dev>, David Vernet <void@manifault.com>, 
	Puranjay Mohan <puranjay12@gmail.com>, netdev <netdev@vger.kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Sept 2023 at 15:20, Matthieu Baerts
<matthieu.baerts@tessares.net> wrote:
>
> Hi Kumar,
>
> (+ netdev in Cc as this patch is now in net-next tree as well ; same for
> mptcp-next)
>
>
> On 13/09/2023 01:32, Kumar Kartikeya Dwivedi wrote:
> > The KASAN stack instrumentation when CONFIG_KASAN_STACK is true poisons
> > the stack of a function when it is entered and unpoisons it when
> > leaving. However, in the case of bpf_throw, we will never return as we
> > switch our stack frame to the BPF exception callback. Later, this
> > discrepancy will lead to confusing KASAN splats when kernel resumes
> > execution on return from the BPF program.
> >
> > Fix this by unpoisoning everything below the stack pointer of the BPF
> > program, which should cover the range that would not be unpoisoned. An
> > example splat is below:
>
> Thank you for your patch!
>
> (...)
>
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 78e8f4de6750..2c8e1ee97b71 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -22,6 +22,7 @@
> >  #include <linux/security.h>
> >  #include <linux/btf_ids.h>
> >  #include <linux/bpf_mem_alloc.h>
> > +#include <linux/kasan.h>
> >
> >  #include "../../lib/kstrtox.h"
> >
> > @@ -2483,6 +2484,11 @@ __bpf_kfunc void bpf_throw(u64 cookie)
> >               WARN_ON_ONCE(!ctx.aux->exception_boundary);
> >       WARN_ON_ONCE(!ctx.bp);
> >       WARN_ON_ONCE(!ctx.cnt);
> > +     /* Prevent KASAN false positives for CONFIG_KASAN_STACK by unpoisoning
> > +      * deeper stack depths than ctx.sp as we do not return from bpf_throw,
> > +      * which skips compiler generated instrumentation to do the same.
> > +      */
> > +     kasan_unpoison_task_stack_below((void *)ctx.sp);
>
> Our CI validating MPTCP tree has just reported the following error when
> building the kernel for a 32-bit architecture:
>
>   kernel/bpf/helpers.c: In function 'bpf_throw':
>   kernel/bpf/helpers.c:2491:41: error: cast to pointer from integer of
> different size [-Werror=int-to-pointer-cast]
>    2491 |         kasan_unpoison_task_stack_below((void *)ctx.sp);
>         |                                         ^
>   cc1: all warnings being treated as errors
>
> Source:
> https://github.com/multipath-tcp/mptcp_net-next/actions/runs/6221288400/job/16882945173
>
>
> It looks like this issue has been introduced by your patch. Are you
> already looking at a fix?
>

Yes, my patch is responsible. So pointers here are 32-bits, while
ctx.sp is 64-bit, hence it is complaining.
I think long is supposed to match pointer width on all targets Linux
supports, so doing this should fix it.
(void*)(long)ctx.sp

I will send a fix for this soon.

Thanks


> >       ctx.aux->bpf_exception_cb(cookie, ctx.sp, ctx.bp);
> >  }
> >
>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net

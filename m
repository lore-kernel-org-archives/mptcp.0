Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDB52E6CC4
	for <mptcp@lists.linux.dev>; Thu, 25 Sep 2025 16:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758817118; cv=none; b=SFN2tuDPMnPrsXPQnfTf+lyEKYksg5G6UekEB7BFBr8M4H6+WAZy3QX1v+T5VcoX/bDeDm1Y5iuMqHDklTwvwa3s3cUZPhAOns3UO1TVAlajbuAHrHLYs1ShtBKsalrnkjf3UOuPlBFUBOWpk6cyClyc1s+QtOULNwl0DWlbjqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758817118; c=relaxed/simple;
	bh=B39erYFu+IADpwH47mN8zsMtIScBC4vuaTnziuWPKH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FArGuAob1NumDEoLV51GOSw42HRLfBRbgbWznEQYjwdDi/85IN5PDejULxYhgHbnWlc5VkdaUj0Ivgv0E7Z5NuxFUf8yoAOUnJJnKCVc3jDlNseSf07xVpyColnhULx0fj09dfGFkHeCGkZ/3wUurzWeWc0+fGQJvvRZgqj4B2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFPkYd/w; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFPkYd/w"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b2fcfef5600so189148266b.3
        for <mptcp@lists.linux.dev>; Thu, 25 Sep 2025 09:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758817115; x=1759421915; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5xevkUUTmwlKwAyY0Wx9nWf1Int/iLI6fP1YJUNaVA=;
        b=iFPkYd/wzEdvJb0MlygZynh8nSiXEFfwI0RBU7IQ2UkcDcjwC9inv6z8aev0SsUI4W
         9ajQKn609txqZK3uNr5/sr7PqnqAaqGvj5LZYjwuCKUrFEsO1d9Vc8QcxTFsHEsdFj1O
         2ilhnl2Ba5bieLFOQEnS8scbsS0F3NZhZfKLCC6WxDAeDlgOLLWG1sHFaeGv3SzkXIKz
         L5r7D3DZXGW3ttI/U0GeyWvvS32vloM/qkfo2NlqSCj3AvnHFaKkIH+kJEEmr0H5BAbH
         Bnqx0TWgIzY6yDKDxG56QLhUJbAidmbxrwsfIoNqiKhqJrpdp4ONlZZtEbkyRzNzTGkx
         PJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758817115; x=1759421915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s5xevkUUTmwlKwAyY0Wx9nWf1Int/iLI6fP1YJUNaVA=;
        b=Q5LhxiIbaW4ccnHXflSfQY1HgGVaW+yDWsZJZaAHgF3Wxh2L3tC2tYJijhrQIxbF6B
         divmeuRddBIKCWJrs18DR3YSeEy8H+Qtj3cyLorIWUlRbCvEYkhtikRHl0UyOgsrUAT9
         ujK+Kf9WiRjTVDvb3qy87fKa4MJLWTTblv39N1y0CarRnjIwhex8fiExtdUZzsVDdkBb
         SBisMuuOhltTlN71iW4MFknuHS0PjHy/LPko95YWCG4UcBICjaxdj8KprW00rFSK1c/0
         /JVnnbtFNsP6Zvuu29WQAOh3CFzeR44uPqj8acIYufR1rOQec6q9uEJwndNv7XkPLXGn
         RE9g==
X-Forwarded-Encrypted: i=1; AJvYcCU1WlQ5bx0EMPkHSt8gTBCVn5ZWmQuPXnzyChpFgecA2oBxTmJVrOff8rVJYdIOkrdvOyBFwQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzq9T/t07kzeqczDTQQn212da7oJdQj5QsevVWwoTcxPMcnLw/c
	6jl8AajQzXIkA8OU3bisNjNJph61XqHKKCXcT74JpPIYAPBxfhxjq4dC5bo+VIouVd1q7YHdD2m
	tEpTiSgxZUB3Zgvd0kXtGu6iVR6hFn6c=
X-Gm-Gg: ASbGncu9dtZDHhcWi2rTQ/RIAmeVOXtKghaesP3MJ36q0XFpeyy+FbIUAixL2oWI6OY
	9w7ZHjr5gpD7v6y1/NZDBL0G9+NpFTIh79q98RbYIY9tCgBUGPVTM0wbQtUfyuUnk3UlLvyOxuB
	rqVLdBWUqNPKl8a8cU3PV+kuPfY/Cf3VbMqF8U8p7h5n//NVjgOU+1G7llj6Vfu9D6hz6lxrzP3
	x1bDH0aP6Q0qOBqtAn/VZgj6YwT62drsXREgLxHDuGc+KuoMLY=
X-Google-Smtp-Source: AGHT+IFwv2YwsWAIKIDmxsrJN0NY39IA3xgFkg9Xv9DM8KA1HxgqMZQFSM1VnRv5Sj5R14hL06ntb/V9/P6xF1NLvs4=
X-Received: by 2002:a17:907:720b:b0:b2a:7f08:23da with SMTP id
 a640c23a62f3a-b34bbebe2f0mr416672066b.56.1758817114676; Thu, 25 Sep 2025
 09:18:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250925103559.14876-1-mehdi.benhadjkhelifa@gmail.com>
 <20250925103559.14876-4-mehdi.benhadjkhelifa@gmail.com> <5ad26663-a3cc-4bf4-9d6f-8213ac8e8ce6@iogearbox.net>
 <4b77c830-2a7d-444a-adeb-4d1370f8923f@gmail.com>
In-Reply-To: <4b77c830-2a7d-444a-adeb-4d1370f8923f@gmail.com>
From: vivek yadav <vivekyadav1207731111@gmail.com>
Date: Thu, 25 Sep 2025 21:48:22 +0530
X-Gm-Features: AS18NWDavCeJ5JOczMPLBfdxzac54ktOAMOZM_aUlp9EmmRHO_1O8MKFqbGzkPg
Message-ID: <CABPSWR7_w3mxr74wCDEF=MYYuG2F_vMJeD-dqotc8MDmaS_FpQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] selftests/bpf: Prepare to add -Wsign-compare for
 bpf tests
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, andrii@kernel.org, eddyz87@gmail.com, 
	ast@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, 
	matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org, 
	davem@davemloft.net, kuba@kernel.org, hawk@kernel.org, linux@jordanrome.com, 
	ameryhung@gmail.com, toke@redhat.com, houtao1@huawei.com, 
	emil@etsalapatis.com, yatsenko@meta.com, isolodrai@meta.com, 
	a.s.protopopov@gmail.com, dxu@dxuuu.xyz, memxor@gmail.com, vmalik@redhat.com, 
	bigeasy@linutronix.de, tj@kernel.org, gregkh@linuxfoundation.org, 
	paul@paul-moore.com, bboscaccy@linux.microsoft.com, 
	James.Bottomley@hansenpartnership.com, mrpre@163.com, jakub@cloudflare.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, linux-kernel-mentees@lists.linuxfoundation.org, 
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mehdi,
You are trying to do much with the patch series. I don't think it will
help much as reviewers will give comments and you will revise the
patches. This loop will continue forever.

I totally agree with Daniel. Please write a proper commit message.

While writing a commit message or creating a patch.Please try to give
the answers of the following questions.
1) What is the issue which your patch resolves?
2) Are you trying to do more than one thing at a time? Please don't.
3) if a patch modifies more than one file then either these changes
inter link with each other or they have similar kind of work.

~~Vivek

On Thu, Sep 25, 2025 at 9:04=E2=80=AFPM Mehdi Ben Hadj Khelifa
<mehdi.benhadjkhelifa@gmail.com> wrote:
>
> On 9/25/25 4:04 PM, Daniel Borkmann wrote:
> > On 9/25/25 12:35 PM, Mehdi Ben Hadj Khelifa wrote:
> >> -Change only variable types for correct sign comparisons
> >>
> >> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
> >
> > Pls write some better commit messages and not just copy/paste the same
> > $subj/
> > message every time; proper sentences w/o the weird " -" indent.
>
> Understood, though the changes are very similar / are the same with the
> same goal that's why it made sense to me to do that and I will remove
> the - in future commits.> Also say
> > why
> > this is needed in the commit message, and add a reference to the commit
> > which
> > initially added this as a TODO, i.e. 495d2d8133fd ("selftests/bpf:
> > Attempt to
> > build BPF programs with -Wsign-compare").
> I will do that in the upcoming version.
>
> > If you group these, then maybe
> > also
> > include the parts of the compiler-emitted warnings during build which a=
re
> > relevant to the code changes you do here.
>
> Okay. I will do that. Should i send a v4 with the recommended changes
> but not including the rest of the files meaning the ones that I haven't
> uploaded in this patch series which contain type casting or should i
> just make changes for these files in this series?
> Also will it be better if dropped these versions and made a new patch
> with v1?
>
> Thank you for your review and time Daniel.
> Regards,
> Mehdi
> >> ---
> >>   tools/testing/selftests/bpf/progs/test_xdp_dynptr.c          | 2 +-
> >>   tools/testing/selftests/bpf/progs/test_xdp_loop.c            | 2 +-
> >>   tools/testing/selftests/bpf/progs/test_xdp_noinline.c        | 4 ++-=
-
> >>   tools/testing/selftests/bpf/progs/uprobe_multi.c             | 4 ++-=
-
> >>   .../selftests/bpf/progs/uprobe_multi_session_recursive.c     | 5 +++=
--
> >>   .../selftests/bpf/progs/verifier_iterating_callbacks.c       | 2 +-
> >>   6 files changed, 10 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/tools/testing/selftests/bpf/progs/test_xdp_dynptr.c b/
> >> tools/testing/selftests/bpf/progs/test_xdp_dynptr.c
> >> index 67a77944ef29..12ad0ec91021 100644
> >> --- a/tools/testing/selftests/bpf/progs/test_xdp_dynptr.c
> >> +++ b/tools/testing/selftests/bpf/progs/test_xdp_dynptr.c
> >> @@ -89,7 +89,7 @@ static __always_inline int handle_ipv4(struct xdp_md
> >> *xdp, struct bpf_dynptr *xd
> >>       struct vip vip =3D {};
> >>       int dport;
> >>       __u32 csum =3D 0;
> >> -    int i;
> >> +    size_t i;
> >>       __builtin_memset(eth_buffer, 0, sizeof(eth_buffer));
> >>       __builtin_memset(iph_buffer_tcp, 0, sizeof(iph_buffer_tcp));
> >> diff --git a/tools/testing/selftests/bpf/progs/test_xdp_loop.c b/
> >> tools/testing/selftests/bpf/progs/test_xdp_loop.c
> >> index 93267a68825b..e9b7bbff5c23 100644
> >> --- a/tools/testing/selftests/bpf/progs/test_xdp_loop.c
> >> +++ b/tools/testing/selftests/bpf/progs/test_xdp_loop.c
> >> @@ -85,7 +85,7 @@ static __always_inline int handle_ipv4(struct xdp_md
> >> *xdp)
> >>       struct vip vip =3D {};
> >>       int dport;
> >>       __u32 csum =3D 0;
> >> -    int i;
> >> +    size_t i;
> >>       if (iph + 1 > data_end)
> >>           return XDP_DROP;
> >> diff --git a/tools/testing/selftests/bpf/progs/test_xdp_noinline.c b/
> >> tools/testing/selftests/bpf/progs/test_xdp_noinline.c
> >> index fad94e41cef9..85ef3c0a3e20 100644
> >> --- a/tools/testing/selftests/bpf/progs/test_xdp_noinline.c
> >> +++ b/tools/testing/selftests/bpf/progs/test_xdp_noinline.c
> >> @@ -372,7 +372,7 @@ bool encap_v4(struct xdp_md *xdp, struct ctl_value
> >> *cval,
> >>       next_iph_u16 =3D (__u16 *) iph;
> >>       __pragma_loop_unroll_full
> >> -    for (int i =3D 0; i < sizeof(struct iphdr) >> 1; i++)
> >> +    for (size_t i =3D 0; i < sizeof(struct iphdr) >> 1; i++)
> >>           csum +=3D *next_iph_u16++;
> >>       iph->check =3D ~((csum & 0xffff) + (csum >> 16));
> >>       if (bpf_xdp_adjust_head(xdp, (int)sizeof(struct iphdr)))
> >> @@ -423,7 +423,7 @@ int send_icmp_reply(void *data, void *data_end)
> >>       iph->check =3D 0;
> >>       next_iph_u16 =3D (__u16 *) iph;
> >>       __pragma_loop_unroll_full
> >> -    for (int i =3D 0; i < sizeof(struct iphdr) >> 1; i++)
> >> +    for (size_t i =3D 0; i < sizeof(struct iphdr) >> 1; i++)
> >>           csum +=3D *next_iph_u16++;
> >>       iph->check =3D ~((csum & 0xffff) + (csum >> 16));
> >>       return swap_mac_and_send(data, data_end);
> >> diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi.c b/tools/
> >> testing/selftests/bpf/progs/uprobe_multi.c
> >> index 44190efcdba2..f99957773c3a 100644
> >> --- a/tools/testing/selftests/bpf/progs/uprobe_multi.c
> >> +++ b/tools/testing/selftests/bpf/progs/uprobe_multi.c
> >> @@ -20,13 +20,13 @@ __u64 uretprobe_multi_func_3_result =3D 0;
> >>   __u64 uprobe_multi_sleep_result =3D 0;
> >> -int pid =3D 0;
> >> +__u32 pid =3D 0;
> >>   int child_pid =3D 0;
> >>   int child_tid =3D 0;
> >>   int child_pid_usdt =3D 0;
> >>   int child_tid_usdt =3D 0;
> >> -int expect_pid =3D 0;
> >> +__u32 expect_pid =3D 0;
> >>   bool bad_pid_seen =3D false;
> >>   bool bad_pid_seen_usdt =3D false;
> >> diff --git a/tools/testing/selftests/bpf/progs/
> >> uprobe_multi_session_recursive.c b/tools/testing/selftests/bpf/progs/
> >> uprobe_multi_session_recursive.c
> >> index 8fbcd69fae22..017f1859ebe8 100644
> >> --- a/tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive=
.c
> >> +++ b/tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive=
.c
> >> @@ -3,6 +3,7 @@
> >>   #include <bpf/bpf_helpers.h>
> >>   #include <bpf/bpf_tracing.h>
> >>   #include <stdbool.h>
> >> +#include <stddef.h>
> >>   #include "bpf_kfuncs.h"
> >>   #include "bpf_misc.h"
> >> @@ -10,8 +11,8 @@ char _license[] SEC("license") =3D "GPL";
> >>   int pid =3D 0;
> >> -int idx_entry =3D 0;
> >> -int idx_return =3D 0;
> >> +size_t idx_entry =3D 0;
> >> +size_t idx_return =3D 0;
> >>   __u64 test_uprobe_cookie_entry[6];
> >>   __u64 test_uprobe_cookie_return[3];
> >> diff --git a/tools/testing/selftests/bpf/progs/
> >> verifier_iterating_callbacks.c b/tools/testing/selftests/bpf/progs/
> >> verifier_iterating_callbacks.c
> >> index 75dd922e4e9f..72f9f8c23c93 100644
> >> --- a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
> >> +++ b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
> >> @@ -593,7 +593,7 @@ int loop_inside_iter_volatile_limit(const void *ct=
x)
> >>   {
> >>       struct bpf_iter_num it;
> >>       int *v, sum =3D 0;
> >> -    __u64 i =3D 0;
> >> +    __s32 i =3D 0;
> >>       bpf_iter_num_new(&it, 0, ARR2_SZ);
> >>       while ((v =3D bpf_iter_num_next(&it))) {
> >
>
>

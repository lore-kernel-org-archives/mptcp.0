Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1007FF
	for <mptcp@lists.linux.dev>; Thu, 28 Apr 2022 02:51:37 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id d15so3147670pll.10
        for <mptcp@lists.linux.dev>; Wed, 27 Apr 2022 19:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nCvO0C5tCxZkm0TKZ/4ZfGEUmJr0lFiUlkxtgYWn36M=;
        b=T+CyR368xC2hOdvMnY+1aTQtFJZAy3qo4j2v4fZdYY8ZyXkWYJXo28umjssgqLW/Fe
         aRKaXpbr9hs9Ej5uic9aVHBhvGYWISjVbRwZLSr7KR1tReKjPN819BjFss7rcd6zZL0U
         G8udajShkXLdrRD1dq/cy52fyrj3a8UW4Ihs8E9P7/rN33htGXd+6fybQixNlnxcVsVT
         DjWvY9Zhu/wV+3Z+RdrhXuxmOfDWidA4HTGh/ymLZN83xJKAKXgZNkdhpgj0GeRHPfeB
         UBwD7Pn3z2r0YlrTgDc6q7iHLaBuEJOitv7nGmqSCo60S3Ll/ZtL4lqIxYdvbZnxHUBi
         gzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nCvO0C5tCxZkm0TKZ/4ZfGEUmJr0lFiUlkxtgYWn36M=;
        b=lls2g2Q0OEAQkDX15+AZIRJRujXRvu0IoXGokUyf9kllFLCcapWUAy0UmCJzOmy0nt
         sQZ3s1f1lRBiPGGWkxrdXbuyjGR5zrmXgu38Tvpv99YFHqAN/dRJlnohqW7I4o6J6urD
         pdDnqE07LXm9SjH186JHSbHz9z7BOWmRipoSB4OTdOUrIhLt5z8r+RbVRksTgjqDIugJ
         +43OP5tyJxycJmYeftk1wz5SeZXGE4ggXjcqR4e7cHJYKUREPU03qaJzl9ibjJmYsplX
         vSNLYMAg2M9t30B03YsM8hu2ttOr2nc5/vLHd9/gQvTNw3BJzNtbPeaLVyCdJCmKfM7S
         OBHw==
X-Gm-Message-State: AOAM530PwCQp5hgXstg04q9vjF9RlE+hqnv3dk4Yr/HbKlvJJACBBTuX
	uFomvsQ0mX+0f7SqDrrsid3pNhLX1/uQofK+y08=
X-Google-Smtp-Source: ABdhPJyhy1sp5ukccQp4FtUp3ROnaMNqqlaG41wSOhAvC3+EtGhicyi/I6SQbNh+zm2y1lWc1WVSUUYnwjZWMXWmZJc=
X-Received: by 2002:a17:902:8f8d:b0:15b:7b98:22e6 with SMTP id
 z13-20020a1709028f8d00b0015b7b9822e6mr31228328plo.102.1651114296755; Wed, 27
 Apr 2022 19:51:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <a412b57378176f189e112a36443ac133fa90566c.1650947043.git.geliang.tang@suse.com>
 <50d4d7a13beec75c5172d81c2c6d037fb74efd79.1650947056.git.geliang.tang@suse.com>
 <d521e76e-729a-cc7f-9ad5-e4e26f3da8d@linux.intel.com> <CA+WQbwu2n-Wva1Ja2dFxkbsQtfitCgUrK_KMQfm2VJPCsBmxig@mail.gmail.com>
 <db186e4e-491e-2384-ad51-f18e73faf0b0@linux.intel.com>
In-Reply-To: <db186e4e-491e-2384-ad51-f18e73faf0b0@linux.intel.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Thu, 28 Apr 2022 10:51:55 +0800
Message-ID: <CA+WQbwvKox=T=gWYQhA_M=44apNSPbZqu+8NL_8TBwAf7f5mTg@mail.gmail.com>
Subject: Re: [PATCH mptcp-next] Squash to "selftests: bpf: test bpf_skc_to_mptcp_sock"
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Geliang Tang <geliang.tang@suse.com>, MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mat,


Mat Martineau <mathew.j.martineau@linux.intel.com> =E4=BA=8E2022=E5=B9=B44=
=E6=9C=8828=E6=97=A5=E5=91=A8=E5=9B=9B 05:47=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, 27 Apr 2022, Geliang Tang wrote:
>
> > Hi Mat,
> >
> > Mat Martineau <mathew.j.martineau@linux.intel.com> =E4=BA=8E2022=E5=B9=
=B44=E6=9C=8827=E6=97=A5=E5=91=A8=E4=B8=89 08:20=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On Tue, 26 Apr 2022, Geliang Tang wrote:
> >>
> >>> Add CONFIG_MPTCP check.
> >>>
> >>> When CONFIG_MPTCP is not enabled, we'll get a clearer error message:
> >>>
> >>> libbpf: extern CONFIG_MPTCP (strong) not resolved
> >>> libbpf: failed to load object './mptcp_sock.o'
> >>>
> >>> The message before is like this:
> >>>
> >>> libbpf: prog '_sockops': BPF program load failed: Invalid argument
> >>> libbpf: prog '_sockops': -- BEGIN PROG LOAD LOG --
> >>>
> >>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> >>> ---
> >>> tools/testing/selftests/bpf/progs/mptcp_sock.c | 4 ++++
> >>> 1 file changed, 4 insertions(+)
> >>>
> >>
> >> Looks like this also requires CONFIG_IKCONFIG and CONFIG_IKCONFIG_PROC=
,
> >> can you also add those to tools/testing/selftests/bpf/config? Maybe th=
at
> >> should be a separate commit, since other bpf test progs appear to rely=
 on
> >> this undocumented config requirement.
> >
> > In my test, this bpf base test still works without CONFIG_IKCONFIG and
> > CONFIG_IKCONFIG_PROC:
> >
> >> ls /proc/config.gz
> > ls: cannot access '/proc/config.gz': No such file or directory
> >> sudo ./test_progs -n 103
> > #103 mptcp:OK
> > Summary: 1/3 PASSED, 0 SKIPPED, 0 FAILED
> >
>
> Huh, I wonder what's going on? It fails for me:
>
> $ sudo ./test_progs -v -a mptcp
> bpf_testmod.ko is already unloaded.
> Loading bpf_testmod.ko...
> Successfully loaded bpf_testmod.ko.
> libbpf: failed to open system Kconfig
> libbpf: failed to load object './mptcp_sock.o'
> run_test:FAIL:165
> test_base:FAIL:227
> libbpf: failed to open system Kconfig
> libbpf: failed to load object './mptcp_sock.o'
> run_test:FAIL:165
> test_base:FAIL:244
> #103/1 mptcp/base:FAIL
> (cgroup_helpers.c:146: errno: Device or resource busy) Removing cgroup: /=
mnt/cgroup-test-work-dir831/mptcp
> (cgroup_helpers.c:146: errno: Device or resource busy) Removing cgroup: /=
mnt/cgroup-test-work-dir831
> #103 mptcp:FAIL
>
> All error logs:
> #103 mptcp:FAIL
>
> Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED
>
> This is with Fedora 35. I'll check the BPF CI to see if there's any
> information about their configuration that might explain the difference.

I figure it out. libbpf reads /boot/config-* first, then /proc/config.gz:

 1840 static int bpf_object__read_kconfig_file(struct bpf_object *obj,
void *data)
 1841 {
 1842         char buf[PATH_MAX];
 1843         struct utsname uts;
 1844         int len, err =3D 0;
 1845         gzFile file;
 1846
 1847         uname(&uts);
 1848         len =3D snprintf(buf, PATH_MAX, "/boot/config-%s", uts.releas=
e);
 1849         if (len < 0)
 1850                 return -EINVAL;
 1851         else if (len >=3D PATH_MAX)
 1852                 return -ENAMETOOLONG;
 1853
 1854         /* gzopen also accepts uncompressed files. */
 1855         file =3D gzopen(buf, "r");
 1856         if (!file)
 1857                 file =3D gzopen("/proc/config.gz", "r");

So we do need to add CONFIG_IKCONFIG and CONFIG_IKCONFIG_PROC in
config. I'll send a v2 as a dedicated patch.

Thanks,
-Geliang


>
>
> - Mat
>
> >
> >
> >>
> >> - Mat
> >>
> >>> diff --git a/tools/testing/selftests/bpf/progs/mptcp_sock.c b/tools/t=
esting/selftests/bpf/progs/mptcp_sock.c
> >>> index 5cfaec4e7245..7b6a25e37de8 100644
> >>> --- a/tools/testing/selftests/bpf/progs/mptcp_sock.c
> >>> +++ b/tools/testing/selftests/bpf/progs/mptcp_sock.c
> >>> @@ -7,6 +7,7 @@
> >>>
> >>> char _license[] SEC("license") =3D "GPL";
> >>> __u32 _version SEC("version") =3D 1;
> >>> +extern bool CONFIG_MPTCP __kconfig;
> >>>
> >>> struct mptcp_storage {
> >>>       __u32 invoked;
> >>> @@ -46,6 +47,9 @@ int _sockops(struct bpf_sock_ops *ctx)
> >>>               if (!storage)
> >>>                       return 1;
> >>>       } else {
> >>> +             if (!CONFIG_MPTCP)
> >>> +                     return 1;
> >>> +
> >>>               msk =3D bpf_skc_to_mptcp_sock(sk);
> >>>               if (!msk)
> >>>                       return 1;
> >>> --
> >>> 2.34.1
> >>>
> >>>
> >>>
> >>
> >> --
> >> Mat Martineau
> >> Intel
> >>
> >
>
> --
> Mat Martineau
> Intel

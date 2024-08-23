Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84A91C7B97
	for <mptcp@lists.linux.dev>; Fri, 23 Aug 2024 22:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724452135; cv=none; b=d0I9jnHs8F3OFZYUbRdMH7O31YvmwsWlTVWgw06NpwjDzj4DEHKwM/kr4dXBbEIXaNpJiY78k5sNpKLd5m/JMbk9oCUjP4cuca9sLD4DGhxk+1g2GlAosMBLb0s5Bbdc3jmnIhz2XBTJhtp01i0vs5HTdCOdvIbieH3feWgbNmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724452135; c=relaxed/simple;
	bh=lhFa9C+TdLA9AgtlhB86iziIxZ2TXHCWtZB1vVjHBhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MpZ7qluwTEViuy/zzRbplw7W0h1C7jpzxAYFMl2HVtRfjOw8ce8JC3vnw81/brflFY/biecbvtZRHZiaFblY+XTbx09xwmw0Va+XztxIApXlIGhEckFTee1bE6E+Sjgoc02Wto56yzG2Uz1U0M5hG+TnXxhl43OAJWU7C4AzApM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+SUjuGQ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+SUjuGQ"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4281d812d3eso25453695e9.3
        for <mptcp@lists.linux.dev>; Fri, 23 Aug 2024 15:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724452132; x=1725056932; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWtV3/DOt8P4Xpd14+mqShRwy4l1Z4jup7YrAn/As/k=;
        b=H+SUjuGQCl5v+wYlhLetHvW4QOcfqLUwHfZ5KvWpPIOeIwV8RMvOjdHg9YTC6WraNr
         Ts5oOrqhf3QEkQkvpEfnzT95BqJHURuMrUDiAGtC8Jqz5eIxUUbaKZyhXmUIc8Q23Vq0
         JXuWzLgj64tLPWhhTw2iuFpKGsRrQrxEExx9Xb9fP9oJUZXBFlo6I5BrCL/VRTh1xFzH
         Mf6qJrdyOlMWbmXIUAODKj28cQZQxtsZf13NDCtV+ImJeH6DX4jPW58+jzkeEjny3rR+
         Ib62ipSB8HXVuM7quGWdUTWPl2XZT+Z7cEb/Loqy6YRKy7e11gHUWirS113kRrLUkhob
         af2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724452132; x=1725056932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WWtV3/DOt8P4Xpd14+mqShRwy4l1Z4jup7YrAn/As/k=;
        b=rNv9jsHXV4UIL+XyR4zeA9g/w83AAi3Z4QOLm+Mx4chSdmxCHTsHqvQyXmh+Mbe6ET
         4nyOt5bbt3UH52GNZSsACcup61JU0sstceQl/5yX/YZDOpnSRuLTtEVrr23ETX6XqoUE
         gPXCezhhwd+e7FAtdhSQuo+R9dmpQrvaQYatM3r5WxqyXMyKp5cNyZXwB1ugQg0ZJGTn
         PYzC6YGEaJllCllSCignsi9erhw3lSwHZeOaM03bSgXze4Slv7YzIva/4w6XJgyLWZUk
         Ne9EBY08W+NDROI/+VutGtWt1KnhqfTBTmN4M3ApfwqEzdCf3A/ezqyMfpbXsR5sOrh6
         B4bw==
X-Gm-Message-State: AOJu0Yycsd1vt7BomDaCCekDk5hIcUCfIGkTUMmIedIK9Dnjapl9VYlm
	TISbEeOQEgUyo/2wk2Y2Zsv7tELrf8j5olTyinZYwSbWI2zP1EEorM7ZMyp7tMLCgISay3RIHMH
	28JUlKpp8AKSJcokDDmGWYpXtmxy/k7MZ
X-Google-Smtp-Source: AGHT+IHC28T0OxdS5xfWVXMn6jPEmfd/fTwBRe4M2YVY0z1mCKUZOIrmxvOKGo0k/glS1YBPx9wJCuP9gjWxOW50vjk=
X-Received: by 2002:a5d:58d9:0:b0:368:6564:751b with SMTP id
 ffacd0b85a97d-37311864454mr2589305f8f.32.1724452131607; Fri, 23 Aug 2024
 15:28:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240816-ups-bpf-next-selftests-use-khdr-v1-0-1e19f3d5b17a@kernel.org>
 <20240816-ups-bpf-next-selftests-use-khdr-v1-1-1e19f3d5b17a@kernel.org>
 <CAADnVQ+JBq8-6Rhi_LHX470uj2_2xxJAhgdUfg_abUxEDqpdJQ@mail.gmail.com> <6a693ad6-f145-48c1-b3a7-d441d3764e73@kernel.org>
In-Reply-To: <6a693ad6-f145-48c1-b3a7-d441d3764e73@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 23 Aug 2024 15:28:40 -0700
Message-ID: <CAADnVQKnEuQ4XZROLWH47mEZNwnJ9TuyTrauOnuobcLgVMrimw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] selftests: bpf: use KHDR_INCLUDES for the
 UAPI headers
To: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 17, 2024 at 7:51=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hi Alexei,
>
> Thank you for the review.
>
> On 17/08/2024 09:22, Alexei Starovoitov wrote:
> > On Fri, Aug 16, 2024 at 7:56=E2=80=AFPM Matthieu Baerts (NGI0)
> > <matttbe@kernel.org> wrote:
> >>
> >> Instead of duplicating UAPI header files in 'tools/include/uapi', the
> >> BPF selftests can also look at the header files inside the kernel
> >> source.
> >>
> >> To do that, the kernel selftests infrastructure provides the
> >> 'KHDR_INCLUDES' variable. This is what is being used in most selftests=
,
> >> because it is what is recommended in the documentation [1]. If the
> >> selftests are not executed from the kernel sources, it is possible to
> >> override the variable, e.g.
> >>
> >>   make KHDR_INCLUDES=3D"-I${HDR_DIR}/include" -C "${KSFT_DIR}"
> >>
> >> ... where ${HDR_DIR} has been generated by this command:
> >>
> >>   make headers_install INSTALL_HDR_PATH=3D"${HDR_DIR}"
> >>
> >> Thanks to 'KHDR_INCLUDES', it is no longer needed to duplicate header
> >> files for userspace test programs, and these programs can include UAPI
> >> header files without the 'uapi' prefix.
> >>
> >> Note that it is still required to use 'tools/include/uapi' -- APIDIR,
> >> which corresponds to TOOLS_INCLUDES from lib.mk -- for the BPF program=
s,
> >> not to conflict with what is already defined in vmlinux.h.
> >>
> >> Link: https://docs.kernel.org/dev-tools/kselftest.html#contributing-ne=
w-tests-details [1]
> >> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> >> ---
> >>  tools/testing/selftests/bpf/Makefile                       | 2 +-
> >>  tools/testing/selftests/bpf/prog_tests/assign_reuse.c      | 2 +-
> >>  tools/testing/selftests/bpf/prog_tests/tc_links.c          | 4 ++--
> >>  tools/testing/selftests/bpf/prog_tests/tc_netkit.c         | 2 +-
> >>  tools/testing/selftests/bpf/prog_tests/tc_opts.c           | 2 +-
> >>  tools/testing/selftests/bpf/prog_tests/user_ringbuf.c      | 2 +-
> >>  tools/testing/selftests/bpf/prog_tests/xdp_bonding.c       | 2 +-
> >>  tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c | 2 +-
> >>  tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c | 2 +-
> >>  tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c   | 2 +-
> >>  tools/testing/selftests/bpf/prog_tests/xdp_link.c          | 2 +-
> >>  tools/testing/selftests/bpf/xdp_features.c                 | 4 ++--
> >>  12 files changed, 14 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/self=
tests/bpf/Makefile
> >> index 4eceb491a8ae..6a7aeae7e206 100644
> >> --- a/tools/testing/selftests/bpf/Makefile
> >> +++ b/tools/testing/selftests/bpf/Makefile
> >> @@ -37,7 +37,7 @@ CFLAGS +=3D -g $(OPT_FLAGS) -rdynamic               =
                    \
> >>           -Wall -Werror -fno-omit-frame-pointer                       =
  \
> >>           $(GENFLAGS) $(SAN_CFLAGS) $(LIBELF_CFLAGS)                  =
  \
> >>           -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)        =
  \
> >> -         -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)
> >> +         -I$(TOOLSINCDIR) $(KHDR_INCLUDES) -I$(OUTPUT)
> >>  LDFLAGS +=3D $(SAN_LDFLAGS)
> >>  LDLIBS +=3D $(LIBELF_LIBS) -lz -lrt -lpthread
> >>
> >> diff --git a/tools/testing/selftests/bpf/prog_tests/assign_reuse.c b/t=
ools/testing/selftests/bpf/prog_tests/assign_reuse.c
> >> index 989ee4d9785b..3d06bf5a1ba4 100644
> >> --- a/tools/testing/selftests/bpf/prog_tests/assign_reuse.c
> >> +++ b/tools/testing/selftests/bpf/prog_tests/assign_reuse.c
> >> @@ -1,6 +1,6 @@
> >>  // SPDX-License-Identifier: GPL-2.0
> >>  /* Copyright (c) 2023 Isovalent */
> >> -#include <uapi/linux/if_link.h>
> >> +#include <linux/if_link.h>
> >
> > No. This is not an option.
> > User space shouldn't include kernel headers like this.
> > Long ago tools/include directory was specifically
> > created to break such dependency.
> > Back then it was done for perf.
>
> I'm sorry, but I think we are not talking about the same thing here:
> here, I'm only modifying the "normal" userspace programs, not the ones
> used to generate the BPF objects. Perf is a special case I suppose, it
> needs to know the kernel internals. It is the same with BPF programs
> requiring vmlinux.h. But I think "normal" userspace programs in the
> sefltests can use the UAPI headers, no?

Not really. perf is a normal user space that doesn't look into
kernel internals.
It's used to rely on a few .h from kernel src tree for convenience,
since they're not present in what's installed after 'make headers'.
Hence the tools/include dir was created.

Using KHDR_INCLUDES is fine, but it's not ok to search replace
s/uapi\/linux/linux/ everywhere.
Like the example I quoted above.
tools/.../if_link.h is much older than include/uapi/linux/if_link.h
and it's ok.
We're not planning to update it.
It's like building selftests on the system with older glibc.
There is no requirement to have every .h in the tools/ dir
up-to-date with the latest in include/.
We're doing it for bpf.h because new selftests typically need
something from bpf.h that was just added in the previous patch.

> I understand that I could indeed fix my initial problem by duplicating
> mptcp.h in tools/include/uapi/linux/, but this doesn't look to be
> allowed any more by the Netdev maintainers, e.g. recently, 'ethtool.h'
> has been duplicated there in commit 7effe3fdc049 ("tools: Add ethtool.h
> header to tooling infra"), but removed quickly after in commit
> bbe91a9f6889 ("tools: remove redundant ethtool.h from tooling infra").
> In this case, it was fine to simply drop it, because the linked test
> doesn't require a recent version. Jakub mentioned [4] that these
> duplicated headers should be avoided, and the ones generated by 'make
> headers' should be used instead: what is being suggested here.

This is a different issue. There are very few .h in tools/ that
needs a sync.
bpf.h is one of them. ethtool.h is certainly not.

you need something for mpctp.h. Let's talk about it,
but switching everything to KHDR_INCLUDES is not ok,
since there are a bunch of things in play.
Sometimes selftests are built standalone and with non-glibc-s.

Also realize that bpf selftests are not really kselftests.
We use a few common .mk for convenience. That's about it.

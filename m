Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFF64C6C
	for <mptcp@lists.linux.dev>; Sat, 17 Aug 2024 07:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723879337; cv=none; b=Pv9OHOuST8Lv6N29jxPRXcf5KMBJPWN++3ptazDd+qLd6TlHH1l14TVaE+vCFreR7pQZHApUIVYDTian86Ny0XEwhcmKRjSXMiuuLAv94QARxaGGjNcXW2iSRVyDIBU3wQ5y1PYQlTDypSlf4xA7rHVjtfKJFyEEyX99gH4K0u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723879337; c=relaxed/simple;
	bh=7cnVUeChjgu+H9+YLNcBRYkwu+eWF6JojTp+Wk1c2NE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S9B8jKu+n72liGFxUJMfwHMX9Vj0Wy/+1ppeqEg1Ly1LcUG4plcl2muSc1RPobbXywsxYiEs2IbY9jsBxEEAhtZyHwndsRxayMkJC7XbPUh6BMtk9BGsV0kR6ZYfUNdl1fXAWVqTPEDa0Q7MJ13l5UQOf1eAEDyPGo+LRl52Eyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+5DCXB8; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+5DCXB8"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-429da8b5feaso27323365e9.2
        for <mptcp@lists.linux.dev>; Sat, 17 Aug 2024 00:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723879334; x=1724484134; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qv//cMXlZMFtqNbjMe4oj82em7Hd3JuMo8tNEDaIu4c=;
        b=U+5DCXB8N6BBSuFp01rxlNc6MCPtjd9/e4tqpe6kC6/UJsc3UXZWWOh1ucBqaQ4UOh
         nWsTvletQMVU1tTiOBHMKzKPYrNq4tCBdQ3KY9jLoLJxtWpzfcYYVAgo9FhlXQHUmgI+
         aSvclTqDagOssRB+RXdiBAo5WFJeqUPiBopm2qv/8WWplvE1zlC7Q3liasRVMppuJmpS
         UF10ndyDnR1oNxnkeSDTUFCbrRLlbxeLZ3xwPqaQqBRSJpikcFBN3pQWsbtA+qHXuaLJ
         N5Zf2pTg1o72Eh/Q+X+Pn8EAUZpxcwEVfkDXh4k3warmAPXKevE4pPRrHxPzgjwplw75
         l/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723879334; x=1724484134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qv//cMXlZMFtqNbjMe4oj82em7Hd3JuMo8tNEDaIu4c=;
        b=JEhpJNr6bDGOdCK+E2vdY+pfzmqbFI9zICgKgT/7Re4QLhOupFE6qw7a3+s0BWYWJ+
         9/imVZ/duHzjswxlYtm6+eXnyLp8CJ0U35tyI47KKhuyN8b6cVky7j0VcfmvkK4iUU+V
         XUiMB4xKo0wb8w6qlhkuysnzmcThrEQBpI19pZvND0ZlodvkTQqJ37ydt0CQCVyoJU+5
         Ix2dOM/wHjf2qA3y1tAUbFWg/9AEOdJ2pnY1kbChFdP7xnmKbd9CqY3P0iWQ1GFS4rUX
         MuhPELUTYpzDRUJGkkse9E/AWlktnRlaxLG6ABJAgYvnu3+gPmK2Ay4yb+oamfx4iaaC
         R8eQ==
X-Gm-Message-State: AOJu0YwOgldm07qcjPp+ww4gNERSUsws1/N5v72eaTeoUB0ZSJQLw0DW
	DmStCp2HtYTSuaqVWNaivhLb5bsobcQ4jgbncOyGYBRDQyMZVBUcKqj/WuBuUetdkgrSYuE7UZE
	HX09zenw2h+byan66wO24WnRrLAY=
X-Google-Smtp-Source: AGHT+IGYPED+EDMmtWlfqZ30mThja6VK8NtB6YP/LLvy3rtLIhdo6cjAoEMDY3Rrqz+oI/iTzfyvpN6uMxgGM1b65vA=
X-Received: by 2002:adf:facf:0:b0:368:4b9d:ee2c with SMTP id
 ffacd0b85a97d-3719443d206mr3972273f8f.19.1723879333453; Sat, 17 Aug 2024
 00:22:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240816-ups-bpf-next-selftests-use-khdr-v1-0-1e19f3d5b17a@kernel.org>
 <20240816-ups-bpf-next-selftests-use-khdr-v1-1-1e19f3d5b17a@kernel.org>
In-Reply-To: <20240816-ups-bpf-next-selftests-use-khdr-v1-1-1e19f3d5b17a@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 17 Aug 2024 09:22:02 +0200
Message-ID: <CAADnVQ+JBq8-6Rhi_LHX470uj2_2xxJAhgdUfg_abUxEDqpdJQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] selftests: bpf: use KHDR_INCLUDES for the
 UAPI headers
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
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

On Fri, Aug 16, 2024 at 7:56=E2=80=AFPM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> Instead of duplicating UAPI header files in 'tools/include/uapi', the
> BPF selftests can also look at the header files inside the kernel
> source.
>
> To do that, the kernel selftests infrastructure provides the
> 'KHDR_INCLUDES' variable. This is what is being used in most selftests,
> because it is what is recommended in the documentation [1]. If the
> selftests are not executed from the kernel sources, it is possible to
> override the variable, e.g.
>
>   make KHDR_INCLUDES=3D"-I${HDR_DIR}/include" -C "${KSFT_DIR}"
>
> ... where ${HDR_DIR} has been generated by this command:
>
>   make headers_install INSTALL_HDR_PATH=3D"${HDR_DIR}"
>
> Thanks to 'KHDR_INCLUDES', it is no longer needed to duplicate header
> files for userspace test programs, and these programs can include UAPI
> header files without the 'uapi' prefix.
>
> Note that it is still required to use 'tools/include/uapi' -- APIDIR,
> which corresponds to TOOLS_INCLUDES from lib.mk -- for the BPF programs,
> not to conflict with what is already defined in vmlinux.h.
>
> Link: https://docs.kernel.org/dev-tools/kselftest.html#contributing-new-t=
ests-details [1]
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  tools/testing/selftests/bpf/Makefile                       | 2 +-
>  tools/testing/selftests/bpf/prog_tests/assign_reuse.c      | 2 +-
>  tools/testing/selftests/bpf/prog_tests/tc_links.c          | 4 ++--
>  tools/testing/selftests/bpf/prog_tests/tc_netkit.c         | 2 +-
>  tools/testing/selftests/bpf/prog_tests/tc_opts.c           | 2 +-
>  tools/testing/selftests/bpf/prog_tests/user_ringbuf.c      | 2 +-
>  tools/testing/selftests/bpf/prog_tests/xdp_bonding.c       | 2 +-
>  tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c | 2 +-
>  tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c | 2 +-
>  tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c   | 2 +-
>  tools/testing/selftests/bpf/prog_tests/xdp_link.c          | 2 +-
>  tools/testing/selftests/bpf/xdp_features.c                 | 4 ++--
>  12 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 4eceb491a8ae..6a7aeae7e206 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -37,7 +37,7 @@ CFLAGS +=3D -g $(OPT_FLAGS) -rdynamic                  =
                 \
>           -Wall -Werror -fno-omit-frame-pointer                         \
>           $(GENFLAGS) $(SAN_CFLAGS) $(LIBELF_CFLAGS)                    \
>           -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)          \
> -         -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)
> +         -I$(TOOLSINCDIR) $(KHDR_INCLUDES) -I$(OUTPUT)
>  LDFLAGS +=3D $(SAN_LDFLAGS)
>  LDLIBS +=3D $(LIBELF_LIBS) -lz -lrt -lpthread
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/assign_reuse.c b/tool=
s/testing/selftests/bpf/prog_tests/assign_reuse.c
> index 989ee4d9785b..3d06bf5a1ba4 100644
> --- a/tools/testing/selftests/bpf/prog_tests/assign_reuse.c
> +++ b/tools/testing/selftests/bpf/prog_tests/assign_reuse.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright (c) 2023 Isovalent */
> -#include <uapi/linux/if_link.h>
> +#include <linux/if_link.h>

No. This is not an option.
User space shouldn't include kernel headers like this.
Long ago tools/include directory was specifically
created to break such dependency.
Back then it was done for perf.

pw-bot: cr

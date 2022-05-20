Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DCA7E
	for <mptcp@lists.linux.dev>; Fri, 20 May 2022 22:46:33 +0000 (UTC)
Received: by mail-vs1-f43.google.com with SMTP id i186so9671182vsc.9
        for <mptcp@lists.linux.dev>; Fri, 20 May 2022 15:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5pQeUb7i2aQrMCTFP4sfEtDtoSYxOjDxSh8e8T9nS1E=;
        b=L3x6/NW1KmjyeV38jecoTyoSPtHQaXXxld5nI5ziNWGeMDmOuzG8gyeiR5OidJyR3r
         8HpYxb/QGZAC6BHmf8HtkBI3YA6VWOoxBvg0LzNDtqgxaSCQ63mlnoJSMXlhVCP/O30k
         1xyQ4xMW74V2jTNALUiqUtfcsAeE6tjaFnDgsiw1JkLLA7t6+00Hg4RDEkfmHsKGC2/V
         q7MZTNjmnGdc7t+qtUdI04hJ5JIOCqBhrORl5bOMJ5OzUwlaL0K0Wcp9vtYav4hhLnms
         xHnHZ/v6pFwI+bI0gRcpPniT2l9Ixnfiji1lstMTybByURvjkhasLrUpuoLM0DW02sBg
         +1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5pQeUb7i2aQrMCTFP4sfEtDtoSYxOjDxSh8e8T9nS1E=;
        b=0Gk2gz7q+A8bubQriA+iejnOmtV/9lAS7HZUmxl/ADyqGE27j13QpD+/Y/zXL3buEj
         37hBoLYzJEb0XLtB6lAVwv78lSanW0Jm6bZfBxXRI4uCD2CTqrh6tE0QlVXRXvQ6pCvn
         INFqzbi8hl7nHPS3s7U29jsk1UnUvI4wu2apOPcF/M+WJuwQ3+r/ixOOp3jB798M454L
         nsq6XKgaFOpGgXpm5N0Def/V9MgLyHF5o1LrcowFYqcsc5NGjbY5BxVQbnyzXcH9EbEh
         VI9YzILsyMWiYfsWDhAoF/iWg0WuQcQ6ppbln+ztUbqSMSDMn+GxmeML5Y46MrErZO6W
         78OA==
X-Gm-Message-State: AOAM533/Pz6636J1Euq1eToC7Y/imgBMT896feMq1SlXIXgb+DhG84wX
	K8N7Nq/8F9hzw0/+xXNtqz7wH2aDU5DwPc1QZ1M=
X-Google-Smtp-Source: ABdhPJyiaAtAdaUBzDp9yFdA6kuTy81xzJn/Z4v7Wfuy50rIkY0QXBW8+d0+xYs7kmFR1Mu1NCsSmgdujwsvLus5sTo=
X-Received: by 2002:a05:6102:370a:b0:333:c0e7:77e8 with SMTP id
 s10-20020a056102370a00b00333c0e777e8mr5497192vst.54.1653086792033; Fri, 20
 May 2022 15:46:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220519233016.105670-1-mathew.j.martineau@linux.intel.com>
In-Reply-To: <20220519233016.105670-1-mathew.j.martineau@linux.intel.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 20 May 2022 15:46:21 -0700
Message-ID: <CAEf4BzaZ07_VRN_z6xPogcx-YQuPQR8FCkC=K621r5oo1vBViQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 0/7] bpf: mptcp: Support for mptcp_sock
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, May 19, 2022 at 4:30 PM Mat Martineau
<mathew.j.martineau@linux.intel.com> wrote:
>
> This patch set adds BPF access to mptcp_sock structures, along with
> associated self tests. You may recognize some of the code from earlier
> (https://lore.kernel.org/bpf/20200918121046.190240-6-nicolas.rybowski@tessares.net/)
> but it has been reworked quite a bit.
>
>
> v1 -> v2: Emit BTF type, add func_id checks in verifier.c and bpf_trace.c,
> remove build check for CONFIG_BPF_JIT, add selftest check for CONFIG_MPTCP,
> and add a patch to include CONFIG_IKCONFIG/CONFIG_IKCONFIG_PROC for the
> BPF self tests.
>
> v2 -> v3: Access sysctl through the filesystem to work around CI use of
> the more limited busybox sysctl command.
>
> v3 -> v4: Dropped special case kernel code for tcp_sock is_mptcp, use
> existing bpf_tcp_helpers.h, and add check for 'ip mptcp monitor' support.
>
> v4 -> v5: Use BPF test skeleton, more consistent use of ASSERT macros,
> drop some unnecessary parameters / checks, and use tracing to acquire
> MPTCP token.
>
> Geliang Tang (6):
>   bpf: add bpf_skc_to_mptcp_sock_proto
>   selftests/bpf: Enable CONFIG_IKCONFIG_PROC in config
>   selftests/bpf: test bpf_skc_to_mptcp_sock
>   selftests/bpf: verify token of struct mptcp_sock
>   selftests/bpf: verify ca_name of struct mptcp_sock
>   selftests/bpf: verify first of struct mptcp_sock
>
> Nicolas Rybowski (1):
>   selftests/bpf: add MPTCP test base
>
>  MAINTAINERS                                   |   1 +
>  include/linux/bpf.h                           |   1 +
>  include/linux/btf_ids.h                       |   3 +-
>  include/net/mptcp.h                           |   6 +
>  include/uapi/linux/bpf.h                      |   7 +
>  kernel/bpf/verifier.c                         |   1 +
>  kernel/trace/bpf_trace.c                      |   2 +
>  net/core/filter.c                             |  18 ++
>  net/mptcp/Makefile                            |   2 +
>  net/mptcp/bpf.c                               |  21 +++
>  scripts/bpf_doc.py                            |   2 +
>  tools/include/uapi/linux/bpf.h                |   7 +
>  tools/testing/selftests/bpf/bpf_tcp_helpers.h |  13 ++
>  tools/testing/selftests/bpf/config            |   3 +
>  tools/testing/selftests/bpf/network_helpers.c |  40 +++-
>  tools/testing/selftests/bpf/network_helpers.h |   2 +
>  .../testing/selftests/bpf/prog_tests/mptcp.c  | 174 ++++++++++++++++++
>  .../testing/selftests/bpf/progs/mptcp_sock.c  |  89 +++++++++
>  18 files changed, 382 insertions(+), 10 deletions(-)
>  create mode 100644 net/mptcp/bpf.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/mptcp.c
>  create mode 100644 tools/testing/selftests/bpf/progs/mptcp_sock.c
>
>
> base-commit: 834650b50ed283d9d34a32b425d668256bf2e487
> --
> 2.36.1
>

I've added missing static for test_base and some other helper and
replaced bzero and memcpy in BPF-side code with __builtin_memset and
__builtin_memcpy (and dropped string.h include, it's not supposed to
be used from BPF-side code). Applied to bpf-next, thanks.

Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8BB3D7B
	for <mptcp@lists.linux.dev>; Fri,  6 May 2022 22:25:27 +0000 (UTC)
Received: by mail-io1-f47.google.com with SMTP id f2so9533506ioh.7
        for <mptcp@lists.linux.dev>; Fri, 06 May 2022 15:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NKngyg6H4LzHGgY5WX93en+mLYjHn5tEgpXL8XPGins=;
        b=UIsyoBtmGjQUf/J6PDrp0yL7O2eyyFWhQX8HMurJ4yoiwlXKR7JWg12h0zLkuP/KR/
         7JxDrhGQzSMS5nqtKb71urWhTXjHBkzUadFMLMJGI5zhaCqjRLhuIibJcRRHf88Pl3oB
         f2Maq0ax/4STkl0iBZ82j7W+r2RqIZZouLAUCFoQZAs5L0ITDosusKhsPbZ5QJAfIJYO
         4jcMLfdlS6WYZv3tfaoc3/3NwoNBfbCWw++UrShOeGR7fGBA7i3HOQ+QVcZ3V1VqhBLG
         p2bkhZRTHAa7q1/QSthBzYzCN4d+J/9Xf9WYI5u7S11r0fwS3G2YiRHaKaml51sOhrtp
         MG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NKngyg6H4LzHGgY5WX93en+mLYjHn5tEgpXL8XPGins=;
        b=bNWW8CGJBayZ7q9mM+GOXoeyne2LzcMKdG77CaoNjWpNaYegzU2NohyozWRJa+6OMI
         yz38kWv0UDtEDM+JusoDFTApNVpWSA+oNIARb9jjY2KiC63NiKl6x4k7m9rH1Q7bLgrw
         FTiaHkjSWKWmjpuWLxI2rIqRnvs3es07Cy3MJaMaCsOXp2+NDKd+s3RQL2Q3F0xXVnNF
         e/3v5Rak6QieGj0M8/dLrebeINQ13WOlxktC6wB3616dZMqfdUOIyfsnsvEYDp0RdGAc
         0D7pOgGCBlKNIGZ09XAoRNHe95iaNtczFNmPIaVA2pfSk525V+lX6d27xOuNqcx3hnC8
         RrOA==
X-Gm-Message-State: AOAM533/LlIxhGFjatZrNwQDE3WrTkL75rYrSyvXgnsvKtwXgHV3RXEW
	QTG+285jDJsKvHByfP3at2ybvix28Gkn3J+0p9UNJPcSueM=
X-Google-Smtp-Source: ABdhPJzed2737G/RT9aiyHxZPSSu/yCRp9JOQeTbZw7imv2nbuSKOKUw41GLFxPxw99fJQHr2ZFSmig6pZLeoA9/foU=
X-Received: by 2002:a05:6638:533:b0:32a:d418:b77b with SMTP id
 j19-20020a056638053300b0032ad418b77bmr2392102jar.237.1651875926938; Fri, 06
 May 2022 15:25:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220502211235.142250-1-mathew.j.martineau@linux.intel.com> <20220502211235.142250-4-mathew.j.martineau@linux.intel.com>
In-Reply-To: <20220502211235.142250-4-mathew.j.martineau@linux.intel.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 6 May 2022 15:25:16 -0700
Message-ID: <CAEf4BzYKYtQLxHFk7cbGA47JNX7ND4cYEqaoDMiQLBttXYd5+w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/8] selftests: bpf: Enable
 CONFIG_IKCONFIG_PROC in config
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Geliang Tang <geliang.tang@suse.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, May 2, 2022 at 2:12 PM Mat Martineau
<mathew.j.martineau@linux.intel.com> wrote:
>
> From: Geliang Tang <geliang.tang@suse.com>
>
> CONFIG_IKCONFIG_PROC is required by BPF selftests, otherwise we get
> errors like this:
>
>  libbpf: failed to open system Kconfig
>  libbpf: failed to load object 'kprobe_multi'
>  libbpf: failed to load BPF skeleton 'kprobe_multi': -22
>
> It's because /proc/config.gz is opened in bpf_object__read_kconfig_file()
> in tools/lib/bpf/libbpf.c:
>
>         file = gzopen("/proc/config.gz", "r");
>
> So this patch enables CONFIG_IKCONFIG and CONFIG_IKCONFIG_PROC in
> tools/testing/selftests/bpf/config.
>
> Suggested-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/testing/selftests/bpf/config | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
> index 763db63a3890..8d7faff33c54 100644
> --- a/tools/testing/selftests/bpf/config
> +++ b/tools/testing/selftests/bpf/config
> @@ -53,3 +53,5 @@ CONFIG_NF_DEFRAG_IPV4=y
>  CONFIG_NF_DEFRAG_IPV6=y
>  CONFIG_NF_CONNTRACK=y
>  CONFIG_USERFAULTFD=y
> +CONFIG_IKCONFIG=y
> +CONFIG_IKCONFIG_PROC=y
> --
> 2.36.0
>

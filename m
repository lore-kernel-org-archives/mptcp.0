Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8467E
	for <mptcp@lists.linux.dev>; Tue, 26 Apr 2022 06:36:53 +0000 (UTC)
Received: by mail-il1-f177.google.com with SMTP id r11so10815543ila.1
        for <mptcp@lists.linux.dev>; Mon, 25 Apr 2022 23:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wECC4R+QuVfiSAeYQyQoWz/cNQFjmW/f1KrV57yGY/s=;
        b=ifo0pjVVCOEi0N8CXzwwLKldAR4kaNVU01B1FoDWmzqF4Ths7o4tP4kKaFG0QcqfMF
         M/B7hcDS7zk4cbwpBjhznPTd78IaDCMYtyo/MwZLlGxmJumZEVQynjxsMOpj4vBKo+F2
         eXGgYv+7tdiTnbDmSMTjEX3yPGNKE3rB0OXDcclsdNLFwAeYaphBqnicCjK2HKElo128
         Wpwop2fKK36XXmLS1ZYsYDci8Tnd9yhsxeSKnD51QLZqUZwTYo2/VsvY/eEp/ohZQznp
         0cPgwbU0NweccsO22jPnnNrRPswqTQpeyGLpsVunWTcsyrRhoyfRuMG/8fpRPXsnOI/D
         7wbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wECC4R+QuVfiSAeYQyQoWz/cNQFjmW/f1KrV57yGY/s=;
        b=Kteomf1P2jBPYHNG8EED6LAeo0GoUTJTfOkoZbgj7/ITynSRpXAxmMWxpS3aA8X6hT
         me13JlLD9sUNQgKiTSSpRl4WPo7itLfqF0oSAli3Q4NtR8CWDqRDBlZivorNaUeTDF4N
         USdIba9a0DCsja7JpyM0OWuLNtJkjNmE8EdrH+deW4PJnR/VVroqZsEuO+80lc7hlJEG
         N2+4qmgP/DASFrthzWybq1nQlxJK8c2bWz0YpfqbK3yyJDsrOHX1x3S88Jm53tqF+XRx
         OvUf4QadQ/Jk5nHFLAce0QA/at3p4nIE5KZR1BIb7mk6RoKX+BqSHUpPXqqRvfyFA+w2
         AYQA==
X-Gm-Message-State: AOAM530BiH2UjvjP/wOhvH6w+rjb6vyg+kB3GdLBy7TfXA7ON4YOXX4/
	nX/ZLNKnrsrmjZ74WqmOILnP91lfNQSdfxo21tg=
X-Google-Smtp-Source: ABdhPJwbSL2NV4RgfA/38RWAWWiVALA0Rp/QI1vPmKztG+nn4vIhfpMk+RBTR7/dnBcNfBl30W3eRlEjnj93HFZHTcs=
X-Received: by 2002:a92:c247:0:b0:2cc:1798:74fe with SMTP id
 k7-20020a92c247000000b002cc179874femr8318736ilo.239.1650955012791; Mon, 25
 Apr 2022 23:36:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220420222459.307649-1-mathew.j.martineau@linux.intel.com>
 <20220420222459.307649-3-mathew.j.martineau@linux.intel.com>
 <903108df-161e-515b-da3d-bff4fb49de39@iogearbox.net> <779c3a31-381d-75b4-5f7b-be36e9816068@iogearbox.net>
In-Reply-To: <779c3a31-381d-75b4-5f7b-be36e9816068@iogearbox.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 25 Apr 2022 23:36:41 -0700
Message-ID: <CAEf4BzYzCCFRj2Bvv+7kv5AT2WM_Vb6hLYyNGP7FAT9mkG2afw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/7] bpf: add bpf_skc_to_mptcp_sock_proto
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>, Networking <netdev@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Geliang Tang <geliang.tang@suse.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, mptcp@lists.linux.dev, 
	Nicolas Rybowski <nicolas.rybowski@tessares.net>, 
	Matthieu Baerts <matthieu.baerts@tessares.net>
Content-Type: text/plain; charset="UTF-8"

On Mon, Apr 25, 2022 at 7:29 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 4/25/22 4:26 PM, Daniel Borkmann wrote:
> [...]
> >
> > Looking at bpf_skc_to_tcp6_sock(), do we similarly need a BTF_TYPE_EMIT() here?
>
> (Plus, CONFIG_MPTCP should be enabled in CI config (Andrii).)

Should be done once [0] is merged in.

  [0] https://github.com/kernel-patches/vmtest/pull/77

>
> Cheers,
> Daniel

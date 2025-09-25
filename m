Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABB72EC54B
	for <mptcp@lists.linux.dev>; Thu, 25 Sep 2025 23:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758843148; cv=none; b=hwJ/0gNHo4pmNvXdV1umzumwqewvqi/yF9uMrIzrK9M+D86OnCFlowfOUSuiE4gemSdIy9IsO86PIcWepCxKs47K5I4ISANnLBQ4K4YezdrBiusjLX7S+AHbGhOOS7mKWzmDbD83o8ASx1VNdsgGqVzeHX5JkgZLIjdrwHtLOtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758843148; c=relaxed/simple;
	bh=l5LRunuTe/LqJ3h4k3fN0y4sQ6ZlASLvxnuyjT0c2dg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tWChtFdEiRs0XJW6iVZmzH3l1SVBWzikLIjAzlUrdYs2eCIbGVqiQnvjh+0fpxr4mHk1vBOQMkWAHJ3V3kIGgTBOiK1AVjbr+/CSIn2BqQ6bD9W1FUiUMOoIOdZDBeuSPK6Z/sPKfhS3nB3yU+Loh3tMrNy7/NbkSHDTVU7Ywew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtATd9V2; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtATd9V2"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3304dd2f119so1237272a91.2
        for <mptcp@lists.linux.dev>; Thu, 25 Sep 2025 16:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758843146; x=1759447946; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l8PWUy95/xwAeHXQlv9LwNQfamqkfSoV3CUxibqo+As=;
        b=dtATd9V2na+pbrBO687/HTevSEnjP7HZIsuU0h0xEXjkW+7lgUzq5mHEsGIogSZl78
         jTVeASsxzGbQL7zvrrBuC7iDKDn1b5/E24ZHthqtHMaS991F9vow1e/dETtFaunHbJ60
         wS76l7g/qx+jY7i9F2XNCzv4dEcXds9Edo2UIqyDOa7U2VyrDwLkB1llzSAqEXrJkC/Q
         UgVUb1l5xYr4eZz7DimHWMdsAvBC+sHC1VHfxe1dOuHWkP17oFZYA3fif/27bdED10bz
         xWvn98ijLSjmxDUVcNEnZodm8YqxaMWjsATcT4eJeS9Nfgu7wzzGsd9Gdwp1HWf2AecL
         EuKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758843146; x=1759447946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l8PWUy95/xwAeHXQlv9LwNQfamqkfSoV3CUxibqo+As=;
        b=ReK3tSGbffANni266e+8SghNFcyJvjuFauNcAhdnW2hgUZmkq8Qgjfvc1HCzkmv9pR
         g87hxpUd2S3xitYGF0zX9Q01o2k61TII3YYgb78gqpRe05s+qA+Hw+q+PzVrqwWWreI8
         gXexmCxQX+gK28YCPsn5zYM9wQ2MaS5P8bTKxXPyIjrUv49M5Sh5hojC3WLY3PnifB3S
         pLNFb8A6WYdHl8h+HnldhZaieiqQZlsDJ5MjGN1q3P8ImNyNJpNpgLvFcsbHHqC6FMpy
         ipAtXAK21hPYP6Bd3XhGAMO6g3Qo78Am7rDj6duDpSlV9Lp+L+oKq7yT/CW7SSIv8IsC
         Vwpw==
X-Forwarded-Encrypted: i=1; AJvYcCW5CHWakhzPOc+LUKD66RtAfDCvPGrZChJicFJP0YioQ/HFzYVoe6a1J47RWvbuxLnxoK8cBg==@lists.linux.dev
X-Gm-Message-State: AOJu0YykZ6hqSZQKbJ7jN45CRVcRBa1QAGlF7WNp+87rJKJOuRXmo3nd
	RIaPaXp7BXSS4XjOFjpsuSKmZDF2QxkAjeaMSZxZASLEediJ0WmMjOdya0ewd0XHkfSZGgYX/7b
	TiTcGVxTxv0ALjXAd6D2WL57NtoiTlug=
X-Gm-Gg: ASbGnctLJEIKFWvihkgaTG+qSuLjWMX6gDsDcBKrSPMPjNrcS+rqCTkj0N5hMyAZzdM
	pvsIBW7W3HGj91O3PqpEi3xh39USFUtTrTp8hnw/YZvHhVL8qXkU9PlIqcnX0LTrnXQT0SrEAGP
	lxJO4K4m3W54PSBnASDoVYGXOdideCrsGGwils1N/juPfWR1e43xlw4cWZ74VzFDEdrRmfUC0hK
	rSsjbgHfxP0mFDWcpAYga33SE1niXIonQ==
X-Google-Smtp-Source: AGHT+IFyG6lAkXqNECGf0CPqvA5WLNFwkWpmgIcJv7d6UG7Fy+qA0wGWEdL6nyUo+sCagqxDXc40BM4LYLvFPLy3JiY=
X-Received: by 2002:a17:90b:3ecc:b0:32e:7c34:70cf with SMTP id
 98e67ed59e1d1-3342a300aafmr5225649a91.36.1758843145829; Thu, 25 Sep 2025
 16:32:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250925103559.14876-1-mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <20250925103559.14876-1-mehdi.benhadjkhelifa@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 Sep 2025 16:32:11 -0700
X-Gm-Features: AS18NWAPxbw3Q7HkczSi0SkphLUmd3YAUtjm9M5fUjRW3Bv2KTPZjdUhgqDqjkE
Message-ID: <CAEf4Bzaf81OYLTzpN6E4ths_mN2gP29rMYBmbp7P2GqSMj8FbA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] selftests/bpf: Prepare to add -Wsign-compare for
 bpf selftests
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, matttbe@kernel.org, 
	martineau@kernel.org, geliang@kernel.org, davem@davemloft.net, 
	kuba@kernel.org, hawk@kernel.org, linux@jordanrome.com, ameryhung@gmail.com, 
	toke@redhat.com, houtao1@huawei.com, emil@etsalapatis.com, yatsenko@meta.com, 
	isolodrai@meta.com, a.s.protopopov@gmail.com, dxu@dxuuu.xyz, memxor@gmail.com, 
	vmalik@redhat.com, bigeasy@linutronix.de, tj@kernel.org, 
	gregkh@linuxfoundation.org, paul@paul-moore.com, 
	bboscaccy@linux.microsoft.com, James.Bottomley@hansenpartnership.com, 
	mrpre@163.com, jakub@cloudflare.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org, 
	david.hunter.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 2:36=E2=80=AFAM Mehdi Ben Hadj Khelifa
<mehdi.benhadjkhelifa@gmail.com> wrote:
>
> This series is preparing to add the -Wsign-compare C compilation flag to
> the Makefile for bpf selftests as requested by a TODO to help avoid
> implicit type conversions and have predictable behavior.
>
> Changelog:
>
> Changes from v2:
>
> -Split up the patch into a patch series as suggested by vivek
>
> -Include only changes to variable types with no casting by my mentor
> david
>
> -Removed the -Wsign-compare in Makefile to avoid compilation errors
> until adding casting for rest of comparisons.
>
> Link:https://lore.kernel.org/bpf/20250924195731.6374-1-mehdi.benhadjkheli=
fa@gmail.com/T/#u
>
> Changes from v1:
>
> - Fix CI failed builds where it failed due to do missing .c and
> .h files in my patch for working in mainline.
>
> Link:https://lore.kernel.org/bpf/20250924162408.815137-1-mehdi.benhadjkhe=
lifa@gmail.com/T/#u
>
> Mehdi Ben Hadj Khelifa (3):
>   selftests/bpf: Prepare to add -Wsign-compare for bpf tests
>   selftests/bpf: Prepare to add -Wsign-compare for bpf tests
>   selftests/bpf: Prepare to add -Wsign-compare for bpf tests
>

I see little value in these transformations. Did we catch any real
issue here? All this type casting and replacement is just churn.

I certainly don't want such churn in libbpf, and I'd leave BPF
selftests as is as well. int vs u64 can have subtle and non-obvious
implications for BPF code generation (for no-alu32 variants
especially), and I think BPF CI already exposed some of those already.

I think we can live without -Wsign-compare just fine.


>  tools/testing/selftests/bpf/progs/test_global_func11.c       | 2 +-
>  tools/testing/selftests/bpf/progs/test_global_func12.c       | 2 +-
>  tools/testing/selftests/bpf/progs/test_global_func13.c       | 2 +-
>  tools/testing/selftests/bpf/progs/test_global_func9.c        | 2 +-
>  tools/testing/selftests/bpf/progs/test_map_init.c            | 2 +-
>  tools/testing/selftests/bpf/progs/test_parse_tcp_hdr_opt.c   | 2 +-
>  .../selftests/bpf/progs/test_parse_tcp_hdr_opt_dynptr.c      | 2 +-
>  tools/testing/selftests/bpf/progs/test_skb_ctx.c             | 2 +-
>  tools/testing/selftests/bpf/progs/test_snprintf.c            | 2 +-
>  tools/testing/selftests/bpf/progs/test_sockmap_strp.c        | 2 +-
>  tools/testing/selftests/bpf/progs/test_tc_tunnel.c           | 2 +-
>  tools/testing/selftests/bpf/progs/test_xdp.c                 | 2 +-
>  tools/testing/selftests/bpf/progs/test_xdp_dynptr.c          | 2 +-
>  tools/testing/selftests/bpf/progs/test_xdp_loop.c            | 2 +-
>  tools/testing/selftests/bpf/progs/test_xdp_noinline.c        | 4 ++--
>  tools/testing/selftests/bpf/progs/uprobe_multi.c             | 4 ++--
>  .../selftests/bpf/progs/uprobe_multi_session_recursive.c     | 5 +++--
>  .../selftests/bpf/progs/verifier_iterating_callbacks.c       | 2 +-
>  18 files changed, 22 insertions(+), 21 deletions(-)
>
> --
> 2.51.0
>

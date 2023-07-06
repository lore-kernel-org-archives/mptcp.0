Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB470BE5C
	for <mptcp@lists.linux.dev>; Thu,  6 Jul 2023 17:53:42 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6689430d803so655357b3a.0
        for <mptcp@lists.linux.dev>; Thu, 06 Jul 2023 10:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688666022; x=1691258022;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oxUyU6YQSnWGVrIUn8qRopFoq6Rch2uU+VtdwbFIhns=;
        b=OtIAcuPPjgPdGZXTvOG+dp8Ncf1wNHAKnyOgf8otsX/2HkCf3dh4iX9/mKeMkcTEjH
         HotEuUFH81Q3W52A9glUAjAnahmFOvh5Q0OI4UtuTYtEt3VksYAjLhVNXbUGU8mNXuG/
         CR665sWy15+BcyKmvQ+ttemovQLI+nDDwu0ArIePAFzc2h84NDhlrK0Ylx/86+cGTpJF
         X8w5I90I55STIqbSyvcmCk1Pj1kt7i6Gc21G6z74Br9oU/pFlCO1TlnSytuDb+G2S4Tu
         6JUTuabnaaOPIIlA2miPiZUvi6mjqKBIBUx0JhD0ex8miQZjfkITyxJOmTijslDDhbG9
         Xpqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688666022; x=1691258022;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oxUyU6YQSnWGVrIUn8qRopFoq6Rch2uU+VtdwbFIhns=;
        b=DLG6x5+AgPx58YcaMgesFxv+B4oTuDrxz59216CEnQ2d5ZQ88e52gyTQLzASJr0oLZ
         pT6fpVb1WweqREIPLi95BqJ9bzNymoqq0CaxIZjfZDWWLdOP5Qd/XkBWpoMeiCzDLeqC
         SdCucSjhjBrq15BqtGL/Q4SLx8SWGtSEDLskPaABXTggusu/SSorZUGhXmgOszd62+64
         IA9w5P596mriGROqCarcW5d08MVF/CaKDP8h7uEGWYcKc3OWLMrbCCLULwqxF8Wcc/Ey
         5z21k4s0PHpR2pjAEJ20t12Oum12CEMnhR+Fq0Pm/f925cctlvYcj79PKp4CQFYKzZeC
         3hKQ==
X-Gm-Message-State: ABy/qLZHEv4Hcj1y3T6vscfDNPuxzD6r8mKG0ZvqhM54jQDAzF1V/+ZU
	UvcfwDmhrRfnwZBOuNCX0Uk=
X-Google-Smtp-Source: APBJJlFE5BxdI/XAivusUMplbfCjkAiL3p1bmMz1xra8CUVNiTbBEwhLMFoNw+9e7Fxkyx5p6WUNpQ==
X-Received: by 2002:aa7:8892:0:b0:668:7744:10f5 with SMTP id z18-20020aa78892000000b00668774410f5mr2338629pfe.10.1688666021922;
        Thu, 06 Jul 2023 10:53:41 -0700 (PDT)
Received: from iphone-b61117dec01e.dhcp.thefacebook.com ([2620:10d:c090:500::5:e96a])
        by smtp.gmail.com with ESMTPSA id l3-20020a62be03000000b0067aea93af40sm1564733pff.2.2023.07.06.10.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 10:53:41 -0700 (PDT)
Date: Thu, 6 Jul 2023 10:53:38 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: Re: [RFC bpf-next v3 0/8] BPF 'force to MPTCP'
Message-ID: <20230706175338.spgjlarowmbeof76@iphone-b61117dec01e.dhcp.thefacebook.com>
References: <cover.1688631200.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1688631200.git.geliang.tang@suse.com>

On Thu, Jul 06, 2023 at 04:19:39PM +0800, Geliang Tang wrote:
> 
> v3:
>  - patch 8: char cmd[128]; -> char cmd[256];
>  Fix build selftests errors:
>   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/mptcp.c:218:2: note: ‘snprintf’ output between 98 and 129 bytes into a destination of size 128
> 
> v2:
> 
>  - Fix build selftests errors reported by CI:
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/79

3 patch bombs in one day?
If your RFC tag means 'request for comments' then please wait for comments before spamming again.

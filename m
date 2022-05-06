Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C063D7B
	for <mptcp@lists.linux.dev>; Fri,  6 May 2022 22:28:07 +0000 (UTC)
Received: by mail-il1-f181.google.com with SMTP id s14so5654828ild.6
        for <mptcp@lists.linux.dev>; Fri, 06 May 2022 15:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/CpZb7ndIc4uJklRh3E2E3FxIA3evq19i2HXND3IGGM=;
        b=XQmwAQZRnspOZgGEkNJfozpbymc7/+2whzFBzNafyIdZXmMi8y3qIQvNvSCdhbCsdj
         sNQ++eNXwFyYq1h8mxiQ25SqJTej/E8q3yz3AtMzim8qYnLOSEn4ge8i5Raua6S2LGlp
         WeebU+Avzw/RC1YqzbVomcb9S0Inf1SqC3aVamAoavU85dLTdK3e/Ro4GTH50k56t+fT
         4nsLLPyi/sBqAkJnAL0TAtULZkPkfe/Jujxq6/HUIMAyhm92NcDXgQuKAuoBHwS0CZoP
         guNUPzOwKGzqWCZ2n5/cTu97kQ/c3fJL1o1rcekcaV4T/ERlUuT4mINsfzXpngJSF5bG
         O4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/CpZb7ndIc4uJklRh3E2E3FxIA3evq19i2HXND3IGGM=;
        b=6ALaw4+b28H/VH8f29olexWQiY5M6fDjequgviQzdKG3Ja39U+k4Px4bQhAuHmcCmt
         uBn/Lzrfj3f/Fr5toL3E0ZBcyLLQstSmseV13Nuynfs/6v4XDH2YGBXalwJNMM4K5B7i
         foCia0loxneUfQbcmeO3ap2VKy/5lczQsC0Vb/kDdanaozsArNTlKgguy3/5Md/oTbGF
         9gsXYgO2JfzQ+9TfeCLQ62xBqp69kdCgL7iQUk3Pz5Qeaqm0sAz8qyiadhgwuhs58rZo
         Y1ZXGxhwjM0pPgerPoaAVgnz5EHnrzihVx61nSFq9CrsWlbKcYVdU7LTecv9oqywuDkd
         4tzQ==
X-Gm-Message-State: AOAM533MJWgBYz7e9WFcadbTmNQbYfuPKJ0p9MCrLG9+ayJymC0Od4ye
	8c8K26PWzfKRJKzag0lFLS2+SgSBG/sFqKGvzz0=
X-Google-Smtp-Source: ABdhPJwn1AU5H30RtqOr1eEKJRqZ/2BWjSzr83c7iU7JLwiXoTWyLrGA562VPTJ7mtv5W41hOYry7ewwGYRMp/vHOAc=
X-Received: by 2002:a05:6e02:1b82:b0:2cf:199f:3b4b with SMTP id
 h2-20020a056e021b8200b002cf199f3b4bmr2135689ili.71.1651876086469; Fri, 06 May
 2022 15:28:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220502211235.142250-1-mathew.j.martineau@linux.intel.com>
 <20220502211235.142250-7-mathew.j.martineau@linux.intel.com> <108060a1-8e8c-6d2b-a3a0-a18dab3e409b@linux.intel.com>
In-Reply-To: <108060a1-8e8c-6d2b-a3a0-a18dab3e409b@linux.intel.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 6 May 2022 15:27:55 -0700
Message-ID: <CAEf4BzbqfV1FySVu69-am6hz2ykPWXspqyFV8eG_Gapwp0kUqw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 6/8] selftests: bpf: verify token of struct mptcp_sock
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Geliang Tang <geliang.tang@suse.com>, Alexei Starovoitov <ast@kernel.org>, mptcp@lists.linux.dev, 
	Matthieu Baerts <matthieu.baerts@tessares.net>
Content-Type: text/plain; charset="UTF-8"

On Mon, May 2, 2022 at 3:14 PM Mat Martineau
<mathew.j.martineau@linux.intel.com> wrote:
>
> On Mon, 2 May 2022, Mat Martineau wrote:
>
> > From: Geliang Tang <geliang.tang@suse.com>
> >
> > This patch verifies the struct member token of struct mptcp_sock. Add a
> > new function get_msk_token() to parse the msk token from the output of
> > the command 'ip mptcp monitor', and verify it in verify_msk().
> >
>
> Daniel, Andrii,
>
> The z15 CI build failed on this commit, not due to any endianness issue
> but because it appears the z15 CI VM has an older iproute2 version (5.5.0)
> than the x86_64 VM (where the build succeeded).
>
> Do you need us (MPTCP) to change anything?
>

I'll defer to Ilya (cc'ed).

> Thanks!
>
> > Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> > ---
> > .../testing/selftests/bpf/bpf_mptcp_helpers.h |  1 +
> > .../testing/selftests/bpf/prog_tests/mptcp.c  | 66 +++++++++++++++++++
> > .../testing/selftests/bpf/progs/mptcp_sock.c  |  5 ++
> > 3 files changed, 72 insertions(+)
>
> --
> Mat Martineau
> Intel

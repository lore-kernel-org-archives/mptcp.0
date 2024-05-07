Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5CB320F
	for <mptcp@lists.linux.dev>; Tue,  7 May 2024 20:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715115123; cv=none; b=aLpFq1gkCKEbhuVB8tEFBwveU40yUPKSVWA/mon29sO7tDGHqquKfiwVLkK1tduE0H9sCQ1Vb+I02c7Z0t9yQMRtIb5GLk6SHsdOOlO7xr6U2aTOeITg0Enm2Hq1f8UyOxnrU6Pjzn9UztdiqY7gp+DmyKhnVISrbhdraNBHIvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715115123; c=relaxed/simple;
	bh=b8UZ2RsJ1KvRwNE/4/qun7NqMNi9/Ak7SZwXxlqtD5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FtIPxpgeA1DmarBsy5xRcs+ULREf3XddA/U5qAotQTozDCK9XQFYboY3gd42olLQ+jQug7SYbLR0EqoZXVl1ZpVlhpfNpTuGxuh6uFsjVnShjmeZvIwnOSTdsHqro5yckgecK0pvAwKlgD/elhtM4YmT1iQ5pq94A+ZkzX3F9+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fB4M1Z+d; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fB4M1Z+d"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41b5e74fa83so27746465e9.0
        for <mptcp@lists.linux.dev>; Tue, 07 May 2024 13:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715115120; x=1715719920; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdcR2a16esVT3UB13Wto/4zRmwQIrll7yYTlz1PQXa8=;
        b=fB4M1Z+d1p5Afv4UvYPxiRAiPn8imCbGwn0IkMNjAJRKmg76KHBEhpWJo76L1ae+sw
         ssvCfyjfwyFJ24pIi+Ulv00e5Homeo1sDEj26UbrPc/+JXrCF5mkYwqmgum8nv9ey4V7
         nQOawvOHY31fG9ApZMRKPKBzlmN4ZzKOKTRwBeufPVI2s0sieWaJPbEBi2zHtu0d+3Dj
         UrxIl05uoKV0kDjLK65Ouc1q1NTs4Qdokw3HfykrrzRwwP12bI7DHpy4mrpxm1YQUVpR
         /FgHEVybhV3jd9aGz6+zU2b9ezM5kFoqoltuoAv+CEKT4ruVfNs7B2WJbiK0VWmsqEY2
         Sfmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715115120; x=1715719920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qdcR2a16esVT3UB13Wto/4zRmwQIrll7yYTlz1PQXa8=;
        b=aUOwTEp9uU/Mpe7h76L6t0NSB7NZLm9VFnL3GSMtzqxUwhwASEj+p5e1N04r2Mz1Y8
         WIhNCYq0soEuk/ANwUWuy26SRPJEljeQY+bNXXuUpg0C8bs0+feL4etQ1yEBxfLqMAWb
         Mec3sdRSVtUMPxTRwnMLe2DD6G14uWYPoOwCRYZxc0Wkbc3lQlpjNrsK2INDrqsY0Itp
         puwJ2rpa8XZqs2gGy4FoUhmuBbh/oxG/teV/AUOdnvYOAsGDhU4JnTybRzDgIm+01SWH
         JEmZxs4kIQu7wYIqf3TXKENKhe8uxcO7pi1qeHDlwsWjICi58hp8+0nIl7GV/DMomZj2
         gbWw==
X-Gm-Message-State: AOJu0YxOvkpLYrhuZmWrTidBBLG8LZmZPBozCkgVbvDxsrrJ/jfFmCiz
	CsifrDuXsdYsS3hhfDztj46jTkRy62RVHc9xvatves7vuJzRQY0reJhpyNH9tics+jd2HP+k+UX
	ZY7mT+dRC2cPkgqvGO/+u7b8GjTQ=
X-Google-Smtp-Source: AGHT+IEupALi3YmwRAFNO89hfoLq5x2UZOxByq4dlLEg5tUq6l7C9/2mHmwsQr3MawIVxEWxb4cV0A1MmIur9qWOZgc=
X-Received: by 2002:a5d:6e55:0:b0:34a:3f3d:bb14 with SMTP id
 ffacd0b85a97d-34fca242709mr600329f8f.27.1715115119939; Tue, 07 May 2024
 13:51:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240507-upstream-bpf-next-20240506-mptcp-subflow-test-v1-0-e2bcbdf49857@kernel.org>
 <20240507-upstream-bpf-next-20240506-mptcp-subflow-test-v1-2-e2bcbdf49857@kernel.org>
 <CAADnVQJ5-APFxMeGsUDSWBsiAbhJGivs=fBUapgYEFNHgnEVeA@mail.gmail.com> <d28dec16-9029-42f5-b979-a0f11656a991@kernel.org>
In-Reply-To: <d28dec16-9029-42f5-b979-a0f11656a991@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 7 May 2024 13:51:48 -0700
Message-ID: <CAADnVQJM73g9gTq3GxR-RMmpJPK3DGgzUTQiJXjz_B1G_4JAAw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] selftests/bpf: Add RUN_MPTCP_TEST macro
To: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Geliang Tang <tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 9:02=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org>=
 wrote:
>
> Hi Alexei,
>
> Thank you for the review!
>
> On 07/05/2024 16:44, Alexei Starovoitov wrote:
> > On Tue, May 7, 2024 at 3:53=E2=80=AFAM Matthieu Baerts (NGI0)
> > <matttbe@kernel.org> wrote:
> >>
> >> From: Geliang Tang <tanggeliang@kylinos.cn>
> >>
> >> Each MPTCP subtest tests test__start_subtest(suffix), then invokes
> >> test_suffix(). It makes sense to add a new macro RUN_MPTCP_TEST to
> >> simpolify the code.
> >>
> >> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> >> Reviewed-by: Mat Martineau <martineau@kernel.org>
> >> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> >> ---
> >>  tools/testing/selftests/bpf/prog_tests/mptcp.c | 12 ++++++++----
> >>  1 file changed, 8 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/te=
sting/selftests/bpf/prog_tests/mptcp.c
> >> index baf976a7a1dd..9d1b255bb654 100644
> >> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> >> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> >> @@ -347,10 +347,14 @@ static void test_mptcpify(void)
> >>         close(cgroup_fd);
> >>  }
> >>
> >> +#define RUN_MPTCP_TEST(suffix)                                 \
> >> +do {                                                           \
> >> +       if (test__start_subtest(#suffix))                       \
> >> +               test_##suffix();                                \
> >> +} while (0)
> >
> > Please no.
> > Don't hide it behind macros.
>
> I understand, I'm personally not a big fan of hiding code being a macro
> too. This one saves only one line. Geliang added a few more tests in our
> tree [1], for a total of 9, so that's only saving 9 lines.
>
> Related to that, if you don't mind, Geliang also added another macro --
> MPTCP_SCHED_TEST -- for tests that are currently only in our tree [2]
> (not ready yet). We asked him to reduce the size of this macro to the
> minimum. We accepted it because it removed quite a lot of similar code
> with very small differences [3]. Do you think we should revert this
> modification too?

Yeah. Pls don't hide such things in macros.
Refactor into helper function in normal C.

But, what do you mean "in your tree" ?
That's your development tree and you plan to send all that
properly as patches to bpf-next someday?

>
> [1]
> https://github.com/multipath-tcp/mptcp_net-next/blob/4369d9cbd752e166961a=
c0db7f85886111606301/tools/testing/selftests/bpf/prog_tests/mptcp.c#L578-L5=
95
>
> [2]
> https://github.com/multipath-tcp/mptcp_net-next/blob/4369d9cbd752e166961a=
c0db7f85886111606301/tools/testing/selftests/bpf/prog_tests/mptcp.c#L559-L5=
76
>
> [3]
> https://lore.kernel.org/mptcp/cover.1713321357.git.tanggeliang@kylinos.cn=
/T/#m0b9c14f1cbae8653c6fd119f6b71d1797961d6ba
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>

Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D6815F32E
	for <mptcp@lists.linux.dev>; Tue,  7 May 2024 14:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715093063; cv=none; b=pHnuxGI0jO9BFhgomA6JuvoqQEmJwHBkK5BVAwFx4sLYo6NsqKlaO+GdvS7u7Gxt8Y50u8MRa4/B/7c0nsCtRCPeCzKd73ZF80hEph+H7EVTsPknFvXBsSFdPxSmeaN06kShahgpFsIdK67ppcdHGHNQ8lwbOOCQ0HfwwDPfuAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715093063; c=relaxed/simple;
	bh=MJcYisYTisx12c9+k/4ROq+EmyGFozWAglzPDCQ8LYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pVecEbA4V35+U3kfYE3r50i33b2oJl2CIloaHXEmQ7+UhTJpQ2/s6eoIqkygyLVC6L+iaSQGGQjHjcEdSkGtvgzIX7RO8E/ke5VgLu/DGDUxnmmYVhSRgkXJseyTu+D4n+7XVtYrMnJE27i1989DpbClb18BBS3AjtXojLNM9Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSVTH6Lk; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSVTH6Lk"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-34da35cd01cso2959985f8f.2
        for <mptcp@lists.linux.dev>; Tue, 07 May 2024 07:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715093059; x=1715697859; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mMp6G35qfDMIFLx3yZQGEQxUo7Vd7yGH6r3sL6jUUss=;
        b=FSVTH6Lk6VY+vUDOAC/VIFCaGAw+wCTBFQut5tzB59nw35DVkQebNT6GuN9UsKxXtX
         F/D6eRcoH94OEJyAoeJSxuqwcdMChZaJz+9rwjh8/SvyYeCIk3PgjnLKkm3mIi74Yjzg
         94BMRZQr0sNL1iHZpulRwpAiiQZWbWn4XfqJ0JealKHxLwrYVu1mMRx50B1NRYVkeEOr
         Upz89nRypaUXvt1DpxwkpYDaiW1xcmtZ9BBQiTQ2AmkJlzTAh/j5IiC7FpgK37s6iy8y
         X26ARJiB8Z8ARZS3H1r7EsDqNYoMBvWgejILK5Omu4WmaZRe2Yah2pnrQwC7f1W0iZJ1
         9Vew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715093059; x=1715697859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mMp6G35qfDMIFLx3yZQGEQxUo7Vd7yGH6r3sL6jUUss=;
        b=IrJZF+PDJpabrbf4P0NHKbPlE6Fbd8qFD6duNxUTGeiMK0SlvurSawNIouzq0kvkt2
         hfJMa0zoA+fHpjiCa3YI6n/pFYQUSdN5f0+JBemdQJqdd4hsQk4akstZ5aGfqKCR3wLt
         cowN0wsOqCQJFAR3nkirDKKD0mBySquqYR9cxcQ5BQ9WwH6l85sW5FNaiEr20dM6ha4L
         BW3hYvNmgVT6iMDif0cGMT/ZoupzUquACl4apSIkodMrqpsA/kmJus7uzEEhoj1n7c2b
         QUj0xayLqzJ9SrjCJ52/JyrW0DBcx6OhEKWduo0kZEtU0dpLzLRceQPTUtzDuHaFheRW
         JPng==
X-Gm-Message-State: AOJu0YxNhKDmIQKXKb5msrgOznr9ilkrzf0mCCCeqQ8S0A8pf7BvFWMO
	5BLnmy4mgV34iP2jYnLDduWG7ITH3LIwwKrNYLUcw7ALlmJFkI2t6zC2byqRnlPtzVsWVNsaY0X
	MGTsdV124cYpPaab8/JVyg/0+tvI=
X-Google-Smtp-Source: AGHT+IGk49uH7ZoboBcvIRsYhD4hszb/KCw/BsklZO7vFWGZC10XurT1JgKe8yLt1pp+x1aSe9iYc42YpisLFYU8qk0=
X-Received: by 2002:a5d:434a:0:b0:34c:8cbb:d6e9 with SMTP id
 ffacd0b85a97d-34fca8116a0mr14105f8f.71.1715093059114; Tue, 07 May 2024
 07:44:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240507-upstream-bpf-next-20240506-mptcp-subflow-test-v1-0-e2bcbdf49857@kernel.org>
 <20240507-upstream-bpf-next-20240506-mptcp-subflow-test-v1-2-e2bcbdf49857@kernel.org>
In-Reply-To: <20240507-upstream-bpf-next-20240506-mptcp-subflow-test-v1-2-e2bcbdf49857@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 7 May 2024 07:44:07 -0700
Message-ID: <CAADnVQJ5-APFxMeGsUDSWBsiAbhJGivs=fBUapgYEFNHgnEVeA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] selftests/bpf: Add RUN_MPTCP_TEST macro
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
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

On Tue, May 7, 2024 at 3:53=E2=80=AFAM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> Each MPTCP subtest tests test__start_subtest(suffix), then invokes
> test_suffix(). It makes sense to add a new macro RUN_MPTCP_TEST to
> simpolify the code.
>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Reviewed-by: Mat Martineau <martineau@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  tools/testing/selftests/bpf/prog_tests/mptcp.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testi=
ng/selftests/bpf/prog_tests/mptcp.c
> index baf976a7a1dd..9d1b255bb654 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -347,10 +347,14 @@ static void test_mptcpify(void)
>         close(cgroup_fd);
>  }
>
> +#define RUN_MPTCP_TEST(suffix)                                 \
> +do {                                                           \
> +       if (test__start_subtest(#suffix))                       \
> +               test_##suffix();                                \
> +} while (0)

Please no.
Don't hide it behind macros.

>  void test_mptcp(void)
>  {
> -       if (test__start_subtest("base"))
> -               test_base();
> -       if (test__start_subtest("mptcpify"))
> -               test_mptcpify();
> +       RUN_MPTCP_TEST(base);
> +       RUN_MPTCP_TEST(mptcpify);
>  }
>
> --
> 2.43.0
>

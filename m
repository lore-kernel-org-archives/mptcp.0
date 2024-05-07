Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44ED1A947
	for <mptcp@lists.linux.dev>; Tue,  7 May 2024 14:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715093390; cv=none; b=DGKhJJqbkwaHJvAKcDoEp3ORNcCxlBvFyGhdZgGSoqgExzXwrfojxb+773TtwTGfY945WhJB9ErsUowFx686X1IZqUsl2/gbotHzQt2E4T33Adew5aP3heEkyIEcmmresk4bXjzaRjxuoATE41+hEl9p3yDdCfGPm7fE6Gy4dwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715093390; c=relaxed/simple;
	bh=xfqyY4/5grH1OWHSQBdFFIJMUsvolggHOKTUaOh1qSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R7Fm70UgjOnlMt5/4wGGC73mHhiKaXGmXHvE+MBaU/cuLcOWGeAfvYgOxp8CGtlJO4Cs+E9TkG+QP1VfliFNrRlgUUEunF7glGYmBRqp4vvQkAhL7uvA14rofscyM85O4/h0Mx6HY64p9T0bxtZqcFCgGkNw7qKAkoa8Y/vgbHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhNoe5Sx; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhNoe5Sx"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41b79451128so21979135e9.0
        for <mptcp@lists.linux.dev>; Tue, 07 May 2024 07:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715093388; x=1715698188; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnRmtUcfDdB44V0fx8MJBtpQNFlOxDchfgegz24nVno=;
        b=NhNoe5SxTNRPbtFqoPJgyAAI9eHfh1vwZd04v8bcQvBPESFcr9S3pvNrut/Xoqkqwg
         7128XywHGbFo6YC1MjUDCicAnpBfi2CK+k6fT7aeCES9FO38tNoAoeFHaUqZ67jeD2/V
         iysdDXfQduDyQjyOu7x85dF0Cwawe6LD2c11iNfoXhfbtCLniU+nD49+Mi3MxMik0isA
         v8ncJBIQSlgHBjkC17bZuryzAlc5VsIeGv1W9hjhzfh1hWSQ1jfbEqMB0ls4yjQCmatl
         uWZxJg1VfLSEKUwGJpuGItKP+2r8cSrZoVMGUo+7zcwh52ND2RdH9clEVzgTwFr68qVu
         sxiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715093388; x=1715698188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vnRmtUcfDdB44V0fx8MJBtpQNFlOxDchfgegz24nVno=;
        b=lgXvAk33xLIIPPiTUwOQfA62K2SOqkQaWR2FOnKu5kXv9iS8bieeBCr2cZZBV6A+Z8
         fsEGN9mqJUYCXHqYz1rRN05zkIBGsunx6CkKu/73cu2sY7Gy4zcPhv6VyWRdA5mPJLes
         INWVKFGLNELz4DXCSYkeZ+GXulUy0u8js0d6Vg3Ra1RjNes8oH3hB1cTEsZpyf7a+3hT
         /3/rqOMmzIuXHK9OvIhZYORc8pc9DsEjcek2ToPD6YEeptnxb7W7xm/ypwxffTSzu3gP
         CYYu81eOSSFxGzGtBPyQS6Uxqi6bXPck1TNhF2WrpkP/SH6EkqkxpCQiv3VfiUW6ENcg
         98mQ==
X-Gm-Message-State: AOJu0YxJ/hUq5jLjIrxsnuwpICjx4TGGKXl9g4gbj26lZ5MeGgCARc3k
	pjUBo1mFBN4SCA4ifuTNuZfRBB/oLZAJThY4EM5/dNUOfcraMni9cF/0BN9gUf8NWOVS67pJoP9
	c2joahsvVa9AqKuABm5k5ziHbaBc=
X-Google-Smtp-Source: AGHT+IEyDTD/I9zL2HwaweaoKMz5Lei11guDe3q1iDpWuCqeRsHJL7skp4ytlkMDTcD03FTwjW+4mqh8kqLb4UflkiI=
X-Received: by 2002:a5d:5147:0:b0:34b:81b3:2c62 with SMTP id
 ffacd0b85a97d-34fcafcce2fmr3976f8f.35.1715093387541; Tue, 07 May 2024
 07:49:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240507-upstream-bpf-next-20240506-mptcp-subflow-test-v1-0-e2bcbdf49857@kernel.org>
 <20240507-upstream-bpf-next-20240506-mptcp-subflow-test-v1-3-e2bcbdf49857@kernel.org>
In-Reply-To: <20240507-upstream-bpf-next-20240506-mptcp-subflow-test-v1-3-e2bcbdf49857@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 7 May 2024 07:49:36 -0700
Message-ID: <CAADnVQ+ADQRrZmZ_M9LLGj9u_HOo7Aeup+kid62xZfLCvSxUOQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] selftests/bpf: Add mptcp subflow example
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	Nicolas Rybowski <nicolas.rybowski@tessares.net>, Geliang Tang <tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 3:53=E2=80=AFAM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> From: Nicolas Rybowski <nicolas.rybowski@tessares.net>
>
> Move Nicolas's patch into bpf selftests directory. This example added a
> test that was adding a different mark (SO_MARK) on each subflow, and
> changing the TCP CC only on the first subflow.
>
> This example shows how it is possible to:
>
>     Identify the parent msk of an MPTCP subflow.
>     Put different sockopt for each subflow of a same MPTCP connection.
>
> Here especially, we implemented two different behaviours:
>
>     A socket mark (SOL_SOCKET SO_MARK) is put on each subflow of a same
>     MPTCP connection. The order of creation of the current subflow define=
s
>     its mark.

> The TCP CC algorithm of the very first subflow of an MPTCP
>     connection is set to "reno".

why?
What does it test?
That bpf_setsockopt() can actually do it?
But the next patch doesn't check that it's reno.

It looks to me that dropping this "set to reno" part
won't change the purpose of the rest of selftest.

pw-bot: cr

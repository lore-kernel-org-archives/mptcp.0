Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5946B20315
	for <mptcp@lists.linux.dev>; Tue,  7 May 2024 20:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715115298; cv=none; b=WhhsW8qReU+FUZhqkV1mX+Fdi93TAWgilfgy3sEVEQSj9iIJxvzzfqreL7K8/ywYqCrzy31KSjz7AQiDDmqZDvXHzyf+x8Lwn02PJJUCCThkFMYDq4CgHGqcn8zI1NFOOZHnbkG2R1IEB9obMPZeKCTZUhN1wBlsmjtcShz4shE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715115298; c=relaxed/simple;
	bh=cAKfbhhQ0Y5jBdfh2NiEcm1JrkpS5yL1MIDSPy8wRcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fvXwGezSxMbNDkBmM7iPVJ9paFAVF10/hRoFUFJZf22XPn17HW4JPGyvMAlzivJ2WyuLUwEpsybXaSpdlKDaKK/WZyPTi7xtInbWwHim+rPVn2rbcpkKxlmPOUTTbGUpwGr30Ohnlo9R9+cA+hlevw9w/tb9bWRHluD9mV4Na88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjrEfUMy; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjrEfUMy"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-34d96054375so2206225f8f.2
        for <mptcp@lists.linux.dev>; Tue, 07 May 2024 13:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715115295; x=1715720095; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MRBMHAIqydmnvRNILnVciTFpbX1I1b05QddPgDfHrK8=;
        b=kjrEfUMyIkTkLspYFeLGkR/OVk4viZ2vAFK/Xq02RZUR8eFNFUILx3bMMP9owsRbwB
         UwTXggMszV41GWlN3LNzcE+yPlPGFq2KozbFKzgXCM0ZO3TVqCw7ctE8YNeINwv0YGd8
         xKekm+B1JrfvpkT+RKDJKd9rV3+vWWwIDARCkbvw19hsCNhrbR6MVnWNFsRbKmGenoKt
         s+6eriWxjgHzS2+TcaShQXLaApf6MqI5vItZhqqZgHsV/VmSImstpMMKmYnKQfHyMXgx
         1Ul5zG8BSbLYYoY+7vbkLMnffsnpYSv7HDo/zQuTnFtAWGINrCk9KnQ+MSbvP/eitsC7
         LSiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715115295; x=1715720095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MRBMHAIqydmnvRNILnVciTFpbX1I1b05QddPgDfHrK8=;
        b=eTyb6/n7ijH+9UHQKK3O8xooVjW3i2uxSmZtp1lYIbK9Z5r0JmhNzFB6nt1m38UG9i
         xdXwbNsjg7W2Nd6pfY+/xYHlBGYjXNy7p++HMoNV6JRRUz+Gyuwb5N9UEFufpmNfJGS1
         lMQ12YMzJWg3vAD9ogLcI0kgpREn03M2rGmXKFDy9CnT7kA4VBFYLP2lFEyH7C5OgQHl
         uF2YfR1wG5QPMFredGD50pcMVKRzzSpG8Obp0uxWF+blzR2jhqO5xUXMgwO9bfx+wGdf
         s0yfCV7EpXZwdFYAJLuL8VQexn6QSmAqVeWSbLjNxvIyC5xT/6pKdZhOeTMalD3JhBm5
         gB5g==
X-Gm-Message-State: AOJu0Yxok9u9bnR+SOghruPVNJJO5ej60GLnBAM34Mt3PjRYdomvuRy5
	eKgQyLUYM3q9rTbcogK7APvtSN+DtafoRgz7VS13z9enSMJPa1RCKycIS1b8R/HpcrdjA+VwP31
	bBfXIrdBHcC7qL98w/TKwip8QVnCjljMM
X-Google-Smtp-Source: AGHT+IE52tKX9im4lf8ezaDOOo3F3Pcz8ocEU7R0wHR1s8GzZ3ATxcqKKY3Q4tN3pKTGM3M7EeQ97g4fY8Ejam/i8No=
X-Received: by 2002:adf:a492:0:b0:343:a368:f792 with SMTP id
 ffacd0b85a97d-34fca621315mr604788f8f.52.1715115294492; Tue, 07 May 2024
 13:54:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240507-upstream-bpf-next-20240506-mptcp-subflow-test-v1-0-e2bcbdf49857@kernel.org>
 <20240507-upstream-bpf-next-20240506-mptcp-subflow-test-v1-3-e2bcbdf49857@kernel.org>
 <CAADnVQ+ADQRrZmZ_M9LLGj9u_HOo7Aeup+kid62xZfLCvSxUOQ@mail.gmail.com> <843ea6eb-a28d-437c-9c98-0b8c8816c518@kernel.org>
In-Reply-To: <843ea6eb-a28d-437c-9c98-0b8c8816c518@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 7 May 2024 13:54:43 -0700
Message-ID: <CAADnVQLA+2uoJJAJNFoK-EnUjLAwxJjxOXAizLWhcx4mf+C2Vg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] selftests/bpf: Add mptcp subflow example
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

On Tue, May 7, 2024 at 9:03=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org>=
 wrote:
>
> Hi Alexei,
>
> Thank you for the review!
>
> On 07/05/2024 16:49, Alexei Starovoitov wrote:
> > On Tue, May 7, 2024 at 3:53=E2=80=AFAM Matthieu Baerts (NGI0)
> > <matttbe@kernel.org> wrote:
> >>
> >> From: Nicolas Rybowski <nicolas.rybowski@tessares.net>
> >>
> >> Move Nicolas's patch into bpf selftests directory. This example added =
a
> >> test that was adding a different mark (SO_MARK) on each subflow, and
> >> changing the TCP CC only on the first subflow.
> >>
> >> This example shows how it is possible to:
> >>
> >>     Identify the parent msk of an MPTCP subflow.
> >>     Put different sockopt for each subflow of a same MPTCP connection.
> >>
> >> Here especially, we implemented two different behaviours:
> >>
> >>     A socket mark (SOL_SOCKET SO_MARK) is put on each subflow of a sam=
e
> >>     MPTCP connection. The order of creation of the current subflow def=
ines
> >>     its mark.
> >
> >> The TCP CC algorithm of the very first subflow of an MPTCP
> >>     connection is set to "reno".
> >
> > why?
> > What does it test?
> > That bpf_setsockopt() can actually do it?
>
> Correct.
>
> Here is a bit of context: from the userspace, an application can do a
> setsockopt() on an MPTCP socket, and typically the same value will be
> set on all subflows (paths). If someone wants to have different values
> per subflow, the recommanded way is to use BPF.
>
> We can indeed restrict this test to changing the MARK only. I think the
> CC has been modified just not to check one thing, but also to change
> something at the TCP level, because it is managed differently on MPTCP
> side -- but only when the userspace set something, or when new subflows
> are created. The result of this operation is easy to check with 'ss',
> and it was to show an exemple where this is set only on one subflow.
>
> > But the next patch doesn't check that it's reno.
>
> No, I think it is checked: 'reno' is not hardcoded, but 'skel->data->cc'
> is used instead:
>
>   run_subflow(skel->data->cc);
>
> > It looks to me that dropping this "set to reno" part
> > won't change the purpose of the rest of selftest.
>
> Yes, up to you. If you still think it is better without it, we can
> remove the modification of the CC in patch 3/4, and the validation in
> patch 4/4.

The concern with picking reno is extra deps to CI and every developer.
Currently in selftests/bpf/config we do:
CONFIG_TCP_CONG_DCTCP=3Dy
CONFIG_TCP_CONG_BBR=3Dy

I'd like to avoid adding reno there as well.
Will bpf_setsockopt("dctcp") work?

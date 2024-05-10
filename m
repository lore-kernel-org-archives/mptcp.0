Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C55912CD81
	for <mptcp@lists.linux.dev>; Fri, 10 May 2024 14:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715349974; cv=none; b=QT1zqWpf9ZIekywdVtHt/IgoBtqrY+Rd5y6zt6DeV+xI8VvaZ81N0p8Al9ZBd/HVjBxS42HIHAn9yWp3KXlsjp9c5r12i8iEk3RRlV1SuWLh9GIxqEd0a4Hg1Omt2VKy+GytYhrK4Epqb8xELBNQktUuuIjv1RjQj1ZS+fTnhgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715349974; c=relaxed/simple;
	bh=bijg8uhnWEQekQWJ9OWl+WHmxr8G6KdwdXn7ukNViuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A03OtflCeZa4H9xh5sCwekHA58YAbk823XF0HWykx7QNEiCbPxQyN2BzfZ3Vy1JcDBz6Z6guhaJf9GikdFHsm8JiShVrPx31KgwqE7zWybqroJ9ivxtbCqBur6a265yavkdUGti2hpzDjx5VcfSxJ1J95jADrSfu0Ca/xpbaZwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWtzJVL5; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWtzJVL5"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41ff5e3dc3bso4400875e9.1
        for <mptcp@lists.linux.dev>; Fri, 10 May 2024 07:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715349971; x=1715954771; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KtoGz6jfy1lPdHNSbF50tppsBzL53WmOBF6+e6OvgdI=;
        b=TWtzJVL5w52/aMrDD8Thm5spam4/H1gVWveYr9zPg/IkOccIsCmIbRvmzf2xAItPEk
         uwxedlLs07qt7rZdgc3MdT2Ews4c6ip+rtJsO7vdofP8Cq1DcsTPMpuwiqtzCFJm6IkE
         ks7hCw2ffFSye8GwuwkBHXgta/gPhII8JEZh/wRqaVdhPvJrHhuM9sE7BwI5NYD+iJkC
         uryCq7pp8W5ryeGTz2kRr7ka8ZoOoEMZAtB3XljvSMHvnY9maGA6VJk1WqL7Ku8pZIFL
         j7L+LLdqm7FbbbASBlf3d4Dlq/Se83BjqmRpaV219HFZsMEaFlQgb63P+PmS3MEGlfkk
         WYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715349971; x=1715954771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KtoGz6jfy1lPdHNSbF50tppsBzL53WmOBF6+e6OvgdI=;
        b=V4tIABs1HiQpo3nWvJ4PO6jCHJMuNLJnTfWrCt9fOR3VLFey9+oG2rwsB1sPhtJtcA
         x5lAaX3WgLejbyxNRUYnDUfiYmGAarcqKXeFHV7/eWSr6ElnJ4k2gjM1qOvKnV1CHpu1
         BQBO8r6rKoWVYVcTbKcPYxSt0/HvuedPsT3uNqJNb2BFpjsi909dvVPvmwB6umX1odS4
         pmzXO8tm84y/RFKy9Tog9chi67izMFGvCcz/OTDOZ7H69257O5ZWuqNNx2Ch453GfEQe
         Ofa9oWQCQ6cWE1V1WbVjgjcXvgo2EEkhNkGmz/TKJL5/yIYAEUVAlBJuye0mNQtL6vVK
         WHDQ==
X-Gm-Message-State: AOJu0Yzzm5vJArai0KpHW1OdZt7xFOA/YNt1IWrPFyBoWihcoXFzP+7b
	gA5lO9Cgw1lX6qWFH35ob4mCCm9mW7p08qwc9R4cda19H5amzuTLwEIjpW0EfqXo1DMa8YIVlMj
	56eV5l+dsFuNTzkE8KcJkhTCnDyA=
X-Google-Smtp-Source: AGHT+IEw0fZBaki+GPAhG2zc2JHOEQAQx5c4LqBi9+08YsH3bkf+8FlSjd6bJTK1i+3cGr8XCGXUcZPKfXAoGkabQfg=
X-Received: by 2002:a5d:4910:0:b0:34b:d659:7d0f with SMTP id
 ffacd0b85a97d-3504a731d39mr1927718f8f.16.1715349970455; Fri, 10 May 2024
 07:06:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240509-upstream-bpf-next-20240506-mptcp-subflow-test-v2-0-4048c2948665@kernel.org>
 <20240509-upstream-bpf-next-20240506-mptcp-subflow-test-v2-2-4048c2948665@kernel.org>
 <daf7ed61-e09b-439b-9cdd-b6d9aa003e27@kernel.org>
In-Reply-To: <daf7ed61-e09b-439b-9cdd-b6d9aa003e27@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 10 May 2024 07:05:58 -0700
Message-ID: <CAADnVQ+Tp8+Hhy__=uevSZsEetsWYommjhC9SqSfKEeBu51cKA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add mptcp subflow subtest
To: Matthieu Baerts <matttbe@kernel.org>, Manu Bretelle <chantra@meta.com>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Geliang Tang <tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 11:31=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hello,
>
> On 09/05/2024 17:49, Matthieu Baerts (NGI0) wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> >
> > This patch adds a subtest named test_subflow to load and verify the new=
ly
> > added mptcp subflow example in test_mptcp. Add a helper endpoint_init()
> > to add a new subflow endpoint. Add another helper ss_search() to verify=
 the
> > fwmark and congestion values set by mptcp_subflow prog using setsockopt=
s.
> >
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/76
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > Reviewed-by: Mat Martineau <martineau@kernel.org>
> > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/prog_tests/mptcp.c | 109 +++++++++++++++++=
++++++++
> >  1 file changed, 109 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/tes=
ting/selftests/bpf/prog_tests/mptcp.c
> > index 274d2e033e39..6039b0ff3801 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
>
> (...)
>
> > @@ -340,10 +344,115 @@ static void test_mptcpify(void)
> >       close(cgroup_fd);
> >  }
> >
> > +static int endpoint_init(char *flags)
> > +{
> > +     SYS(fail, "ip -net %s link add veth1 type veth peer name veth2", =
NS_TEST);
> > +     SYS(fail, "ip -net %s addr add %s/24 dev veth1", NS_TEST, ADDR_1)=
;
> > +     SYS(fail, "ip -net %s link set dev veth1 up", NS_TEST);
> > +     SYS(fail, "ip -net %s addr add %s/24 dev veth2", NS_TEST, ADDR_2)=
;
> > +     SYS(fail, "ip -net %s link set dev veth2 up", NS_TEST);
> > +     SYS(fail, "ip -net %s mptcp endpoint add %s %s", NS_TEST, ADDR_2,=
 flags);
>
> I just noticed that this command is failing on the BPF CI:
>
>   https://github.com/kernel-patches/bpf/actions/runs/9020020315?pr=3D7009
>
> Is it possible that an old version of IPRoute2 is installed?
> 'ip mptcp' is supported since v5.8.0 (from 2020).
>
> It looks like Ubuntu Focal 20.04 is being used, which has the v5.5.0. Do
> we then need to find another way to set the MPTCP endpoints?


Manu, any idea?

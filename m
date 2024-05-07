Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2F315098D
	for <mptcp@lists.linux.dev>; Tue,  7 May 2024 14:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715093033; cv=none; b=ZPX0DCLjq9e3ySSX7hXN8G4Z2+m2rSDug/8QC+Nq5JvSlNRi1E43TNhDa+wSMWq1VHr/cNmujyIwdd0yfRvsBiiHYKITdCpJLxjWkuTvKmjDDFz9vnjUoY/2UmHtA50aPcrI3qPQsyz+YHsdwk9JiK8vFRRM1T5t4AZvnbhpW2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715093033; c=relaxed/simple;
	bh=cVK00FVDWLzEDng1ImuaW8RdJLe7pFz6qhNng9TB52w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hsmL83J9qgyQqpqU51kIwEACkBRThBQbwZCtjrzmv1tlnEIxoenJgQMZ8KWdOiEPQuxS5frcK23Wn/VRHJy0v2dneYWTv9wrvlQvKydrk/k0VKL0HyNIAnP9/F5FmMpAY3K30PqlUY+1XZYbAVokhfDIKPpteFYjYNa3HARI6jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZiEuP7l; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZiEuP7l"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-34d7a32bdd3so1603606f8f.0
        for <mptcp@lists.linux.dev>; Tue, 07 May 2024 07:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715093030; x=1715697830; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8bM5RjluxHipg60pIjQCs1Kdq4Li1XFga7CcO2QMKNA=;
        b=EZiEuP7li4b/8+hTWc3C85ydQcQgNu0fox4SLaRg7vfr5TxD9vIPabWaI+esJQ4ucx
         7WgUclJC8YF2AXo+xQvoET/QKcqhIUisEJv7aQuJxfkDqA0sGw3ZRURWS5Ghjw6kF/Lb
         nkojG2qwWHPA5U01XmnvU0zJ4+V3HfXHHAMcrJqyXWstYKxTJ8YJmes3qXhEnuQFhrfE
         7PRQr5Hu5kW8zhqpsLv7e5CxUxzBWlpYde2557zTSZMjBwC+NRMGL2r2AM7VFv+si8iS
         Hr0Dbz87gdJq64rFSfpxqlArgvS9RwkCyI3MkoVH0TQ3DP8FKQSR7QdRPWfFCFJ+a98P
         2OPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715093030; x=1715697830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8bM5RjluxHipg60pIjQCs1Kdq4Li1XFga7CcO2QMKNA=;
        b=l6c5YuykRcS3LlfqGxSbA1+c391xpSmY0e8lQCeFA0H2KEVDLiESSCpA6ewMl29UN8
         xcEkFwkyORVeFO+PeRZ0YpgQ34gmja6z7eEFz8n1eJ5jw1lxKXB4LwnlbxA9YJXXwle6
         bGv/VAEOl5Vcl9WYSKjTXz5+usRwny3ALL3sNXnji+Q9trgRX3jRce7CZQFe2mQlL5mb
         xhcEBn+/+Ays69lbksP5xSTckypCuxbgCeJVzDjN7qyD6ovunAO1MFuv+qHO1f5Yq3+N
         byBhQmu23CRMfSB+uDjObp9+aj48LzP0PLWJkWTgXKutAzMoMNydtuCUdMpW5ZML4Y2b
         notg==
X-Gm-Message-State: AOJu0Yw9Fv31QSYOjhm0ghpsrBZ6O71tY5GTmr6cFl3ET2a4+mRF2qsg
	p6pr/WhYE/81uMVeKcxNBO3yh6a5e59wvWF3VPmeZuU/SD2hKqqaHbCih32sGQvfxtjaU0AM5BI
	hPirUK5NMCk7cAxXpCTceDN8TbZY=
X-Google-Smtp-Source: AGHT+IGohbKdu5N5Ex+4EkZMkPfNXVJa4QuvuOwWy2p6XWZL9RHKYD+h27FqkUdbOj4eiHLrpqiOUEpbKJrSf/ZV38w=
X-Received: by 2002:a5d:42d2:0:b0:34a:56e7:5cc4 with SMTP id
 ffacd0b85a97d-34fca14b3bamr36578f8f.2.1715093030024; Tue, 07 May 2024
 07:43:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240507-upstream-bpf-next-20240506-mptcp-subflow-test-v1-0-e2bcbdf49857@kernel.org>
 <20240507-upstream-bpf-next-20240506-mptcp-subflow-test-v1-1-e2bcbdf49857@kernel.org>
In-Reply-To: <20240507-upstream-bpf-next-20240506-mptcp-subflow-test-v1-1-e2bcbdf49857@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 7 May 2024 07:43:39 -0700
Message-ID: <CAADnVQKWCVfUhQnoYBoEZaZbfiX8MROcj7Ct-nB4-axhZqMecw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/4] selftests/bpf: Handle SIGINT when creating netns
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
> It's necessary to delete netns during the MPTCP bpf tests interrupt,
> otherwise the next tests run will fail due to unable to create netns.
>
> This patch adds a new SIGINT handle sig_int, and deletes NS_TEST in it.
>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Reviewed-by: Mat Martineau <martineau@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  tools/testing/selftests/bpf/prog_tests/mptcp.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testi=
ng/selftests/bpf/prog_tests/mptcp.c
> index 274d2e033e39..baf976a7a1dd 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -64,11 +64,18 @@ struct mptcp_storage {
>         char ca_name[TCP_CA_NAME_MAX];
>  };
>
> +static void sig_int(int sig)
> +{
> +       signal(sig, SIG_IGN);
> +       SYS_NOFAIL("ip netns del %s", NS_TEST);
> +}
> +
>  static struct nstoken *create_netns(void)
>  {
>         SYS(fail, "ip netns add %s", NS_TEST);
>         SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
>
> +       signal(SIGINT, sig_int);
>         return open_netns(NS_TEST);

That's a drop in the bucket.
ctrl-c of test_progs doesn't really work.
Such clean up needs to be generic as part of network_helpers.c

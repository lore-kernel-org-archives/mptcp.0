Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EAE28F1
	for <mptcp@lists.linux.dev>; Wed,  8 May 2024 14:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715178773; cv=none; b=hA91jlZHegfUbzXjjKAxI7s1r0UcxYcham/lqRp/5E66ENzwl4W+gDlzrO4zgX0NoDPih9KitgNBw3FxSymVGzRmjJmBDQruFC9bQiCwpn3tz3/5DRdO6ApNB5AnZAm4Ej77Y+IesOc1hdPVefuo6Ivqg1IHPwUG864o057XCZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715178773; c=relaxed/simple;
	bh=HVuSNV30ElxcT1+wSpbmK0uLVc4u+3qE7HNXqWCBkzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J+zI+FONMuxB1y2bN2+OCLI087zFW8yT7UOxK2+UUH5VBXlpWfBMpib4yY5dgeal7ZsMqwOBC56kDA+OCNl+aoSDChNStU4wEb/ZAhjDBCmKZwCU+Jw1258CLiHmii9xLPWelU5yLmxKQ8SaFyMoMldrzAL9aMOmHlaAdbYL03M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hgp4z2ww; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hgp4z2ww"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-34e7a35d5d4so3343274f8f.2
        for <mptcp@lists.linux.dev>; Wed, 08 May 2024 07:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715178770; x=1715783570; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVuSNV30ElxcT1+wSpbmK0uLVc4u+3qE7HNXqWCBkzE=;
        b=Hgp4z2wwasHawOvBITB0XkKC5fzlQpQn2YE+u3FcqmcjI3zC7jyTQOi5YmIgJ1M4Li
         d9WHvznuF8SHc/3usxoqm5ipjxkl3oodBv4y7BgNOF2MCB+lWufjDYF2YaccjCRw4YIp
         M2gMC4Dt7lsZ5mumKMBfrCjOldGuvyJZXipdpwtGwcAkbI9X7f+Q/FBbmCuMYoilfoMs
         XoSFZFfi47pI73S3RZS4S3pmXAJULWraxAk++wmb+tQ+5/CGe0a266JJTsdqGmBdfIn+
         xvkaivTKuKYek3eCPtfN/ypB7C9wwatAFw/RFGExAIq4SwtnFU912JzJxSHeO1J2C4gd
         e0sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715178770; x=1715783570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HVuSNV30ElxcT1+wSpbmK0uLVc4u+3qE7HNXqWCBkzE=;
        b=D3RS6Ux0mOoR8adpkjV8eV9w6nC+FdOop0bcH8EKr8lmCOkA6Lqtw/ydXJYxVfOddK
         fKNIf0bilbc0KaAW6smODr+OBtiwCR1OGa6ioY/yeNxQJd2vy/EYRPhMuknFWJD23D+1
         2ditYDc1eG59pTwm0TgvkM4mVvH9dQ6nu5FVqqrJeMztVCg4zhEf+MIE4B0PzxOtmH9s
         FFu+eINq/qblElaMVYBlSAOvnurSWLvuBCqc5tH3bmQlYPRNJrcgAS8m+Epo8z2xikKl
         96WaPy9YIkoVW4EGXMkTixdgAAV7BI/e+XXJ20zMZ/lySylUxPAcRfEc8VrIRspmSIpx
         nQXA==
X-Gm-Message-State: AOJu0YxhA5Ss+lPyQNQV02H+kw3ppJmVRBe05bWYNkSs8m8HFyoqIpWu
	pbZQYFbCIp/n25tRU6d8+KjnJvb5VRBTyijX1DrxAnnMNWCOYSgQn6JeJwRB3H8N6tJt4niJ6qg
	b3KltOe97Mc5uww0cHEvSHPgc+bo=
X-Google-Smtp-Source: AGHT+IGIQzT0RrKC7x0GqEWEZhRSqTUdJnPjGul2tjjJI1pgCNj6AAR9flqehUHmkOSFJCiYE/2NxHIW09V4wGkEHx0=
X-Received: by 2002:adf:b1d1:0:b0:34e:21cd:dbed with SMTP id
 ffacd0b85a97d-34fca14b28fmr2461061f8f.14.1715178769627; Wed, 08 May 2024
 07:32:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240507-upstream-bpf-next-20240506-mptcp-subflow-test-v1-0-e2bcbdf49857@kernel.org>
 <20240507-upstream-bpf-next-20240506-mptcp-subflow-test-v1-3-e2bcbdf49857@kernel.org>
 <CAADnVQ+ADQRrZmZ_M9LLGj9u_HOo7Aeup+kid62xZfLCvSxUOQ@mail.gmail.com>
 <843ea6eb-a28d-437c-9c98-0b8c8816c518@kernel.org> <CAADnVQLA+2uoJJAJNFoK-EnUjLAwxJjxOXAizLWhcx4mf+C2Vg@mail.gmail.com>
 <42d0718f-296d-48ca-a21a-b4708e9bd6e9@kernel.org>
In-Reply-To: <42d0718f-296d-48ca-a21a-b4708e9bd6e9@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 8 May 2024 07:32:38 -0700
Message-ID: <CAADnVQL4z=LcJW7iD246Tc+TB-Ast-eYHA9DaN9q6dgQ_Z97Wg@mail.gmail.com>
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

On Wed, May 8, 2024 at 12:36=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> >
> > The concern with picking reno is extra deps to CI and every developer.
> > Currently in selftests/bpf/config we do:
> > CONFIG_TCP_CONG_DCTCP=3Dy
> > CONFIG_TCP_CONG_BBR=3Dy
> >
> > I'd like to avoid adding reno there as well.
> > Will bpf_setsockopt("dctcp") work?
>
> We picked Reno because this is an inlined kernel module that is always
> built: there is no kernel config to set, no extra deps. Also, it is
> usually not used as default, mostly used as fallback, so the
> verification should not be an issue.

Ahh. didn't realize that it's builtin. Then sure. keep it as reno.

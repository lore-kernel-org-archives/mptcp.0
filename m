Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659941D5CC9
	for <mptcp@lists.linux.dev>; Wed,  5 Nov 2025 16:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762360147; cv=none; b=SCaFf3XddXOQ8mnmuo15bJRDSFUJ9LtFKXQe9DxtA1muN9C9vPmh4cmEyQMP8sDdEfRrpPfnvaDWkTRRiXZuXkLTtrl5og3BeOTF3i1EEyOm8fLK1XPIxee/Mu7uzbloYpusaXJuATCKLeEL644DzABr9aynNOk44prX1FcSgUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762360147; c=relaxed/simple;
	bh=Y3esDubalrgvIM7lQbRaeJHeZfYhyTamlVhvSeykTdU=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=geapeFnl4Kl65/yTFwD+W8shkVl5qYjm4YfD/LgvS7i8qNNhYIcNk4ssUwIxzzuUQ2HrXd42qCQJ63Ti+gTlZvyewuDwCEuQGh45lq7wNhYCQTWj3Mk297125QY9jy3V9I3e+mWzLQ5ny5paUtE07t5GvYmI/7mnhKUHIQebvIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=glVWbtX5; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glVWbtX5"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-27c369f8986so201505ad.3
        for <mptcp@lists.linux.dev>; Wed, 05 Nov 2025 08:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762360145; x=1762964945; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4nU1PjlWt8geYMQt6GT0AiT1wsIJuR3sWLCn6E75oKQ=;
        b=glVWbtX5aURJLYjAjaKRqh7lI+w7RDR+flU4un2VSOcVxDLeXnX316xZYXRJ/i2ttV
         BMgyI2VnHXSyTrEDpPpOfq+mZmWU5SqSPIOA987F4D8pL9+J1KQhDEbyXdWsi0HdHHFc
         7BHCoqGT++5kBfKULzMxCYIZJjke+ZsL6zpInpEIRSniKDmFOLDA/NgrazB6ZTjfEf/+
         9Y6mZjBQmVUlwE3motP75rlKhRmKZ2UQuNwAQWtKpzCcgIAtwAp4BN2dLmcLMUnNJYu7
         J/YJU76wjD9RFByxUWdrJ+PA0QJXZv1MrnY7rLBarqIlGb0IJH/OvXSBQyaeiIPxvo5u
         r/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762360145; x=1762964945;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4nU1PjlWt8geYMQt6GT0AiT1wsIJuR3sWLCn6E75oKQ=;
        b=ZV64/+MgwphHEx+AlyaibfsgyvImzq5Dui3XHcgCHKe/wwN/RCNkwJIAf3VaJKv+nV
         13frwtPTXAxM1HMFHXwVtL3PWSQR9JCQQwJXGixfTGdqvZ/XIdXh2lMaNkAGjLZtvUqi
         EU69uG2gkCa6rzGRGAjy65keSJgK65MxsHOIq4gXUwNLlYT9NgPmiKTKphs5LghaIIIb
         9m4b8SH7QRhNSkk+OUFSEbLPdR0uHw5yYkvmia0GgNlYN1Yjfc2yq5QQ0s7ckrN3y5jO
         i4FRKV21n4JlzRw0OuHn2PPrOAIYsnayDrgzxPcLoCgsqRn8gzNbZTL9ag66iDRe06xv
         GNvA==
X-Gm-Message-State: AOJu0YyIltJETC0MDnVjAiVdMPL7IMwt6ve8N8ero3zCtwP5nK6Y8bBj
	fo16pDuwT+UxDdD5rfGCG/UIro++gSmA+TF02Cvh9YBUyNplhZ2YxDI=
X-Gm-Gg: ASbGncuA5p6v/t2qP5xoPeQr3nH+EbbMsB4tXT6Ke6JwFgQz54wSHr9svkBTZWsff+U
	WCUw0+L6Dt/GoSO4uPlGfJBtVu0R/KKVMME5ffE9JMknGzDzYO479QalIHJ4RsR6r7tpYUXw34i
	/F0yF6xVJI4q3csTxeTAhLNCIFJWPDGDD301o3kYOKXiaRT21/LLc7G0DItqMptSgra3rRtbgUg
	JKmlkuSTKcnANxAcXRSmV1EPGJ+BvbPvplZuK00o1Tw3SPibmGYi1Dw+/SH7VotsNlQzkRpomKu
	g7BF2FJAkw+Eqrjg0uKmT+J9Yh/qIVM1kCHUhGtJePeShtIyR91KLhZo0nGIfruJoSDtAR1oNzA
	ORy03yVEAG87Sgn3ArF0vCgE9hgiYhAAFAGok10ckZ0nAMtSM/iMECvh2028HMiUINIIM8N70Mc
	dnBkKfCMTd7fAN
X-Google-Smtp-Source: AGHT+IGgWKyx2LhDismGAF0omNwqpntZYZQCmcW34e98+NzfTZQR4m5s4GoRB7IaGjz7F1aHOFml8g==
X-Received: by 2002:a17:903:25cb:b0:295:9cb5:ae2a with SMTP id d9443c01a7336-2962ad0793amr27722335ad.9.1762360145438;
        Wed, 05 Nov 2025 08:29:05 -0800 (PST)
Received: from [127.0.0.1] ([13.83.233.102])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f2893bc6sm5919066a12.10.2025.11.05.08.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 08:29:04 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <0395b95bc89964254ad9a10a9e6da9fd58b6f7a7.1762354419.git.pabeni@redhat.com>
References:
 <0395b95bc89964254ad9a10a9e6da9fd58b6f7a7.1762354419.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net 2/2] mptcp: fix duplicate reset on fastclose
Message-ID: <09b12daa-4c45-d341-2eb8-35406fdfcf31@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Nov 2025 16:29:04 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/191074=
26763

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/bf6b927f00d4
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1019919


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.com/multipath-tcp/mptcp-upstream-virt=
me-docker


Please note that despite all the efforts that have been already=
 done to have a
stable tests suite when executed on a public CI like here, =
it is possible some
reported issues are not due to your modifications. =
Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)

Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306FA646
	for <mptcp@lists.linux.dev>; Sat, 21 Dec 2024 10:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734777208; cv=none; b=byYarWZx2D4Zc9n1TSwm+UZfTkRwFfQp1Xh5G47Ub6dUXFFyr09elEIk2VsDJOkH/XZB+1xSBD2mGi722r9EQ8CPfu+pJ4y3izrhw7dcpV97vJN1Iy8tlKP0JNVFeRtcNSCYAAwp3EF5ENfD8ZbUiY5NdtlbMtG1skgfGk1Rh88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734777208; c=relaxed/simple;
	bh=aTizTX68mT5g55/dYWHbzMxLKVFyjmvzqsGor+4ViGU=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=CqabPNdYYPK5INRn2shPOrgMFceqq5XQb40n1FM1PQsrMijxzXj3FyZFkrKf7qsyHcMw/KrB3WFOchVU31P6euNSLZ2/JW+zTlpfp0LpbG7Red1DIYmy+6APSsMsnsrtEWLiUXDwMUnaCZT0mbOcDSWNjrlNBT58Edkzf69zn2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zc7X5Nl7; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zc7X5Nl7"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b6f53c12adso204764085a.1
        for <mptcp@lists.linux.dev>; Sat, 21 Dec 2024 02:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734777206; x=1735382006; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5dE378wnRTIZW5hFoh4us4GhxfbUMlb9QtOs65eAYo=;
        b=Zc7X5Nl7wPPJH9RHOg8XhwgE/brcZtb0MkeqK3nCzoRD9eejm6C0PQMfOo7Dtd0Lu8
         1eI9xQa/ESxrBaiudMD1dPMvMZij9qHrtKiDGtNHE0lGU2sxvAhxj7meYzSJBLamPCL9
         QIJZ8Cb4gWLXOp7mDg8TC8wRKYybPPIwqwE4PpsdxSnGmcRyBD20QjL0vd0xvltijNrI
         O4fQJvt/t//DY3yFsXO03Apq2AImuAdGPfG7s+s//qlDjpmmL2ZhHhkcdfvwZV723g5K
         9Vdy1joHlN0byGTjyUYwd+d8RRMvYxeAmfS5hkyrSUT7CGQWviOF/uSFcvZtQbpmsbcn
         pqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734777206; x=1735382006;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O5dE378wnRTIZW5hFoh4us4GhxfbUMlb9QtOs65eAYo=;
        b=kc+9V+Npm9krTWCoJVFgQm7vJ4hGUgn7XZ4vxNsBmQmE9dcNRSDXzaaSzZ6zSvXNK9
         lAeu2fj1ihlj5Aq34hoJEAe28YRs3Ym7BHuLF2+CaX7VgrwwT2HdVRzGUOHqKsqBLwFB
         snodlK/uLmwVLR+9hHwApI2dFdBGCBlpQo0YvVUbjgq2GfSqhTyhCxCwUV5lbHP2C8G/
         OPplyWDapvbPgTrsUNh6XCg0dl4/Nf8KKTlOp7Ab2HB53cHkX9we5fX7ZL4V8yHuEG5d
         JV480rYBS11/3FtYYsTHK1XcTESQuhmiWLqftyx0afwNljH6tT+99x1z6AJpKt9s0yq5
         LfrA==
X-Gm-Message-State: AOJu0Ywm2vazlxLMoP4vDfAJYmrcAVLPLXjj6usWjY5MWzsWEdV3JHMh
	vNsnt5oIXwgKVP6udbXzyz1JhZ23rcWe8mvdjC6Vg6dXrjkDULA=
X-Gm-Gg: ASbGnct80PQmgaMhUUFn2cAEYphWUIr0tsWEpXtkocgCh8KgKcW1NxDzN7F6yQ5aXtg
	UHzK6lBT1OBTLKk9cIl16ykS29n1S08o+mjtSK20rrppE33FUIFKkAnFavxyNi4gzzam82c43Cw
	McCuPROZvTq4VQiyroNzu6b2nkVpurOXI21oVyjp6meEgDYWTUI20shHif1yWp6tMQUVROj8hYH
	zoiCRI4N4qyRqXwcZJqUfQPhiqRGDrQZLKuvy4dmICYc6PlcgkUuZ4vmgWdE+SRnNJfKQ==
X-Google-Smtp-Source: AGHT+IE73SyhYIL6oFh8i/Gkd6NFsIKueOrAFfLK8sVg1u3ls7DHbgT7JdI04oOw4uiEFVaRy1JIPQ==
X-Received: by 2002:a05:620a:178d:b0:7b6:e8c3:4b60 with SMTP id af79cd13be357-7b9ba79e0fdmr735797185a.28.1734777205918;
        Sat, 21 Dec 2024 02:33:25 -0800 (PST)
Received: from [127.0.0.1] ([20.55.214.247])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3e64d9c1sm25363571cf.2.2024.12.21.02.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Dec 2024 02:33:25 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <025d9df8cde3c9a557befc47e9bc08fbbe3476e5.1734771049.git.pabeni@redhat.com>
References:
 <025d9df8cde3c9a557befc47e9bc08fbbe3476e5.1734771049.git.pabeni@redhat.com>
Subject: Re: [PATCH net] mptcp: fix TCP options overflow.
Message-ID: <6197955b-99e1-d191-c8d0-9b6da48f6263@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Dec 2024 10:33:24 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Critical: Global Timeout =E2=9D=8C
- KVM Validation: debug: Success! =E2=9C=85
- KVM Validation: btf-normal =
(only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/12443930793

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/54b09e873b02
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D920093


If there are some issues, you can=
 reproduce them using the same environment as
the one used by the CI thanks=
 to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 Core)

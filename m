Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A8120B804
	for <mptcp@lists.linux.dev>; Thu, 23 Jan 2025 09:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737625182; cv=none; b=sUfTkl+dsWH8yPxYKBtmp+BXVFR153N4yk7v3PZbSDdRYLvxrUNS5VWyG5m9NCeBWTwbhTxUXM+JcGnvDheLcw/6uaSICPr6oAW/3fK71509JX105KZ3EAR9Kt2OlWT6BvJplAzk4gHDFDqGdeySpuRfTZl2Tlpjwk1hl7i4lH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737625182; c=relaxed/simple;
	bh=dRCJFB1ZAaFoyYc2K7q5d15sPdOEjoaa8kIivgRjQ2k=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=m7X4YtXcUzsdWQU8MdWy8b95BB9fmd5FA5TGINX1Xehd5HJ/ioIYSzVThLOehMgnopBYb0Qc63F2Q7Pm2Zm7//foFK+19dUiu4bmaVe/WjGr0V3QLM8R5bNc6lxg5Eh0HIsNUiBJ45pKMNRLXFe0iBVSQR8/qGYVmV0D7dMaPPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PO9lExdq; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PO9lExdq"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7bcf32a6582so54136685a.1
        for <mptcp@lists.linux.dev>; Thu, 23 Jan 2025 01:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737625179; x=1738229979; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kwjTecx3DMcUklXRaJf18NgGCW/NE5GkBMAdfbWT2sQ=;
        b=PO9lExdqncTIO7HlHvrFYnXH5fXWqPQe9Rwx8lmWyIB3EWXqF08n4+CT4gh8vo0dId
         NB1ZcxB5hzshI1yUwSWVhDO2NkxhZI75pMYUryeINW7YFGQlX4VC1oWqQ+fhajovsHVp
         6FlVKRYJ5z0pEqRBvIBiCHpgku8C5j6Rh7aghssLbTU7J04RsRwWlCXxsgaS9vsKsi5e
         +4vfXGgqeDfc1YQlvDzjEHa3SdYXGngdiIIWrC6D13/zBjPci9JJdzg3XnrXc04hNm5I
         aB8sMmtwgd91OEtfJ3zfZeRNYYxeWXsTYugJE5Hy3Q/DJfipk9C2GZXJWcCspzuXq0c7
         Ydgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737625179; x=1738229979;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kwjTecx3DMcUklXRaJf18NgGCW/NE5GkBMAdfbWT2sQ=;
        b=YSEiXw8GhcDOp2B56L3Rr7PimINajTvycIv/HFCrELH/RdBtlsGcnLq5cWqGEBe8Z6
         szzMPDhlqmzse9MmSQ4j+ksddDQAnyStza2Bn7ASPOFH/SAV3skw+mA6SPWqTnC0EbNh
         zyRai02kBH2vM3ksabfDCyKGVdNy3vtrxAvik0337tfmV7ilMdxmckOdGSUvfh8GAnMX
         5Pgh+ux8L6RxpUrTmf0zUuxnvZw7YJz/oSZMZRhog/yCjwKN9MnpTRzhSNxzfctRCmSJ
         aAThEDPHuQu0kGnL0Yk8ZHKPdvSjuT8JQVNPnojHJAjrlZzQzj8TeUuRHLWSUR6XM4MF
         R4YA==
X-Gm-Message-State: AOJu0Yw1D5KM8voqZYoVUYQpvzlkcVctNNbrf1sxUmammEQx7vwBxmTS
	il/Wa7NrSESwGqsaLpgNG+atukf0E7GOQNhDZfK/uBgKKzimAMY=
X-Gm-Gg: ASbGncuTsk1ObwvdQb57bYw5YStxWkR2sAuAl4LEbTNtR41txtkCG67ghktKM0+cOLk
	SOdBcpJs0WFOWEbjsDty+ntgbbKpbd4/aIQAlCrwzqZULAmSHFLvtQgcN29bAOekyfqz8akvLPw
	nH6AIvIUwlO9VKZALVPDXhO4hQ3mXprjggZPwrCYnATKQ+pbm8s+ckA/LvX7X1jWHmJ/5DkRV2u
	zvpbKlcPnoRvJ/wCewalPUVu5ifvV1CtidVClFSLuLBoYsNKj+NlxOIkT00DsBEFRzQz2wkk1nN
	YY5axDc9qT1LVYw=
X-Google-Smtp-Source: AGHT+IHiY6fVJbJLrlGwFTKHO3X5Q16wMeKIx+UFkD7qs9YaTqpucGZjNfC09wBthwhD58YMT3DzgA==
X-Received: by 2002:a05:620a:472b:b0:7b6:dc4f:8879 with SMTP id af79cd13be357-7be6328792fmr4756522285a.47.1737625179058;
        Thu, 23 Jan 2025 01:39:39 -0800 (PST)
Received: from [127.0.0.1] ([20.42.51.94])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be614d9937sm756354185a.75.2025.01.23.01.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 01:39:38 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Jan Stancek <jstancek@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <7abc701da9df39c2d6cd15bc3cf9e6cee445cb96.1737621162.git.jstancek@redhat.com>
References:
 <7abc701da9df39c2d6cd15bc3cf9e6cee445cb96.1737621162.git.jstancek@redhat.com>
Subject: Re: [PATCH] selftests: mptcp: extend CFLAGS to keep options from
 environment
Message-ID: <8cfe6248-bbbb-6f39-353e-355cdf0b01ca@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jan 2025 09:39:37 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Jan,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Unstable: 1 =
failed test(s): bpftest_test_progs_mptcp =F0=9F=94=B4
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/129254=
62256

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/a6a58622b014
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D927742


If there are some issues, you can reproduce them using the same =
environment as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
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

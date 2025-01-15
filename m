Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128CA132C38
	for <mptcp@lists.linux.dev>; Wed, 15 Jan 2025 22:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736979679; cv=none; b=QzPDUC2exElxz5/W+soEPmTeeo0TfwnOpt25cSIHD/F5b6l5b/Dk4BBll+TGomNQuplUnxdfdQg1SGNeZX1P2LxKdoQO1l5Im2lo1P4FG0tPFk1sOKHo3G/zcnnaDCVN9UMklw5XeBKUnu8I2RAb2TAwEm3HUbQl0A0JsaS48Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736979679; c=relaxed/simple;
	bh=I+1NdTSIbKgvwNL172RbSUb5RPMmiTJ03r+sPcmCH00=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=DgmlSJuJMF2EFrV3Z21znQp6pyfAvSvwmjFDezVfeS6ezxyQFJ2XEa96prXRdHedcSBqg93Z7NGHx+qRC4iV+AqcgAQx3rj9O/36xdwOYOVNFU4w6492sZGVGzXW0hg8DO0a3K52H3ecra/bq+pYYm4/3Vjyk2wes5Ru6NA8+Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ggz69nt6; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ggz69nt6"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21bc1512a63so3831915ad.1
        for <mptcp@lists.linux.dev>; Wed, 15 Jan 2025 14:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736979677; x=1737584477; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oeoAdlYxibRIecJxDkzt1NkM30WEXFJU5FeyhUzpsCg=;
        b=Ggz69nt6Ho7auF9bFNcWvqnnYXvmaSBIL6t2wXcJdfQSCZkl/PkqmzHS+m2y7AGyHj
         8PBqYRqAKtbMcgAoeFmZ/XJeIOwU9+s10NHsoFrXy+YBksCHEMHcFAUf6HHMTOvZXrqt
         J5qtVI+JJOlg+uS93FDzS0sPKbGjXh0EyJedSLTiwj2BNgYM6RBAAdlvoYgDF/EGM1i3
         evr+cuvSRBScUHiX1nF6o/otwNZB14dWpethlvz1L8Ip7WPVDiSY91GEvVObMBWzCqdY
         74ngyP6cBlluHF+biMQWoYA+bRn5p++iYT9cCr6e7WcOlaImGtxSWeEjITmYEcVyR5ez
         cj4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736979677; x=1737584477;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oeoAdlYxibRIecJxDkzt1NkM30WEXFJU5FeyhUzpsCg=;
        b=Fnmcl+rMBelPCC9bszN4XePHG+Pzq5oXXDyNn3T7BGe6vpAWQKMCLcUkG+E9gtaMGU
         dUblAf6My+FsdMnc5gg+Cw1f9HB8Xlu04PRhwBcBxTrzq+YdsKCoJC0Tg5SIt42liMaW
         gptbhejpTGJA12J1X6pSo/hVocLm6WgmzIN3sUQLDdpr/ihI+hG6SzUv3lexQ4pjLWyd
         zW2qRNXNmGLY1+rbzxQAN6tS24Tt9Y7Nuhvnb4P0BuJm7Ffqbn2zBMQgpOpqUteK+aoJ
         Zv3oLnSDOywFLaqzQYGQLt1bqyqxX23s9HYKMzRzkU3V/CdR47wugnKqxwBNNpJ4bKPl
         p3BA==
X-Gm-Message-State: AOJu0Yxg6pgp9vZHKTGcQqSmmoELQ5I5oochkHbI0OVOQJ/f5fTKe8TN
	KknklBdQRE9W8o+7RZYGcMHnonpXZCopJLg8ucb2qx2hzoF/++M=
X-Gm-Gg: ASbGncur0TD/NaSg0s5vqGYQAbSKgKu0vtO33MVUSLOvlRjbJu5EXIryLUMw+vyv84I
	2uMC35My4j79WIQO7tTgA7SW7KwCsFiH+LalhHsNd7gqs966oGtM3DjQ9uCTW9lsa+UXMxOPIUJ
	ENLYcLgTbBoYaHEmRO/AzwDUGStlLimYmA4YfYYSqWoBs4UcB6m8BNEuj67G9jP570opH1hbXPg
	yY0d1k3C+Cu5UNLZgOXAbndLoiqWyi3VYFe3AiLDbsqqMBc/qvMgWbLxL2pUKJqBHuCYg==
X-Google-Smtp-Source: AGHT+IFQVagjIg2N2UQyicCaSoUyzamNgBKnEKRClGdxfys15Mk1uwj/hsM7920qVhKGjGg2i8+36Q==
X-Received: by 2002:a17:902:e74f:b0:216:7cde:523 with SMTP id d9443c01a7336-21a83f6710dmr517994165ad.32.1736979677175;
        Wed, 15 Jan 2025 14:21:17 -0800 (PST)
Received: from [127.0.0.1] ([52.234.33.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f22d0d7sm87618515ad.163.2025.01.15.14.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 14:21:16 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <7c8a258328ed6d235a100e3fa13c2da355119951.1736974476.git.pabeni@redhat.com>
References:
 <7c8a258328ed6d235a100e3fa13c2da355119951.1736974476.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: consolidate suboption status.
Message-ID: <b6540328-3461-43f7-0d52-0f3274e01473@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jan 2025 22:21:15 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/12797327590

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/7492f7a28e28
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D925847


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

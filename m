Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C845787C
	for <mptcp@lists.linux.dev>; Tue, 13 Feb 2024 14:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707834507; cv=none; b=R2kBvBbBE6t21e9Hvjwg/+34C6d1qdWpg+1Z7OCxPi2VxB/qtoK3zKuyQumQp1kvRHv57anxIqQCsxKtJdnW2QuksOdFPnXKciNApHz2zySI5U0dhCF0J1Htw7c3lBuWLFSbpTDeRIqNVCE4ujHSJKvkWc28bN/aYXDm5RLvgEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707834507; c=relaxed/simple;
	bh=Ak0yBBycldeGVvfmD9vI0qxaP52wL52D4MrARYtNANM=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=VC7FMHpcYSDRr5VVoU8T2yt1A+9yIufdtFv5pRi44vX6g7cn3xW9IocpONtoD12doZymYR6tlZzLjgcbz6/uwmwO0CbUO6jnfbOKmHKnxUGZpSrHkPuoyb8dsRS1rGyZFIBPurENAky5r2rp2ffRKxqiQyAixvnMeA7mRMtOk1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wv6Rr3gT; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wv6Rr3gT"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc6e080c1f0so3773129276.2
        for <mptcp@lists.linux.dev>; Tue, 13 Feb 2024 06:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707834505; x=1708439305; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+IBDOl5KN5sN/kK26kT4hnx1Ga1qKcElBKAkEDa0X4g=;
        b=Wv6Rr3gT9ifMGqa8qa1yU9DYQ2ExGsM+SkFFeG4JzGUXBznR2d+uzAZLSnYbYnsCTp
         wUjeR/3iJEPCBePCn+G0GuCgl2AkHnsTCl/sI1FIFupkMLK3i/scPipdCgSLYIwYt2Qe
         V3ie+m1y68Xek+72rprUNg4fAj6EdJxuk5oRiT7s1AL3YgFO9MLXeF6+HPNZFOLTff2C
         HcwpkUBru2fA/oZTZTSpaD1atA1ljhWi/NiJJJ17oXCbn7EB7dBHybyC5gT+YKwvmUYt
         jXBwUwEkUd+oZ5ihygoj6A85AOnU/GGpvFMZJ0f9JaXcjfjcS/rFLIofToWTydiQW+lE
         FZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707834505; x=1708439305;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+IBDOl5KN5sN/kK26kT4hnx1Ga1qKcElBKAkEDa0X4g=;
        b=BNRX8QATytcn7YAhIEUlwf7rAbYzR5Act2OhKIYbwspXIikASlDip2U+Z7lW1/WUGx
         I1hnL3kUW+hprDxVDudYeEcwW/8Hy6R7kDHjCYX+YCd4K5zQt44Zf7dG7G0f2l40w/uZ
         +cfM6HhbCtwNP1ymU+kdiDdJhwC0ngWLXvdDbV2mFmNIU0TlR4qN4qEcsuOK/9XRfk4Y
         1FGc9J94kv/xq+3LFWKtgSZ6mQWUBbAdwspcCmib5p2wYGqqcr1wK4qH3ElvxeLZG8XF
         FMscOqnYNErqflHFX0fKvEHNLlq8EUQSiTTr6vK6CpmsqNCXMhq3a1U62Ept1eEmwhR1
         r94w==
X-Gm-Message-State: AOJu0YwxhaS7j94hkT8QzXHdfEj2tr97wZPr+3NydZpwuqLnUdH5LEYi
	CxtF5b+3PDaXOgKYGy8mhmyTfwfdpfN20Nt4Z8hsKwIvd4+2+pM=
X-Google-Smtp-Source: AGHT+IEsCCip6UlEH+qf89OLHDGjPIaarPgXA0MjeKnPLFAKHsSLonEAUkeZdDX+bXLxUQXypGl4sA==
X-Received: by 2002:a0d:e210:0:b0:607:7e16:347a with SMTP id l16-20020a0de210000000b006077e16347amr2701895ywe.42.1707834505042;
        Tue, 13 Feb 2024 06:28:25 -0800 (PST)
Received: from [127.0.0.1] ([40.67.142.100])
        by smtp.gmail.com with ESMTPSA id xr18-20020a05620a5cd200b00783f8693df1sm2990879qkn.37.2024.02.13.06.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 06:27:53 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240207-selftests-mptcp-fix-5-15-v1-3-005b0cdb135a@kernel.org>
References:
 <20240207-selftests-mptcp-fix-5-15-v1-3-005b0cdb135a@kernel.org>
Subject: Re: selftests: mptcp: diag: fix bash warnings on older kernels:
 Tests Results
Message-ID: <771cf377-d62c-2a01-03d7-153beeb1e5ea@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Feb 2024 14:27:32 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7887523975

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/a0e162ea2e56


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
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

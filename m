Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC89628FD
	for <mptcp@lists.linux.dev>; Thu, 31 Oct 2024 02:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730343261; cv=none; b=AmPVAJKspgcNRgWGGGlvw9xA3R+6ojB5HRb6KYUhIqp9WVxYlCHqxhBoZYuDrGDOufyQU2mCleSUgzsUhVA5VN5e8jUbVNO0TkVnPO/UX0WtSxvFecQ6g/Bnl//OQxE7skfDQX9dZ6YPRrupkijNhPe565qaSwONMLX6M16ET24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730343261; c=relaxed/simple;
	bh=5hoOSIwfnFCt/9vEARu6Dttc9FRUdm7B3FH4JiV1xt4=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=J4HrYZaSLP16L3Fy1H7UWh4owhlF5iFj6zcUT/m0M3Y34ugtVDxifUMTJlgHocYuhTGysJ+IgNGheA5nBqr6SyAjWyFssW/ajLOGoeWYbW2x1S8QbQrn+/z0z5uN8K4vd0mf0219wJft3gryTeAXduZnkribC97KvYDgHod3eFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/Ijsx2a; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/Ijsx2a"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-460c2418e37so3662171cf.0
        for <mptcp@lists.linux.dev>; Wed, 30 Oct 2024 19:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730343258; x=1730948058; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gAEe2duX6jg9yB0rA7genIIIuPbg9f5ZogMMHC1jW1A=;
        b=D/Ijsx2akmHLfzjhT6gad+cekfexgjkoF/oMxmN/BB6b4NuRyY1tBnex0jDVD8r5P5
         vUYRVV+y+FHX84YkCWzdXT/NQ3rMXjgUFGeflA3wVNK1PQqR5jTc2ceqLUbaxYrHMyOl
         5ZDs310JaASnkiDqtSKuX5nKwEXOoY5x8Lku/Iw3hsE1A8ad8KNN8YD/FvfdKbMVOY7X
         rq1QbPpMtQm/nVrLZGInoy2DIz5QW5QVa+MEOa3fRj9J81gWLuRr05BbvJSyUkB/OAKV
         edQgld70TcksfkhUkf/TJcvFfjNu9S2PzyIk9gGLRYRDbonM60KnTDtD8kafDDF+xEHB
         GMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730343258; x=1730948058;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gAEe2duX6jg9yB0rA7genIIIuPbg9f5ZogMMHC1jW1A=;
        b=Hisw86590P8rxmO3/QC641i9mLRMX03JeK0gCFnm8LfRbHFnxSkPAzar5DtGv71kDy
         dvKQK4o2b3gY/4D08SvNzxmzXJREot1KoawUatsE7QrC/TRLUSTiBU2XqfvY7jz3qOe7
         2RHPtg3y8wHXaKhXgdgHXWGmu+giEK5vfF7djKfhshC2VLnWKMNhWylDVh3Fa1McfqTO
         TRu4ncdLpEic7+v/nfZdVxJR9kt7ICpcxLSHJMYBkdV/Tm0SYAaLd3Wb+rUwp6LF/0Yt
         HXPcubX45NQdjm9/hasaCMe5gB4ixg+R/ErlGlN+fAsdM588L1Qjayg0ViM1AvCckB1k
         jNcg==
X-Gm-Message-State: AOJu0YyIjKNixUZ6Z/gCEYHEtxOF+2aw3IUWGu71svf9fg3zLaG0mhgi
	DLOHlRNBNyEWY9nKH7+kE81gOlir7zl7j6zkue84QGk+1aAxPyWc+7m9
X-Google-Smtp-Source: AGHT+IGPGalLSdm1M3+/PARIbFxm74TpUnkodTY+Gl1oyIsKPV1MY86QbGpUhJj8LUf3wDSIZESbrw==
X-Received: by 2002:ac8:7d8b:0:b0:461:18f2:ae5b with SMTP id d75a77b69052e-462ab23da8emr19356001cf.5.1730343257456;
        Wed, 30 Oct 2024 19:54:17 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.51.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ad083f3asm2999891cf.1.2024.10.30.19.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 19:54:16 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <c02fda3177b34f9e74a044833fda9761627f4d07.1730338692.git.tanggeliang@kylinos.cn>
References:
 <c02fda3177b34f9e74a044833fda9761627f4d07.1730338692.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH bpf-next/net v3] selftests/bpf: Drop netns helpers in
 mptcp
Message-ID: <657fdb28-260a-816e-9b9e-b31813b0a0a4@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 31 Oct 2024 02:54:15 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Script =
error! =E2=9D=93
- KVM Validation: btf-debug (only bpftest_all): Script =
error! =E2=9D=93
- Task: https://github.com/multipath-tcp/mptcp_net-next/ac=
tions/runs/11604759674

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/6547fae841cb
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D904875


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

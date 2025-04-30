Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1555F1EB5B
	for <mptcp@lists.linux.dev>; Wed, 30 Apr 2025 17:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746032939; cv=none; b=kAnWNAFTIxtY2DQNqchY9SknwyhfC6mjWUR6er4+9kVQMNFPPkwICuOACkxbKTpSBmVRVI8RliPfuxbb8+AEnEUZnbwb35WNj9yJ3kYiRe/1kLrs5ioeWr9r2zP+zDdL25homIOZQUG3zztS6ke8oU5xcD5suTaNM6e2in0eVcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746032939; c=relaxed/simple;
	bh=ENUe1XVhv70nkYBVRtcw9HYN89T68A9+8VcehhOvq1M=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=mZoV52TMx+rIlxhx6caspMdYwenUel5k3HLLzCucyYKIaoZ40aInbrpbH/X2Koyuzbu25/O/eWKA9dd75ow4ska5wX8wa9fiuttBl8KDhCnaStUuafKv9sausNw7H4sy3KYntHrJEcfXBGEJEiu8YRM6RWrTh+QfDRt7N/fzl1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLlSk3E5; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLlSk3E5"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-73bf1cef6ceso192122b3a.0
        for <mptcp@lists.linux.dev>; Wed, 30 Apr 2025 10:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746032937; x=1746637737; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/OftFaPrjgJxl+NLnnFDbRCoee9A6NeqDl69Qqk9qw=;
        b=WLlSk3E5rXwVmGsEliePSL0+yPVptIaNpRGeBjNMrH+LzE8dklyrh/EMhXX80oRwrK
         hVllZj9cTypiEb+ce03xXMreM7EK+v+NjutkPxbDsIoS0EYm5tF+fAnRDnUZ8RTyOi2m
         D8HOM8tmNZKuXqhXXn+co5/rw/duEf62lp3lQOsmnrqoqHAOPL5xq+7QimkGctg588mx
         19gI+oFjXGmeuOs76odMFikzlWpNgcwSMeSiEA1/9UDn0UNjX66cgBPf7AVN23/vDcMa
         xQjy2YYgsOXPpipKnF2RhGpQt4FqNERjjg1ypm/QKrIfvEdNKj34Jou6J1O1ByoyXU7D
         +yjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746032937; x=1746637737;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q/OftFaPrjgJxl+NLnnFDbRCoee9A6NeqDl69Qqk9qw=;
        b=DsWu+vEd3pA13/qYuLNjneM+unAq7xy1ZwgYf1JocdE8qVSzoliI0qdeiDZqr1yERF
         0+rwI5Br6M4pZvqxoSyY61tb3DxBxVXvM6EZPdJ+3L6n4rKhvQbM1y7bqmvfli41FKtr
         t6xuQrbMQn9nck0j8mEayffFhZyTFWbzY0DTsbrdZfA4GMMwSTjd8Yx2uwFqmD9vAiwG
         6uCTp9Har1PlgREkGm4u3mGzXfSqb+26JzE2ApYdB2B4AdffRN+eOiL18nruerfSDq4l
         66tDiVxGyv6EmHRaI1UnOwUMmSZaK2fbTK0rMbcgS/LfcxuR5AYl6xKZzE4JYaiswqtj
         0O6w==
X-Gm-Message-State: AOJu0Yy9QCMRwLLcC2VsulvIpl96Pf84MSPtLqKt/Enwo43mKecAb8AB
	PBVaOUZGB2S6rYGIyVs+eQtJRgJynnjkKxJoNfk627Hf4mQoz8Q=
X-Gm-Gg: ASbGncsLw3M1WDIyF7zVkj9u0eqp6mb26ymzDHLr4XLymS0QHZcRqVYQS/2/mUjU9pk
	jjxhactiVWCW1Sy1v4NhOJ+mpx+n0Augn1/cXv+qkS9LcIvb+NJkg6Sh2wh/58ISEFOsU7ZwTJJ
	j56bhbOf4pp/QTq7/r4O+FoKunIxsSYpGxnlql0yv1EJ/6sP61TJCfRipmab+PR+JhjhNmjaveD
	LhgKRyXOS5ccM3SnSzyuZuDcK/TPasu2qCOdP7SNupFLNYXsYiz4pc/eBPEh+0d/pUMSqFvCGDI
	DNvJ0ypV2Yx9AmedE3JiGr0r7eCFcDDqDmumd47rpgAr4nEvCYDj
X-Google-Smtp-Source: AGHT+IH+PjYqNMVV71GVy7d9Cyjf8zz2US/VL8xKNTNoT+EYwnYwEAijvDQ2Df6tUSbf3514qdAx5w==
X-Received: by 2002:a05:6a00:2e05:b0:732:2484:e0ce with SMTP id d2e1a72fcca58-7403a811cadmr4281879b3a.17.1746032937381;
        Wed, 30 Apr 2025 10:08:57 -0700 (PDT)
Received: from [127.0.0.1] ([52.234.33.79])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a944c9sm1892309b3a.169.2025.04.30.10.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 10:08:57 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Pedro Falcato <pfalcato@suse.de>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250430154541.1038561-1-pfalcato@suse.de>
References: <20250430154541.1038561-1-pfalcato@suse.de>
Subject: Re: [PATCH] mptcp: Align mptcp_inet6_sk with other protocols
Message-ID: <e2c02df4-be72-e6f4-5397-02adf9cf978e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Apr 2025 17:08:56 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Pedro,

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
uns/14758969434

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/0a4b887f44e6
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D958572


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

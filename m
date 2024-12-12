Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8902153EC
	for <mptcp@lists.linux.dev>; Thu, 12 Dec 2024 17:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026246; cv=none; b=Nc6PdGjA2++SWB/mFgEg8AC/O2arf3Eln+1OuH+wf1HcNsKVJvf/Yc4HNJkO4IAWvHlwFNunuTtxNdhwOQH9uPjQVIYyvyM3czm4I5jVOAinBRN0317u9WaDWXOV6kvWQjjj0RsBlCqYSLxBp+lJS8l2f56hnsSKV6LeXqOLZ5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026246; c=relaxed/simple;
	bh=XxDckxnbxmPIW3rYVugvk22peMFca1+14PMgOZO8zkk=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=qAWpNVR0JFKJkOEoKYUDxvbJkaI4TmeVIi/ZB+6wDO2RIXk+BQCRlBqh91I4T+3G4QXf5GiAeW/4Dy8FqjBKdX919KlzKMvy7Vn/8ZN2xeNuTwoHK0lA0iTwmJbDM+xWQUyRlfML7V/IIYlbJ3jGbmiuWQ8dT1UoC6cu17C9KpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgoFg7XF; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgoFg7XF"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21628b3fe7dso8308525ad.3
        for <mptcp@lists.linux.dev>; Thu, 12 Dec 2024 09:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734026244; x=1734631044; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtfZsAPTBEzVxiJ9UiTvXdjPnOYYFFggntRBEL5zYRQ=;
        b=KgoFg7XFNPmZzqKCQyJnOi4d5PXE6uK1hjRF+IUFRtrBAXeV3mPf7EajxB4JH4yojX
         meaBSZL655e/Se8oGTUWz5c2qQ5LrzcgP2NKEs2GACx+jHBhgWakqYuhe/IPCOxo/6MS
         TL7ezFjKhrfhxlf83bM5jfiKVkSUQLSE0QNK4csrq2s4cOajSVC36Fsw/AvdJbqQrM4q
         Xo8oFs3UzYlTsGE8bawG6dXJpHrNOtz9ooLpC5k4T/iAooMaGF+7Mg90cLMN6J0Cm8yj
         oZdRi/RZiMZpLukplLNGDVv2hxyZuUHVMDRm50JEtp8IKgCM9Drl0LILao13Y8vqRatY
         Axig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026244; x=1734631044;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NtfZsAPTBEzVxiJ9UiTvXdjPnOYYFFggntRBEL5zYRQ=;
        b=xGatxtCOh2tfIgucZYdRg7CWO8DcZ6NGjp7nHRMosUyFqZeO1/w/DyKeSVTiUepOhY
         PHvW4yoP5XIhTzho4+JN+UbCTEU6uuBftqecJZ9QM+V/bE1D5o8G2yRQ0xaN2yXUQgNH
         X7OADZiRoDzvx8V6y1GOPWm/W69DtcmtiIka3l/neX0aSQAjXBTaVUVlt+0XmtJAdygX
         ptCzwuvxEac1x0pTtPntnpf56kHRdLGIR7p/EPOf6SYpJ6oQD23873ufPh5CxZpftUnJ
         uHEl/zSJpGuw7vFugNL3XI0PTe1623jpj7EutGb8e4Zim2f0NqNk4v9h3WtdEhKKY7Jx
         200Q==
X-Gm-Message-State: AOJu0YxayOnuXZSoG09bMFgylSAYdFmWppQDsNr7ixmTS1Q1SRU8I99f
	T6RpZZuQlf55COwwH9ZQRGjnssSJ3BMh+oXrH9Z2YP3yqvQscso=
X-Gm-Gg: ASbGncuqodPooptewQ7BvKFtbE80pR4bWUqfGlAZTmt9e+ipOUeGd3EjwY0DTitQj1K
	hb5m6P9YRA3RBAPyxJKLUgyXeZX9lpOtLTv0pl/O+ZSeEMD+s+XK34uBABHgwKiewTRUCnuLtD8
	drP7Q/RDahqGj9AgV/Wx4wP/mQZm6HJlZh1ypuxTcJ+dzE5BiAp0g0ZhkYx5wr7oPh+v0Gt+Pnn
	8ehb3Anh1hvJDpqTTBA4rWFSk+S0jjtC/Hz9brtvcik59Nv7jZUEbSowSg6se1ytT0B
X-Google-Smtp-Source: AGHT+IFDFhideFsVVGlTxvEB/LOXH4B2Kjj4HYzw94MhITaLjHma/TGvbrlI4/2WNHw9PER8kRpYCg==
X-Received: by 2002:a17:903:18b:b0:216:cd90:f8a with SMTP id d9443c01a7336-2178af00972mr75286115ad.49.1734026243789;
        Thu, 12 Dec 2024 09:57:23 -0800 (PST)
Received: from [127.0.0.1] ([52.234.36.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2163872e46esm83284735ad.238.2024.12.12.09.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 09:57:23 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1734022547.git.pabeni@redhat.com>
References: <cover.1734022547.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-next 0/2] mptcp: rx refactor follow-ups
Message-ID: <429f1d50-971b-a720-a13c-b0fc4bde04d3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Dec 2024 17:57:22 +0000
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
uns/12301307404

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/63734435a74d
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D917303


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

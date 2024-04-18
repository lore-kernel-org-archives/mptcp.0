Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3CB17109B
	for <mptcp@lists.linux.dev>; Thu, 18 Apr 2024 16:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713459508; cv=none; b=i1CyxUHfWhxnYyzh2gPr6/B40SBf4/sfm/Naq0dxJnOQgtlDkuoxHns0Rjr9Zhs/QlVWm6YUfWcqWc1N+hBILXRKQP8ZZT+oPg1o8sHdJ3STX75UcBp2a0t2kJCDmzyCejPe368jwAQAhggozCl2CMProv7r/g23FUOGrG1+RZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713459508; c=relaxed/simple;
	bh=R9/+NsIYKNzGCTtpgJ9dnGEBwxAKxjE8ogT+9EW7Wps=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=OpXM8Zh3UUjmKrgn1ZVjGdCEi25YmQZcHAjzzJfTyvcSuYwYoSRaJB9VBDYJgVyXUuFLuay+IBA0c2X6IKEgH5UpkrRgbJuIuCs6Ejg/83skMAeRaarYbVR3W2JDHmuI5ai2V+pKso0Hah2VkjPcBMa/GS4qTHSqJqoUrrUmf6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTWcSmLz; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTWcSmLz"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-434ed2e513dso4635561cf.3
        for <mptcp@lists.linux.dev>; Thu, 18 Apr 2024 09:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713459506; x=1714064306; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JsfqE8Hax6cIdhlVzP9scj9oYU/C35tI/ezkA8y6wKo=;
        b=PTWcSmLzMaOextCi3ADOShEA+ehYZodExZ6XHcncD6/KtW9tw/oSQ1jgpw9N2L08lR
         6FsN+rbsHKu23TaLhu0NCWZZscujSToHv1O7YzlWLBjCdawNUem917pp7gLD0r3Iq2Kd
         c58okEahPE1B8mMYuuJ9DO06MCWN7vTWH65PsIcqKJ+tx2N16nTvvSANi7cvtaEN9BRm
         lLFKyfg7aq9y5X0U1GyjvVOycE/rbfF1D5BaIyvDDZgUIJU9tl20TYfkqkgF2u2Hn4gX
         uN3gSa8QHgkosZXuC3cdeCL0a3TcWcLkFrgO8fhLfAxRCVcrSywWaX/Hkn+F185uRjis
         HcLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713459506; x=1714064306;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JsfqE8Hax6cIdhlVzP9scj9oYU/C35tI/ezkA8y6wKo=;
        b=CzAa26E4rjO0kWnOGTPqudtBtYfYolj1q+dql4DBrYhQ7VYuv5oqd+4iSYPw+5BsfN
         1WyB5i19VLpGt101oC4w2ECA59xRcOK3pGweSqXNtFpHQVfhia2VM3YmM5/r/rgGTGKq
         ZTqh7DqD4n1tFqmd0WkeNlNaPFro6m7QCVl2YZbvJNUHeCsCNAckaZI0uXqslIcT8kRd
         6g2YTG5+f6GSOiSv2PyI7qGEjU8EwuRUA5zFXgyPO+YVgEeMy6rJxt3KCLNweBloO5k0
         llmonW57QhcPffnZSBBgVjzhms4Dauwq1x+DgxGnMUaN9Rp6UmR9rrXag8yBbUtzAyhO
         yeqA==
X-Gm-Message-State: AOJu0YzMGkr23CDZIgLrlhs54JEwBW7TyMYwbjeJoOTyn1yNweMYll3M
	Z7lzn+sR/UzvwTNrGfm+286rqhjTzzczJVDLZ/89vmzDUxeIu78=
X-Google-Smtp-Source: AGHT+IEQIFQ7NKbdschQpqEh+pCqNwXOMpZlLVJxTshg/h4oGjlkGrN8h2FVhWi6eOQz4iNnZ+hZmQ==
X-Received: by 2002:ac8:5d09:0:b0:436:d35f:2264 with SMTP id f9-20020ac85d09000000b00436d35f2264mr4342071qtx.43.1713459505728;
        Thu, 18 Apr 2024 09:58:25 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.148.20])
        by smtp.gmail.com with ESMTPSA id jv9-20020a05622aa08900b004366d3eef03sm799653qtb.68.2024.04.18.09.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 09:58:25 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240418-mptcp-getsockopt-info-opti-v1-1-7138a96eb50c@kernel.org>
References:
 <20240418-mptcp-getsockopt-info-opti-v1-1-7138a96eb50c@kernel.org>
Subject: Re: [PATCH mptcp-next] mptcp: sockopt: info: stop early if no
 buffer
Message-ID: <4080ff8e-8bcb-e9cf-b949-8e475fbfdadb@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Apr 2024 16:58:24 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/8741402954

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/06f7acd7238b
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D845876


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

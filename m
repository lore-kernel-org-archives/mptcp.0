Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3282915698D
	for <mptcp@lists.linux.dev>; Fri, 28 Jun 2024 16:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719593254; cv=none; b=XOIsoJ2ZkSF/k19cKJxO9QHp4r6w8PKrcT5hYbxE7rm4m9nTrJacTAchalL4yfF7d17VBBYOfgWP8E0oLMps0bBkXadip5rcZTkpuP3NW9JGZv9QFhfo3x7fg6GlZNjqwLJs5tOabIspMPmq53LEKD4jT+dLAc6Llj9/OGdLUcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719593254; c=relaxed/simple;
	bh=L43TUN5+9brU9MwFSfytQDd4bSWd7ND1VqPTazTfxi0=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=fnWs9BaehWr0F2Q7i6uG30BLLMilLgeHSRxf5YVmQzDcrBmcDYkxp51iQV1lqEGIFWaAOXprjpUe+aB0KHubnrvzT6y+/p5CIXRBRVUrAY9ewdBlNrJgRJs+BOZsHSsiz2Yq6o5P+LwN2pTyXetQIAZNVseQ6UdTdWZVMpsgEI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6lR8Z5e; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6lR8Z5e"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6b5932383e0so16192706d6.0
        for <mptcp@lists.linux.dev>; Fri, 28 Jun 2024 09:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719593251; x=1720198051; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ag4/5fu3/sM4hOyqoNryVo7SWCoLdAqbiZp0RvkXios=;
        b=L6lR8Z5eeSYsIXJo4HIHg4I1jNnt828+8ePrmrMeZo6zs+87nq5why6fAhVFbX3u/S
         7JqTOvA5rPXSd3yn6ffS7U6uEfaGS6n+6uPhg0jRHpdGai2hLAb1svMzoKuo+t4Nfpmr
         b6Jwt+BY3WKVkp7h//8wchvpo8TZjer7LuX+D6kyOIaVjIoVNpePSAEyf7PYETFIynv4
         bVW/QbtUUGeWrreVzwzT7+JqClAGkdrZ/qH7+RaAiiqHWIuvxyoEkQduXjoZ6QBCO51b
         ftfChb7Th9EitawY3CHttALjR+rchknRlor12HfeN4XwQHbW96nx3OtyCRIO8sdYcdUx
         MJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719593251; x=1720198051;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ag4/5fu3/sM4hOyqoNryVo7SWCoLdAqbiZp0RvkXios=;
        b=U9Rxi0lSz6KiprBMyxbCnaOGQAByc+H4BP5bZsZsmi9tE8ZfEEX6QyHDykEZRgqfdf
         TgQLBoy8plIXy0+gZbYibbbS+ly7j/RY4ynlS1arl6Cs/ejI5JxjanoIJJJjV6AExEAT
         x1remz67rI6oZJpngwo6aZkAP5pRtixtUu2q5EKx1Znyy1V7vpw/NlGWUrbLdinbMjYl
         wlz2mp0utr6KVs9OUGddTDJfgjcj1Ur9cK/yNa5sc95uSuMY7z+Rro1h8Rokr3KtoP9+
         ZCPUO10MWwfAHg6bSYWfV3ya7TJMWpt6XO0XB55bCnzPJ8xnbBfjH1uYEn3c996NpKFb
         NYJg==
X-Gm-Message-State: AOJu0YxtF94LWVjmrvesaOyP+xtQe9+u56qdTGwqELb1upRMlcZPOjFp
	NL6G5sU5pW/X0kfsWQE9P7dJekMHgDveWxds/BQx+QcxADZB4UI=
X-Google-Smtp-Source: AGHT+IHydhDo9o0l+YXssjFPQUIQEzQd4z/aebx3ZH8UkqmN8JFucf4Di/Y4PwBeB1pCOYhJ+PKzww==
X-Received: by 2002:a05:6214:e4c:b0:6b4:f979:1e03 with SMTP id 6a1803df08f44-6b5a545b32fmr30805636d6.25.1719593250953;
        Fri, 28 Jun 2024 09:47:30 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.77.244])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e564d29sm9259196d6.46.2024.06.28.09.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 09:47:30 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1719589916.git.pabeni@redhat.com>
References: <cover.1719589916.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net 0/3] mptcp: fix signal endpoint readd
Message-ID: <b0f6521e-86ec-6cdd-cd8e-1552b0d9b794@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Jun 2024 16:47:29 +0000
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
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/9715703255

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/f42115410887
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D866666


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

Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E83158DAC
	for <mptcp@lists.linux.dev>; Sat, 13 Sep 2025 02:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757730916; cv=none; b=DauHOhrptXYCf+eMYBvveIzYsY/KBkaag9PKmN+ShExS0Q8f+rgEUuFhyk1EmI9xh1c9a+U3crz1u9b8sc36hbbZQ+Zew4fCIMeMKu1BI5a4/qSDFb8AlP70N41x2KJ7cUcWKsTHKNa2dJZEQebVeOulXKeKZZFq9S4DKZeojTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757730916; c=relaxed/simple;
	bh=9ajEzPrMtvpgyV5NvZUS3beAVZxs+SSuhfLpnelqCk0=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=mx5colQxysabR2lLBN628Uei5qGNlcTgFmyNUgvYteTgoeWm0WLW6NtH6qNX78u5EjT37ooquWDkD9k5FHC6aPjiMle6gwtwjaysIZFglojqx/tzF6EGjGWS3/Y1Pmv2E8dPmdOQ2zbriHDmAA6l3V/+mg+p0wQ+52jLY3KKazA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aGxDJHRx; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGxDJHRx"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-88c3361f16bso207759039f.0
        for <mptcp@lists.linux.dev>; Fri, 12 Sep 2025 19:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757730914; x=1758335714; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F1OrENnafvqi7viYwg1HW9pT6S48DSJWyEIfpM3rNiM=;
        b=aGxDJHRxv/8P87ws3DdiGCUIdTCecfE/VvOPuyGr+vv0Q9LRjC3WBd6VjLA2zlEL1C
         gCqZQlCjN0R0UjYUwLLrS9XHHRTGMmBwby/r5QKaKCFHTZ5PNeBbtbxisKpvvEhsMgrV
         HWNm/1gSA/JGvNlIUSBPfSVrGjSTt2ewCYg7gQvWj7uyh+vjcOuaKEwp6Qi5BJofkFvf
         QIeyUfX89YfY7sXKhhV9hkr8v3hv64lOrrjjxLiLQUaHL+Ld08RM3n03zjDOVnMKUt9W
         Z0nsIH1CDdiGpTJXRtrfCts3Y003pk7lHh/Ealk9DY4kQnvVNKU7L9sDz8jGSdHgFSc7
         AwRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757730914; x=1758335714;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F1OrENnafvqi7viYwg1HW9pT6S48DSJWyEIfpM3rNiM=;
        b=MRwMJ3IkIpmMZ9idgtY9egkUsPQg8IGvWsZqxPzTZ20hlG8MXpSy44HzaoH//7XnBJ
         xPiDONUvQ7wr97eIDewTZKA+/e5YKCq96EHk3lO3gfs5tgm6C1Qej4/pSKGUnvpnh/yt
         tEmwYpLUCNaWEvSURukvVC5zzxomVO58u80DoV3sGbWPBIybFGR/4XHl+WwwUIarwJhd
         MemRX/fdifQiWEfwIkiduQgGnPlOGT87KmH+aif++NhakOHocOTs/tWc2lmVzAn12o1X
         0EKYY6CKMR6eWuncefqRD70dee5/Xl0k5Y0OIX6yxQOwT59noWL7QGmulDeiugn22gOX
         kyEA==
X-Gm-Message-State: AOJu0YzXc44Qx6GEIWF3BIabiDIMVcy2yJmPsageOUakGoPhHJgq2rAH
	ujqLYgpslkBae2vl1g+TYcElgZRJrOQJBQtWykI1nRDKRxSNTIMREYDa2WW0
X-Gm-Gg: ASbGncta5SRaj3SwAgpor9f3q2bmkkgM4KkV5OGv+c648Q3gcojoCP15fkLfIghx26H
	/utF/QZt1F/1YVuQ9NDNbIaHagDygfp5QRn9X+EZd7lECz7i33SBUtZQZQLXeo1cixzAvNb07lk
	lRm99TUYUDLbVnnfp5fx6GgHULp4aom0fNLCqB7vvisSPj1wpaFltRfS6VwS1SMgLhDBlH3WAA1
	KxvzaFlaL67gF1d9sYwVQtpvkTIgEp5pHKUqtBD7nDRUMyaw1Jdbz1q+QrX2AlhOu7lyL0ZgyNu
	hitKb/v1UnM552Q8rMjEcyma3IpS5v8Mk/Ux5U5ET+BdaIIewj9u/53eQi/l8ZNJjs7m8pVKRp4
	tliqwjlbAKYBvxwKyz881M22qD9gSkZs1tBenhksAsl7omu0=
X-Google-Smtp-Source: AGHT+IFDMSv4pJDVHzjR3eqNSJajm3e67Bjb4nLC5G70CQPf8TQ3osVz72Usg/7k3+X3UJyUjnsiTA==
X-Received: by 2002:a05:6602:3419:b0:889:62e4:f65b with SMTP id ca18e2360f4ac-89032906b38mr722550739f.1.1757730914284;
        Fri, 12 Sep 2025 19:35:14 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.160.195])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-511f2f587b2sm2250297173.32.2025.09.12.19.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 19:35:13 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1757723270.git.tanggeliang@kylinos.cn>
References: <cover.1757723270.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v11 0/8] implement mptcp read_sock
Message-ID: <7607406e-26b2-a934-3774-c29a1176ddd4@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Sep 2025 02:35:12 +0000
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
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/17689445299

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/4e5e8b95edac
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1001988


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

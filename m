Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A75D281369
	for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 10:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758192347; cv=none; b=YAgGISK9KZoIbm5lVoA3c2uKdmmuTofe2DhF+YGp/hO6W2lmSUH6SAXNWhuMkDIwY+4ztRvgCufkzx5cgrrUyY0kl3aR59SrxKWqTrgy4Wuq8jiosUbzsZpyZLoBifTtjFvEjHoXjs8BTYTQ+W6mmClMaQHtOHtuCd9XH6FYlYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758192347; c=relaxed/simple;
	bh=/PTrNFdLuT+O1YX1mezbw1JfrBLplLROxBf50o+39GU=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=OeDaz5/pXc/mwLulfZqxN4CzJEagbkFy2+OikXCJo+VGanletF6D4/YUS3cE/CsMOSFCVK83lipw8Qn25NWoHykjp2D+5Sz88uRkDdNP4HFAvwalJveiFFV7rHltbTq2+cMpMMXQl2R7WsbxukO1G6Ht6+3fLyum0dmajNSXDyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmvary/q; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmvary/q"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-42401f30515so4442115ab.0
        for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 03:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758192345; x=1758797145; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+3Vsyt+QD/5KJL7f4+JwVFCjRer19CFMV+J+fXAefg=;
        b=dmvary/qlwFnSsTkQ+ty5zvDoPPSSAB+PUrJqEify1/zGJA8oNASaC8pY7nadPxc1R
         /Ukc+iGw7IXN6CGn80/Kg3RjOogOK1rnBhJ0jle7C0FYT4vI+1Fk3I/bAGquw9pSy7zf
         a1mJDrPY6tapYEv52LPBK/gTHtreTSzlaK5jlMwf/NX7elmNcB6n+QyubEbP3Ydh5E+y
         ROH8ARjE27TVEofRDmot5OjadLyzTJGA59fS2Nz3Mc8uzM5D54PaG+pipMLZUz1reAfX
         9gsyWtzOAohT66o2lrlnRQjC9xW3jCg5ejEgIG1U1Pe0BQtr21XQoKO75EobzlAKZetb
         SdmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758192345; x=1758797145;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i+3Vsyt+QD/5KJL7f4+JwVFCjRer19CFMV+J+fXAefg=;
        b=pHLpGhBwE0+8uEla/3Ev+8IkutXgAPwdpKAtMahE2KqQjC5HOlfQYHFJKYpwNxeOwN
         z/3iDas5WSVFaLcklHU4o3Vsil4/m9MbLPNKmgHULH9QMaXf1xl6kmxKpy3rbdrZ10I4
         swMANWcFUQI4EVcfYDoOze4hAHduUULlCJLQSdcXS6jSdN6YV7Oy4Tm2Z6cnIQEJBo2V
         9kcYJ0a7lsh19Dn7HzIFiru2ZkL5KitK8dVYPAnnUE2dIE9W0e+PPhneGP4ZmHQ5KdyA
         V5jgiY1ZOnobAOfg9slzeu6ymVXUqgHcmwLyum3WfqKC7aC7cD3pn52nnZGVQc8onokI
         dUFA==
X-Gm-Message-State: AOJu0YxV3LlQtk6Rg4q9jPrXFfj4DXCvPL3z2i8Ef+NBp/19q2ykll0K
	c/YXsfMk23e8+KRM6gDwPZJh2ngEXGsRv6yPOLw4H7v8xFCMm2dYWi0=
X-Gm-Gg: ASbGnctfxw5sNdsm4mzFAmykGWK8KUhduIrnFFfsSTTBG9+ZR6/8EsoRf8z2ZnKRy3l
	RuntykfbdX0mNE6ucnPvoq1tr7raLEbmanbgegJQHDHsj08ROYjGsfd3z85Qvs5lgpvmb2DH70E
	u1no5VssQozirodea1tG1HsEgmTMBf3d4kgbwWfz8j+8csrSezic31KelQg0h1OnmHp+4vueK9z
	dcbMvJvJAZTB4hFQAlYdhgdwxA2VO2IHAc1jvpUoPBpr6O550wKJuuJjax6sOSTDUhCxhxjdp6s
	JMUUYZv4JTgbQ9zf2dbJlr2BQhPthf7EHzbTi9DKy4UaWyRJai8UQKxZMJCRIpwhgd7T4sANt0j
	8AGCkk6jK/SFIegGRLHIJc4oZKMAsfH/FQFpVfUhMSL+YONryZqUl
X-Google-Smtp-Source: AGHT+IFdhCfICaBdRh5s5EunCLEfwgcnG7RtS8z5rTj2MZ8w9H0c5+vQI14cbPx0J3rKpwXbC8bMtg==
X-Received: by 2002:a05:6e02:170d:b0:423:f113:749d with SMTP id e9e14a558f8ab-424441fba5cmr36492655ab.4.1758192345046;
        Thu, 18 Sep 2025 03:45:45 -0700 (PDT)
Received: from [127.0.0.1] ([40.116.93.55])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4244a36aa66sm8511185ab.8.2025.09.18.03.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 03:45:44 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20250918-net-next-mptcp-blackhole-reset-loopback-v1-1-bf5818326639@kernel.org>
References:
 <20250918-net-next-mptcp-blackhole-reset-loopback-v1-1-bf5818326639@kernel.org>
Subject: Re: [PATCH net-next] mptcp: reset blackhole on success with
 non-loopback ifaces
Message-ID: <cea88b72-0e45-94cd-cda4-799bddaf3dbe@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Sep 2025 10:45:43 +0000
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
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/17823928930

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/8ae74e00f863
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1003682


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

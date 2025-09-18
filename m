Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6E5281375
	for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 20:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758227637; cv=none; b=UjoMDXUcFWo9GglhDi4aTMhIeHquY2VGNykS7qwCsSojF2VRxWG1hX3JdweigJ7us3jNl7ZwmoBrCShm7XnDp3XpV6wGi9A7qe0DzPKi9wek+JdtpmACeTOgmDC4lASbHkfba5c2ij74E5lQ3i2g5HZWJZOgVdfP9QpanUtnR7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758227637; c=relaxed/simple;
	bh=+OCz2UIRLP1X/FHYxzqZx1v12BD1EQb5ylaIczX4NgQ=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=LBKwYnYXLtiSPaXRh5gjjbRd8xAyT+a3xOWuoWBCvnpascMo1mligMYuHtkQmnydyA6njQ7WKT9/4KNCuCiBXnGBvntooP5YH+w92q+yGT9KZVU3bByO7Y8hguzHpuYnhtM+M+7icqA/rS77uoZNVdgvC5yp+E0duDlZsngh+Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JSP8zXq0; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSP8zXq0"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b79773a389so14560191cf.1
        for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 13:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758227635; x=1758832435; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BbFyjHVZ9QQe54AtSZDS5R+Ubw3yZ5KQpDaZa+ebuOA=;
        b=JSP8zXq0Du4AQMtJQN4+1yK7z6nrz3uVICohMmHKyLX8zZkyLWLFxrf+72fIvxdHkY
         u/clu3SvQDBRcGX5fNcuI6P/sSSdctXTtVfIPaQr8rXXUqKRB89OWWsix+JoV49A2n0I
         Koch1DjmG3Q8sBK3jaAGVcbHI/YxV2nhFsSo5qp+Oiyzgb7nJPJ/j3HSlHAWnK20Tnwi
         VLWba5EilUThaeNuL4P/mNvlRDtUQ3cE/cM5PjFhFQRxT+vKZi9u/b46ds+wzHyQ5JOj
         2F+fMySPb1aINuWd/VxMpVxQG6f31lujyl13dSsJaD/X3SBkj8p0CKVKpxirFxNbKDp/
         2X/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758227635; x=1758832435;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BbFyjHVZ9QQe54AtSZDS5R+Ubw3yZ5KQpDaZa+ebuOA=;
        b=vDt6ZntPHION2UK67R7PWIi1gs0YljCOZ3MHGDsRLH4Pvh2DbAQOGs9J1LlL7IM1NX
         fS/tNrhInYdVOM07cSjhwY63Lt5mB1NbCYzeFdMTGTGnpv3yUgaBiBCVxNzLt1AQgdhG
         1eyLazpGuFFabdhmhJhU5OqD0yQ0zlB6y43HkwLNIkXNkJGebZeFEZYvze35AO0OUpNu
         ErA/iZH+FvDLTQAejiBrvxlYvod2H78leD/PfupIjIzQayDzE4O2VDt9s9fJyT2/5juE
         ySs1CLOh76lFRYBP+H4ONcVanT7rBzd0pRFaRT+V6aeepJVdTmF7ru8c6BSbFB1qvyUz
         IEMg==
X-Gm-Message-State: AOJu0YzmftXy+7CPOs1Fwjr15U2sD2VTx0yxvqyZaa+MhKrjj2vKgNdr
	Fxhe4PIlVxjFZCtfQsEIKadu9wOJ71h7aUqoGMJ7aI2VtfJL7+YoQa3hQjGK
X-Gm-Gg: ASbGncslc2/Cf4VRZdh9sWOHU5BT/c4sM3MjesOt7MyqnhVKXg324QzR+aYL+AsH20K
	VSkkKRKFq2QCqSpQZK0Q2eElsDkrxBuRomMeRKV7j6RPiFqAA9Zcdukaze4JtSd/ADAw0pkhQrc
	Lz5qdWyAKZeqsCfMFWkcVD5fJX6DSuR/bwXC9Ha5Bb3H64UwpzLvTvLiTXm/3WZ4Hh3M7uzmMdZ
	3p3wwNQKRZyMhXaDa7Md2L+FXn2jjiWYM4QrMvHBbsB1u2EcrhTeEEoKQCS1A/WWtQ2WYRX6Ny9
	8v3v4LCFbikQgM99EIW9oqvGAQdd0SDJdNu4dn7aRkgOVWy5WTt8T6wzW6y+t4Sbkobh74fKQVZ
	uuw37c/nyG1Z45UGKLj79JrC2wcPsWJqEaEKPDDltKlhC11zUodaJ7tGayZXqiYcd
X-Google-Smtp-Source: AGHT+IH9mEYAWPqE3c8dZH9kzMXxzQOfmh4hr/FMKmUYYwweiOhBe7+Q3n3hVHkqAunOD4weSAyJkg==
X-Received: by 2002:a05:622a:4d03:b0:4b5:8af8:6b28 with SMTP id d75a77b69052e-4c072f1e1bemr9695551cf.65.1758227634289;
        Thu, 18 Sep 2025 13:33:54 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.47.38])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-83631d5d1ccsm211743985a.53.2025.09.18.13.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 13:33:53 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1758214563.git.pabeni@redhat.com>
References: <cover.1758214563.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-next v2 00/12] mptcp: receive path improvement
Message-ID: <dd39e243-9ffe-86c0-9db7-6c108470b3b2@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Sep 2025 20:33:53 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 5 failed test(s): =
packetdrill_mp_capable selftest_mptcp_connect selftest_mptcp_connect_checks=
um selftest_mptcp_connect_mmap selftest_mptcp_connect_sendfile =F0=9F=94=B4
- KVM Validation: debug: Unstable: 5 failed test(s): packetdrill_mp_capable=
 selftest_mptcp_connect selftest_mptcp_connect_checksum =
selftest_mptcp_connect_mmap selftest_mptcp_connect_sendfile =F0=9F=94=B4
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/178367=
36262

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/20282b41a458
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1003937


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

Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com [209.85.160.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177A022E3E9
	for <mptcp@lists.linux.dev>; Sun,  4 Jan 2026 11:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767527804; cv=none; b=QqgwmyAMyeILXRIGKcXDaBf7N7VsXkU4nlwJZxfPi3Z2ADlyCIlIGs7B++45Ck9yA0qJAeLhV/lQ2xx++2DkmansN93IgbL1Mk8Eoxnonbz4jaRZv5Jjpeh743Ksnh0LdIGyY3iKJoc+z1l8SNaSTSTvSU0dLDPnLgpFMIjpN+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767527804; c=relaxed/simple;
	bh=G/rDW3F04jQlKi+cpyxAoeANsjbvAax4Yavod9JlLQ4=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=AguTPKH7nbGXnJf5t7bqT4Uz9C0sED3/tzx46B8ew1EgJzB6bCbbiLW1f0/bGOfsj3gp6NtWRPDcL6FwML5c31cBvAwiKFUz8vdhafyBqOpNu3gqvEvuYkyXqMrtkJdOuADFpEQSBNDsfFKJm6KAMykZMnWK/hy+0aEdZqFW5Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SI3D4XB0; arc=none smtp.client-ip=209.85.160.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SI3D4XB0"
Received: by mail-qt1-f196.google.com with SMTP id d75a77b69052e-4ee13dc0c52so119060441cf.2
        for <mptcp@lists.linux.dev>; Sun, 04 Jan 2026 03:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767527802; x=1768132602; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6HSCaU/h0toIBmP5tQzQkw7HQfc+iF13tb49wG27tM=;
        b=SI3D4XB0z/Owq7phEneo72dER4UwZAuJTwTP13u7p6IjV47IO2Ucbx4sVjcTd0QkDj
         fR/rL+JO0XADkqxBt4hSABlYJNg5BkGBzenD+yNppplagREAzc0TU9MZ4KaqDjdi72C8
         5RcqchVN4VdzgVd8E8qAZR1iL9WTPsBGXJatO71nm+DsQoSPFo4YUPXUmvignFTo6MaH
         QjeSDZixv0jNhHYVM8S0GnAz07m6K6+0nKEgrxuPD0LHJWMn8IDXjejA0fCFV/p8h3NU
         Oc3gYsgKgbPbzc9F1hXv2QDTiaRPQbTKm+sRSoukOeMTmgE6AWRnIirT3Hf5GLeaTcOY
         9P0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767527802; x=1768132602;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6HSCaU/h0toIBmP5tQzQkw7HQfc+iF13tb49wG27tM=;
        b=v0VvxC6rdyTi0eJS7+Xv0Yz/3deRis7hIKpg1AmpTSTyvi6k32qDywHTYyvdjP5Fpe
         ilE5SmI+MlUmYS/MyehI8rOqh+i8/i1MAd9CadSwpOYpZgrKlVxFMOFFZ/EAPEw33MW0
         d2VDZVoUlmwCR9UvZMdoBNFeNwZnpFTYYxpU8+j1bItzpBkQSqDmFo2HnjUQtsYqbGII
         23YBKjqaI9js9Cp76fIxnBmicm5/pBN2Zs5EkdfgW49Tix0kDlFJNFHUhiAjEgYWZs9T
         EceyCp2QGqXdRNrcj+GHWY8rfINeSomz+LjYb+MlraxQ8Yi+Q8A9+BnUQ4Exb3S33fl2
         YpcQ==
X-Gm-Message-State: AOJu0YyJKd0W52XWNHR/aMz2747OzNrye2+T949n3AUe5HXPuQmUnVmA
	l0WkIDa6TShuChRohkuJhb3B/VbY9WuxlXkXreykSjMHT89wq/rliAdbB0+h/vw9Tw==
X-Gm-Gg: AY/fxX4YPnoZE+A5nC3gO2eHi5N7r9EQdzKcJKp6ALGTQuYDvdlAr/8csm1bSoEd02V
	2MsL8YDk0z3+9jykZ7XT1QqCiENvwyMm57UXm/Fe/zOOQjA4Zd1uPAMi29gGsUCD0tbkp5/CHGM
	gcFJ51iTfVecIQDMTUVQ5y7WajGIy+b+wPGIECPfPKF2Af4QB6AtLwph5jz4vt0XPoj+BOyR9Ac
	mObF5+3A0/qfZXHQNH1h+rrNkbCSUML4vEyrIpD1VyBxymzYHjeO516i8MUTrPnAcxxvzm76PJb
	jU1jGmU5bd3//AVyO3+FGSm+aLZN+0j5G2AhJKaxyjp5Tmmz8mzasmtkl6h7SASW7Xusq3H5SdC
	MTnjC9zxVr5h5H6kuICUPQsR8CFv56U0GavCM7y6Y4kjECC6Jpq9PP9nSGEGGoP1ABBdQo2kNhn
	9Hn1wxQx6GbrdeYFue04d3rCDy
X-Google-Smtp-Source: AGHT+IGE8gxy3IZ1UQa4sHPT4l5JxLu8Vn/Ou60KnWqW9ytWIV9UoDGQD0bRIVteja7AvPViIHwsdA==
X-Received: by 2002:ac8:5a95:0:b0:4ee:43b0:b053 with SMTP id d75a77b69052e-4f4abcd0726mr630416181cf.9.1767527801892;
        Sun, 04 Jan 2026 03:56:41 -0800 (PST)
Received: from [127.0.0.1] ([135.232.201.81])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4ac62f973sm340725011cf.18.2026.01.04.03.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 03:56:41 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <867d350fcac80ce446ae2a756f1eec09d4cc54fc.1767522515.git.tanggeliang@kylinos.cn>
References:
 <867d350fcac80ce446ae2a756f1eec09d4cc54fc.1767522515.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next=5D_Squash_to_?=
 =?UTF-8?Q?=22mptcp=3A_implement_tls=5Fmptcp=5Fops?= =?UTF-8?Q?=22?=
Message-ID: <3ba0ee93-5bf5-3f05-8e42-32b543883c99@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Jan 2026 11:56:40 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_mptcp_join =F0=9F=94=B4
- KVM Validation: debug (except =
selftest_mptcp_join): Unstable: 1 failed test(s): packetdrill_mp_join =
=F0=9F=94=B4
- KVM Validation: debug (only selftest_mptcp_join): Unstable: =
1 failed test(s): selftest_mptcp_join =F0=9F=94=B4
- KVM Validation: =
btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: =
btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/20691737340

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/c170b3ef73e0
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1038182


If there are some issues, you =
can reproduce them using the same environment as
the one used by the CI =
thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
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

Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029AF1BF80E
	for <mptcp@lists.linux.dev>; Tue,  1 Oct 2024 07:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727769584; cv=none; b=CrU/m+8L7ag3y80oDVllH32udoMvwMATd/peHKVGr3PyQXFTuXV7USFQwjIeJBbwNtFjfAfABmJ3qSt88XTiIAWp/ukC0mELZSfrNgsyU4QSkNGzRh7dM9tYG1HIYF3HGDv/2xYEa8+ERUNvPJXN9/zoDe9BbgMHOcSGWU6FIAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727769584; c=relaxed/simple;
	bh=s94NwAoXm/k+5Sy3cBHHRT52hSX2SzaGlBD5fHJ2Lf8=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=ory1XapS/MCy/saaOCRXXuhQFaEprUvm1woFeNgVyFeHjCwoLI4TNsHqdmhrwjDaMQ3Nz9LwTPodsAgXHCpffs9zx1rB7R9bmdn5sbXmNwgyQRdZ5TbXfQ+LRlvPXBLTNFjMDXfdef7lYgLfZzkOlaYD9+138qX7JfiKBNOpgfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkQkSnt5; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkQkSnt5"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20696938f86so44981395ad.3
        for <mptcp@lists.linux.dev>; Tue, 01 Oct 2024 00:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727769582; x=1728374382; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=453VkcsWExJS5evxqe4/d+WEQOaiXzPW5mG18+IZZMs=;
        b=mkQkSnt5DL0aY9f1Qpv9Q0SWqavEToLG97OverUvNTIwBwT/zHqMNVfl5J2zP1efuJ
         onnOpg/22gvHTLzTk43+SyXlUoYctsTTNRwaZto6cRKc1wvikSNuImU+gOvEO+0oFVtw
         Onfrf6RmRyN4phhV0X26vEsk6TnB233I+UhZVFK0px3wVDMvlUxdbk6StMA20K4gOwaQ
         vEJTDqO6GhdofIURv4/V9UdNeTsGhUXZU7nKqp0CnCp8fTL6yByLmUi5L2SEGCx0ihKq
         0FAvbvLH2i44f0TfMYCUcvL5O/PWwnmuCxtP7gVVbgeSw+6JJANRNGlT3d/0TGjn8p8k
         YnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727769582; x=1728374382;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=453VkcsWExJS5evxqe4/d+WEQOaiXzPW5mG18+IZZMs=;
        b=WP8rij+q+/d8429gy/AGLklSYJxIDa1e+Vn8ZvL4V7AdAF5iAvf+J1PHK33U7td2cl
         Aj6Gj2mCUakJIJyfBor16ghJJxLKK47eq5OPysgms1sZ/1EeGuA2i0Sz6R2GFPaiwiRo
         iFAeyMAzRrYyTWi9BfQuIFTY9MnhVT4bt90vvX/nAj8tnhEqSjP543R+Ujo48k0ufGJI
         sIHs3m179jvOET/AtSKTnfpwKPGSeDLhhQZovZMzXufOplWdbFE5WjuSljPOCJ3c3GUB
         /QhqGnxm6tOHR1X7WtzWbePbrVdp/8pqoeniyhuxUjZxbDDmhZwjPryx2Xbzyq2IYm+8
         mZNw==
X-Gm-Message-State: AOJu0Yww3gEyeyiNphzf8af4/DWSv9MvvUA0gsYiR5Sxd5uR4E8DGlLd
	GwidA8BSB2c9Ur8Ltl5bVfrfBO9p118OZVjrNE8pm5dDwU2qx9wRUgRL
X-Google-Smtp-Source: AGHT+IGtnrjA7iKlT+AhyPHp8gD5s5u8Q+Y9M4CFdr6M/tBOpCF50PgMoLDcDfJpS3yr7BiJkOMriA==
X-Received: by 2002:a17:902:d48a:b0:20b:7094:8d14 with SMTP id d9443c01a7336-20b709491bbmr106244195ad.5.1727769582216;
        Tue, 01 Oct 2024 00:59:42 -0700 (PDT)
Received: from [127.0.0.1] ([52.190.141.112])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e0d5c4sm65287695ad.157.2024.10.01.00.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 00:59:41 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1727764822.git.tanggeliang@kylinos.cn>
References: <cover.1727764822.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v7 0/7] add mptcp_subflow bpf_iter
Message-ID: <bc06fcae-e391-051f-46d0-5a7bf81ab5e8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Oct 2024 07:59:40 +0000
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
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/11120333559

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/1c40aee13c8a
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D894364


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

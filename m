Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540881C5D77
	for <mptcp@lists.linux.dev>; Sat, 16 Aug 2025 09:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755335063; cv=none; b=dt+nMOne2b6Zh1TqXrTvrs3O/RTvWbXrFjAsbGplO/nc2KfvMzX7YJnUmfJQE6ClmH9M559Dms3CpzkcIfw4+1bh+MS91M/5ZpG4Y0WnHgCaY5TYWKQB2yA+4aiUUOUD9f4GdPmOIW+vjkXT+b88Iq2gquS5zhdlcyQ/fOzSQFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755335063; c=relaxed/simple;
	bh=+zFjADLX+tanz07i5FdEOj68Bh4+YllZPWm75W1qKQ0=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=r9YxhYoAp8bS+mJEgJP9WvBDgNfwRkwcn9Lt1ocVsWekZykNxsC5FqUA5JzbpoxKGE4Kte9dqwrXXcQqRMgv0NHwCMup5NJ7Skl3eZEzGtf+eCoU144G9yt2VLvUaMF/lBH6XWodamBNUAfGLMIgrX+bXugUiajLFjdXm2FWwuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9WMX5Zf; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9WMX5Zf"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b109bd3f9fso37491441cf.2
        for <mptcp@lists.linux.dev>; Sat, 16 Aug 2025 02:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755335061; x=1755939861; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iYH7qrEX5DEsB1f8t8xsfiEAR6vASuandY90T6TohYw=;
        b=E9WMX5ZfzG9sOPX/PqAv/2Qy+QZZWTrNCnaDh7gdjBFMIyXcA/tWLZhY8tapJMxrN0
         uiCmExA8p35pOR1hUmCmAOKr1Hog5PTGYboMtOLScS07dmIpQwMsJoBM3CLwZsj6IPQ8
         jy/1juOvGmxu+iD20XmitfjpaNvRfC4XjplohDzjoCrZk4s0Z4aos/94qexDvGJ5TlOP
         gWhxnIBOx43SwRwEgA33KhnFOp6QBcif+9xVbZC3va0DpB2pV2EhbnmQBMNiSslr7jHz
         409kD+bc7qm9RKoFXnvqRiVO+uaEmB9LJv0qkaxkzFC+42OQRkYJruEAOP+EJ6YNf3Wm
         NWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755335061; x=1755939861;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iYH7qrEX5DEsB1f8t8xsfiEAR6vASuandY90T6TohYw=;
        b=EtnUMQk7Orak6q62LwzTywdxZyLt2MGK3Ncvnpgp8ma3MOgARKQV4wu+nqfneeelho
         yUPkvZ16EHhhBNfWIW5rV9rapKB8/FH79KnCYBLBv2RP90mUd6qjLqriJm+XpdkHAv7p
         QKPCaIw1gnPb8QDDIqLSC4tTJD37iFZZiGA7S7z+2z8/FCMyDYFeDmCf/1PQ//yICvMt
         StJ7FXI5/ulB/GdbL6KdX13XlgLjQ6IprycJc0xCi0M7IAKsmcUgK2//zi5bgP2ofc7m
         ZJjuTjO2RqG6RdyVCggAE7LKkM1uJgJdmF+3G26z1W1HWIyo29Pc6/uvYY6UvHEWSmEE
         2bMg==
X-Gm-Message-State: AOJu0YwqY5OiBIBplh3kfWl9KmMIcP7dlX+eL+LSuSCOQPiXlsAQca3z
	ftUdUNySKMoZ+lAZmYLid1LQg2bRxpTnDWe3bdes79A1fK5HeXYBmn2UpoPR86Y=
X-Gm-Gg: ASbGncu42o1VwKUF4ZclDoMvUuVKHColiNx25RTcayJrHfXBzdVnpTfoR8Y39qs7d8w
	h8cywCJafA7stdjw4+/4adeCZPasrASoy2EuVYnwGSF1EqEkl4Ry6nAgrTnVD1AqxEgki7sThBb
	N1ot0V9UkusIIQqjf/+1f59MTO393oru+xHB99NQJczAexu8RYZhWO1kUh1GZlMqpPrJiuBIhQZ
	cHdsBxx/sqka+bjTcl4+NO8+h1RtGiN6jKywcO62/7GHipBoileDcSX4EbXf31lmkQacbYuzr6E
	9TEhjhjn0ae32JdLmAa5HiGjwp3NlEXb6Y+vvkMHnl/mtCBj8lNeLz7ND3cVLH0+K/cXiMIa0sh
	cOjUOlyrHuRlQ9Gf0bx46mL9j8eDWc1qEpQ==
X-Google-Smtp-Source: AGHT+IH0YRaERXC2Z6qjKrRs+49vBxFosvU9pWGkJ7H75vW1eJXDhICAKd86pIidGImygViLsH2Q8g==
X-Received: by 2002:ac8:6f0f:0:b0:4af:41c4:a491 with SMTP id d75a77b69052e-4b11e0bb58cmr65431371cf.15.1755335061104;
        Sat, 16 Aug 2025 02:04:21 -0700 (PDT)
Received: from [127.0.0.1] ([40.76.239.97])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11dc18fdcsm20772961cf.3.2025.08.16.02.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 02:04:20 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250816071814.10087-1-yangang@kylinos.cn>
References: <20250816071814.10087-1-yangang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v4] selftests: net: mptcp: add checks for
 fallback counters
Message-ID: <6b21b68b-59b8-4ae8-7e0a-c071872ccc3f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 16 Aug 2025 09:04:19 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Gang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Unstable: 1 failed test(s): selftest_mptcp_connect =F0=9F=94=B4
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/170058=
94805

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/758610f062af
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D992117


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

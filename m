Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6E22E401
	for <mptcp@lists.linux.dev>; Tue, 12 Aug 2025 10:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754993968; cv=none; b=CrhAwZw2bbhFV3wEEVrLGiqrR12c2CH1P32NX4UaF2yhZX1gDkFGmgp//7s+aaRN3zONNj63f6gLq7HZPj8V3bRd02B8rOmNVB1EdV6tdV/lG/fR8oyQIgEnogojzeHNQpn/ge4XbsGtaLxnF9acVOJ0b0uod2bHsUjtQOqdxCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754993968; c=relaxed/simple;
	bh=yqXBVQ4N7B1aTpjMRoH1rcgFRbkimC0W7vKTg/26NQU=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=U9G4GwRqVzdKI03bHMXwlYeE0gRqO/s0AEb05agZj+VMRrlCnR3EjXENHkH7kinWIO92C/1PHVfXgqbVFdJohPj3gAPDx84zhI5XTLlMEAb5I/Gnrn2TbtVTXZ81degB8WdhlTG5G9MVr03213eHG7OOwfZAqMju1gCcxIx64FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFuMK8l4; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFuMK8l4"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-87c0166df31so330031539f.3
        for <mptcp@lists.linux.dev>; Tue, 12 Aug 2025 03:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754993966; x=1755598766; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ehMMRZT1ubFk5Xdjqi+SlHbOgEhlBdpSTxW0e+w2shY=;
        b=UFuMK8l4KIQpl9xsq2uUeLnHJqK+nh+rxgqnifQ71jhT9Q6TkB2F5mTXuuXfJ6GX/h
         eeBqztKP1y7+GU0/59aviKPHi09QNCjXgSKg2mD1HvHCE0sWah1Xrk4VdgxAPeG2qL5Q
         yKMqAANHH51HTcAhetgt4xv5bcGrkd9anXmYcbeAVseVmqgd0SM5a5Q5Ek6LlJYI9WRf
         3zVeggegVX5gCY10Msso9X/YdKBp6mE5sCbNfKFbpcUAZkjBMszMF8e4hBuZvGSsjaax
         ireyfxd4YK+rt6E+0cdEk1289N4XDz/qcyOqM/D3YOAgaSTMPGSZgEKYVZhsJZ9OAQi4
         4TMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754993966; x=1755598766;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ehMMRZT1ubFk5Xdjqi+SlHbOgEhlBdpSTxW0e+w2shY=;
        b=Lcpy6jUqjRDxQdjLsk8HJR9SOrvOd7zhfflwy1iDvGaK/x/hqS1tGq8zCDEeg+yp8p
         FEw8OyhbBXwKyzF9HD1DRGNnO9u/UyDKsNv6rc/7yCymcef8GuMhPxVVV2WSVmDfukEe
         R890AKgcIBKvi+jySVxf/UrMqdXCM+5MpzwXu61zzljRQHuhvP8rl5vyXkCaafIOGKOW
         JgVWXVW0aAJkiX+i1eYczXq/lS1pNkue0L9ISXrgtiL6vAnoWOcOdWUMMVX7Ivj2E71r
         zw9crHLySGz+i8VCSfr45V6ayofpR/dJ2c5yEadVs6FuEKNC4QW5w/29BINihNXd+Oj+
         gpGA==
X-Gm-Message-State: AOJu0YzN1Ma5ec4I7HjqMUV7n5pDZRi/bXqG32ifVTXAVX0fSviKTlee
	MJW3TvLPbHxS8lMWuvOUACE+T5Yq5kg5Z287w2vexWfMHM7/D+ZuMgoecvsd
X-Gm-Gg: ASbGncsRrI0kvVf2rTzqx0zZB9S6TXX6YXb9/880B2eHqyVP5377F5tRUwr/7XeBl2l
	pXz5Kz3AbIXXnVdiAXbDUPdEmGh5lQxXjeAEIG02H/YnlYH9DUa4DdNWc1Zj5zd50Juu2Mq+3ci
	xkTWZEBf9JRx7XBGyOgTo+INI1/vJWfznFxsjg1CffsBf1bAWMfBV4M2j4oqpajEWWzawMx4iAh
	KpTfR5Fr9S5RAKDV1BRcuCsTRuGd1qUTiiDa6Zc1NFXjjFGM1//E5FlASNnS2zZV403BDxDvTAd
	B/M9Iq7WIisGw4JyE/lqch1r2hLN3qB3lAYK3QV/c+B9z+DKj9DNu5tnRSVRWp9Q6ZyxKiWhSIW
	VDVm1kKxuVeR3BmMX5Q2bbC0Ndv7MFKWB7HWkroHh9TC8al8=
X-Google-Smtp-Source: AGHT+IGvTBiRnDLSJcAL96IMeaXSHtJlQ8n+lgUhFZ2H9CQM64eyTzows4X3Uzos5QQza81ht7qsdQ==
X-Received: by 2002:a05:6602:6403:b0:884:e57:9f1 with SMTP id ca18e2360f4ac-8840e570f10mr1295129539f.2.1754993966156;
        Tue, 12 Aug 2025 03:19:26 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.232.66])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-883f18bace4sm367595039f.7.2025.08.12.03.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 03:19:25 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1754986785.git.tanggeliang@kylinos.cn>
References: <cover.1754986785.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v2 0/3] mptcp: add more sockopts
Message-ID: <897206f2-501c-0451-18d4-af0a3e543ef8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 Aug 2025 10:19:24 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): =
selftest_mptcp_connect_checksum =F0=9F=94=B4
- KVM Validation: debug: =
Unstable: 1 failed test(s): packetdrill_mp_capable =F0=9F=94=B4
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/169035=
40842

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e5177b226ee9
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D990418


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

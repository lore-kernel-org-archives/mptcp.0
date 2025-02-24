Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68751A83E4
	for <mptcp@lists.linux.dev>; Mon, 24 Feb 2025 10:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740391612; cv=none; b=j1ovDamyPh8YsVyIeh6O4FXLCdq4OqdZNIBUBeEMIVGf920JhYhTMbSUXRLoru31h/ap7z0937b6Xf2NajFZDAV25S5stVbNQVZNj2FjG4P+cQRACgMXshjlbJUcI040Y/9j1uyMaSXRPIqENmhBBiZrwqP3ZfA1DkLgI0RYbE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740391612; c=relaxed/simple;
	bh=GeFrcOibO5vnNWftZ7aPO+sky+1mPhwQgIcrk6PEjQE=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=afSggJV8RrWxR0/iKXwDk6XDT8MwnWRTw/9GeBbu4hoNy1llflbCfbzCBNy5RAbc9yC5Z9UtoRSxTNzodlCSCCLWFA0c31FxxDBRAG06uV/+0SJ2OiwconmuT0dOFE/UvfMoEcpEXhI/1WR3tZMtgGWoZ9i++BK/ThQpozsd6w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1ZizXan; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1ZizXan"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6e677921db0so29028716d6.0
        for <mptcp@lists.linux.dev>; Mon, 24 Feb 2025 02:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740391609; x=1740996409; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJYBcYZPTh3yTTVfmrLq4m4EmwU3u8Vx5XGh0/Cx78A=;
        b=S1ZizXanLRDzHkMXXLuXpOkRLbgN+J0HNA5nR6YWRODqD7RkWt7WApbEvHE3+loBw3
         EKaNY+3Xkv/NoGzE727RElhLALUuEx3D6MXDJ6hXCNWE77lNlGDAgM1chcjvZZJHoKAA
         2Etr6L1SiasZtmoWY0GeYYPKB0PDPHUlj4nk5pTjH/xIWkvW8fiY8fmH//+ca13nVjRp
         LBLdTPl6tvUMFBfbMnX+Q9v3hGMqo5zsxERR6X1vfTRCs4a6cdbSIhgyNY6E6dAgOfGJ
         DaIb4klsBJcv7l4uJMytsPXBJc4YwZ0KhGy+NwNZ05vTtVE4UvNZrFi6NqhATPxgqPVo
         Cm7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740391609; x=1740996409;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hJYBcYZPTh3yTTVfmrLq4m4EmwU3u8Vx5XGh0/Cx78A=;
        b=Ca65k1WiFEUy/2irLHvSkOVcySQfWM/GfrQkd3ON6AC1gTx0QKcMusLSPOEi4Y8wvf
         0n7TV8Rm3ctMBXlh2Rpr4XGissGh6ax3Bqx/7YekTmSV+aATMZXq2vP6vN3Z4CLW4y/M
         C7wOXXPsP8KRzf8cYoqGcfEdYFXc59/Cfy1nWE9Let2jU/wQla/CjBkmK4W7idGQj7cn
         nWQmOCvgBqSIw7BloNlc94pLRee3tG3Q/+KW8p9wQVIWthn79SoQ58rti+l67AQs4Euf
         C4yb//EXMxigUO+pn02swWHbHfGlOOWNbo7KfUpn9TE3dEgyQ/3t4K6QoRAPViHYPulZ
         TW3A==
X-Gm-Message-State: AOJu0YwC/7DW/McrPqK2/t04x6HNi9WyJZw0jk7u3Rvn2UJZ6x89m4TN
	gNUQYtsfXB90tNLAfyVckW+lsNT7hYdMeFxsl6b591RB7bk/uxHk3b41
X-Gm-Gg: ASbGnct3MzLWhT1yUNvz5Q+a5Xc+BgurAgRK2FVHCDXYeU+FAk1PbDyYf9//aysylId
	NCRP4Xneynx3JDMnVpipKh3rKw1XpalC3dTVwMd4FQAT478TUPBmDopP3RUetaow91+38suUbZ7
	OIVNZ7mP0A4Nw2jakk1Hj0Okp5gTCKe8HCYuM61FHF2YxL3zrdK2AA5KOBNo1ZDc/f0FrIT0+A7
	X1kUxLKM6r05lmTd29lJYy0YbmociWjRyAsbj3J9RfHQT8e+wCRcELVJb6UQONa47yONzvMVU2/
	fO1KM1d74EbkDm2rfqZIj69iUYGqnz9fB4g5
X-Google-Smtp-Source: AGHT+IGFae1ZGdV2BKT5lJfnyZKZoqRVpPaqZAusT3toZYe8Torqnpo8Y/3cB8blI1W+Ecp46/qVSA==
X-Received: by 2002:a05:6214:e61:b0:6d8:b115:76a6 with SMTP id 6a1803df08f44-6e6ae616bd9mr185620986d6.0.1740391609650;
        Mon, 24 Feb 2025 02:06:49 -0800 (PST)
Received: from [127.0.0.1] ([20.42.48.69])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65dcf9645sm131956436d6.123.2025.02.24.02.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 02:06:48 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1740385876.git.yangang@kylinos.cn>
References: <cover.1740385876.git.yangang@kylinos.cn>
Subject: Re: [mptcp-next v4 0/2] selftests: mptcp: add tests for increasing
Message-ID: <ce967652-7a40-cac2-4221-a03e8741d6aa@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Feb 2025 10:06:47 +0000
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
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/13494531915

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/07791475cb37
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D936949


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

Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B60E1F6677
	for <mptcp@lists.linux.dev>; Tue, 15 Oct 2024 16:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729009807; cv=none; b=LDZnjgc7NZuHuoTcoLevW3tBQP/+fNcx+LwbvvzsT3vCY8WD3+yba2NKuJd/L3rio8kru4vbOkzRG3IePoCLD8/jm6FBggFxNc8X+7qTUh5gkZSpz5LrpGInJ1tlHiAJhS38VraREu+kyH1vA2SZpUxm+k/bWP3KshS/NqJ04UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729009807; c=relaxed/simple;
	bh=eKYPXXAqlwfhDH9g7xx6Pr7+PvGyiCLKpzfIeNPZvO0=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=SpTASexuXDCtetTTZkmNmI0u2wTcsU1qYoIAeyQWVhUNjOUDrShagzLqbBxcwi7Aa4lKxoPcsU95gZQefk72hrGieE/vVW1Dp5FqqitkiBm0zPHt9irpaETgjCFnr6WtrzOjLoXpPtHUoGY0wogTcDgFJ3HbG7NZywKfQbG0tS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MprbgVhK; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MprbgVhK"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6e2e508bd28so43052857b3.2
        for <mptcp@lists.linux.dev>; Tue, 15 Oct 2024 09:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729009805; x=1729614605; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+FEU5CyW+CryAH0sU8GFvFYox1+yQ/lHAk5rFV4ISA=;
        b=MprbgVhKoav0pn92cgKYwYy4jUiIkPS4hH2r9Mo5e9i811WD2/Z0iedect3TIjzaua
         Gkj9BUpvft1J99Dt2zBndXFZxTlsyuwd91pl9KRN79UN0hmOz6qW8dzN5BhvXseM5k6u
         VcrPeia+8Mh/dgive6rrc7D8r44m+c6bdYo+7lngC1gMTmGS79YlVTAPlBz5DWtwT21t
         NJS0jlcAP2V2cPGOlN8ZR0Iye9kbw4kfXf6RzJtG78TSUTDeH/QloIHq2PWALhwaMj01
         LEefKWeCi1aoDLUOLyEXzRQOysc+mO8HkXlvTSqtUXePmFNTb/sgkOQnCKr+KAtRBISW
         3G/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729009805; x=1729614605;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N+FEU5CyW+CryAH0sU8GFvFYox1+yQ/lHAk5rFV4ISA=;
        b=WRuLAUo7q1q+ogtVlK0eepXPbD6in9RdbGsAfziJPS4zZNQlODL+QpbDve2SYsaRao
         Kp6UnOJJwzxgENnrkN0SH9HHBvKV0dV0D8IN3rk0NpZJmt/Gg6q4yLJuRJyli7TBf02k
         TOY35wv6uYO+1Q3x6eeC8NE1nRLqpvdXZUwQPecnFDP2+8rowPi7/3G8kik7lTEYCb/3
         yfnvV0S62JzjbOQJhiYmrBv9Dw2EAlvettZVK29ZtSKkk5s3yNKQa3kZ6/32p7I/V5UB
         AMNf9FDMUYzNcvL4PDbKUvMK8AhtHfLNps/NUoW0GuBH4DcqMwkrgRUWbxR6obAvyGJs
         JYUQ==
X-Gm-Message-State: AOJu0Yy5An64FJIdvJVHQPQw74A0ByE/eVuegjL9nZ8bOMyrEUowhKLG
	Pv6jaZTAk/qPgC6GAloDDZvFZ0M3w95SugDsly0d3C++48kkaDsOyH81
X-Google-Smtp-Source: AGHT+IELTgpyHZAjbSozu3a043R+D0ajmcY+B0yTtiyM6PwNf7Wdj6Ndx95mQjMlAmgWWI/Pp/VTdg==
X-Received: by 2002:a05:690c:2e82:b0:6de:c0e:20ef with SMTP id 00721157ae682-6e3d407f916mr11499427b3.7.1729009804842;
        Tue, 15 Oct 2024 09:30:04 -0700 (PDT)
Received: from [127.0.0.1] ([20.98.6.132])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4607b38cec2sm8176051cf.85.2024.10.15.09.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 09:30:03 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20241015151737.4111686-2-matttbe@kernel.org>
References: <20241015151737.4111686-2-matttbe@kernel.org>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next=5D_Squash_to_?=
 =?UTF-8?Q?=22add_mptcp=5Fsubflow_bpf=5Fiter=22_v9?=
Message-ID: <465fc398-2e39-8a64-2ae0-567015c7e0bc@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Oct 2024 16:30:01 +0000
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
uns/11349477323

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/3a3642f20e95
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D899379


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

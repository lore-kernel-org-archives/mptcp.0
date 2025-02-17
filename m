Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0B3C2EF
	for <mptcp@lists.linux.dev>; Mon, 17 Feb 2025 11:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739793120; cv=none; b=ZBEvEj4lX+TyJkGsmDW6YO/0ST64V57Pg6hjHsaHK69XBZyolRaZg5q2zicjoGdishBJrrVdqxDNxL4fc3YmptGX9hVJUxSqOf7/JpNSquWrzuQ6BFMhyyhmmKUGKKArRpNR+iCYXn54PeSM4iJGm78S6HrDV7G1gA38HMBKYyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739793120; c=relaxed/simple;
	bh=Ij/TEhVwsgR5Tu6oi8n2Z4tXt8yEzp+35BGNaAgDC/U=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=CHeVxSgypcYn0aB+D7A+NVxbDvuNUGxW2DYYJpqi2471ZuyKXgWLfV02TxI9GZPzSqu2+tw8SRoeV6WyhRX0j2X1gAp6uAHtGzsW0ueqHmrl8+dcO8ICzSXb0hdPEAgy6PEfDXQZFg4+gBnp6Pgpkj9tY8LiQjucgR99HvhIV7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4pUr1U6; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4pUr1U6"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21c2f1b610dso107454095ad.0
        for <mptcp@lists.linux.dev>; Mon, 17 Feb 2025 03:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739793119; x=1740397919; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDnoGciZSKC8VHWtjpo9/Ql1tW1ZA+2S3V1DSwaYtuY=;
        b=Y4pUr1U66gzGDXQghBDU+DTAExjGN14JIi2sMJHte74xdQOy6tSDZYndcD0jdB50gk
         HLQmzESnoKe/d+a7zaEobtPl1SRGaf+sjEEHABWK+cP0vyqgZs5AeOpThCzr2tbYHqjF
         W2OhJXGfkpCdXZIQmP7cnzZ9q1hVNkWSOAugHKbnMVwD+QwOI6tPg6P2kTvAD7fD+rpe
         tmMaUoDFeFwMqV6CIVtqkLq0T6kYkTrR3+4orhZ32J+UPPuiqLKshEYObhi1Fb119ogH
         AQUNKVtEeHLlf99/GouVqj0krzBOhqM8CPDgK/WX0Fyldnqcc5MDBpc3reSOn4MnWDaa
         3Wyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739793119; x=1740397919;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pDnoGciZSKC8VHWtjpo9/Ql1tW1ZA+2S3V1DSwaYtuY=;
        b=FUH/gqQ7wCm/iwrJaCSehMhdHvzhI8t74jKzb8Kh0622n3A2hKRtjXSbtn5xU54FC8
         i37ZZtEqAedsgYcDmtJeWi85zx+MTRsXygMB0ap21spUTf2AgqZwNmhpJWlfooVkkYDI
         9ZUxoIQRSoWD8VBy3qc+8j8QUbPmFCiAN2cstvRfK+pzjP8sxI0iJgkVYAz7uayQLwI5
         +U31aiimgjz5rTguCzFaQuJymu/FO7jVTwzfvP78MgAfzHkzZYfYKtBCEwdQ3KBgTLfE
         02ZOku8G2laG8JCWoeAgXBhH9KwffNby6wI+LtxzOeBC4+l6hdMtTEvlLz76tBNc2GEA
         yrCQ==
X-Gm-Message-State: AOJu0YxeFGogY4nzzy6jugwwr8P7L7UmjrMvphjJEmfxOFAIcUBO/v6B
	lQssyYpsm+b0KXCrmNhoeFypffXWgu9QwEA3uReNDM4nQpRHmGKEIcsE
X-Gm-Gg: ASbGnctlpNbW7ek4MEcAKMgHKq/jw2H2zYdPGTDKBQxJkZ30MKLjZ61hqUQFeLRW4xC
	wSgiHPk7WvKcR2jrk+oTYUW65ylMFcukoLohuI1c8x1fDbYoEUCaA1R+s7mNBrc0ZMNnlHaZy2E
	ta0LdTUK1dHyYiscF/odHcuChGittdLnEjmt7PcdMuCA7exfWUpv38EhiMgOkPcmx1dbmyL6hgf
	OgqZZz5SE5rWYchPaCvQZtX97lovxRuJT94IB6U5xed0JSrkS1LoRNCO13mfhZiYBAAcu0Ktdv6
	gmba9gMJWNqmMza2SjV+d9vxe2qi
X-Google-Smtp-Source: AGHT+IFa3H3p4j429Lmhf5M/BergHtfEWBpAxR5B9cUHxLvC2yy3PVPJlXo6tbXwb0pBsJkw97cQ/A==
X-Received: by 2002:a05:6a21:7a82:b0:1ee:5f93:5376 with SMTP id adf61e73a8af0-1ee8cc16305mr18096596637.32.1739793118611;
        Mon, 17 Feb 2025 03:51:58 -0800 (PST)
Received: from [127.0.0.1] ([20.168.24.112])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7326f724fd9sm3317063b3a.145.2025.02.17.03.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 03:51:58 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1739787744.git.tanggeliang@kylinos.cn>
References: <cover.1739787744.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_v3_0/5=5D_Squa?=
 =?UTF-8?Q?sh_to_=22Add_mptcp=5Fsubflow_bpf=5Fiter_?=
 =?UTF-8?Q?support=22?=
Message-ID: <8a1d9f2c-ec7f-6493-c1ee-0387bc004bc2@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Feb 2025 11:51:57 +0000
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
uns/13368589515

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/c163f5827a44
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D934633


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

Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1263112BD
	for <mptcp@lists.linux.dev>; Sat, 25 Jul 2026 14:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784989067; cv=none; b=oBbBH/aBjtM7ErLnNKhLW4KzlBTypgkFSIkwoonOXdRGY9LKtUgMCWzuf5cr4TgMXHLKxLuSMTbrucYMfiUh+fzAZUYCUXAQfe5UDoBp+EJo/YKKf2EZOKGFBjvLSIUt3A63HmcgUDtkjwonTjsw/lejV4bFjglgvgMpeDE1ZPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784989067; c=relaxed/simple;
	bh=5+yST5eh03HpIpLH66kZqtjgiYUDqXcZbVyzKy0DOwc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=FYcU79KMcqTwTksCR71aE07j3OHpP9aVrwayB5BYS7CycaYPpzosqgZl0ukM8utbBICw2qNn3Szut+XGrJYf+dtin2jBNXCRx5mcVL0d42RxyXx7jncpJDO8ABkOGqD4IGgba4xSr7C/QZ3HlP3ltvXn6+bhjjN+Pw7Ck6g/8G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hhbCsjuL; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhbCsjuL"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c9e30214d8fso1083231a12.3
        for <mptcp@lists.linux.dev>; Sat, 25 Jul 2026 07:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784989066; x=1785593866; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6xRDVVH+htJNQnvvUwEkU3zABrRMViquaIU2cIV8Lbc=;
        b=hhbCsjuLrc2LCqzmGbuGaRonMD8iF6nnMU7bMv/rRwMQWXW3EWKq0sdsHrKBHEjlpx
         7of9om2uHDtu8IhG2LKRBWL4aAO6mBoTt4XVP6LcqynDiLWBskJQ8psKxTB6oiwnGRNC
         vbZRLDb+Pq8OfLLDWLM1Ps10jB5oAywUNjutyGx5Cu9WtNcaI8sx/jtVQP9x+62RkVoE
         d/CtDI+fUwxTAQ5ESgSxFVuWJsGBRGMRlAUqwMsLeagi+YnYDO8p7Gnf3pzm+LrgrxQt
         irM0VVuRV1LHl7fk4c5ZkYC7/De++cNZibgJ7fpT2kdzKdLgAf39kTI8iNTtDvyD0BH8
         TS9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784989066; x=1785593866;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6xRDVVH+htJNQnvvUwEkU3zABrRMViquaIU2cIV8Lbc=;
        b=UlSru2n6Y2DFE/SxeL/rBq3xNwvQVB0d5ZgVKI8Qw5SBdz7AgzH+vyQMN4Mh4z6Qru
         UBfQwH+3wU8ySzqSHQ5mclEZ2Kt0yw1u+5/yJmd7s6gcKjTYKH025uNPWBtNMkeUPtLF
         5kedvq7nV2fORcU4Y6Mm2le90xg5tRbrwRpPjImtjuIF7+XctMTWrVU4YB1swa4TJe5F
         tJ4Xk1l7g7Skr0J+fRV9IwZRC+cSsh6B9rB9j3BnVZXuLVY4JdiVzSvJ/m6S7yJdRwFB
         s++cGX5mTrnh5QG18ufW/Rfh01N8ags7YDmPDYuxBmkIHUhpTKbBZqKjlkTSs0m8tWqQ
         vkYQ==
X-Gm-Message-State: AOJu0YwpkkJWD9n8mgGPtJQnOC3AHzx8BKUBNb+z3JufOLnLDCi5OYPm
	ZQvlDoNTYN6dRa7PH2KGMXsELfSNVFMNSCQIwY62Tsuu7glofBNy8qCtg/6R
X-Gm-Gg: AR+sD136yt4rekZkuZ3uYsfbyuvM6UGEuo2A95QYHccy+q8tQzmrz9f9vi8nhuiraTh
	2Y1aHvagDgCZ9WIXnS+uDwX1GrVllHhjehaO+0aPYtGvFE8ie3KL3m/HFso8PdLMGhCtCrgMJIA
	Ljp/GQS69VpyzzXgP6pDs8t07okUJDgslo0MlJIImGnCJet8PCdQ5Kt79kekVEnxlQBcHxd5yuh
	EMYfJqJkZWK7nqnfcnDilKJjwE829KokHI22mc9vx6Mt39yT1BfP9pXNeWe6A5ajXplQxzzNQTY
	mONiIzjn8lbdhM7WKl23XDMXPGZrXA2jM0wLBepm1aRhup1/izLKA4WYCiAtK7FlCUbjOJ/oQ30
	hH7lN7oMEsnIrROr4ZCYTBLyX1LhDmyqJ1SruJS8aSyGRHTvWlkMoaMtuRRV4z3qvyFAhtKpvMS
	Tr+HA+tf1rwlHoiRHf
X-Received: by 2002:a05:6a20:6a0c:b0:3c3:7cb2:8aee with SMTP id adf61e73a8af0-3c67df974ccmr2247659637.57.1784989065936;
        Sat, 25 Jul 2026 07:17:45 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.212.54])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc548f5dsm12946511eec.17.2026.07.25.07.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 07:17:45 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1784985085.git.tanggeliang@kylinos.cn>
References: <cover.1784985085.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 0/6] Fix socket options used by NVMe over
 MPTCP
Message-ID: <d60ccb90-7d19-08a0-808f-7acbef725411@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 14:17:45 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_simult_flows =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/301600=
12728

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/bf15e67a2e42
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1134397


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

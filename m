Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94151482F5
	for <mptcp@lists.linux.dev>; Tue,  4 Jun 2024 16:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717517313; cv=none; b=b/2cJJIkDNWaDHDXL05rUtbXVc+CUcY9xb6Z/ATJEqi2s+MbXG0wlOWUVPaMvfL8CqrtubYRXe8EVxH6pCquwuWjhdI6zpiVCAavk1IHKyUQ4I0eRHGHqEbtNFC11GUc4+iwX/VR3awez3QJL5qtteCZp4m7jv9ldOz6l55dI9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717517313; c=relaxed/simple;
	bh=w2tK9zRsdiy5M8l/fry5qYxvBNa/PfUeHVvxsoDEkmQ=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=CuPM4URtxZVquQMhUb0QYrq+vMA2dzGE0ZewzC9eFt2rwNpqRITKSeeN4CZJ2xava+WuCo+sgxc+kxkk6Kerjm0Jt2R4m7vlXLMQQh04RahjZd/R4xVe6HfKxN9JeKGMBtTrFqdX6hL5OVm74D5E6yGB+6uv8unUhytz1yZt8Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9HsWarb; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9HsWarb"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f44b4404dfso50647595ad.0
        for <mptcp@lists.linux.dev>; Tue, 04 Jun 2024 09:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717517311; x=1718122111; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wfKBe4RcsjN8L6+XVuU1rq3Jlh7bvtQKpv53Y3zRo/Y=;
        b=m9HsWarbt1L3g8oky3AmAxAFfEwrs5//HqcBHz635vl5XZdOHgVfv6nYkn9qZgUqgf
         As7pttWL6e4+fuGKS057bceLVZWS94T8h+L1EZr9rsW+bhG5Rv79xSu2z83kWlhpJefx
         RYA2LeHyVkc95jRjXGU5z5hGNbaq4eKRWCV/97BV+qNqEmlEpA9iHvCo6Du39asuST6f
         MN+jzYWkpMxu28pSToXPbyp8IZQHhNGgIKb1rOx1WSRs6ZolY10diwmuajdBQ9ZDCMjY
         56986Dlfs86khUnmvguLKSBz6/0fpWr0Wtm/THbvoN9HFCfRMKK558xzLzB4ldAGdAhr
         GhAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717517311; x=1718122111;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wfKBe4RcsjN8L6+XVuU1rq3Jlh7bvtQKpv53Y3zRo/Y=;
        b=p6aeRjFBzwM7CtHYKXgNLchpazJsJ5EVm52bHtPatZsiJbF0ra/qaumfbD4IzEv9L3
         dIOkqpkVt9MnEo60h4QuXpNFTfdvlRQV9xTKopkLNc8lMN0CXyJaHdaf0DPY5xk+O8h7
         1rVl903umiaASLGmvoGWI2FL5qFMld6IT0lwWDtQ+84fSZomSefjm8MgGkygLVuJXSbf
         wmskhi5lIQEhaOoR8+Y3LegfWaDTqYGkRGqugIMQGXZ3ULVpWLmWhGQfSoElXdZXGooS
         98SI44F7UaXJ27bOLFpnGQtqieMJqtJbZ5p7udpi/xr98JjvgwpsW7gzsRGIHhZ21yiV
         QcQw==
X-Gm-Message-State: AOJu0YwFhDXPwb/WtTYJQIV5qwzJROM1ur/qw9XswRI+pO11IOyZuOX+
	ju/RQBmZ1FBGVDe2RPQvmx4zi3uRhGyz5OJ7drkNbtUVbQSM/ucaL7TF
X-Google-Smtp-Source: AGHT+IFaDRzbKnJwFUCvZGb4pkDYcr1iZXr0bhAheUwtS/gJbYNZG0UmbYuXHd0T17LQwHK/VBZHMA==
X-Received: by 2002:a17:902:e548:b0:1f6:7815:2325 with SMTP id d9443c01a7336-1f67815259cmr83352245ad.56.1717517311019;
        Tue, 04 Jun 2024 09:08:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.88.99.134])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f632416d7asm87366875ad.286.2024.06.04.09.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 09:08:30 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Jason Xing <kernelxing@tencent.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240603170217.6243-1-kerneljasonxing@gmail.com>
References: <20240603170217.6243-1-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net v5 0/2] tcp/mptcp: count CLOSE-WAIT for CurrEstab
Message-ID: <c22957e9-4925-02a3-73f0-bca2da0eb639@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Jun 2024 16:08:29 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Jason,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/9369946878

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/fc0f674bbb04
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D858351


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

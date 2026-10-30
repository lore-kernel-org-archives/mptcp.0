Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793323055;
	b=lLYXDt1jbE/UUk+xKKJFItCpdZZb+I90G1GaFVqeiA85ECPZ1u9YXE5TnWmZJXP8Fv6+
	 qyY31iS7FuBjgXNDLuA5kB3D5uSZu4o4pvEXY/6eUq3aFuFpAOfK6VcrFZp1QptKblVW5
	 4afVTgyDbC755nJNN86n4G04mldNsyvhOO5RP6m+ui+xmf9h+MXEzEoFxUaTuSNk2t8vt
	 5AuIPhwW2etvVwp/V8ElzyKqAy8gdVjeFXkG0padTzdmQ8Ha0WNT+HIrW2Ro0Qtsvpbnd
	 y3lTMilHUe+YDO+xGytjaQUVbBDDwsxl1W4xCTGxM8Ky2qAkNdv2xYX6E0z8LbQDwKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793323055;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=hFz8yYBnd0DTkYl/OJ3UkKzxVYF1ezdcNQyukkEEqRQ=;
	b=NeNRdhmkl4nUIF5NMnZ7TPYcuQYAGhrnxWnuy+PE+dJeOTPvFHgqGgNGMy4JFBlLNvOw
	 Wf6BHZuuuznwqdLpTC85NCoJEfOkWKsZRAYdut+aByTSYtxSJ8wowpIfBZc55jQOM7Fe2
	 TJw2dwhfb96i8lvuqUqvz2Q9XH/D2z7lKWYuNcZO/t6VyBR/hkPiHoeerOGQUVkCGFY7d
	 uk0655YNJpsmjdeNhqypXTeesg54T0sMpPrE2ixxvi1rYqOpBWV1VAthmDqFEK+VMDNrc
	 WkotkQBOdOTdi9cy9mAgTbLm8jpD8uXQ2XYYMnvaLV03Iep+XExMS6IiNTOoEUJ8v4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dg0zBd5H;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416D7606A31D
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 01:17:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 416D7606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dg0zBd5H
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-181516de561so189499c88.1
        for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 18:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793323054; x=1793927854; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hFz8yYBnd0DTkYl/OJ3UkKzxVYF1ezdcNQyukkEEqRQ=;
        b=Dg0zBd5HXyo17hONlZTkWuqF6lh7cGyxz9v31vfDTnCbX8k6UP7KSOFxQ8n71wDbJI
         I6Hoj4D/MsZJuJe3YAOccmN3Jwh6h/E7RNJg0TMfvf93xTc1dOcBz/lPb4H8lQXxjVEf
         KdHiFtG/ZA1XbAhqLEkjgESNjyQcgVCs5e9K39DQixyOoFTERvHJ7CNEGlEUq1nsdNXo
         MbYYp23Zst92xZWen/4Vfq5Utt1ozCliPQXpo1RC4Qdu9Qsw822lcNc6yRZU6mZteeaR
         QOyDaFyRkQlcZI1EyDPrks7YmZzSBHswE2VxB680eZam5gmONsagoOIMj0OIx/yjpuDL
         ZgjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793323054; x=1793927854;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hFz8yYBnd0DTkYl/OJ3UkKzxVYF1ezdcNQyukkEEqRQ=;
        b=C+CTS94PU8s7nINTwza1kccK++pQIwzM94PmLFIwxczwzfrxODHsgOth6njWDDwEQn
         dvj6/7TRA4+ComkRMzl/CKl5gnYv80P+ZcI0WtSp6Qriwxf5YAppokWoMgmm6iLws+yO
         2tcdU8d81dvYXAgHuSC9Cyt1CBLmUvjdAzqyMtwd3mwjuTjZF2NMYIzr9yaoJuPCITfN
         copXILszPEDquIWZwaTb1ptm+K+am0fZDmkM/A3CwHjPV5nWEFbhNUun5iW8hJdtOF3Q
         Bx871x6huX3Ihh9pr2MqmAqgMrmLhEnVkD3OEGu+BYc952SzT3MnpqjNSY+/w8FFAajz
         0TRw==
X-Gm-Message-State: AFq9FYLPH6K9ekswADjoDsI9D7r0404ISoc21UfPZ2vMamzHzzVGSbaJ
	MpGBtQo5+QYJgELg6pTJ5PlAnlyli+evLVVyut8wth7LYck0XZ3Lpdg=
X-Gm-Gg: AYBFou3Mx7kl4SiQtUwHyr509Xhf4R+nfFXX1YYPgA9sW07FKi7JplIo57PJa6yduDI
	FuM8IUU8OpIY2QSu5qniofnJIxUaGVCpPRbTLnzheUb/yVtmIvvCj8GKQbHVvcX/4Hv4mU4ms7n
	grUnRxc2VO9l/KQFa3ESo3TuEeCq1r/9slUTXlJEzFCU30lGZnhGBxGJ4ovuWIbLZwCe3wOab5b
	CvpBYQ5mTh55G69lG7hgXRUkEUVG3Wpt4aX3MNZG9YgaBKdnLfJGxUZcoa3/ph0w0s5JY+1PM3u
	euPK5ttRP8KcQHCbDXw6/YT/qWgNJRChUPuD0/Z5pImu1lQGY7hi/o0CZnu9/V9WcXqlHOsvw/T
	4qikXtgkyNPOqpSFSQxEgK3b4wqREZ/jVrtQVzwI5Gx087WC+I1rNDiAsmCjG1ZuSSpoRkuQ6hI
	OzHK4plSKQNnz6lTE2UpUJ64G0uxJKTAsCnneKHo3MWo12CS/e93909Vt1YMKg6DCus488b409q
	VcAph09Wh+SGsXd2fonDekUoJaGARsvimn7ujixcT24uGYhZpp06EbkfSpOLFSK8GpR6WC2G2oI
	Zzx74tRtKtnAxzG9xBxjBk2YBrw9IIaVQsD3Pnxa
X-Received: by 2002:a05:7023:a5b:20b0:14e:61bb:ec3d with SMTP id a92af1059eb24-1ac5b3fe092mr921645c88.16.1793323053971;
        Thu, 29 Oct 2026 18:17:33 -0700 (PDT)
Received: from github.com ([13.71.229.241])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1b0a628bsm2129277c88.22.2026.10.29.18.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 18:17:33 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261030-mptcp-reset-mpj-early-v2-0-90f119392263@kernel.org>
References: <20261030-mptcp-reset-mpj-early-v2-0-90f119392263@kernel.org>
Subject: Re: [PATCH mptcp-next v2 0/5] mptcp: reset fully_estab after
 fallback & reject MPJ earlier
Message-ID: <0b111e41-fc66-3305-dad0-52aa309eef0d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 01:17:32 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/40975021307

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/78ffe8cb00=
da
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1196695


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

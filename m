Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4ED43147
	for <mptcp@lists.linux.dev>; Mon,  3 Nov 2025 18:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762194809; cv=none; b=UVhrhPGRMWgENwnaTssvmpNkM4Ba9MSxMQHJDtj+oOEPoiJjrqbwVG+ms0LiWdaPOS4s/fWrL0FsCKbFjTK/o8q23N6x86Gd/Ux30QJPkO2y386fZUaJtqO15tlsAJbyuaVOqlw8xjtOFFj+SuW4G93rp7EMs4Mp80aSCYWYPjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762194809; c=relaxed/simple;
	bh=w0KxwaZpSVyrfZ/uiVZrNdmasS2Xi/TP5byiqKlCMGk=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=nRc4gWXAjhrUdDXPaqn87f96tcW3fBWXak0sXKmRLCg8D3sgrbtZSildyfu6X8WSEjLP8bR8JXbUTYqJpLR8dXe1sFpj979e45lSZPgxBfaprstIbLmYIiKKMjWhwATeKe2gaVYCsgXr09hLLLTioF49ZtpSDnsTz/R2R8gzklE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvQxx5/v; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvQxx5/v"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-890521c116fso467701885a.3
        for <mptcp@lists.linux.dev>; Mon, 03 Nov 2025 10:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762194806; x=1762799606; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLLUHhnXW863idRwctDAkZSd+09pww44YISROCc0t3w=;
        b=SvQxx5/vHmFFT5qWllwxgZ4XCN6sf163ZkHT+gfrSfBgS/3/TobUJghyOj5PCRIFt+
         J6CwRPiS7tqtHFE/qoLElORVkNe4dkc3+9pMVcfcqVjamwgQOSNEE1SNsVx1e2g5yf6Y
         FT0UnP5SAZYHHy87Zf6vsru8zViKbmt0NsWwMD03zVrw6aVH/pnfrjwSqKhDU5Vs6QVE
         9/yhzqbPZMAtiBDUK4dan+9fOIpZ9X0VP8zrjMlQyiY6ulftuyI5ZylYbjTtyh7hJXml
         agtOXOkeWVnOg1BonyNduG2Q46UcfhWivf9wwJDsGCrwuV1LGYPMFv7qemIaMYTnmCq3
         TRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762194806; x=1762799606;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vLLUHhnXW863idRwctDAkZSd+09pww44YISROCc0t3w=;
        b=DFJOBnLpofnzRGEEeCWqRNS2l9DYqFMizEdnc14ULGJdkR4gCdz9cwOhdUjQ4i/geb
         hJc0R06QyeXEhSU9IGfd4E3kuC7cmW/y51y+EUz5CgjNJMRjEOYIWPHIItp0LLnzbBHO
         Dww0Dc8kqp/DXYekbT4KbBVUynqwY07WGUQZFPtetT5y0OzpX3Ubi3i7EJOOr4t9kdxb
         PXgY4vD3IWRcs/w7LreTIKl8mAgLuCzlefAejPFtXu2zkkKSf9T0N23y3gdJoUvhXLNn
         5fS8MKeaR/3pwy6mZBM96vPGEFIupk5M9VDo1i7YrhagbSwjp9+9JDgNM3M9NwXPEI3R
         p0fw==
X-Gm-Message-State: AOJu0Yy7fSPbz2gT2M6xDOmTnR1yaSWGpj9W/rbQOoaPEWywYOCnovAd
	z2V53h7hSrXvoHFVuz0CzNpe/TEsH+5lsD2l8BD8VK8xG1EQENVfHjA=
X-Gm-Gg: ASbGncuWhTwluedkZfV728Wt/I7TgfjHpst6Bfj0Zcv3Et/iFC+z22/QFsreNdc/rNO
	X9tvHtfUA3PFOLLrc+vW3aftrjjYC2zNVxwUOy0RDeUFMg31+JvpYYeL3rcwh8GQXeDXos6eus7
	9tEOTL3i89cszyAnhLGP5TGVNmIE4jW6s6eq1plBMjwf6ISon7R2PGT6C+IlYMvvGlEb4UPvs2u
	p4fxDa786XxAAYxojJHAqRWO879YcptJlt2qDZvy/SHDRYjx6xdsO5djXuhxjXD0ZnakdE/yYY4
	dHWIbGZZdo9u9MrEGYScqGSx40WuWFGsvlYPlmJ82agZBnhYXRz+yWRSswTLwgcRlCEaN/+PDEJ
	r6R6/JaNDWMgAa4PY6iiTRQzvKh9ByLJgcehW3BKniguqDQ6Fmwfv2Rfz71hRGi3Vz3VkfuR0Ub
	+/sEpgsoIfolZA
X-Google-Smtp-Source: AGHT+IGIYs5mry6MnecKD25EZYPwgvgMvxx8XmccGLDouzFc+KATRYWG+JX3SaA1n7TLtugbdqthfQ==
X-Received: by 2002:a05:620a:3723:b0:81d:26e6:ef8c with SMTP id af79cd13be357-8ab9ba73036mr1520826785a.79.1762194806585;
        Mon, 03 Nov 2025 10:33:26 -0800 (PST)
Received: from [127.0.0.1] ([172.200.23.74])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b0f808df99sm32108685a.47.2025.11.03.10.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 10:33:25 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20251103165433.6396-2-matttbe@kernel.org>
References: <20251103165433.6396-2-matttbe@kernel.org>
Subject: Re: [PATCH 6.12.y-5.10.y] selftests: mptcp: connect modes: re-add
 exec mode
Message-ID: <c98d27b8-43d3-a545-bd10-363293cae99b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Nov 2025 18:33:24 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_fastopen =F0=9F=94=B4
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/19042890953

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/6dc025489b98
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1019038


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

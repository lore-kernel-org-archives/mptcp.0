Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792663538;
	b=qcyEREk6F1uhGDv1tEYQZIl/ZdoLiLzRcL3sEECHUiX53FTLGY9m1IbdC50fEOBRr1uo
	 44VPGL5g7+JrcMr0JC70Y5sSV/9bKdb6FlmdOdQmY9YhyD35KwEhYisNNW6T/k8Y8BGV0
	 xNwYjqzXCsvLW3yh1e0Szo+QcFDUzhHFoii1Q9RVOb3L23VcY6j+OMUHWlVpbEVzR3Q6h
	 wNTWac3t3H555p2cfA3JpNrLB5y3yFTW4D/0XamFpjQMFxPRYXh9KJGDbWGOJJ+Auuneg
	 d8HrDPij5OLEMKxczt9eEugiW+2MBTrk6PvQpp0fTSyllLhONzoUeI0dMy1W88CYq5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792663538;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=aLvaVCNFOUr2bWhux31FcrGkIpUKKSgRsguB6rz/Ihg=;
	b=QWWHXupBhfQKislkkZR7d//jbctPcXZXpsvFuPw909RIoNOPiN1Si0FCxRsinP3QDGx6
	 VcNfTDbohkm2bR8BRQ/zc0g6g0HEe6d0TXmzvI+SO/6yAxqwC6GWb5SGL2cy2AZ5L99Tb
	 4sKntwpnDeXrsUSF9Oj7JYExyaS2Do+YAD3VT/J7aULQXxIsAF6ld/UCZqCCXikbv75RH
	 hQyU10pdTLTD3OcBAhOwCOWt/37yDxjtR3FlA6CUazwD3JyQPvqveo0kpJVnXqXXyp96j
	 1Btk8/+QFrOPJv+5YeNsZ+QSJ08xf8QmwGRRdUPnGI2r8bLoQP+zd+LdaxbCmemqj5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Qyn7B2LE;
	arc=none smtp.remote-ip=209.85.222.179
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C40606A31A
	for <mptcp@lists.linux.dev>; Thu, 22 Oct 2026 10:05:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0C40606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Qyn7B2LE
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93e515769d3so145996985a.3
        for <mptcp@lists.linux.dev>; Thu, 22 Oct 2026 03:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792663537; x=1793268337; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aLvaVCNFOUr2bWhux31FcrGkIpUKKSgRsguB6rz/Ihg=;
        b=Qyn7B2LEbbOeY4/sFPK8Dk4rJh2o/u4ZUvZZOxMlPU+JoIhXLrxEWgG5nBmeCJfsFQ
         rcmJFfQZL9b5X7DWMiAwTKF+sMQo/Bp6DorvzpDr8DUtEhIrhZuEIYIOBWxHJW9eRowY
         rIdjNir5rOcsZmA/JFXF3HGuSKg89s/d42TPyLat6dhFn0DZNCsqPIy74zGf48fFgHYb
         +nn4EU2yZkPuB4LCe7ZGDFP7jwV71wsu6fPhy6OB13y7vSFBIiPwArqDH9VNb1AXIGos
         rpGB5pXm8208BXGRdqT5ALdPyO9/G4XS5QaPcKEZYUwKecGawX2e9Q6TptccENuuZxLz
         DO9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792663537; x=1793268337;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aLvaVCNFOUr2bWhux31FcrGkIpUKKSgRsguB6rz/Ihg=;
        b=tkrIB95wSnt3/smyOzqE1MAxtRz0BHJaylYJeUULkD9mAo+TuBnkTyGQG5Nnkx2Kww
         X+18Ip2qTucutnxcRCWR2l5AjEIVkFJkmPAfORhX/lmm9SCkZmZWz+GaccbwEoQK7suX
         yKlzT0T50xq6PjhL3OL5SuCOkQz87BaEAL4vL3Z0Huh45jGh0DUFW+Au40nCzzL+XfsR
         0/vl/tYv3/yUDITcgzsMQyySGJYLHBhIarQYDESG0GS4EGRcsVvQ00i5j8zPTFOuY5Fu
         3e0rrVafXk/h1pHFkNcey1JY0X2X45FkzdoEZdisGqnIdr/O4tX0VeDNc9nyEWXbQlcV
         Jn9A==
X-Gm-Message-State: AFq9FYIQ6BDdmm9C+iiZltRY0SMjh/OviTEj104WsHvkmhyWew8+7QY3
	1YZEAQ8SDXlhqlhLlGQjqRvmrqbICZ+2QZCXRL6TGIuQcA1NuuuuaRQ=
X-Gm-Gg: AYBFou3VZIsyBfWiFqQubb2rCxFp/nuoZvRudlMYpfgxadJuzK8GGwfufNcHjhBT2Wp
	FfIY4kY9RrhFqJcDal7FMGfPuxQinYCT76hyIVvDlSX3hWc0F0Yxku7x5+aV7EiRA/dTPl7QWqP
	0xrr1c5OMg7W4Vd8mQ2K4UeXhXZQr5BSyd/Bq4LMDaYoK8OHAQNsxyENDuG55KhPahS+eYBGLz/
	TSMZp1Lm4XfPNOqD0HlZIkXL0iUMuY1t7WD3l2rU41I4Ee0lPo6O1kg1WYDX5i09M6wx5PXkSHq
	y/pVqNxdEJJ6giZcSk5XeCmpkTWxDKIITdzcyYyV+YPNiXT/M9pRnUlVd1wAylzlInLLsUjmV9k
	g+6xvPqanUnE10G+eb9FSMWJWtcPXbmTAHyEZ0ENm5aNLhcpS0XDk1MWS79Mlc8u9AhGH3+RmvX
	hWwCAc3ZH6jAXfqA7d5lRtzFt3TBXRcUGb/oUmHqc2f++WlLUShMah/4BLL9W90tzDLgBJyKnJ+
	ef20OEQUP0jTa6cq+su/9mzGTWi9B1JWR2ifRyPZovDTWQAPGae1v64wHMb8M9CzgdgPNA=
X-Received: by 2002:a05:620a:730b:10b0:93f:6375:aa97 with SMTP id af79cd13be357-93f6375ac77mr168083685a.83.1792663536613;
        Thu, 22 Oct 2026 03:05:36 -0700 (PDT)
Received: from github.com ([172.190.119.132])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56df222dsm476985685a.26.2026.10.22.03.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 03:05:36 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Abdul Wasey <w453y.me@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261022085041.211318-1-w453y.me@gmail.com>
References: <20261022085041.211318-1-w453y.me@gmail.com>
Subject: Re: [PATCH mptcp-net v6 0/2] mptcp: pm: in-kernel: fullmesh:
 re-add of the initial subflow endp
Message-ID: <d8d3faba-7002-1bad-5f08-e7191780401a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 10:05:35 +0000
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

Hi Abdul,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_mptcp_join =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug =
(except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug =
(only selftest_mptcp_join): Unstable: 1 failed test(s): selftest_mptcp_join=
 =E2=9A=A0=EF=B8=8F=20
- KVM Validation: btf-normal (only bpftest_all): =
Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success!=
 =E2=9C=85
- Perf: Unstable =E2=9A=A0=EF=B8=8F
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/39753130001

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/59bcbcbc036a
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1191124


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

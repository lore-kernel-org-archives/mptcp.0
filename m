Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2511EB9E1
	for <mptcp@lists.linux.dev>; Fri, 13 Dec 2024 18:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734115893; cv=none; b=SficxQA4Ml2XJLUsEOw0Orr0izpR1RF1x9U0TCYke4FvuCqv9yKKcgeJC2j4lO902XLEDSmCKaus/THSIbVAvn2f+p6zvVhmuI4e130Z8rCDKtMT+aF71j7NfN0kFeul30nhBpPMLy+Nj592XFHj2ZrqTP9xjqq4R0yhSVkeYaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734115893; c=relaxed/simple;
	bh=bcpZS60wj5SJ0jCtscqBqtcUmu0HRZkBqVJKyTFLkw0=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=gFZCCa5bB85bUqHnJZtreinQshyGm3eGpMYb3X6ldyj/i4PBUpw/RjC0QMVZmlwz3PtKyyhrUzmcRAVi0eKPIsFVDj+/p9If2P3sK4dCOT4HFPNyOaTr243rdrW49LJulm2J8wXa9Q9xvZy3clhx4gOI4U0GYDjjWUBO4Nsuf6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQFFVd68; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQFFVd68"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ef6af22ea8so1822297a91.0
        for <mptcp@lists.linux.dev>; Fri, 13 Dec 2024 10:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734115891; x=1734720691; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qaRE7M1Phs3OO0SBAFccapdnqwo8ftoW3ZJUY4D5Abg=;
        b=OQFFVd68WKlIcnKc3dcwSNah8Prr7E1MeNKxqFNF07tvJuyhVr5hB5bu82/Q/x2EXa
         RMRPn6Va828anSj42hEzKcVPbHvCUT5R9R4LOCBdnwZfn+4iw7PrT4xdEv6+rXWDg3Ov
         7ITg5FlGzVf5REbJckJ598Zt8py7P30asVQX6B4uyXSL2QmpGf3TlnrBkRYQtso6nrpC
         WgZiXQrGD6jW2JLNKkafBdssuIUBXZ7b6xusTtszOxZ//AF49tlaqBDmVQhA4pCcz3RP
         hpR2HdrQeGonZ4GcZ1xY03ZtK3i/h7ow+X6p2A/hNjHCgPQ7GTQVTn3bhLj09hECpeVW
         XqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734115891; x=1734720691;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qaRE7M1Phs3OO0SBAFccapdnqwo8ftoW3ZJUY4D5Abg=;
        b=PdYHhJJ2Zja2q9Sf9CfmJYyp8SsW0E+LtdoiTtPoiMwm9Nz/rVNDFazp+5S1wzJMC/
         d1us1Sg6q10VGxLNwFdWYdnqRwG1rDFE56xOFS3SVPtFHS8+i03o+QlWkptYjSCK3jt1
         LsKq/kgqtEBpNKCY3Mdp4VHZyHAh548NSLuRq+fB51ygtrKE8iW/8wdEwNAyn+hKUD5L
         OBFna14tkP6J9MZWp05tpe3s64LWRC/iPiKcb2Yq2E6LeJJka/4lzfutu9Df/wLHWuss
         oRAQIVOVyCpA8yaeCSzfBo36MwiA8KJAuXZn7c0Ws1NPY2cCR0WAQD/wXN/AW/uePHlc
         xkPw==
X-Gm-Message-State: AOJu0YyqFiZ7Cn6uHBPA2Zl7OyE++OGoBeZ5t1RDdwP3N6Ae9zvNKxfo
	dgPPPHbc3T8XyKh/CraT6CJrXnbdu5trgyWTAwr24bqkPeIcojxyMVRs
X-Gm-Gg: ASbGncsNTsBj+x5hqmqdK1wpltnkp67dRVUwQBIN9zIF+OQ22OA6Ceot0ha1B8JrpRc
	UjpwOAns8lHnX0scNFw5M7f7ZpHtcsjPJ0OzaOjmkoQr4Ci380WHbAbMaOql5XVoumpH7/ZQ792
	VnMxbc4j9J7eFmD5ivqM/Lc2nHS2/7C8iqD0DkD88NOdUF/eBJb7XfqGNLg46TClvA62pc2rIU4
	5wyokTG0roOXds5OZMqfgp9bMQnspy5tvr9+/Eor0d1jWcobSsimtidOoVSAGKG2eE3
X-Google-Smtp-Source: AGHT+IG6Bx4RRnUgcbyxrE2P7Wutmm0NgZcACr15bKB6yIecwCb6P6rnVbrGg535ynxUhGrKoa5OvQ==
X-Received: by 2002:a17:902:ecc9:b0:215:a3fd:61f5 with SMTP id d9443c01a7336-21892981131mr54411995ad.5.1734115890822;
        Fri, 13 Dec 2024 10:51:30 -0800 (PST)
Received: from [127.0.0.1] ([20.171.70.51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1dcb420sm977855ad.70.2024.12.13.10.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 10:51:30 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20241213-mptcp-pm-nl-spec-doc-attr-v1-0-e43165c94e81@kernel.org>
References:
 <20241213-mptcp-pm-nl-spec-doc-attr-v1-0-e43165c94e81@kernel.org>
Subject: Re: [PATCH mptcp-net 0/2] netlink: specs: mptcp: events: missing
 and clearer attr
Message-ID: <912e3e86-1563-e2cb-98ef-9d16c53d2d22@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Dec 2024 18:51:29 +0000
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
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/12320759664

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/df4e95cfd61a
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D917716


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

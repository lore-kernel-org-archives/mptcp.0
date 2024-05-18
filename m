Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F04C1DFF5
	for <mptcp@lists.linux.dev>; Sat, 18 May 2024 16:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716050377; cv=none; b=GItMPEcppgKpoUGikTyE5BErVT/6Iv9gAMrYlgGYcSwQPhI1wSgzD8OCvQlZxvlsCstGrIvEH8Fb550rDb/icoXZb0FaP01SWMINQL0MbA0J00s3flYA8sOXaB2jdKuUfixNqaaxXUU+JD3cILPQtReOeHZaGfuhJQ1NT8VzJ8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716050377; c=relaxed/simple;
	bh=zPhQHDXnzFC2/FX0+EDwa/m+/OgdtBuDDMMBNVOKQlY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=HD4MzbsFHoAuLrthKJurrRm3zdkfZT6XcFQ68BLF8VWOOHQOpAmQavGFEKpCjk6MeGBp6XTk0RWbQYzRwbBkjsmw2QKNO5rf5h9MA5wh2s3BLn7pma5FDzFONc1VZnibdZIiDivZmmnmVJAL+VI+wdXQyb7wOAbvWKCa3uvoGNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JboUcmLG; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JboUcmLG"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-792bcfde2baso137321585a.3
        for <mptcp@lists.linux.dev>; Sat, 18 May 2024 09:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716050375; x=1716655175; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=syupm8YLcYHBmDZSLAX/fqxiwNvTRhfsyzSeOSliOBc=;
        b=JboUcmLGXc0CgwyBPGxNu44w85ip00wggrtkXsbaOBJ0sEmKbyf0O+wDk8DDsjuMdQ
         KBkZyYUej4Lfj4xzlPNQyPHmTTkR1zNI5/MDmT8MskcinKEyVjp0QkZaoew3OTJ6RsC/
         q0J21juYWtjhIXCfa8L/GJ54Uys3BVcdC7AWMm2karIt+1TW2+hBh9GJUiN4dVRvaJZ1
         O9nhnyFkHgCUVKXloyVoZjvV3cqFXxlehklF9NhJ5DomYqsJSFQWgcaYwj+3JsM123Ap
         T/u73gEZ4p7jV2zjXSMvARlnu+efHN8+WA6h4xEMVXDXGivgx8cJwkXtbY+OZ/lnYxc9
         N4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716050375; x=1716655175;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=syupm8YLcYHBmDZSLAX/fqxiwNvTRhfsyzSeOSliOBc=;
        b=mhDMDt+1iqk7Lz+l01SFgTCeiTbyZmfD8redK4XSEXOQOesdf1rwqvBJ0zVSJFZ4SP
         WquqtM1z1gjQQuOTzWZEolDCB8xgQDsuF+wTC/hIf8v4hBwIRGvM8vcYWbjXeuvfk8j8
         L/zjjsA2gi1/YjE5sviIAHMwjIxvZE+fW0afmujlYXRPft9ypkgACtI7jDYvoPdyD7zK
         AvJ76gdw/jgUYYc0FgV+wZWSnVYN27jmQVJmLkIbDieSJKeBZy6AKCVxeAVE+nqWHW8y
         P1BgrKO02j9+btxtmobyxdFUwqrGEbrf0iQPOsPmrNa2RbpK2Pkc+aGFIAX651Z/sQYg
         kWLA==
X-Gm-Message-State: AOJu0YwnIDF47X9Tx8Ibv1MNSLdU5iHjJSU/UgX0nZm9il+HoBUZuakO
	3y/7m1YLelQRQbPtc468c4u/0OLx4F210m/74rHSNe6H/5bJ46oHdsXs
X-Google-Smtp-Source: AGHT+IGHRbU2c8osITeOwn3n3KC+8jECdBMH8t62UOBtd7KkXhkecZV/3s1Skltkrqv4vpLXLZb/yQ==
X-Received: by 2002:a05:620a:a56:b0:792:b8c8:8654 with SMTP id af79cd13be357-792c759fafamr2469089385a.17.1716050374923;
        Sat, 18 May 2024 09:39:34 -0700 (PDT)
Received: from [127.0.0.1] ([172.200.199.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf340533sm1002858785a.133.2024.05.18.09.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 09:39:34 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240518-mptcp-doc-v2-0-68304a17cd7d@kernel.org>
References: <20240518-mptcp-doc-v2-0-68304a17cd7d@kernel.org>
Subject: Re: [PATCH mptcp-next v2 0/3] doc: introduce MPTCP global doc
Message-ID: <02a79760-abca-3b23-af32-abebf39be926@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 May 2024 16:39:33 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): selftest_mptcp_join =
=F0=9F=94=B4
- KVM Validation: debug: Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/914104=
6566

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/65924c221c10
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D854193


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

Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CD51C5794
	for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 17:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729619624; cv=none; b=S2OjPAitnT1fEHwlS3sF57wLixG9B49M1glawJm1rotDogS+VqTFg7HCg7CxXM8USktpxmLfvugqU1Xplu6LNkjY2/pPL0shTZlF0FzL+enIx7tb+Mlfj/KYIAFjvaFvCxAeNdo3O6KmNN90dImU71TEd7lxhDEiUtj0tcCPnys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729619624; c=relaxed/simple;
	bh=jnbHKZhQOgt9EfbbK+0gA1zXGfVud82Atk1dfrhtrIg=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=gKRsM++9NuyASyDuNSAIFyves7GXbT7AotV6hyuzJ8OUcqU9yl5qquuGeHy7fzWZVINGQrWn6wbMJo+OT9WQbzOmZKPW9dWfo7js1+0xSXSeZ8SFbEoUo5CIGGo8TgUp0KUQalEZnI14SK/Jaf+Z56J+CdweAw0ZoXRhN9AwMQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jl0aGV05; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jl0aGV05"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e681bc315so64224b3a.0
        for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 10:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729619623; x=1730224423; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGMAL/FsZdCM/rOFWmxOjkTnNaITIe4NUL4vvFGdW/k=;
        b=jl0aGV05ih0onPNpmVqQy1CWBj04NgSJC6Mbek0pLs3WX5yXGiKDhAueMlYKV2LSD5
         6bh49fcQ2CCB9UCOO3Vgwx/ke7e5I6kknbSMzLnMiWgcBYRYNDS6wdW2H3UpsfbVQ3dH
         3zaehOg4TDovQwiIura//fVEe7VjrKpCxMZtrZwwda2cfMA0kxPPbPTEsn5ksV0ipoCG
         kF8LX081snxiIioojz1PTQcReZmCxNMtcbhsOm8A4V1sBVQ2SxmQY/ddtj05e+BDAzDL
         LU515Xx6Vn6UsIb4TyqKOAcCLRwC1bmr5+iY4T8G0SCAB5jhgtZKy5OjummCcUCix2DN
         X5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729619623; x=1730224423;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gGMAL/FsZdCM/rOFWmxOjkTnNaITIe4NUL4vvFGdW/k=;
        b=U1axFSwN7cMcC2fKq3ekk3klBCtRNlw6/rX4svBh/R/wwK8tgyjq4PoF4CrkAISgf1
         9OZ20kkvktQASlOgYiEeGQzb9Xa7vJSVgKPr7c9HVN48m7HiYExugV2cxfjnT4QtRsH5
         RhbK9RlX2PIZCDoNOacsKNkUpqaDsWykR/TpDULHFkFKEtm1UQgiG0W1G4swWKhweXax
         hr1N/Si/N0IuO79BYkjsbbH8GtSkcpl/zXrnCzqnOm5QfkVizsZ2YPAUAkAE42PhBuub
         b5WlIiyp0Ct4HG97uaRlwLAPFquoVU+DIebmyXqL8XLtfMrULeyROEoDHR5V2/priMx1
         pFbw==
X-Gm-Message-State: AOJu0YwbrT63U4EyP3L6NrfGn+VWWv+f857SgsB7IVIYPU/4FS01bzUW
	n1BSEXMzjEujWiDFN0ce4HgjnAflkMsfIDA/97cyEmQG7qOl3yo=
X-Google-Smtp-Source: AGHT+IF+2Mi8iPCgNgCET4OSJNFxP/ywu0UUUaK82STpr6f/U6bH5AUGKXaY/MomVIvlZhjXs0T7+A==
X-Received: by 2002:a05:6a00:2a8:b0:720:3092:e75f with SMTP id d2e1a72fcca58-720309350f3mr107855b3a.8.1729619622499;
        Tue, 22 Oct 2024 10:53:42 -0700 (PDT)
Received: from [127.0.0.1] ([52.234.38.137])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec141b799sm4996636b3a.192.2024.10.22.10.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 10:53:42 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20241022-mptcp-pm-dump-addr-admin-v1-1-9ad328d01817@kernel.org>
References:
 <20241022-mptcp-pm-dump-addr-admin-v1-1-9ad328d01817@kernel.org>
Subject: Re: [PATCH mptcp-net] mptcp: no admin perm to list endpoints
Message-ID: <9491420d-453b-8c67-031d-55ac9e9b1591@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Oct 2024 17:53:41 +0000
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
uns/11464957788

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/599dd97c86a6
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D901898


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

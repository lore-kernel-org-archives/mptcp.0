Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com [209.85.222.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814C83321AB
	for <mptcp@lists.linux.dev>; Thu,  4 Dec 2025 10:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764843623; cv=none; b=T5i2VIwzlZEw4kvK5FXG1UShHR6a16yNZyAAWC/fOOFM8LuforggBMY10I8/TgJiYpGW0TUiFvrkGb/66AyrOqnBtZB0kBe/IL2pSlEftneqrKNX3syMwy1IlQFNPRQ1dzenx9lr77DT+0Yz8CNUEJtFZQtSxMC6wmswuIkSZ6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764843623; c=relaxed/simple;
	bh=RrNUsyRsPAyg0c7M60z65bkRd4jKv/YgH+Xn/bhs/Kw=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=SDjMHmOdG9T0cAQpYNC4uuW11/ojCKHUBtOtOGkiNLoWh+3qjJuOSzZCe3nnO3K6+NPkv8Z3HxgEJZm4y/K+oEYNXyh1SSP774qB+lrpQK55iH1CAapLaSw7AJrY6aIA6Rz6gjDnQ0AtfO50iiPQJRU/U/oBJagipW295GwticM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YzoPIOr7; arc=none smtp.client-ip=209.85.222.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzoPIOr7"
Received: by mail-qk1-f195.google.com with SMTP id af79cd13be357-8b2627269d5so66489985a.2
        for <mptcp@lists.linux.dev>; Thu, 04 Dec 2025 02:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764843620; x=1765448420; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sElRCSzGtGhrNyqm/Ikk3rJzgtBJgn1srZ8awbxKQf4=;
        b=YzoPIOr771fRs6raydG/TmmM9RiI10chbCeEWSYB80pPlVlhmevDSxP3R4vuBsj1QH
         nRObkzNJt3ZN03oslK3Vgrpf/aBSMv+UdDJA6nWrSaKGw8Stpi0W9fau7FQvBkBVdq3z
         JT9gycClgr6cjmOQaGoXE+Bqhq2cCTJofnlEDE1otH+yZIdCbLdxT+rIxWgf2fr7zVOx
         jf3b9AgvcQCRbu26FTeYjkybL/ogROBrkQd+cFCDEfSXQ1lcgyeu/n0gGpmiB4itYpj2
         3TG+8K1SbUePA9nfj7urzqugTJZUq72nWXVvdqISYNY5YVADzALAg8wJxzpKNx2g+6+8
         /NwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764843620; x=1765448420;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sElRCSzGtGhrNyqm/Ikk3rJzgtBJgn1srZ8awbxKQf4=;
        b=DY5QxdGKw4GiPK9m3wHdKbneDCw18bWQ2qsBJ5OAycqiiG4dNqyAAyYORVpSiQI/X/
         d1T9/I9kUf3p3kxdY4WhQ+lRjUq0Fr79/8IKpdA4LyFo1MyTNNkNmqEgLnqBsB/Aja/g
         iAkFBXdMvj+msCLRXWhyWvVC2z1cZ5DvKFV/VeT/O/rHYV6g/Wgby25UZL2+C5Q99DDG
         kFHVyOYi5DFKpPKYMXO2tB2ixApbEqEwWyx0sZfWz7KtsOOF8ahGEqwhM+0xZyMehWrM
         Fv65l9tEYheZ874vuIgln1b97InFB6sMyPH1FWR2GhLb2Fy4AwoRTbiKcEIUgJn8Qnw8
         Lucw==
X-Gm-Message-State: AOJu0Yyv1XjFe2zM+MtlBCNZkPEbM0eoL7AzMYOdibYSy+7KdI4NHEZ4
	O/G/fnFV1T0xROoIn9DvxNgwUmADPyMutNElIOL0JXHLcYIO4+SszZE1SNvDGKxnEg==
X-Gm-Gg: ASbGncuXC+ox62e/zvI79BOoOzp+PLLqLstpQdPcCrZ3x0qR9xELbaUbnOc+5pIOPLw
	rKs+SxS+Q50wVAUAnooFwwYC4pY9x84Akg23YTzK78jLznkv14eNxEkh+uORlQI6lbv1z/Ug4C/
	L8YmgevgVpz45aqvHkoXzUA3K63lIg9RuQD13NORm0EKj2mOOve79tTQ2gIf9HpJ6bQ3Dy2WFws
	57gvI2c4EaER3unaw6kch+fdjRiIseGbuoUyxaeVS19YQbnn9/uOmYtvXTld+j0sfLxPSii0Kk8
	dRsDeA5PNVd1bu4SalpaYhxVFEidaMi9iJ/h+nfOg6BvsixabDr6NDgR2VLUQCgOzyE4tHPZ82+
	k9Ma8v+MJ8qtnh9zuPQr9ztTe09gxyG4oM83YqqFQ/yWFa40Yvv0wBf/nfZ/i7GbukQ220beAXt
	UiJuODUzZ/NYeu2cfpjxTjxZ9G
X-Google-Smtp-Source: AGHT+IEj4aNe6jMJYGbXx7v8pwPDnTzXVJXGV4E0IbP4Lynb0SJqN4kjj31N/TJvABbYe61jW+2QhQ==
X-Received: by 2002:a05:620a:4610:b0:892:a71a:c02 with SMTP id af79cd13be357-8b5e59276d6mr721398985a.23.1764843620277;
        Thu, 04 Dec 2025 02:20:20 -0800 (PST)
Received: from [127.0.0.1] ([172.183.95.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b627aa013asm107677585a.50.2025.12.04.02.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 02:20:19 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <6ad37e65c7501b061811e79b45f7898cff838a4e.1764788106.git.pabeni@redhat.com>
References:
 <6ad37e65c7501b061811e79b45f7898cff838a4e.1764788106.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: avoid deadlock on fallback while
 reinjecting
Message-ID: <60c4c5c0-e0fb-d2a6-68ae-c2add87e5adc@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Dec 2025 10:20:19 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_simult_flows =F0=9F=94=B4
- KVM Validation: normal (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except =
selftest_mptcp_join): Unstable: 1 failed test(s): packetdrill_dss =
=F0=9F=94=B4
- KVM Validation: debug (only selftest_mptcp_join): Success! =
=E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =
=E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/19923942884

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/aedb85d7baaf
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1030212


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

Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1875D24679A
	for <mptcp@lists.linux.dev>; Mon,  6 Oct 2025 17:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759772647; cv=none; b=JV6BFEBlZWR2hAOBTnBPBbLoz3vwFYoaaktn3roP7R66JQ5PzNU0PurjpEGKUISYE6Tp4AG0Qo6xc+3ZKwWE3r29bCO+8nX4SQVo6Fxxmjskj1NIpANkuczryvP9jog8bn82lsSlZ35crrf/qoXiTc1//Lk9VdcfZ4U+YegcKqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759772647; c=relaxed/simple;
	bh=CVdqnshc7WDXn+kIPz3j+8s8F2a1UBrDTGpXkG7jm5s=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=riq1GO9nvIfM7xbl8jyf4S7jmqYTy9+VkvaDqu1U+l4/NkwMhOud4jXXfOoggKL18KF2rhd4RE2LBXGLhsm1+9GJxftC1pNDNpAHXWQEpTo+hO9EOsNVTDjhuyysSViWBKB7LbNQYHMVZlhqvatPl0buwiNYczGFq1Qa0PrFpUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bl/G2GTk; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bl/G2GTk"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b550a522a49so4539581a12.2
        for <mptcp@lists.linux.dev>; Mon, 06 Oct 2025 10:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759772641; x=1760377441; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0S3BcWukzqUWp1wnAkggMe23BGplruCM7laapcoq2cc=;
        b=bl/G2GTk0IOBqGlulVbIR9PMXmeEBiJstrTYm+vluu7c8n8mgaU/9ypdIB6O/smGBh
         bQYj2knBZPz7kOLS8wHXJdn5OuxNXD4ka8GW628z/paPk/L6hpiYSTslrei/tgIeczF5
         IX7CbHeClZYOT2rrYr43g2JquxODD88N6ew+pMZwDAmCiJCo9Qe2l006GkSn2HcShwN1
         cYm1iSRmWDPieq2PsaMGtI/uWaql/yC/unndXWpSegxbcKtprhpTpriziogEm1NNNcsJ
         f+g7qhXVYz2pL3DoNjJSLE/mYhDYwUT3ve7V5M92i0AqtaFrZ4rDtNFiuw4GR0+Gv2Q5
         gsIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759772641; x=1760377441;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0S3BcWukzqUWp1wnAkggMe23BGplruCM7laapcoq2cc=;
        b=ffHXz9n0NS2kGnwk9xwaUd3g73m/BE66A0ieoUixOf9dkPzMWqmG/YzQzaaOp7GyoH
         hX3wpCl7b4679c10Ad0g0SMvFHmgZG6/58uTo8tl2BPXm/UHx+pFrIHtt6XZbCn/cOii
         07eW8482zI6M62QRnZkGJV6KiuOYEuRXsPgP0xDxM9MLRgSRWsnSOuDz4vkhFQt08gbW
         q46olFWZCGCqUacc25QxfYMrHpWC7bDMVouDr+aUoxWa7BHGjxtI0LfBenn6k1ns79E4
         EUlZofqFQn3+v3j7GeNjf/pnBfT9joD/NjHSYSAKIcchVXVziqNcIPnMXUV9rNhCrDc0
         MWUw==
X-Gm-Message-State: AOJu0YxQq/dZNLWzm0Fx43EP9N0VDl7b3kR7Mbu7hSsP0AxnVEz65us1
	uVLth1prSriAamyC7Er0ZRHz8d0GqYKFUZWw8Y20gEuRL6LektpzuzcN28gv
X-Gm-Gg: ASbGncs83uY+dV04WZR9Kxm6u++CWtJiDZrQJ2piFzOZC/OBIqiLcoeu0WKpw1xsQPs
	SfyQcdIXQWUdP6y/Osw8RZRHZYuKS65rH3Gvs5TBAn6SnsNoMCjrYca4bdQBi70yyPhef1arCVK
	1fA4IGdSFzM+S2oaJDs+XkXoPGh4PFFjqG5mh7xcmmXmr2lSU81KA3us0eLNfBu/OQsSx9Kb9G5
	K5iR4Uc1ALSlgpTVB3ZbnfBo/PRzcjCdiD6/s+FU9iQWmuU1EsCY4tHkrKb/CP2z+8blu7pGMeO
	cRldJSMdHrlQEiIVYAzpJoLTliOlIVUQRHA9vlUd+d1Jr/TcxwU2q9jBuVK0snYvolw1DOrTZbS
	+EgAjVeoNvoEdfJlwS5NxzIbNzYfq/jtGIPzmdH4o2EIrLBY6gcXJj1ZWJbjR
X-Google-Smtp-Source: AGHT+IEPbtIdFLjuxwrQ3aS0mgZOmOfJewNgxj8xDDkafCLm6OPriePHcjBqb/+aWCPPg/Gydn953g==
X-Received: by 2002:a17:903:f8c:b0:276:bbd9:4593 with SMTP id d9443c01a7336-28e9a62fc36mr134264775ad.33.1759772641019;
        Mon, 06 Oct 2025 10:44:01 -0700 (PDT)
Received: from [127.0.0.1] ([20.171.126.215])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d137c6csm138448065ad.61.2025.10.06.10.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 10:44:00 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1759737859.git.pabeni@redhat.com>
References: <cover.1759737859.git.pabeni@redhat.com>
Subject: Re: [PATCH v5 mptcp-next 00/10] mptcp: introduce backlog
 processing
Message-ID: <fa72931a-2f97-cd53-6a68-794f9ea54e1b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Oct 2025 17:43:59 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/182885=
23358

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/5641b16abf48
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1008615


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

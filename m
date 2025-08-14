Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B040B19F424
	for <mptcp@lists.linux.dev>; Thu, 14 Aug 2025 08:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755161480; cv=none; b=FA3h+asXUEjjHoZMjy6rvzbFA0j62I+KObm9mX9asQST88gctdcuFEpX636nZHcY7FlncrbN55nEmEs4dfqtTHCmSBE2nMSFLNR7VtQ8w7fiMJYiivxBjaHqBDLFxvM62JGTReo8NWtUNFeJjKwhKuypKm0Ij2ZWOe5brfvNWH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755161480; c=relaxed/simple;
	bh=AwJkOQuHo8wy+eMJBr0sV8Ww9EUaJ99b/jBoJRRqu5Y=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Jbh+N5nZMFo4evF9b7xylb4E54qIIKYq4fTNfkW5siJrVOWxnCcynJOWhw8aBtkRkw73t3O11oewOYV5D22c+W9k0R+atMrkcMEvBPot2spWfFbqe95epexqLDI+P6EzEP0hIIn+YRzj+f8sFRug2ZyFcZ/aLrPSsaJca6pdBFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxsyKdm6; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxsyKdm6"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-70a9f5d4d97so8548536d6.3
        for <mptcp@lists.linux.dev>; Thu, 14 Aug 2025 01:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755161474; x=1755766274; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CG/R1VMrC4K5X5G+CVznyikgbVFb3opBro4txGb1+gk=;
        b=hxsyKdm6LlJNYJQDMGHpXPDCFQbyoT5UKjztBaa2fhXAZb0Og4OH/SoC7paKefQujR
         FXUxA0DJukn+pMSuQ28S+0D5C02CqaggyLn9tlPYaFLCJa1gGY8OKGKj8rjk+E2EIK4n
         XpbwlxLN4PDR1OZDPanT+RXZbJRByHfK52hol/imHAVmWk85vphvGCmnF0dRWzH3urjD
         rqNSc/bVoiqE8Y4+EpUjrSwSbo0TCleIp/ZAlR/xPJCvNqYH4E20rxdC7RmqqtcvrXu8
         6yPbito+xXJPkdYkctdrpspNdJofOgLwdXKQPnFMNzdjHQDqSN16TUe/45ZA0Xi0kWjx
         RxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755161474; x=1755766274;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CG/R1VMrC4K5X5G+CVznyikgbVFb3opBro4txGb1+gk=;
        b=DphuVZRbLembs1R8O9muJV5bZwe5IG5A4XBXw9p+uLzEUpsC6HII4w3XcgbprCLxOS
         gtpe8hKYw6n8ZPDV8g5Kw4HLjY0yT48J+RtuhmOYl8/Qtz1MoLWS6QoNymzPUyzYdICb
         eD1XEHUaMAIKcqup+MJ+s48x/UfswrCRj9Rilb3hHFZxSJF9G6CpmLJuPkq8AstPCDR2
         FvdXTs+3WfqObf0BAMRbtwIi7SmON3GJDlIX8yBzk7CXp36SsKpyRYBP1YzJQidFnr0O
         n18qws3C2uylnoaU7CoA0AmpjX2XXRBC4oUbV9mo6mXakx9pS4Mj/QyxA2bnyQRjGWnJ
         F/kA==
X-Gm-Message-State: AOJu0YyUJCMn7tkw4S6BnXAZGExvyL8y7Y0rj1nKghE74UafEHSwLJAJ
	pWh13R+Dpoh4qQesQsGiokKbUM5V1h70ghGORJBznJXMaZvPDUpwNYOYUd1p
X-Gm-Gg: ASbGnctTwteHy4CdYidMx3uTfvxI1wvK1ZGomAYotTwNjBIiTHocM6rG2xKqx6Xr+ND
	BKV/bB3Ks0k8Nxt4fxlJUz810DPVDWec/MbErqEKdMgzpaVHG3vXIm5EJ1QCZQM7Y56dX11nRR8
	CHN2HP4EhJpxZHCGX9+5ycEon3nCeWmcWzbSdVQy4Gv0ThN+UzM4aEbiZsrWXE5oQ+l9Afzatwn
	W2pavJUOljXonTOPPLRa1FJ9ZBnBjbsQaPTgVR+lOBcuW/b383gCuW/srlJXGBVikMyAv2LPJ9s
	Wgqoq/98NymtzaRYvDdyrtAGPPNOs+n40XIOelGKGQMFNoQoBX4R5dLA5yRzalCf6VTys4Uuf3j
	jZC0Alk4PRGTrtEzm2h2yvvvDD0+JVGVvhoRJVicTsE/o
X-Google-Smtp-Source: AGHT+IG/Y3aKtTmf3nN7l8/SJ61diVsX31IDu6w5rCqTGQdE+tzbY1KRRfUE5tGMk3m/wc+0eKu0Ew==
X-Received: by 2002:a05:6214:1d0a:b0:709:f328:c663 with SMTP id 6a1803df08f44-70ae70135efmr29427486d6.26.1755161474354;
        Thu, 14 Aug 2025 01:51:14 -0700 (PDT)
Received: from [127.0.0.1] ([48.214.55.66])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ae6cee936sm10720596d6.32.2025.08.14.01.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 01:51:13 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250814065818.34804-1-yangang@kylinos.cn>
References: <20250814065818.34804-1-yangang@kylinos.cn>
Subject: Re: [RFC mptcp-next] selftests: mptcp: Add a test for self-conn
 fallback
Message-ID: <ab7a5df2-2ab7-f5b2-3597-c247ea027913@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 Aug 2025 08:51:13 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Gang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Unstable: 3 failed test(s): packetdrill_dss packetdrill_mp_capable =
selftest_mptcp_connect_checksum =F0=9F=94=B4
- KVM Validation: btf-normal =
(only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Unstable: 1 failed test(s): bpftest_test_progs_mptcp =
=F0=9F=94=B4
- Task: https://github.com/multipath-tcp/mptcp_net-next/action=
s/runs/16958528774

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/a48b6ab5e005
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D991327


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

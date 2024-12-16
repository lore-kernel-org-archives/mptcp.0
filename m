Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E931920E6
	for <mptcp@lists.linux.dev>; Mon, 16 Dec 2024 07:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734333963; cv=none; b=QXS/bIlIlW5B6FbdITzQu5M8+KzM2JxYkMD+AL+06moDYOaxNkLYEtND55gwW4jcP0nsGNO7UbWnypKLmUTqgSBhVfccTld7cksMj8Q+DVCcs9V0EUUK70O2WmyBHUvoW8FmAwvFEaczA9fxjwtrqZ0qq61FUeIjgl5FrKc41tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734333963; c=relaxed/simple;
	bh=vnY+9SZCP7wSsyMJdvW7UPl9HQjxU3yB2CebZ6Ou3Vo=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=TtCQeOkOpeIwEu9/yiNltdyu2A19kBFDWd4pEItnzJo3Tz58Oibnooy92rehZxOUSAt4ZRoLDqtMTlW7IBjx7V+W7uWPp5QxpCvlzrS2chRZYvwlEylLz4JeEaSPWH/pZ6advZZ2fLFvOyvqjJlfJRg9ch+6gNSXkqZeQ0vFqfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1bAuEcR; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1bAuEcR"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2165cb60719so27999435ad.0
        for <mptcp@lists.linux.dev>; Sun, 15 Dec 2024 23:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734333961; x=1734938761; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=05lQvaeWykABY7VjECIU+XD7XEnFdDUtIAn1Ouk1+UY=;
        b=h1bAuEcReSN97fz9+3l+JgsficlMSDxNNKAnAYgVG5Pbpa0Uu6yEwXcQ3L20gE3Ocm
         l0vwD9sSgzZeTDmaUAAvAirgNuHpopyUkKIPbcWJYimRGbHXSFmx8gzRW2Oe8kcpWYbW
         +n8hFGHbOwOQOo0EKW2Sznzlmrv/FY4dmWvU56Y22Fi9h1uq77G7rUBXXn3uAs80ZjWn
         G00z0DGHCJCo21bKNr1PeqNDrpISPgW7GNEuJGD6Q1XHjzjQSK0mmKM1GMkz19HIdyd+
         EGrhkWevBLH7QhoP7nfTgBSlO+6CmiLWD63ccvlcDjUkvFRE4+zq28MZZNbO/R6atES5
         VrWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734333961; x=1734938761;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=05lQvaeWykABY7VjECIU+XD7XEnFdDUtIAn1Ouk1+UY=;
        b=bIB0wBzEGvd/J9y9cmLOM2P0N9TqrBDXNRUEeQq85c3FOa0cuOxdVBcNIm44nbue7R
         C2ddN6usn0be53wvI3EKN/zB5AihT21VrWoufsA7cNCXm5ottpNDgDmMxcZOrbz347mG
         wzjbn6QOVIW5Xpzem61aiwOFxdKnn+QH8I6o5DlbupxDZqpRaSL/aELLtHndxAd0YprC
         qNsHf14fLj73qWtY7nVb2hm5YGJkHrdZcvg8H7OGMRrWsLHhITpA1iZ8gt02glh/kljb
         WnVnjFV8fQnhGFp1vAKLPpLtROBUXEfCFWiCoPMBQbCEdSFRg94tVRYq0dCops0xMdRS
         xu3w==
X-Gm-Message-State: AOJu0Yyqg2xVA125kcTFatOSf6nzu8xRYVpvAwaxIpjhtFFLUoeliFbW
	l6GNGR8oFi6n9zlSnLHfKiYL1fej3LMK6x6fuclfkKbf0Yw9v9ceXj2r
X-Gm-Gg: ASbGncsqxQf0vwKShJ2EzB/x9MFzU50g2HGl2qIx5QVT9WfKGiMjBwY19P3pfnDarhS
	Mw2Y8y03trz9UlJZG0gxRI1/qruN+rrjWhVcNN27gykSvFrgC0BJJtc86B1qLlp4MqaNMWqk6qG
	ymKhZ2trfno978L/lh+s4H8EDdpnZlTX+eiCLpWA/mdPMiQVnjwhy6voT1TnJ6rEf/mLO+sjE/9
	QtfutjmqXI/iMLWn6Yo/AK4zzKZ+FfUTZEmkSNhbcy/UxKBgukd6sGx6/76QKSFHXo2NKo=
X-Google-Smtp-Source: AGHT+IHoaRitQamO5j6dFU8itYLwUzzR4hdgOgqce58btyAyt+OmlU+IXovIFnbRFVu60GyytOQdrg==
X-Received: by 2002:a17:902:b20d:b0:215:a2f2:cfbf with SMTP id d9443c01a7336-218929a213emr125159515ad.18.1734333961013;
        Sun, 15 Dec 2024 23:26:01 -0800 (PST)
Received: from [127.0.0.1] ([52.190.141.145])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e5044asm36431965ad.130.2024.12.15.23.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 23:26:00 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <a5dc0d188ebb30b3d541178a821b08f1124246ba.1734330271.git.tanggeliang@kylinos.cn>
References:
 <a5dc0d188ebb30b3d541178a821b08f1124246ba.1734330271.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v2] mptcp: use GENL_REQ_ATTR_CHECK for token
Message-ID: <2e7b93a2-f26b-17a0-da01-291e8c5e1af5@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Dec 2024 07:25:59 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

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
uns/12347321838

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/7d7a76c6578a
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D918077


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

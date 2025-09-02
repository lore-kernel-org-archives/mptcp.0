Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F1A2D5934
	for <mptcp@lists.linux.dev>; Tue,  2 Sep 2025 05:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756791058; cv=none; b=BGMT9sRJd9kWvaHxiL0LZmNyBkCLEwNDuk4R+iB16hDmgU+skC/mNpQsOFqc/+75ublGzOhpbseX3/bu5am2yu2F3EjlqToFMYD8yfHOG86qft1atsoYhO5kAMZPSQtNFX13jtcF+kMdhbsnYd7jG3Fbk0PWHfweMfbVTorr4uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756791058; c=relaxed/simple;
	bh=MWJyckVV4bwJlhdNsHtKYoAtjuH1FlmwHco/tiFLgX8=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=k/0kjifWQn1k7JSPBh5patV0Hx6fghWnW4t6GXrMSarFmfnJgOCE0M20cjBehwKfZlUQESImfBQIab4iO/0mHo4UbsfG9G8rHe3GekpkU+lVgxPW5p0aGuO9e3n/mWNCRjClVZFYkX4iwGwmBVlgPKUkDEOgQxdHhqFamE7LIVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lg0PMEYF; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lg0PMEYF"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-248df8d82e2so40615495ad.3
        for <mptcp@lists.linux.dev>; Mon, 01 Sep 2025 22:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756791057; x=1757395857; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=558Yh7ETka2K6D91lN2uYiKTwLU1cRCNU9hVwD3mK68=;
        b=Lg0PMEYFRhw+Gdzn+YVqHTrYvf4215kkdsho1xpIg3cAnZF6klBxULDS6CMlc94I0M
         nUwG9Nr1BIg8q8wVkbA90SMNPM1ZMaod3sjOSj5ncna6GXyhzjLGOLvbsBm6PJUKFTa6
         /xnLc9LKvvW70AdNHhuDdDCM+UZmRzpg5/076vzZ+ftKbkND3zQsBndBh2bX2pH5vEv0
         zLQCJf/Hwlz+gZrUezqeDdKSqqAz7Qb+JPMfAf7mCcx1GsLI+jtOcKFnNBzPvpGqtTMW
         oCurADuRsBs60F0wyAnqgKKi5knPR9zq0NZFa+jZY48oGMS1kg0XSI/VoeGqrt7MnW/r
         i+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756791057; x=1757395857;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=558Yh7ETka2K6D91lN2uYiKTwLU1cRCNU9hVwD3mK68=;
        b=CjiOU51l2G3DKsgDfWZm+/VpVxyC638ro5VeeehjEnSaUntoB9eqN6nGo3ZQi1HTOn
         gf8rgO5Yz45snNn6GwlDU0rzocD5gbKM4s0IW2K9FuShH7W1xcjclk34iKIp5WmXbmpu
         PCZX1HOD9ehm4lDWLI8eCbWlT403cW3OJoDA22pFk4l1Ppj5CL63sPKc5hb7XDJPUftV
         X+IF1/Vb4E6mytTzZlcjr6KwJ2q3nePlpaL5opc7pbMiYzzkf347WOnsrK5EbTOzL6fc
         pmogiIgftQTLzSXWr6U5ur/6c15gvoFgRC90F+hxYE4cUMWGYKknkZB4e+MJRdnwb2x+
         E3fw==
X-Gm-Message-State: AOJu0Yy+nTf3qZDdZiVl5pebfi6pS+n+T35kC/sklppuRiOmoRg1PilE
	WDFMjXrx3287yq4aNbNI8RN9aBp3syeaPrcMXThiC+AI0HK4JCIs8bpfGlPJpd0=
X-Gm-Gg: ASbGncs1k7trVWOnB4IAk2gtoJYJFRWrHidLj0wgOSKhg/rvcQIaUAovBv7yRCCpl/5
	4ARK1MC0EiOy0gJyJroowgwrkIke8u3HwT/UCLhbe1REHJYhYRONHWK06QsTig/7M5nABK/OJgX
	JeSEZym1HP5L0ReXgw0PssL7gQTcyoBV7apyYrN1nucLLo1J64BVDdB+JBE7VBLT3LDPEKUZvY4
	/QeVZi0wKYlTgcvHrLZXR5x83GCREWFFzwvgIy1s+0750VDlAwyi3fMxLmnXf2cNUvWorqbkZ/2
	MsvKCB826hC160djL+LPugik7UYcKy4IOieHmOwzinK0L4ZTQSSuxJnZrfXdyvi2AVjGOOLC2sr
	eFYwg3E6K54wfmO9/aOShdT2AJUdN5evX6N7X
X-Google-Smtp-Source: AGHT+IGRypWoAz12E+M3X9NxXpfpykJWL2WG56QZQrjirdkrM2Uz7HBM0UNkeiqmMhaisT65EW8c0Q==
X-Received: by 2002:a17:902:e552:b0:24b:1589:503e with SMTP id d9443c01a7336-24b158957ecmr12382215ad.56.1756791056541;
        Mon, 01 Sep 2025 22:30:56 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.211.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24a92f897d8sm80025255ad.24.2025.09.01.22.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 22:30:55 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1756780274.git.tanggeliang@kylinos.cn>
References: <cover.1756780274.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v10 0/9] implement mptcp read_sock
Message-ID: <b2d32481-260e-5cc6-a766-f34db781a87e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Sep 2025 05:30:55 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): packetdrill_dss =
=F0=9F=94=B4
- KVM Validation: debug: Unstable: 1 failed test(s): =
packetdrill_mp_join =F0=9F=94=B4
- KVM Validation: btf-normal (only =
bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/17391801764

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/387a1262a965
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D997782


If there are some issues, you can=
 reproduce them using the same environment as
the one used by the CI thanks=
 to a docker image, e.g.:

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

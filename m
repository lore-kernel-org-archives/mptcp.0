Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32BF79E4
	for <mptcp@lists.linux.dev>; Wed,  6 Mar 2024 02:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709692405; cv=none; b=FPO3jRBqvqfMyRtaFxvx7nNyGvvOY2tv7BV9JMiMpJs24SJImDFiXbUUUOtR8xLR7lV1v941qMoVF0ahA81tru1UA/KalgddIGM0INorQ5t8OU4CLX1A/ni0U1DFIAjKRGG4RvovqDEn63YjAyjGE3JUHYErXSDi3lvCff2m/Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709692405; c=relaxed/simple;
	bh=7CZbJgIhKVpga2rPd25i0vW9jzGiTvMLt4IZlhuqbZk=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=lGW7oiC37CXY3DRX6MAHy5Rqj0sWyzDx+2Y0FSvpr05vapkNgaMoEkTV5u5D3F5zwXABnz94Xbwtz46GZ8R0hEAlJk1Z76651njQ/75uCcRos9MleMiEzaipThHWlk33JIVVlm7dfk7kp6sTEFE4HU3vT8URWud6KiN27NsEKec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jcJyc3qk; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcJyc3qk"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7883e1e01ddso12211685a.2
        for <mptcp@lists.linux.dev>; Tue, 05 Mar 2024 18:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709692403; x=1710297203; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ed6zAoTIbPvaNeYIDbJCxs9wwHIRgoqVddAGdYkBCHE=;
        b=jcJyc3qkqKd2BJhIiRudoLh3aFH98NNtwk9A7LgvLUjG9/uhYB1iCsAlpkbzMcjhr7
         VaYs55og027CvwF8nIyPeAH6Liify1GQQetJjA2mB6s+mRgwh0WVyZp1fdUzEHJmWZ4E
         0MZcO0sMPWt801TRXPEi/1ID24vUGGnxQIQYQvacZtX8OpEM7qxlJwKYlbNwmhhbuBhL
         m0x6U8wP5pvvOzmsn91Bm5/LQOfhcmB/ddoEHejDdDR59ro7upV2t2ei4UaGMcXGDfJ3
         yHyR3w75G5ttC3uwLWJsaWXraf9XrJS31TQaFwn140oe/tWK1rkooUjvSjw1bzM+1f66
         JLsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709692403; x=1710297203;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ed6zAoTIbPvaNeYIDbJCxs9wwHIRgoqVddAGdYkBCHE=;
        b=n7QKQmlyrd1V+fqEpyNL98ujDnkA+nknIziAncVSsI/vOrNcwkNpzy/anV1zpS4Q/J
         WsD2kkWYQRCPYvKFuvQcHUlJcrPRNzlOCUcTHEsFWordDapasQALSSYs+FAqjW+x7It8
         Lhc1Go0YsRD9v0DXrViRkMaBjgIB+91iMShZiS4xti7I+wCi5d/uRxpCIngMK6p1VTlV
         Mg6+9AEZOFnLp3BALtF6jZjUPZvdh2+DcBE7tkul4IyBsyKC7IokuWW9V36zdM/Yym9L
         x1DR6kWYCveTKczikphrr2Iw86EkZNfcuEX4GAF4fijG7MpeXcRSnW1LSZstPtmJ7Ghy
         HqLQ==
X-Gm-Message-State: AOJu0Yw9LSqjfrfDH/g0nHAwTfGfGudwBOXz2aJgXlWcvEf0TsSIyCcO
	sH9xxJp2QTXhrVO4CejeI08HAa2dgf1LmCRWbnbpM8O8R9toooHvEZFXInk=
X-Google-Smtp-Source: AGHT+IEdNtixeF7AemmGaFelCHQvOhYlYkLkpn5cJqewMSjqwgOcIfLopI5jg4790ogYRHiP0K2UXg==
X-Received: by 2002:a05:620a:31a9:b0:788:3235:9b72 with SMTP id bi41-20020a05620a31a900b0078832359b72mr4562702qkb.37.1709692402748;
        Tue, 05 Mar 2024 18:33:22 -0800 (PST)
Received: from [127.0.0.1] ([20.102.46.213])
        by smtp.gmail.com with ESMTPSA id j10-20020ae9c20a000000b007871bac855fsm6098934qkg.47.2024.03.05.18.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 18:33:22 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <3903335eb71697af9348119b569e29c50c9e741d.1709688778.git.tanggeliang@kylinos.cn>
References:
 <3903335eb71697af9348119b569e29c50c9e741d.1709688778.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: print test results with colors: Tests
 Results
Message-ID: <c1e1567d-8266-cf3e-120f-1d29fa03eb7c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 Mar 2024 02:33:21 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/8165798699

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/d2baff8ed2b4


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
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

Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8671E53393
	for <mptcp@lists.linux.dev>; Sat, 11 May 2024 09:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715419651; cv=none; b=He8i+Lmp8YyTDzD7hOd7pMZ3himUykbsvf2tLEP8ddnJMUH+uhMeOGATGcilclLVc4jecWhQkGom3otmuaIFf8qc5lJvAnWqVlgNuw3MkjT3BVDDp7sPC8Ogw0ncRTp3EZeBI9Do3dAhGfau1Uuq9LvfeiWFBv0fBDllCxKTRVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715419651; c=relaxed/simple;
	bh=keTCKzsu4z80kCiHsZO6LyHk0pqC1ZK/PRibbS/6V1Y=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=ErSn5NegzQYznATnEj4Wac4n0+GoWJsUhIOSg0LBCFbT3QrsPYI2PIzb5ZTJ3H4eSFHGYfqhLc7jC7cFdPNmiPSDL9CzXe6sxBweEJ2PVDWkEVRI7kWZH3+cbbhG/jI8Fq9s/DTVskWJFNdUkO0MteTDotWyhPKX7ijT33iiKsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNHjIlty; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNHjIlty"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-792b8cd0825so251462385a.0
        for <mptcp@lists.linux.dev>; Sat, 11 May 2024 02:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715419649; x=1716024449; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w88U6zsLBMKhZtvERoZPJocbK7FqccD85/tRJwFhZns=;
        b=FNHjIltyuozo+iTu2lPO70O1xiF8iLA5YuFFSAfaA0vKTsU6qKGAhSn2+KomX0NmAC
         7wYknPbbORNSI/CjMOTfEu+TMyErNq3VE4n3V47BHs/91jLaMA6ZYq/b3fd3zFkOVbts
         KcygvC8GdENSRA/Gx+K1DBY/w3kzQbLxHUyzCTg9I36Dad+OEIEbsvegRVgJi9Oo6qMs
         3B1j/HeKN5BsozQsK3lcA5xLJodLeWYruSueuclarJALOebXFLOwKMCEbsSuQgOj/MC0
         xvdC/6dVuN0+WdQCfG4bE2pwpummRvQbIYLW6a9tK/RY0Fw1ZdcuHuyaKEIHIGoWXQng
         65dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715419649; x=1716024449;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w88U6zsLBMKhZtvERoZPJocbK7FqccD85/tRJwFhZns=;
        b=vEB/rwvfOu/790N4yH4pc4rrJwCOgu2Sv55NL+Ap2JqfJmchSYcThhmVVpqpd2gjD+
         4odHN8GjA4b8qJZQh/hi+oyM6O79Qcvcp3qhPJjB1FXvty5f1aiCNAR0kemXPjF9w/p9
         6yiKxdhavrW2t/f3Unxai0UAycwRVFmNjkU5srDUedD3lpem8chvoKpTJ5yKkDzSP3zK
         /UbJnr0TTiXte+kDmX9hGTzwtCM6hN8YqUhgIKOmKTzz1fiqbG/W7CjxkzhPA6k/+z3s
         nF5tS/15+dEltuPVR4jjn4/cVY6c8VZEBbUX5UBY7jmKJtnCBPvNWdLhIbK/QKzyj4Az
         K3FA==
X-Gm-Message-State: AOJu0YxgwKr7Ly/+ou1Nz/nwF9+tAObwcq8mrq5Hg6SbBdPnCnI0QtMy
	qXGCvljE/v3TQ04quINsnZtDZT4abAhJ5kBeqpYhWP1wbZL2ySJ/5Lqw
X-Google-Smtp-Source: AGHT+IGY7Qb2e+Bc4DlraIErbsubRhDzu8039RUNWFPTI2S2mvZVd3HWXjI2+4SXAb2t3ujUt/Kreg==
X-Received: by 2002:a05:620a:5a43:b0:792:bcc4:23de with SMTP id af79cd13be357-792c75ab82fmr532899785a.36.1715419649351;
        Sat, 11 May 2024 02:27:29 -0700 (PDT)
Received: from [127.0.0.1] ([40.76.117.218])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf2a11f6sm261027285a.55.2024.05.11.02.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 02:27:28 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1715416511.git.tanggeliang@kylinos.cn>
References: <cover.1715416511.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 0/2] convert helpers for win and space
Message-ID: <aa5c299c-fb89-be4d-689f-0b0f7765d9fa@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 May 2024 09:27:28 +0000
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
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/9042513520

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/de6a800ee3b6
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D852503


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

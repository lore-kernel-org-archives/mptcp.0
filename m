Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48513D3BE
	for <mptcp@lists.linux.dev>; Tue,  2 Apr 2024 08:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712045282; cv=none; b=uBafJFHbJ66TV1Rw0UVdr6/EYnZA29bvw88Bk0gmhAWZoXKnZqhwsyO0G3IPDHfSV8zpCAjzwc958ZD6b8aYIS9F8L0bgUw7/b0u6BiBpeeSks1oCMxvO1hIUxxLyD5L1N0SJ0LBt0fyfCDiP90JRswX9pYjUd6Mac2NVOFg/u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712045282; c=relaxed/simple;
	bh=eISlgVVYOPRX0NxBCuE/hkYK5dnkeP+2cK2848bAum8=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=r3kUpWkfiRH6daqLEe8yuMZpxpNl2lrS5IcgoITeCPyZTmzx41c2RYMqr7RLfdmQGmo2NfM96XxbFiJLxQsIQhAyAGoQKyDhfO5Fw4PfqTjnUpCIuoaZlw/vDdY4E3HM5sVj5tn+9W5qZ6C6D3ugHH//QUpWMnNtO5scnHPVrYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZAtUPaKb; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAtUPaKb"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e0d82c529fso40612655ad.2
        for <mptcp@lists.linux.dev>; Tue, 02 Apr 2024 01:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712045280; x=1712650080; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyu2iEJ/v+Zq9xCX18wmM/JQbL1egZfcgXv7uPBPUEo=;
        b=ZAtUPaKbG7csJIEEpFxcElBUfONGSzQJGQuLJuxZGSlq5WXnBpHc+AoRj04w2W4Ros
         wZKCd9xp5d2yezqEJjyMxZgvTeujQHtWJdRj9bJw+KG/94V9jFsCVYHfHHw8jB+JDVoP
         bywPjoMo32tIF0dIYPth3zJk3GV1u+md2px5uqZAG6rRF5UmAOTbvGn7rdUYB2iNcztM
         IzolPkqux6lA+UydtVbYF7MvYOljH4hSi+H23AIZE+qL2PaGsZbbS2ccaVwdJZDas3lc
         o0omDtuuQ1VS4VdH1H8dgM6p9GhYvbbkdY7f6F9SRxeGcmaF+ms/jcgFHXULmPRS2l9M
         VggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712045280; x=1712650080;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pyu2iEJ/v+Zq9xCX18wmM/JQbL1egZfcgXv7uPBPUEo=;
        b=vnll0v5imqRWQXL6J6y/pGcGleIEYJDMmyobs10rPfs2DdHXTmBsfWSJfXsF1kdWWM
         86k9pHumrMKYpUPBj5tuQDo9MttIwzXdvTyLLmVNKHaWPwRIdYqRUSutiUUeg8JPBs0J
         3sX9CE/d/Q4lI+EyCwaNLB9a0lP9lhFd0zxSzOfHhJLC0pYVgLRf5BS42PVang+YCfR6
         U3BVFQQ8ixEo63RU7L3ssvyL7Fj+ulVOq0/qJgHn9JDx5fyzF5b3HLk8a4+3wglE7mBp
         X94vO5FuJb5MN+/qifXKpHGMr8XeUZquJZoPtJ/VjivdNPROqm7i/8GEZMx5vHHLzqZA
         BiVA==
X-Gm-Message-State: AOJu0Yz6Gzw3RpO5q8j+dTolDjWlRsHERJ/VmSSxBmoKFXUr8TYeMO39
	RJW8/LxZnR7hSNXcSSR+BH1guTBNWacnCGcPfN2RLaZdzf39yQtXWxvJqpY=
X-Google-Smtp-Source: AGHT+IHZJzG3rPVN8ihNfIRPtX7heCXYOHE8AhiCd2obg0Va9vYZbsqOSac9C/+4dnaLNof/bf38ng==
X-Received: by 2002:a17:902:c944:b0:1e2:2b67:aa80 with SMTP id i4-20020a170902c94400b001e22b67aa80mr14349029pla.6.1712045280067;
        Tue, 02 Apr 2024 01:08:00 -0700 (PDT)
Received: from [127.0.0.1] ([52.238.27.70])
        by smtp.gmail.com with ESMTPSA id u5-20020a170903124500b001db9e12cd62sm10427436plh.10.2024.04.02.01.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 01:07:59 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1712042049.git.tanggeliang@kylinos.cn>
References: <cover.1712042049.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v5 00/10] refactor mptcp bpf tests
Message-ID: <dff4cd4e-89fe-27d3-ebc9-888d9c123d03@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Apr 2024 08:07:58 +0000
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
Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4
- KVM Validation: btf (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/851903=
9495

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/3619fc2a0f19
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D840483


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

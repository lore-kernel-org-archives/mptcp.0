Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E5F29DB64
	for <mptcp@lists.linux.dev>; Thu,  5 Mar 2026 06:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772691240; cv=none; b=OTTVez28o3rpvVhkglBYTCtWedRnDH3jecPGGPEcP7snYby9vEoQGHLq1q9CXyGo9Zyv8rYJgRWBQ0iwuIWXUhAFCocb96yTt0OHGBIGBXOWC+H9dUcR60IxX44VwoZY2u8IzWfrIqGGouN8SLxqZb2d4c74WECAMvpaQKhZ2sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772691240; c=relaxed/simple;
	bh=OEH+E3LUbQm8NLcBGv8xkZoz8meYGtXgaLv61zOzcCY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=s73kWdcLtKYThn/b+TV3XCuc46wVDUVeg5QPJ6eIWT2gbRSRhamJTsg0mg+ZKAr12dQYEpIFNFdFYmDY5pDRt1+ROknKFKoBvY7l3qfFEvwuQx9DHC8T3on8Hkz0GHJyRJ9iwUKEiQeXIwLPTuLalyE8eNRxdK2nqbmtiP8yujU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDgWtw6J; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDgWtw6J"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-127380532eeso139040c88.1
        for <mptcp@lists.linux.dev>; Wed, 04 Mar 2026 22:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772691238; x=1773296038; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLafWv7W3Z2K/itNmY1aBLkatS9VVwtKFKUHXpvdxtU=;
        b=MDgWtw6JaAFQZjTjXVfpqqzT6z541joFzQS7bK0lRk1TWQJXlBcSxdrLShCXV64R/M
         sealhoScuRBvSkxqMDAYhPLY5EfpHIIGfAp+FeTuXmo1owvRsRR0MOb0nU6ZmIunU/3f
         AHs/oHI/IvaD+Ka1DruDwgtbdoPzx1MgnuhV8XBDhGX6Y8OL9xK/I9T/tta4nW5vti0Q
         P3ff/8sUx2VEsUwIBVEWn1kZU6l++o0aAOZIOBCQ5TsI+Ev/LnEw1gQ2z3y2gLK9j/DX
         UnxyofEbQvVGbYCL8hNz+2MlIlBZsoIND4UjcQ1rEDFMXg4niraRZI8Laj/b/0AemQrX
         a56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772691238; x=1773296038;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lLafWv7W3Z2K/itNmY1aBLkatS9VVwtKFKUHXpvdxtU=;
        b=X503EFAyIOIyJr8LtaJk9bKtGg5MnYxRBjm5R+9nVHaEz9H12dNOb6vyt9fIEc3ilm
         xUgiXqHzgptl3w0UxyGHCtpCjjAKRqbPsyy1kdUtxCwvhiIzdJzeXVR0O6RXTtrJEOaY
         JvLdTGov7v1lr6jvJBfwa8E2Ph7INWzbR1ofKY5BhJ9E7HSby8db9caCk7YX9VbJaVzO
         fspVSG+rjvb42HPV6ZmyaMN5PVzXiIr5IVyftyDImRKFL37BuG3sl39N5Q9UztNOacX+
         kdrzRMqmc0GI+npg1rMS97Ib+tPMaWblTpiuk9p77TWk6XZmGZLTqgzqmTYj4EGm+Law
         fW7A==
X-Gm-Message-State: AOJu0Yz86bFUc9Z8bHxBuVIM4JQCitnnGSZ8fBnuVWPuqwNkUatya6mM
	0g8c0OIJJ1/KQRdqy0nCSxlfXwPsbuoyRy+D1UxsPJcy5mYYZqaoUL73Rhww
X-Gm-Gg: ATEYQzxT4kMS00DLNMSTt/qytmBQJzEJzbGu+SKCvoB75QUSWd2cBVdRbzCiU9B68Jl
	nBJu1WgiCZCLvnCb0xqxXQuzRa4FXQ81HY7/dB6oo9WKbpfpoKmofYMuFlHHm0vmwC9Px2PfRda
	UkO5cdib7qjPIQVv4VCw0x3kCXtJH8n7K+3rAkvK5xtSQEXKodnvqLHqXN6d2o2YQi+YmkslRY6
	y1v//XhwLsVI6eqtLOOcPHVmQZslj/wa/RC4IMoVMpBWAXBFs7lCX1nNKP1He/rl//M0XOaGisK
	3BxzHQEgJ3wWz+uoaF2gVq6lmD9s87VZZfxt632ZwP4IyP8e/whP4SJmDs+w/qSgh2bMfefV5MV
	e+jo0iFo8YlZavQ2ri8Ols9MayWhhGtb2ZF5ZPYdWmfA7E9UeBIjyfPZKXadxvMUPJ4WdTKb3JH
	lC/1Pu+RHK68dFQqZeD8m7HTVWCjKOmXtIgf6fUQ==
X-Received: by 2002:a05:7022:324:b0:11c:b3ad:1fe1 with SMTP id a92af1059eb24-128b707a5d1mr2215957c88.11.1772691238016;
        Wed, 04 Mar 2026 22:13:58 -0800 (PST)
Received: from [127.0.0.1] ([172.215.209.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be2c357d6bsm3181634eec.20.2026.03.04.22.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 22:13:57 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1772683110.git.tanggeliang@kylinos.cn>
References: <cover.1772683110.git.tanggeliang@kylinos.cn>
Subject: Re: [RFC mptcp-next v4 0/8] NVME over MPTCP
Message-ID: <3e1948bc-e55c-f2c9-e599-6962710cd6ca@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Mar 2026 06:13:57 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Notice: Call Traces =
at boot time, rebooted and continued =F0=9F=94=B4
- KVM Validation: normal =
(only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug =
(except selftest_mptcp_join): Unstable: 2 failed test(s): packetdrill_dss =
packetdrill_sockopts =F0=9F=94=B4
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/22702177776

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/519df0e440a2
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1061679


If there are some issues, you =
can reproduce them using the same environment as
the one used by the CI =
thanks to a docker image, e.g.:

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

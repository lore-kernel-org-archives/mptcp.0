Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BBC2361C0
	for <mptcp@lists.linux.dev>; Wed, 15 Jan 2025 08:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736928813; cv=none; b=PSQjBtILSFEpBDPLKh3UU3nzixpTZQmXEFdaOZN8tEcZ5jO5W+L2wzkcgsss+elfN2WTHG4q7hsoBr7jzdFg6Hkb4+2mE9H0J+GEAVsSFnFRSvgCZ2JPDfHY1qiajObdGtRaGAeJGo8dyFWcuExK6jSRy2VDSSV5wWnX1372xqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736928813; c=relaxed/simple;
	bh=IXOIP6PrySbqqNUh3cCOWxcePVB4Wi3+lzFPiZdj6Ic=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=lTdUXQooM79tNzIzEVgPL/zHQD0FKeoeDitIddspin/SbAE1G3BYvDVkPbUNxGL47eW7vyUTm8MCZDEVN5KzzX8cMkuiq7/n+j2WZX2ir5s9b0KxusVoRrH73agFhpmOqJo8ydsmgfj/MvfC+rjlk7dsNbuleNsEmB63mcteQYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AmZv/CzD; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmZv/CzD"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b702c3c021so569162885a.3
        for <mptcp@lists.linux.dev>; Wed, 15 Jan 2025 00:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736928811; x=1737533611; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZbjGSzmRNYjpAc0Ea++4x6+3jKcF7uuD1d8iftsalOs=;
        b=AmZv/CzDknYW3sDaAgVOXeN2ZUEaciYZV+zrYgB/TFkKkF5txMX7myeeR1v6+UGDo5
         rUL9Tf9WBsMHC/ao3umlVP42ShtWO4b70D1wAN1xFOcBf0212IxAMcl0GCaMtygHK850
         O+/zV/rnKgzCmwwOU4Q29u2lreU7qlx1bBfaGUbpEp8ZpLW/5WDwwrQ1BSc8vS++yOoJ
         IsK4fjJtDC/OyvvzCHwMFw+Ioqv4slWXwNXAMIdDJ2NPCvXUlY4+tjQTVZN1cHXAyHSi
         I54iS97RrSpx1rxB2QCEyl+A8TiPGKyQKktxmt35NVp8K95gye3N5PS3aHXCpWQwJQP2
         PJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736928811; x=1737533611;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZbjGSzmRNYjpAc0Ea++4x6+3jKcF7uuD1d8iftsalOs=;
        b=Qsh4ZjLEzFtUQU9hUqS0VM75hYnQ46Wz1U9P/0EFepUWtcZl95ctIU78eaD17oz/HT
         to24GYNsyobb760ceb5+CLrtsh0sDjbTXhLu3HQxfQqdDRujxWuECa9uC8pG7DB5C4zz
         Kr8dGE88NJy90iEq0RLUMaKQVfpzufHBBMbzAf6p+cVlVD9A1nSRjskI+WkfQo1mSi1Y
         YRUx/Mp6IkpsaEJGQKTX29VX6nRqKQ8bMj9My7px+CgRPGXNs5pXxW9h34Tri+lJs2aW
         KY4ZPcSY7/BETIq0AfDyYjEMtLh4AIYs91Y+iZPlr7D+AhTGnYVo3/3rlWug/gl0w+QG
         Wo7A==
X-Gm-Message-State: AOJu0YyrzaPPGK+jqS7ufdrM8VG7I7ppW8hEaRKQXu6b3oPtXhD7sKcL
	q1NnPk6k+/TTQWpA/ktS1kNBvQ4vnWxIs6tEESVmTIiA+mhu2N+Ofm7I
X-Gm-Gg: ASbGnctwFUBr+NhynVZfwRC9IQq4++f2YtAY0BHjwD5ZcYPE8cRmnbYxQ/zShAMdptn
	nIwXLfuKUuyu2QWpQ/IhqXBWCsA/GqFiAt7+jrMebA8koJcnnK84YS8MzbXNg9Vmhj/Cbk0K2xG
	cSVD0HPS9dCltRnM0Dvv2RShsEB5jUSz7cjOszZBVV7Haukpt+tFTSXSRRFZ70oc1EpwKTKcj5W
	raBCK3IsBDeDlFZq6YGx7JYEIU9fBrnTq9DkR/Wtg44JNJtt1Fp07abuYwDWYPrc/7SlLfL
X-Google-Smtp-Source: AGHT+IGSBm09TjuJy3AXJbpJI9GqpZmjxmNisxYJks+bVzCydtShCR9uJuHhs4E4fmHPOHod8PwJhA==
X-Received: by 2002:a05:620a:2907:b0:7b6:d089:274c with SMTP id af79cd13be357-7bcd97166bfmr3895422385a.34.1736928810681;
        Wed, 15 Jan 2025 00:13:30 -0800 (PST)
Received: from [127.0.0.1] ([172.200.183.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce323964esm691041485a.21.2025.01.15.00.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 00:13:29 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1736924314.git.tanggeliang@kylinos.cn>
References: <cover.1736924314.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v2 0/7] BPF path manager, part 3
Message-ID: <1efe02ff-3c0e-7a2c-8e80-bee3eec54d68@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jan 2025 08:13:28 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): selftest_mptcp_join =
=F0=9F=94=B4
- KVM Validation: debug: Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4
- KVM Validation: btf-normal (only =
bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/12783407981

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/0f696004e7a5
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D925568


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

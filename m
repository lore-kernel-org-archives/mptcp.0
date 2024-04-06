Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516A36FCA
	for <mptcp@lists.linux.dev>; Sat,  6 Apr 2024 01:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712366354; cv=none; b=HVhXEFJ4PcZzamZuzhp2P8aWdYZsUgmdzsKIgwTmqsi50zOFBDoxZnX7tCj875sLMTcctQR7TV7WdPgif253UY3R9wtEsUQCEd3kDw90N207WUZDty8XrMjTbFel/MBvlcBYefK804z2rwoMb9n4fWX0TgO3iFBMxrsgJLOEZcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712366354; c=relaxed/simple;
	bh=q0DYg8b4ICsi/ZHyoZsSDnQKYYYM0s6///Yt5+5/O9Y=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=pDzbEKq5A3XTavk/EikK7UIuUbhRltZixgqi4AWjqOgOqEFafeFEO0fiwN1GiM182fBzxa2mWLtDKWtCYdGY+M2RBqOc9q8ndCdOL6O4bZ1T8At1zBLyJvd6te3NrMwyyqZFtgDNS4P+lJJJszyIxuvscYJKvxa7UXE962Yf2WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fsFxUZTW; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fsFxUZTW"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-78d57bd577dso874585a.2
        for <mptcp@lists.linux.dev>; Fri, 05 Apr 2024 18:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712366352; x=1712971152; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SqOdajFyIz7RAVCpoY+Zdrv7HtfUEqyC2YCaqLGFd9E=;
        b=fsFxUZTWrUJevovMtI/KfarS5Ts7QC0znkA85BmDOG0rTcaYWNj87zebpIL6c8QiSs
         AanycEdWWbu9JNQ7+7luBT/Wc3a+MPgPuJBz5EA/04Qm6233sO18RDtjDv318OppOQIn
         YxKyUAQOTQmD/a1UYOm8F0zfR2afydjSKySwYeiwnXdph3BRmOh/7ydQr7U27y7LsLLX
         9zQ4zif2pYVHPD1Qf22hBdyDSOrHjUKKZ+P8Cf3wDYdF1r7kJBCh7nFyUpDciMEvNl7E
         aFlmHw2pIS5vIjgbJP4K6l1bA5sCHAHC0F3gnE0dHc9IX7MW74TWzN+iOJeT4krba4Je
         smgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712366352; x=1712971152;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SqOdajFyIz7RAVCpoY+Zdrv7HtfUEqyC2YCaqLGFd9E=;
        b=e5NyLY7bw+rgZsjikYu6cjwKRy4hprE1nedO+omvJh9UmrDnJZZAH+u1c+ijoCR44e
         JpPWPIn5fIKQXyQrNK8TOSQZNpKDkXweh+ZSA0sGoikZuNVrOWniP5HpbGp0QPRfQJRd
         8LXAl3rVVEdDDjpscJuE0QnmLopgwLVPgIBcWQ7by0T/6ww7nS6tGWouhDFFrBYM4LI1
         XUbIUGzpQ71f0daDRD5Wc4mR9KI6G1PJQLzsk9vMw0GRvUR3i3krAJYSrEXo9RDvUlRR
         BJumI2zcPKxe8o75N5p1qNYLLQvgmB+RE6RI4oyT8QCqVLKzjGbjwOP+czpcYsgfUv/e
         rIxQ==
X-Gm-Message-State: AOJu0YwMi9lvUloN9AGg+XIIT6ps23quGGY1eKDydJQc7LwUO6aPDUiL
	QZQsmGt7uf+DNyN31JwHYv706dYVVXYQ1Y53G6d59wgdSMrZmY23fAMulag=
X-Google-Smtp-Source: AGHT+IGZNpbPWHaOAzWdmRGyZOBiu9F6aH22FaMd0B+goDz8g0ro2+lFQr2CclynWJ3Bqf5Hg5Ua+A==
X-Received: by 2002:a05:620a:27ca:b0:78d:5105:8987 with SMTP id i10-20020a05620a27ca00b0078d51058987mr2153400qkp.29.1712366352218;
        Fri, 05 Apr 2024 18:19:12 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.126.65])
        by smtp.gmail.com with ESMTPSA id g1-20020a05620a218100b0078bd1dc41c0sm1093317qka.26.2024.04.05.18.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 18:19:11 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <0979b4df687213cfaccaca526ad74958db8f67cf.1712363381.git.tanggeliang@kylinos.cn>
References:
 <0979b4df687213cfaccaca526ad74958db8f67cf.1712363381.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next=5D_Squash_to_?=
 =?UTF-8?Q?=22mptcp=3A_add_last_time_fields_in_mptc?=
 =?UTF-8?Q?p=5Finfo=22?=
Message-ID: <9eb641fb-8526-f2ae-a6fb-7aadd96ef47f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Apr 2024 01:19:11 +0000
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
- KVM Validation: debug: Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/857740=
0033

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/7062fb57752e
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D841981


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

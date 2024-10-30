Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA821BA4A
	for <mptcp@lists.linux.dev>; Wed, 30 Oct 2024 05:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730265261; cv=none; b=GW6+9IBiuN3vC8/utmP0rL8QaKMBOniahel07ElHfGMknXRaZYSpapajY4l7LCNMnINUmGSVM2ZW/TCgCiKKzm320zrTcSXEr+juXsqQXkLE6nATuWWqKyiRxU8Yu8N6jgQcXUEqXOuFQ6VMe9ZT6K0Ort71kFm/FTNFCqxYl1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730265261; c=relaxed/simple;
	bh=aoKVUB+G2pNjXr3Dx57gBKafhITUFli3PzFDTUkiCnI=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=gGhRC37R3u0zK5WfrtCgevAzW184gf3YFj1o40ZWs14UIj0E2rfhdw0XC9jq5xgysOROmk+waGov3kXxHbLCgO4W5EFmsIVwQoADuqLyo0nckbEWoy8AomlSDL7+QyRipfRl95tGY+6o4mhQ9EJYNyqPWLicFHWhp+knIKRbn6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OjdVkh+x; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjdVkh+x"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b15d330ce1so499841985a.1
        for <mptcp@lists.linux.dev>; Tue, 29 Oct 2024 22:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730265258; x=1730870058; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unYCzH1moVkBwTO641bpTejumbkqqXNkIOnm6kP1Xqo=;
        b=OjdVkh+xC8yGBYtR6/IbAP5yBSyH27v5X4zMJ9xmWke8BS00q+h4Wa0TP6eH2ADwwn
         WY9OOr69mlvnHi/UQ9eYjvI+qyzros3hf6pbQPxVkWXsY62AROxADXslEQGnW2sqAcRl
         aqacMFEFXp3qAhrZj2i8zdZdFzsn4jmDKNSg9eO1JdPbv8dvJPs/bik4Al3CWMqUwpKO
         ZQIJQSVf3AY/6qXb17Bqs23OssKyo+xHtAcD2umhKdBb0hxFciBZiYYb4SXmhh9f3oB+
         uGIqudmS+IzmuytRdjjsE3KUKZJ3LjFT3T3bBJVbGJeySHHpYn+cjZcvW8ubonjbblAg
         7pIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730265258; x=1730870058;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=unYCzH1moVkBwTO641bpTejumbkqqXNkIOnm6kP1Xqo=;
        b=dDBBdTfgT4RLSTAm/cG/kByhDk72CZAf//WfRU4PC1T9H0Lu32Ify4KJhfdYrL4MRB
         rZLSOEZWx6P7nXiLOoQ2To+TCK3lk8UbklSIeITRxIgikztrHJ1tWVqITrBwEAAdPm7n
         1znwR4twcAMOOcnBLqlg0ZUFdGKIAMTlHbmt7Wf4t08TEYo50Pxe2MP1X/6fxPi+5uM4
         YSULfRdSUnlCIYcWiarOo36wEHGb5XLHSJBf4kYmpHLvaRGzanTuRjO5KdvEhATez2mX
         mbA/JLz48opBkA0p2UUU45dtBYJq9HK7A8qGV5UF2+j9dtoCJou/LTLGp/Qw4lrhsdZ0
         0gaA==
X-Gm-Message-State: AOJu0Yx2J4S9/YYBghPjxsa3NurXGVokib/yX6TLfW40kBwHh/ae3x7h
	PkMLFutpOZ6GdGN0Lb8HZ0jAxZvJnTPIu7ulqPxunAjU96wUMlFtfs5Q
X-Google-Smtp-Source: AGHT+IGhSXB2d8U0ekp3vtXDTgqCDnzX+fvYqwQlzw8Rmfv4ELClbP3utqPNE1fAhJc33VuXMi0uEw==
X-Received: by 2002:a05:620a:2454:b0:7a9:b739:3763 with SMTP id af79cd13be357-7b193efc1ecmr1912565885a.28.1730265258640;
        Tue, 29 Oct 2024 22:14:18 -0700 (PDT)
Received: from [127.0.0.1] ([20.84.127.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b18d27b98csm482826885a.6.2024.10.29.22.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 22:14:17 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1730260715.git.tanggeliang@kylinos.cn>
References: <cover.1730260715.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v4 0/4] add netns helpers
Message-ID: <9ae80455-5437-5127-a23f-bb5f037e07bc@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Oct 2024 05:14:16 +0000
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
uns/11586931001

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/639f675bca10
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D904491


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

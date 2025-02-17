Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34072165E2
	for <mptcp@lists.linux.dev>; Mon, 17 Feb 2025 10:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739789657; cv=none; b=YWFc+NekVA35pEpFPWlJbABbguHMPeqlmubjQUR1wPSdWGQjt7bJtjDefK+plYinNpUMF9wKAWPNum3w1GQMU+fGWaj3dCg7iFCmmAWhAUEucIL6QeGltJBluwC2Dznf7CwPw9dmeuTI3LLBvKfyPYGUWwo4O/8b+7XyUJkngRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739789657; c=relaxed/simple;
	bh=RIgd0HVEGNel0Bp9Dcnx34ywXX/+VkAurOUQIHb06ts=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=V9D9TMrmnGBw5ggBLIDRVTuQ2ZThyy1XFAkQHK3wmXEH+onE1K7ovqwRspZko44/TrTcqNVh8wFEm1KFYDFPV4g0SZ9rZUrFB0Dx/BghHf1l5kkkBGWEhhWq3EvEos1aVTVtc324GnOJv9sybratwWM4/T9RMkAqjFE3UQIdrXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0LLkG0B; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0LLkG0B"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7be8f281714so449232085a.1
        for <mptcp@lists.linux.dev>; Mon, 17 Feb 2025 02:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739789655; x=1740394455; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HMoRvTLs5OW7g40n3ttdMTFGQN/DTzgmUohpOtQvBXE=;
        b=m0LLkG0B8FQVaAGKaV7s1nGsX9nFxNFq1rZiM3uTqqWTD+wancKxplcsT64ZSYATFR
         H30v6h0/NARPpPFY3wZEbzFoJoy4M4qznwGPyXtUTVhPtBFt5/8mcmcpb/Qk+58U0Yyx
         cherRJ+6xjxHnC6QCOPxtp+10/bt/u/4raexDGqWYstG28Up3li8hKQMdzD0DoWjyyVA
         2tZlIgPrvQGHlCl+qo0/CdhUflG1KwahUKzlT4AtevvVXWQLBC7xXr8ZEe+tl1lfyGZe
         0Ov1mv0LHYGNBdH3aNbLCJK1CNmn07LOafJNEphIM3awO/sCTd7uHGUFrhX2prsZeL2Z
         jgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739789655; x=1740394455;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HMoRvTLs5OW7g40n3ttdMTFGQN/DTzgmUohpOtQvBXE=;
        b=RYhkrebMK1BBOmLtib6EC3/Atfdq3v4JU01XQWGb8JhcKFZDjNh120Vt7ZLEiShguy
         UqCMdTbeEgCiLauUWPgC6dD6AS5nwe9VBA2Vxl9svWqTbHmIDONWu1/AVq/NlB9uMay2
         c77sQa3gdUIpv5S5Rxx+csMzyJ9MH76RjSEpSvZnIL1iKCXXA7BYoPIUoU770xy+y4K+
         NsFKKz4wr1e06i1KsM/DWc8TZ2KGlnkSm7A+Bg9ZJOyGTx2as5RgmNdV6Re/pMwEJcyM
         84zuMPacB5qyeikFLwfxOlDbFbUoZMshwunOy6+nXQmjiwZAz+PEHYuG7y3rssvP/keF
         KWNA==
X-Gm-Message-State: AOJu0Yzte3hPiQ55xMc/OYdQAcinwBGkjjZr9LUarmBTiEgmKWAaXKx0
	JRqCvMxM8BBXv2gDO19RfBMjnX7Es2DBPSSkpsuP+nWCULXAojE=
X-Gm-Gg: ASbGnctdy0SOzOituh5xlqIXnwaU7/J2uyNrog3ZzjPxcU4M3XmlIXhtXlVf+9LMXTh
	rGg3zHJ3sUjMjeM+Rghfkk4c2QBp7Cr1CPtYWh1BLVbosNeLZl54xPelKAf8QMAf6hFqMOwyULi
	0NQpCTU7aOSuIX7wzufssFYzVUo5bEEBd4MRGQcZjtA/XwraOiBzz2sMDPnTXHnt4KJt78seQJI
	G5q00doqJX4Trivg/W9zHiCKjF857i6RhYX1ai4fJcI5gQPOwuBNCBieXW46iwiNe9IisnXruWQ
	zUcoyzZsX0XC3O+5F8eBdL5EthM=
X-Google-Smtp-Source: AGHT+IFujzfgXy2rbUpu++bXwE+X8lcgcFF+XRwIgIB8sRJ0DpFz+E4/LdH/I32S+lC6JhN2n79P3Q==
X-Received: by 2002:a05:620a:4003:b0:7c0:6cf3:90cc with SMTP id af79cd13be357-7c08a9cc695mr1064450585a.30.1739789654740;
        Mon, 17 Feb 2025 02:54:14 -0800 (PST)
Received: from [127.0.0.1] ([20.42.50.231])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c07c861b57sm521615585a.77.2025.02.17.02.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:54:13 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250217-mptcp-dss-drop-mpj-v1-0-d671d6b9a153@kernel.org>
References: <20250217-mptcp-dss-drop-mpj-v1-0-d671d6b9a153@kernel.org>
Subject: Re: [PATCH mptcp-net 0/3] mptcp: reset when MPTCP opts are dropped
 after MPJ
Message-ID: <7f40400a-7f9d-49a2-f6d7-04f96fcb219d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Feb 2025 10:54:13 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

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
uns/13366428077

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/4b6ff0b2c9f9
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D934579


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

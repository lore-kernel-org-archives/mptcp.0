Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F018BEC
	for <mptcp@lists.linux.dev>; Thu, 27 Feb 2025 21:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740691132; cv=none; b=I4keuXQAyLCxJ2kuz12X2Zs8OEUBax/41VbskoPew8XRAV0DGzzlkiOwRL6I6Q84sNkh5bczhzOWmvaE97km+dz9bkAgbny3kAiQrFJw7qu1RDyi6Us7sbFaIF4L868cpfCoMODO3AAeuyU8caSaEdxKdq2z6K0l8vuhvbJm3mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740691132; c=relaxed/simple;
	bh=HKrE11kNYF/BMH9z/34lSOShFcWtBZ7GffhbBIjpuHw=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=squGnrfWxUpeVFcUfBMapUTzLfeDzQr1F4ZxqbMr105tpBDok/TmtYTW9BB53Uaac4W4UMw3YZHCbkeMl1av+fYb17ZcJZBmvbpQN6JRB1w8RZsaxny2OCaloGxdhgnAm6X2a+I/D3GsJe2coRtKM7ONBEaqpsHkKN87lm5wMDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLRjaHKU; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLRjaHKU"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c0ba9825e9so99079085a.0
        for <mptcp@lists.linux.dev>; Thu, 27 Feb 2025 13:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740691130; x=1741295930; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0s1ki9eSpxsLFifGfWXj434mT2c7UBNpuZp1N2QwD8=;
        b=kLRjaHKUTMJCKJWy6jcCQ9oJ9/D4E5sqt2Mb/QNutHWRQ2IkFB2q7g3GmNHLF9gMHo
         kKmeXgC5x9lOnrmjRS8mA8rnn8uxKWs9dtnTHKsYqVyU00KZ4+9ZF0wzYqJ/gzzDE5aQ
         z2Kb1ECgyeacg00hBm7qE6ETfxt68BbJLPeTQQXdcRnQG8d8474uXXBUnDyHrP8VspGx
         Kncctb4fcUpHcpH8uoU4GXXttw2dUdR1RbEOfWeIFXsBSn2dA7vXaJQ9kVECtBjIDkii
         Ws7h2lAFsioAT+QVPwm2BUwWDo4QfR1QiLdrmmGfTzkbSHMOaqrBH/P+J9rDnOFfCqZx
         /jNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740691130; x=1741295930;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I0s1ki9eSpxsLFifGfWXj434mT2c7UBNpuZp1N2QwD8=;
        b=QCh3G7kTuhcsZB7KjaS+qBo1hceX57pi2pCR3pkpTLfvLI3WnYXeaOuW2DcRquhn81
         LfPeu9NLh5A4baN1fyUvH/3VBQ5Ty9+rtR4s2f0So3maqOaxpLEpt79JpMMjYMnryow4
         zRZWdk4S6VTZE+X+5qFks9L9/VzjbllEuidkPFvwk/gvzTg5x5uesymfO+ysq1jABlL6
         niUxOlbQLS4J5mW12hiP+nqNuX/EtheXUJ93NHXSxFaRUIoB8c08FkG2ovoskxZEw15C
         P+uZ7aYhbBKfpd9iYqIHAlLSe0fHOUxCZ9uCDJeIMtwSJnjqLnXR1bmKtMvdyGSRWOpj
         gHjw==
X-Gm-Message-State: AOJu0YwnFIGDcAcKLHOZi2SpVdZKIKZU+BzCo6iAVyaOFErcL0SYo/qG
	8sUEhskaRznUL1JP3FuarHcgrupvfypAWKaMA4WieyN956y36JxXn37K
X-Gm-Gg: ASbGncsHmdr+i4OMqxHDIqCaYqMNVaP0roas88mhOy/NBMArZNbWt3TSxzLNV0oMVCL
	7ymFQ9jaswnvoOvRO2KULmDCF1uic2jlEo+zr8qCOBoMgvVrmTbOaXiFHqsIhJ8POMJEVJIKoKC
	6o8ByFqwr+BtQ8avRaj2bFexoRCfdGe1DGmtDcRmniN+THKIkGM2tZb0mdF+o+W/sTDj0amobMB
	xbc86QtdFAUhzZd82fo+xgn1+lpZYsIKtxq//QoIN0Er21a76kDql4PudTRsZhVwyfaIfkFbXK+
	HP3GbSrCsRV+Dzv5n3t440wajReyoVYNK0PL
X-Google-Smtp-Source: AGHT+IElThyMskiHE1V5/42W6n5/+ioVXeuqTcbZup+KsTBLZ0ikKhxF78ib9/Wa2Pm2ZKC9YKgWGg==
X-Received: by 2002:a05:6214:2a8c:b0:6e6:4969:f005 with SMTP id 6a1803df08f44-6e8a0d8659bmr13889996d6.30.1740691129739;
        Thu, 27 Feb 2025 13:18:49 -0800 (PST)
Received: from [127.0.0.1] ([20.57.79.78])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976615b4sm14040606d6.62.2025.02.27.13.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 13:18:49 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250227-mptcp-pm-reorg-code-v1-0-cb4677096709@kernel.org>
References: <20250227-mptcp-pm-reorg-code-v1-0-cb4677096709@kernel.org>
Subject: Re: [PATCH mptcp-next 0/7] mptcp: pm: code reorganisation
Message-ID: <bed90698-8d76-20ad-068a-d618695561ed@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Feb 2025 21:18:48 +0000
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
uns/13575269556

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/423721784d18
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D938681


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

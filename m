Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D65F63087
	for <mptcp@lists.linux.dev>; Tue, 13 Feb 2024 23:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707867024; cv=none; b=anPIfOfK/i3ig7DqzBTOeoMgIUIJRkBA5/HgfS5N6D82nzEIZayWEsgQ9ATlPqGVrlpM8joBs3WuWZE9djkPSNZP/TQWFAAokLTsgGt/5sgnJR0F76Kn270GckdCeGdbaym9heakJf1tfGYxCVIIam1W9w2o1a5HR1IpOx4WPG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707867024; c=relaxed/simple;
	bh=HSe4KlEFopWnb9PsWpAjOMgGkWq0Es0SLmWt05iNPKk=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=sqs8tR8gwoBObFdbMtEdrnYSKH+okuWqkkPXh+lCanSKKEDAcPYR2SDFBltaIKqge/N+2dK42BuNP4uhIq4JD6mrAYovPy/Mzjvt5J+6X4o0cxO+CJSE4yiLRYI8dTIro8gak6voUDkHV+t6cwsY0OcbeQWfqqQN26lcIRa4Q1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iegQAX1n; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iegQAX1n"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-42a8a3973c5so25014631cf.2
        for <mptcp@lists.linux.dev>; Tue, 13 Feb 2024 15:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707867022; x=1708471822; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ld0zYWIEs5mw5xAGamg5q8bpCcgJWreBwrsmSF55enI=;
        b=iegQAX1n+f9lVQjqLVBcmF+Q019vFr/c2Tx8J60YUaoT28iE8ntigCkyKxINejHQce
         F69EbP49tXUKnhyn5dIQ8NwjkDk07evC34tDs1e0LtR0gf8fLiCNCzaqGi1LR2SUQ+xU
         hOmtGIo7vGTCwKMOWWwBchbZ7Iq59aBeGlKxmfB/JpLPmI3xFwtb/SQEDbbz/g8EDyME
         uzj3VCcgdvjSu4OTlujc1Qahr+a+8J2hhLtlSboXS8B/OKON+T2ozjDaLrMYijz2N8t8
         PnnU6hzT1eGrUEzN09u7BSkrhVGyfDlCVWrNZJ3IoIentSMAglrAJXRluQVLZQuMpDKZ
         kSZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707867022; x=1708471822;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ld0zYWIEs5mw5xAGamg5q8bpCcgJWreBwrsmSF55enI=;
        b=msB7XIKlzJN5XuoA3QwMoFcMIdNTquwF41Km+pk64gLGkbubre71oVCoLGG9fiP57i
         WbxAfxoCO6uE9ikB246HPq4dP9dnIixc3TBsNUfMKDjN9ixWgrgVzqPNlvuoMyAy6WLa
         Hlkp+2YlVJXAjnAdFHUdPe4JGEWKbE7iqzTAhLvSwkKaw9b2kU+ClTxM6qsKkCTazMnm
         O9yI6neVe7oGXjL0M1/5/MdmlkyG+ARfU+nH7U6bUkkMXPzNe1o8ghfWRMXqRj6mzi6y
         jEWzP5hNHTkGwuWteUykSpN0Jrv2HMvTtU0QE1/uaEa0my5v9Ct7qmZyqsacP8t/Rp3h
         V0yw==
X-Gm-Message-State: AOJu0Yxt9WHI/QaPkQc9uL8zvnz8Sz6PEpspAAexdg0fgTniZkeRiQhj
	+jFmXPwspocN5uQfcvJaZGcjPqAVDeCMe9XQ2Bf8xDEtasaVBZc=
X-Google-Smtp-Source: AGHT+IEAXOgo2fZ5zi45sJLdHwtd2jicKNkFiQByPJAckG/dMEhOPh/41woxRQSu7022KybF/Pikeg==
X-Received: by 2002:a05:622a:40a:b0:42c:7a74:ccff with SMTP id n10-20020a05622a040a00b0042c7a74ccffmr950293qtx.36.1707867022042;
        Tue, 13 Feb 2024 15:30:22 -0800 (PST)
Received: from [127.0.0.1] ([20.55.118.217])
        by smtp.gmail.com with ESMTPSA id u26-20020ac8751a000000b0042da6e7c0e1sm1492271qtq.22.2024.02.13.15.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 15:30:21 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240213223135.85957-1-kuniyu@amazon.com>
References: <20240213223135.85957-1-kuniyu@amazon.com>
Subject: Re: net: Deprecate SO_DEBUG and reclaim SOCK_DBG bit.: Tests
 Results
Message-ID: <4b3d3b94-1a5b-a526-2a2b-cd63b6cf9331@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Feb 2024 23:30:21 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Kuniyuki,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7893771323

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/b82e0568acae


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

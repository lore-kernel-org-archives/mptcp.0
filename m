Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B782138F
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 00:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708043034; cv=none; b=APiKyYzg5fN5sP7NKzrVs5edLJiXYc6Gmr/ugFOQwSjz12figLPp1/HtmS9DNICY50rqswKbKkxiLxPjiMde6WZkIqkP9MYLk+cSOrX7uPTgALW5B0M4FjsAb01Uq0+FgQfwlcK4kScZaUBRHTz9qt9DL6lqRayW3gWrJNJDFoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708043034; c=relaxed/simple;
	bh=saOcfJvwhUmiomCjVIWal5h1zsM2u7Rx3kG3Y12jRGA=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=bUTJZaHiipwTinLW2YHTiKg9o6oO/GcQ1fylXzSlrrAutQ8ytZGSiw+s0cKlH3nuhYHeqHGTI/Kwg8MJbiPNJxp759w+PvGS6mSxFeeSMYKdQQC5ccmHOnGj0sD+mzaLZUyHFavai7wr37TPS+ro/9DGQrH5Qi6h0LhBopi6qrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVFnCdIb; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVFnCdIb"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78716bfff61so91871985a.1
        for <mptcp@lists.linux.dev>; Thu, 15 Feb 2024 16:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708043031; x=1708647831; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UX/BI5pyqF/Wat1eCm3mN7Wlpk0adOEyrRVFjZtqpqg=;
        b=aVFnCdIb3H9MJPBzUPDBaLP+VnyPJCkGz3gErj0aqd9Vp+GMRGP+Hinxdd9ORAo1mk
         vCjQZNXBtmY4RQdJoaz1tdIEwQ7QzxQpRbSFB8Jir3ANaxvTKgTIE8kvgeU5P6Sgl0MG
         1ycuU4KQH0W9MGxmdPA9ilPBCIaIL4BokUbkkdfuMVBHnl3YJqGAy0vH01zXYLFbCk/m
         Id9KoS9qwx6RLVhEUHrPSO9k445+ynPQr+9WNmCpLInMrAU2pRV+V50TWG/B/DDsiTBu
         d40BmpXGw6AMjTufMRwcex1v3c7Ln951h5uCIIW/YlRw9O9pQU2b3kOQYD7E9vsXxRpI
         OS/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708043031; x=1708647831;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UX/BI5pyqF/Wat1eCm3mN7Wlpk0adOEyrRVFjZtqpqg=;
        b=Bg/byx1Prcr4VBcKToBWCP1788kNyfHJ1u6KaOT/JxJbYgflXkWJue81lcnh/QEpjn
         RR4FAk/9LVVc++Z2qtE+kZM4SClbZzzPGPKpDodyw0xDHl/A1SxorX1ePSTslNbwp5y0
         6/+XGGmuDpZGs+9SeOf5n3B2HTZbgl3h1WDejp+6JUOBfpo50hVJ8cjN9QZoz2YJXlDA
         0W5+8vAvlGG8VYnxMBvulzNcUg3mcbmpNFJnT18rmMq8AK87IrfE1Re5t+fOOvqS5n+I
         mh7flcTtOYZf6eXtz08Dz24lyRdOn0P+LnPNqwX4Au5AFUuYToG8BIUdrlWXQmHBzz+0
         Lh9g==
X-Gm-Message-State: AOJu0YxhFFWADg0E+70l3Tjdn7QX868WTIBSP6mZeUzkA4hqS/C8/fwu
	V1ffTumwpvFRBxkGtdlhbk66rxfpaIEXO6juzec+ztvboGRn34s=
X-Google-Smtp-Source: AGHT+IHYuK4Af36GEEVMlnZY2vxJmwv4WINtrpIZxNBoE2hBWPw7jhwbh+UxFBGjsxMPajpZ6G06Yg==
X-Received: by 2002:a0c:ca92:0:b0:68e:facf:fe4 with SMTP id a18-20020a0cca92000000b0068efacf0fe4mr3634581qvk.22.1708043031571;
        Thu, 15 Feb 2024 16:23:51 -0800 (PST)
Received: from [127.0.0.1] ([172.183.107.251])
        by smtp.gmail.com with ESMTPSA id op15-20020a056214458f00b0068cc0eba833sm1181255qvb.22.2024.02.15.16.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 16:23:51 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240215-mptcp-check-protocol-v4-3-16e932665e21@kernel.org>
References: <20240215-mptcp-check-protocol-v4-3-16e932665e21@kernel.org>
Subject: Re: mptcp: check the protocol in mptcp_sk() with DEBUG_NET: Tests
 Results
Message-ID: <0947016a-7f84-9265-8a8e-74791ce13e83@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Feb 2024 00:23:50 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5269484584304640
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5269484584304640/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6395384491147264
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6395384491147264/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e79de30e413b


If there are some issues, you can reproduce them using the same environment=
 as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

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

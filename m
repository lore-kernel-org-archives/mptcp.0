Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE1615957B
	for <mptcp@lists.linux.dev>; Wed, 10 Apr 2024 10:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712745626; cv=none; b=Qkh8yAR2gLymyRAgI9cxSBYOc5aHeSzc1pnU2or9PnLC+3Ymijv7fkBNfFJPv7eoK9UjCj1khZiUhTlznQQyWYXwns6B59zY+K714XsrPSEaFZCxWV+ISPamOHwgladk8otB5nY68ysg/6UnxsueR+DbmhJyZI9mhikrjIW7V0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712745626; c=relaxed/simple;
	bh=gtNmgaDnnVn8AHrIpu8pWu934zw7/8GSNgWeYQ236/c=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=gb3V+5gdJ1X2P0Ax+ulGTL4sjaANFpgyr4yoq7juMr4eVuAswXVTu2ecbaFqyaFporf66JUlacmRBGIxz9jCW9uAYGYLdvn37uK5YujWfHRvJ7pGDm38lWWkA0tTM/M3SpinwZPlaW119ke7rf8OjvuZ3PRvR8OnkYNEeGFLY6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6pJndMB; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6pJndMB"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-61518d33293so76980967b3.2
        for <mptcp@lists.linux.dev>; Wed, 10 Apr 2024 03:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712745624; x=1713350424; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+3kGt0jJ/MbLQc8NdYJdR0YmBkTiNQ93S6y6FY08UE=;
        b=E6pJndMByLoaHmctbbtp6K2wxZLxpJXBqdCRXeDM20YpcAUFmu/gyzpqvBfTb9uPjT
         8GaqmU2VPAzcdxLGa6ddOuiyDhUO1qq2s6DaXJnT547SuKsYGTwAAoyXxMXxYLYI1GSf
         w8H9U17NU54wo0YT9eftqT9GCLD9RgeAed0pX5h4agdxoIwDCnE3pTX57+NA1rFT996p
         G/mCcU6RaUURKTJ88bC1i1aMpH0QjG/VNY4izzibBlZlxDu4yP5jNmicqFIb9kEvOVbZ
         o3MrgU1ktzktvuq5Oxu33jcdu1GBxLBcg+OvAXR8NTRH6e3dD7CqrLkwHyK2hWm1W+Qi
         Kf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712745624; x=1713350424;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5+3kGt0jJ/MbLQc8NdYJdR0YmBkTiNQ93S6y6FY08UE=;
        b=AGx9uFkEexbtisj+AZ3JW/ySoL5Hnwm0kwUuRxVTwG85ntKWedwNPyXIxkpVa84zvD
         454nRJ9pINKChDD1qMZyBpJ7NW+EwvJhTNEdBTT5gdfH2gOdD0xCDMhP47d7Xqx5O432
         nwWJtTekqMSrdpMnLrjtnKF6ghNhdqsmPc2OqzvVtZLnGxF5sZJDLAyWCMmW/ArZeyt9
         MBPuNk8MB2qOYR+Et71KJHhhZOhyV6gVSdOxcrg0yXXTXkyakBQv858hU1dEtnma/q2+
         mMTdM1kyMewag5GfhbyBnLgSU4dotGJb8/9hqv+uLAqhn/Nh8SJ7PqSXhn1gGw+vMl6n
         CDig==
X-Gm-Message-State: AOJu0Yw8JQ6eea4ruG8qh9A/x6G+1+hLnqWOO2qVvrGez7ugnH3tNG9a
	Dy+5eo3L/17ZOMmbeqrZi7vOivJNlq4lXhwSBNkcr9zjMwnf99I=
X-Google-Smtp-Source: AGHT+IHDu0KxqXpuXCof9mMqOaGw0pOz7C5nBlpbSoG6EhDU6IB+HHt9UPPrIfu+C0f6grm9CGa03w==
X-Received: by 2002:a81:494f:0:b0:617:d49f:d5b9 with SMTP id w76-20020a81494f000000b00617d49fd5b9mr2210054ywa.14.1712745623458;
        Wed, 10 Apr 2024 03:40:23 -0700 (PDT)
Received: from [127.0.0.1] ([20.109.39.247])
        by smtp.gmail.com with ESMTPSA id b2-20020ac812c2000000b00436440fd8bfsm226210qtj.3.2024.04.10.03.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 03:40:23 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <>
References: <>
Subject: Re: DO-NOT-MERGE: mptcp: enabled by default
Message-ID: <16801611-b996-a731-9e91-25f61e641458@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Apr 2024 10:40:22 +0000
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
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/8629465013

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/14566b183225
Patchwork:=20


If there are some issues, you can reproduce them using the same environment=
 as
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

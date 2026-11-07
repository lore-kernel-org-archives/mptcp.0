Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794061588;
	b=erujhDmWqQWbEBz11XWpwf+2GpIlgLgTy/Sf5qn/D6k9/yNF3Fj4pPJBItWw5IK2Eowz
	 hVHLXI4a1g5bW/wrRJrDjGW4ho7NdOWH+na6wc9W/TEoMITYQjlsIWu7+F4Bg1oGq5Gc8
	 8WMkNB8DoAC/4OzvPYQsqgSvEz1QJC2o456XqLB9GlviA2P3D3fWyDMMRSJy5WvwWaH5k
	 JCHB3JjAdkpxLq3VOUk1YLIeKA7BsxxKeUXBLQovVqO6mUrgnJ65Oram/HRY1cP5klLPw
	 ntTs/XoCpKBQlnz27OzglXNVCsZQ2YEOSQjhnXJpIr+Wwhf/999OlqrOOJ4OuQLdZPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794061588;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=e4hXh6bwag5jYmCheUMuy4xzWcH0sITO1yZeadQzo50=;
	b=r2dkG03QsSj0YHf/CUrFrTjGf2zSk1HQLIKEQzSy9yGvJQci0+ZsWj9gj4aa8LWflXk+
	 NIrY1CkwMJV+oyg6sqP+yZ6wUW35S3ByFfTB2wTiCgksooX154hNG8EfXS2c6opSrZzEA
	 yhAGGc0kXpCWggUbukR8Us0DQY8lZ7flWIazHxh7jI3uR3JMzB9mkbi0tLcySIB1N9lQw
	 aC8zidCTnEz/qnifW5ayUSUEPg0rdxAJWEkUTFGD1by7WmoVqKsjg8APyljqUsv/7I6Cu
	 RCdOOx9u/j6VjOhNolJNi0I5BOGhrMu3bFvACqgDKxHlwnOKfqhLEw3HsH3KZ9DtcHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QZNjqiew;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E37606A32F
	for <mptcp@lists.linux.dev>; Sat,  7 Nov 2026 14:26:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67E37606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QZNjqiew
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-170135e43c7so2735754c88.0
        for <mptcp@lists.linux.dev>; Sat, 07 Nov 2026 06:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794061587; x=1794666387; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=e4hXh6bwag5jYmCheUMuy4xzWcH0sITO1yZeadQzo50=;
        b=QZNjqiewKlKrXob5Z+r1lqUrreRdhKULlziQNHDRFh8SPDMulk1dCY6NdF2cRTbmpA
         ew0IVeFJ23lcM3YJq31MDY++7+0OA1NQlO+EeghH7fKiJwEPQUJ2JuBYxaVvudTjMXFm
         BLRE7uq5HXQUTrbLi3WUHl3PLvL98kyjeVBIVuy4Gh151PQYmzl8izTHqWEgvYW+utXl
         pUKJF3+sUhsonee/XMztBuMFusS4YiIJl8JnverpX5ba8sbEiuyvmmR/QWi1f9yyVB9U
         cO4jspDs3V4RVLxAjMb1JPaXMf/FevVef2Tz55zatayV8tDtftAsRjAs3NS6l6AZilIZ
         sCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794061587; x=1794666387;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e4hXh6bwag5jYmCheUMuy4xzWcH0sITO1yZeadQzo50=;
        b=QzYnPf2iUpXGqUgW44xiIkaBZqIxGffoY6w1S7wkXML1BCg51w3vn0tNqjOIM25Ehy
         Z6jBK9Apb9oLcaDZ5cZ9rK+z84jNuu824LWAfm9T90aVshELxqDV0E5UgrGra6RMrUQ6
         KHxXTeDjC8FVPRy0Rgwc7lvwdMdvAlLb+rLkbOmMHKoW/JXROTWjW1q/NWYMnLodJlrq
         czl2Qc4suFDo5UWbHeYzjIl8Z8Z/iiURo7pgX+Dn3a7S1QCCrwpdDzlf+QOaCfQ/Dnim
         Sh51a43KH25suvtZBy52VHHqzpI+ao1h6fAmLz95EyRGWfTF4TSmAVCdKU7ghlkSiwQy
         M5GQ==
X-Gm-Message-State: APuU4Z+8P+4H/6Y/MHN9kFdBva/XCNrESqKdusNzT0vu36a6zAn6kF1x
	LdKGgeTGqjiHifFxuqqoPdMsnNqfcid/8mSwKhqaI43L85hJ7Tky2TQ5SVyiSkf8rg==
X-Gm-Gg: AYBFou20HI1T2Su4pO5JOq8OrSnLwCSSWUiMUSry8Ysy/xghzPJRUy87Dt3HsZRLsng
	xw6GUIt4bjnBwkw81WvrQRlDMaLxhn8LQIlOqeD6Id/6IQw0TM1yQFjRXA4fgYtBS5FT436baZ3
	AbP/ue44+OMlRTv7+wnwFmwneMZPu4Yz4Elz/jWstb4MIPU44RQDAeaEZxnGOG1GIw8RCvQj05z
	WtlnxPWvNj5PO6vnVoqKZBkQFtuHYgrpDpe0Y0KruY9qkZOKmVU7tjbzyibVzN2jRJT9eNtDa8U
	WpguV/ThNWzO7Jn2hiv/8WRIPX2IPT7pLCAzcUSa8Rf41CP8/6BWoBCM3UUM7QHO0aPPJ4WlrcI
	NMguu//nD+BZFwya1qR+dJpYpWQFGCZj9S2+13JA+QvYawzPaTWkp+FtgsscTW7fdycIdP/LJVo
	Y1o2Ans4r9OrXCOpauuchC8xwE2vHJemq1UiRWvd1TqibjKsHs6xBXH1nFyyakSyrZfkwzUSJfj
	8O33e81otOwF+8hTnmx+7Sy5TDM9AzIkEgyFtfDFrh3arlpdpHrxuZvsPmstdG2l7kxMtScC/td
	Z2k1B5J1Wh18hnXzacmYvzMXuzKNmrjQO5L4Mkpt
X-Received: by 2002:a05:701b:42d0:20b0:190:b2de:1549 with SMTP id a92af1059eb24-1b25d294017mr7668964c88.1.1794061586968;
        Sat, 07 Nov 2026 06:26:26 -0800 (PST)
Received: from github.com ([4.242.195.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4a63f6sm18933601c88.9.2026.11.07.06.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 06:26:26 -0800 (PST)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1794053683.git.tanggeliang@kylinos.cn>
References: <cover.1794053683.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v7 0/7] prepare interfaces for kTLS and
 sockmap support
Message-ID: <d369d77a-1aba-8c8a-b88c-97b0e11d5971@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 14:26:25 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Gang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_diag =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Perf: Unstable: 1 failed test(s): =
validation:sched-bbr =E2=9A=A0=EF=B8=8F=20
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/42373664681

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/50d98c10d06e
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1204872


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

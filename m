Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795169753;
	b=IBV3yFTNw9n4k34rglthzh+WqgM8+8Jnj9ToojiP4g8qNJ9n+eNmvht8yH7T6U8lcSiT
	 WZDMdC2MzNvNQhzU4fhkujMvyTciKpnwtez8GWR9L4wrl/2vg/ao2be6eTy0WLdZxNgcW
	 uUqUHW7BA3IiMINjzwdHW1Zb+OPTNyEgO93LbE6FNsgqo9oJzar+61x9dXRBFIrl9rkrl
	 xFKK3YyS7lo7ZoNRHzu0lxmCXP/WsIuWReBxyWrZ0WaruHr7NOv3ZqSobRdng6uTuthNq
	 AFY8fwYwI7dBJr7pZpSG6PL461dEDX7+cCXQDWFs2ILuB+cAp0XFqXQOlMWjPVyZBUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795169753;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=Qp3AF3QsY28QpTy6KPJhjbaWxrTHY1IRhHMOPsrb0G4=;
	b=SLUUNBUrOUCvwJdz7tTuu2B4yGRunO5d2A6U6rB/rSOnaf1YBzBeH/5oUcMbQlhz0CHl
	 c3ruWudl6cLvG17hrEVU/O776xAZhmnQsMfW/8cd+nDBtx/FpmxQO90/o3PudooP7Sjir
	 rk74/5y3N+rrvc3hldtN6fYU7P0ocho0NdSK2orLA1PD8tNHFyX+0ideDSlYP6fW0Jw/o
	 WHhIrSF9gJY53aDzYpkRcF+t3J+I8G5J0NJCKwqK3K/NnOnNSbnHGohCf4C44sDrxJkyH
	 n3CCLrWlYypx8DzYDmik3lI07HiJ7zCK0TXYa0QUJgQ3kzrmRTdo5Z2F7y5yr8Ijx0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gQccLrBh;
	arc=none smtp.remote-ip=209.85.210.41
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E59606A320
	for <mptcp@lists.linux.dev>; Fri, 20 Nov 2026 10:15:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0E59606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gQccLrBh
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-86298f9267fso448156a34.0
        for <mptcp@lists.linux.dev>; Fri, 20 Nov 2026 02:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795169752; x=1795774552; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Qp3AF3QsY28QpTy6KPJhjbaWxrTHY1IRhHMOPsrb0G4=;
        b=gQccLrBhj6CDb/VXZIgX9ykj2OTyfWasawPwPeT7INm8KGGLjnSQC5EjciDwMqbc3z
         QpF1ZGRigwZdzojVC/4G+caooNal8GAnjDmRcDG1mpS3+eGESegmWYcXzPLlVcwmKnX2
         dH5AM0ro4L1pmhu6+XRFTUidjN6t6a0ezdnaO5nfycHu5M5+enT/FA1Fa90xBr9ngfcg
         /kQ82BjiLogRIS8y6sKQ+9pVv47mR7XzrxQeL/qFVuC8mN/JRIVJR8TwEmJQM2gFcgQ8
         EPsvBRDN3qe3mbUWA+YL5MWAVt9/dfETc7EJq7/6fAjrnrfBtq5BLNtX20d8rjUcKwFu
         Nqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795169752; x=1795774552;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qp3AF3QsY28QpTy6KPJhjbaWxrTHY1IRhHMOPsrb0G4=;
        b=WlMfLUGE2Gj8efEJhPzQC7IjEUK34JLK1Km1isnDVYYgGrYT1zllDEaAI+kCHrH4gt
         ZNFg4tGol60u45+Qjsb3TKRS9bPE9vpaKQGRBSKhFKr5qN8Dso2u7seAqqR9TcESXH44
         /+/xay+usBC65kD/Xo203yoVyEVM+gdWskAPT8tsXRLuGYqv1WEkE2dZz9ou6jHXXwqm
         kR3pr4bvCYYbBmwgRbPo14ZmrHyQ7eQ8zYEx9zo+1jKtyUwcL26lUp8JCydRrNVgy6cl
         zhIfjpeqdlYrb4eh2Y4CW1MzsHuDdFqWa/rsgsTwNm+gsf1v7my6ELfL3ovMojUT7f7Z
         anOA==
X-Gm-Message-State: APuU4Z+3zYKcAo5l2Z/Sr+mhUsefgtkJm3xarKunTU4QniHd5yEC37XD
	MW7mDx8hQ5oZ1aXDWhIMVWkUJ+5YwL7Q0xjAg9qXUIynjWQQCaY+/t8=
X-Gm-Gg: AYBFou2Vlb9mAbalt/tm0ThmYS50K9GWem3K/evwaBavJjNrHaqzvsd4JRnwGSkE0tz
	MDOyp4zi119RGmMPhFPWg3/OcdhzUCHFn6i3WxeFRjT6nWVGZ6WY6OGT55U1htDq2NpsxBUt8oB
	oUrOfxNGHC2eWwxzvc81/Ko9R1GS03iQCWYrKRq+tHyIn8ScndWbZuw+oyJjGuk+n5Aozt9c6Qa
	zv6l6Da7SXHNU8V8b3NGG7P0HGnDSCpSzig5hA5PW9bn3g4jF8WWVZonMDzf2LZCjhenbhspUmQ
	sZvE7qOdEDURJtnDkLUzep57PG2DzO+RyqJvwqoGpFaZkwIeLWnoTGo+ZgNJGwohoGSQeWZlsOF
	E2VnpWZSFh0AgV1NhUbmDW2Mbx38cTrdhJRZdQXVqQUuuw3Docv+uSFs2mvVFT4ixxW5vK8Gue/
	60zW0cSsaBvZhQSAyEztJZp5gfHeblbNvckW3JsPpXNB9d05AXki06ccJuZpqfku2dm7LeHegQj
	vkzT1BcY7ucA28oarqaB4YSojS3ewCPc5AN6fFr7rbD9vV7rWVY49hb2sLFjqD0gvo6F9JNiJHS
	mI5rRa6BaCeAFQl3Wdcf9hDSFg5vfQsBs6o0vhF0FCM=
X-Received: by 2002:a05:6808:178e:b0:4f5:1cd4:d2be with SMTP id 5614622812f47-57a035c3e91mr3355157b6e.0.1795169751622;
        Fri, 20 Nov 2026 02:15:51 -0800 (PST)
Received: from github.com ([135.119.110.72])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc5f7ae7dcsm2353854fac.8.2026.11.20.02.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 02:15:50 -0800 (PST)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Lin Lei <llleigoing@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261120075459.2862977-1-llleigoing@gmail.com>
References: <20261120075459.2862977-1-llleigoing@gmail.com>
Subject: Re: [PATCH net v2] mptcp: exclude MSG_PEEK from receive buffer
 autotuning
Message-ID: <f7cdcd96-5c83-08a0-e0bd-8ad8de0b7810@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 10:15:49 +0000
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

Hi Lin,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Unstable: 6 failed test(s): regression:sched-baseline(3) =
regression:sched-bbr regression:sched-clientlim regression:sched-rmem(4) =
regression:sched-serverlim validation:sched-loss(2) =E2=9A=A0=EF=B8=8F  (1 =
improvements, 90 new outliers to review)
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/44702283372

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/5ac9fdbe3174
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1217034


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

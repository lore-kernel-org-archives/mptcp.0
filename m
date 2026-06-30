Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AD03D16E2
	for <mptcp@lists.linux.dev>; Tue, 30 Jun 2026 07:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782803623; cv=none; b=CY2zq7O8y9nfr+c3C8Rz1cnxsMNshwulhAaGq0DHATYK4zZSfUoSadRIyRDU5MLtzKMD8C1AChJVc+zavUBDze2K215GQBQUOq7FqHHWZEug1nCxCPV8cp3JYGaD/nmbyC6Ol7tv92Y+a3iZwPHY0tdx7pAd9AfM1YMIvy8NlxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782803623; c=relaxed/simple;
	bh=wr9WnUN78zUoDi6qnPNnS8ZcEgLBengF9GAIIjMp2tY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=FleLs4tsqCd/VUycWkzkTA/AwulV798bQdV9Fa22cQReJgo6CLaaWA+EkQIlUsoBA5fXqzYLcEWWsKwGvXWiEHcOg4rV/5RqK2hypeGaFKcyIrPD+PLM6GIjCzSa6y8veadEtNOO1z48SR3FdSBVIW2b7zTotZSqs9c4SN1tMI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2DVTE2u; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2DVTE2u"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92e663c828dso30485585a.0
        for <mptcp@lists.linux.dev>; Tue, 30 Jun 2026 00:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782803621; x=1783408421; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZNEmL4XsfbzB2Gdu3FgO4VsoY+4GZMVT/zs5avHLQs=;
        b=V2DVTE2uAuhdJeEPjjE+Tey2a8mEMVeQ0TIkg2AgI4z+DQxilUTc2y062MPbPOybTL
         ahusab69vcpMzynCHBd1J3cZwt1dno+EqffKqFd5xPfRlsmKeqHUbw1DwVr7RmmV5qss
         ptxgZDbauJYEMvTFPKlbBgkAVYExZ22svCxrERY1PMIi55JNA39zY35YPNX/6qw7hAxE
         wI2egwXsxNXf+dVYF8ao3vCZBpooMq176JoB9wS/f9I2kVlq4n9kId9leY7nTA8HzrRZ
         a1q6OtBg3HqHzjPPuV+wWqX3dYAat9r/9XPu57ieRzFifXRUblJg/opkITlgWPdOz+lS
         ljQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782803621; x=1783408421;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TZNEmL4XsfbzB2Gdu3FgO4VsoY+4GZMVT/zs5avHLQs=;
        b=GuoesAlBEJG78u8Uhdtj7nYfH1QoCQN6hRd4dblveInU/usJIpd138FIY+cTGB+Kc5
         aGetKxbYczIntzxY8IgnF6HlhSEZrh53ldRt9INQ7M2tbli3Spr7GmgkfIIlNsgkghKt
         vjnG9tETCfeP4QndjnwuWg5fOTqoMLkkLndVlv2tz1qN7g7l5PXPEKIDP06xr7Hik4wg
         uRbbAfRVFqjibJ/IHEvdFU6OL8oed3H4iRNw88TsKWBhPp8/GRPl5sF7/WFPW0rmp82m
         YcwRJ9ZGrNAy2iA6GIGWB4daVh8iEAsr8LOJXHelB2LF6ZotxbDZMTIoPewUgaiLOjiX
         TOag==
X-Gm-Message-State: AOJu0Ywpcn1YCkhK2apVcHwlhIY179jZ1hOEXLyNyFSwRnFn3DqIBl48
	QzdCJ6u3VG2Pib9uQ3E5mMaZWI3ASl03+iPhKLE+YpWpCY3KleeUL18EFBjj
X-Gm-Gg: AfdE7cl0anBy7/ToJgk78kXKl448Nu0lkOqMeCHHcv37DfAOKpqU3saATOEMTpQ5LAl
	PqNe/T2i0Pw2Wd4g4b7mZHaVAxgpyLkbqU/aUd0gsxC5U/yOa0+nfZPNH4VArWjJQ3iujs1i+Ds
	75UL7tw1KWkW8vop18PSHR4F66WNeGk5yBRE6/IKjDO0r3ienf5wN57Vu9UWB2Js0qf7cVIBLho
	c59yMS00DFOb82L40sjUp4hQzBULRnNby/Hred8gYs/uHsrdEQhKuHpcvYYZPwA3e0ZPbzExdKr
	JqB4riJ6yd2kJbB+cKTUTZdLO05jvL5j/vVAjjeF6i5DhAdqc29Rt59m0AqvuGBP0t2xOBxwvvO
	UyMCAGhFkCdf0yOFZD8wbdHSJFxueHpkNi551TAbibRBdM/QsPPaWKYDB8s5H3xytYbFQyyj7cN
	NqIJnAXw+H1dVMM1W/IH6LXco1yM29LbmgO9A=
X-Received: by 2002:a05:620a:600c:b0:92e:56ea:ec69 with SMTP id af79cd13be357-92e697cbdb7mr69206285a.31.1782803621168;
        Tue, 30 Jun 2026 00:13:41 -0700 (PDT)
Received: from [127.0.0.1] ([40.76.127.71])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e62371ba1sm173643585a.42.2026.06.30.00.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 00:13:40 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <4e50adfde3b80f433e13b86919596be229045edc.1782799876.git.tanggeliang@kylinos.cn>
References:
 <4e50adfde3b80f433e13b86919596be229045edc.1782799876.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-net] mptcp: pm: userspace: fix use-after-free in
 get_local_id
Message-ID: <bcde5007-922c-2f2a-5721-cf691f10e569@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 07:13:40 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_simult_flows =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/284248=
86662

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/0fe82a09beee
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1118662


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
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

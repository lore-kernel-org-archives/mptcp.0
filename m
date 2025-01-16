Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DCA19E7D0
	for <mptcp@lists.linux.dev>; Thu, 16 Jan 2025 08:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737017567; cv=none; b=A/thKskfl1vctCE/YjLR73iGGvopKiZYYz1UTyzzswFZ/mnlobG2aqA9+kSlOJZQg3k5DEe+oJbUSfSOmN1LPSsASS7tTH0xhrZt+eHYj8QRSZZZJgDKf5LRXFhhUCTTw3RSGijJqKXkF7KlHHsZ8U3VSTJdgLty5AZ+HVU09t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737017567; c=relaxed/simple;
	bh=4ClEflJKZ1UemoxiDWzyxW8Gv1mdU8GsKDOD2E1HJfw=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Xnh9g0ffLDoqlCN11RHUGW6flcNa5LCnIiwrnnZqu4tGexBfC6wNOk1EDB+eEUeZMS8TRnfbFWyhSE6pIIraRkd6hqAzagPEOrF10LnZ3UdVz/QCCSriHVH50nuSuCZxshlvK1kSMA+X+tHOPj8v7gL4T/jSB3AiUbFBHIYHwfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Key4RScg; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Key4RScg"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-468f6b3a439so6866511cf.1
        for <mptcp@lists.linux.dev>; Thu, 16 Jan 2025 00:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737017565; x=1737622365; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/VjgG2jDTgyvs0hNGtAGahENlpLlEWfND6fWF8e1vUg=;
        b=Key4RScga8t/0x9dMGcfEpGiILDCqghtwiUomohUDr/nU3QEjpElmbiOQsyjDyMm9K
         WEoWJqujfPoyCHHh/dk5wTk9Bd9LyM9DOGH1qaXfDAKoykLUu7UcNWiEHzuxMe1Jk1hA
         eo+SetWWjVXpwrgzzqf08EXTupVPBw3ztzAIOEOoVhzoiFf52dt02dlJyJe1h+tDA4Ai
         mJ1MSK3BmRWDOpO6nLffGBYo4N13FXXPpH4gXWjVAmKWd5inUFf+CzcH25My1VV9c9Xr
         tDjhnXuV4gSQMrp1GuENUxearEgrqwx8kO3rC6JjwIMPq6Aswny6h2lEQV2EFalpXHc9
         jvWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737017565; x=1737622365;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/VjgG2jDTgyvs0hNGtAGahENlpLlEWfND6fWF8e1vUg=;
        b=MdlNVcNU5l6oSv79v6R2eO8eAmZ/5twbA3jyGxjtTJkAvBlf5fqdgco+5PevikB0eH
         fA0q6hzBdvEIhtLU/eRXo49cTi2ZVyTZg67gWZ7SC+IPBAyijMQ31njBzeG47vYbet9A
         QDp6ll04fiWSHOQYo0VCuP4DmKjiDpceFCFKu2eKLsoO9K6VI+r635iTbTffSVyNXZvM
         JbXHEl+Th7rIuXZkxSA0RmVjlSU2mHB1bk7gACh0hooEtr9sPYsIzV5mw1znlP+wT/r5
         zAH9qHOWAffrZGQaHyOyWyEZb7BZvUX2sg0PBv5/tk3ySw9woyq0JwsnJdp5wuBcVHTV
         EY6w==
X-Gm-Message-State: AOJu0Yxcc3qjHU4ssxU+z6wZcTg7a4Fjd6mlQhutrXkCsgvGfEEQ9PMO
	91O4eP/iRSIBrJ3MVDs+A4wnUphwAY5x2z12x5zJ/EXPDbw24t/5m9cl
X-Gm-Gg: ASbGncvQT3S5gDob1jypjy5JvopXw6xH688mm6PNV7FhzoXkfXcaqVtxzamP95EKDew
	/sImjox68TaoSN8LwoGyn2OqiB/AZbi6yiIoLx66KX8uPizdZK/nLPmz/6CoqxY8igtCMKSTWmr
	a6ytrucdOjihhmIwJ5MX1exceCsj7m+paQRPkad19IvMjMHZyiEJpWhrZ8iCeGBDXFzM4X/DYvF
	JeSwgLQyJtpxlr9KuJeYMobT0n2FtprNLCCTTM0qjn2ORFGg4cxMJWAfeSi7JPIZVk/
X-Google-Smtp-Source: AGHT+IFh0Ug0r5Yky7GLXlEhDSO8nW00b9goa5oHVcoqBIqKz+wi3D19lm795njZYDpe4S/QQ97hWw==
X-Received: by 2002:a05:622a:4d46:b0:46c:72a4:35a5 with SMTP id d75a77b69052e-46c72a43730mr532310781cf.28.1737017565060;
        Thu, 16 Jan 2025 00:52:45 -0800 (PST)
Received: from [127.0.0.1] ([20.42.50.231])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dfad880a1csm74278486d6.28.2025.01.16.00.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 00:52:44 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1737012662.git.tanggeliang@kylinos.cn>
References: <cover.1737012662.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v3 0/3] BPF path manager, part 4
Message-ID: <d74a7615-2efc-0b01-4dc7-f1e3cbae07c6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jan 2025 08:52:44 +0000
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
Unstable: 1 failed test(s): selftest_mptcp_join - Critical: 1 Call Trace(s)=
 =E2=9D=8C
- KVM Validation: btf-normal (only bpftest_all): Success! =
=E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/12804456330

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/50059925b7f3
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D925962


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

Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8A51362
	for <mptcp@lists.linux.dev>; Mon, 21 Apr 2025 13:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745241952; cv=none; b=OYfwWJSytJi92pQcz06iD6tKpkD/W4cfEq28Fvn6Ts2YinfWNA67oESqLHrRLA6NmMq6eFZxn0Gmo4RKClcWS3gxxInyu39ibiTkoCT06sQMvH8y25rNpyIAWGoYmQRtTwxosBoR45kC48Z5mBduCAPGFyi9IW8G26sXHSfDYzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745241952; c=relaxed/simple;
	bh=YJpR2HFHXTOHdYOBh49RdbIVLTKKrsJCmxWRJueK2QM=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=uBQLFe9EXhv+ndYIIj/AJ/qSE/o16lmTX2PCkfHUbXpOvvaGI0U7gp79k8OplUS+vfqlkVKByhFSWwfpeV77kCC03GFGccTMDL2/mjTIs3zjVn3Iy++JL73cC4hkbZSATxydLQvNfqnhorv8TcMF+Hlf3iCXLs483t0YKAqeR9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMUIeGsg; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMUIeGsg"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-47691d82bfbso78948451cf.0
        for <mptcp@lists.linux.dev>; Mon, 21 Apr 2025 06:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745241950; x=1745846750; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjHiQCYRYr6zgRORkizAuCyCoa22Tk3zbwgLU4+Vi9c=;
        b=ZMUIeGsgHJUvztBq0SxzmCHO+blT87NoK5VdgezXzzs3q7lYGrcizaI1nZg/dUWIkt
         Yei278eu9VF6gXv13U1alhRgpF08gS1jcVP+RI52F8jf2VgoKMdR806OYNtQzC1JLZqK
         MGqV0qZ11af8PT9qKWn43Hg/cHmR2NsChGGIRA+m3jRfwxHr5HIAPacFGWllBoHHATaw
         a/cZ0Q/0XKM2i4IMAWYKg67XsQtONJEY33dk/NnN6hzBq2i0e1fEzOK0C3EDPxrynkLZ
         g5C5JVLAm6JFuKknSZ5ZUDKAY7T62Bm6AsoJicdiTqpcS+zyI60nGl7DOBX2EHD0kZOg
         lsnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745241950; x=1745846750;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NjHiQCYRYr6zgRORkizAuCyCoa22Tk3zbwgLU4+Vi9c=;
        b=IBYdAWKyRPlkU599u6kOo49hEidM+XvCJ17Z4Zy9kZWVyMgEDzqH4s/1yQzbXKI8Ge
         sJzIe0eD2EcpKUumqOTNCMoQEEN6gzer6I1iUjSYCpPBlNCQMDyzODRrBoVVN6Z9e7Z+
         X7x8k6v64Isv7cOqkjTOb2PfblLT/qoFR9oV/m9x//am+dGPm2T95yXXCB5a9l7SHCTM
         IDbdcb1QnR7Ky268dNr1sRrFN8IML6KT0WOvdNjNAVsf0XY04/9aAKcV5B9/GTTae3w3
         eBMuWm9lfNdRi7s2TqMsRAqQ130gl1+kJNEICUAuigkcDuawsR7hPHxQEjY3zTTL8BYK
         wk6Q==
X-Gm-Message-State: AOJu0Yz7Kr97li4FT63o5zjW1x2uxR97rHl7H9O5maJIHVP7p5g+qRAL
	noNvFYMXkQBrBIfhAgGiiU+ZISf3iUWbgGbWxgBL5uoO+4FXd+6lqj8B
X-Gm-Gg: ASbGnctTFUPhtJVm/cypW4GwTno//biH5WEUPBRE0wWvnw/wv1M+PVs9NSJRQd0Qgwa
	7PVdnijqYsX2FTBjC7fy55lUxdRo4XE/K0+gM885kOD+BLqornBa8bG8tkXJUtfP0pcnTVjlBmY
	/zK3Zkk77hbLnlsQqo0gFn0ZF/T2U66DPp/4OEEt2vpa5unS0Y8ki5Bigdnaj7cM2RS+6El3drC
	OJ8ToqS7kCo5S3j0Q65gsuAA1oUA6vIlhQPrx25fcZhNZr+szuVq69uvEw0JfUdHrHChjG0soS0
	8CTaDZ97DJO4GlJw+vw+bqcfECeoc1jehstSTzpiNFFxDAm2WTyh
X-Google-Smtp-Source: AGHT+IF92ejx3SrTKPe6niTGAtyYXZt+2CQmh5rwHwHhL/SML+EedcxZ4Ro5QJwtj9Pfs+rkUOISwA==
X-Received: by 2002:a05:622a:15ca:b0:476:97d3:54f with SMTP id d75a77b69052e-47aec394427mr218775441cf.14.1745241949993;
        Mon, 21 Apr 2025 06:25:49 -0700 (PDT)
Received: from [127.0.0.1] ([20.25.192.18])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ae9c3b4b9sm41930561cf.18.2025.04.21.06.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 06:25:49 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <4bdd7056ddd882061c56c0eee3a7121908c0bb89.1745203199.git.tanggeliang@kylinos.cn>
References:
 <4bdd7056ddd882061c56c0eee3a7121908c0bb89.1745203199.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next] selftests: mptcp: sockopt: use
 IPPROTO_MPTCP for getaddrinfo
Message-ID: <ff5eb8cb-3544-8d02-30cd-ebe7e7a5ad15@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Apr 2025 13:25:48 +0000
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
uns/14566295802

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/382d2dbe654e
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D955261


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

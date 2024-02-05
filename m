Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C563B3F8DA
	for <mptcp@lists.linux.dev>; Mon,  5 Feb 2024 17:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707152921; cv=none; b=Xfy4chhEU0jeJsH4MhRugZ00o1wYEq5uRVnC0HooVyFyD2kxVX+e0QucLdeF/adv4UtQadHbu1yYnQYi4BNgSANSJBwJRFfgiwwJp9qGJJO0/lC81WcbGibSMyYLZ49teopCJd9RhbgtxSQRRKl7nDYa2PGBgFVI5hGipHiDVBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707152921; c=relaxed/simple;
	bh=6AZNXqxoqdw0GLPiOfj59VbpQdetJikfD3N/7aIEJoc=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=rwzqDxH+mcxfYLfPB1BwWDR+4BiooXUQqZ1RUkeSCQx+RHK2y+4m4yefhYZ4j4Rzfql5hW9NrArpIwH5ERPkkRsk7KC/tdKxxcv5wPwAL/d1xu46liO26Tnfj4mIm5xUrq3AubLKCatP/dI9MOxaZOokYGCn2POzsuevSxwjkaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cstpAdbw; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cstpAdbw"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-290b37bb7deso3802416a91.0
        for <mptcp@lists.linux.dev>; Mon, 05 Feb 2024 09:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707152919; x=1707757719; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2B0EwE29Y/gVn0u61jYyCj22f2nszmAtj1ZmQOjnVJQ=;
        b=cstpAdbwqYJng51YFjbicHWNlts/77Eaz/Yw6ycOIUkzEkU7kdMm9AGycMKVMCuFqX
         r2fGIOTfeGx1kknFdG0rHT+J9QrJGEsIZlyGHJaDy9W4pN727o/OVVs965OMiXDBuNAp
         NS3o/JhkVOtZPbYAxCN9/HmADvmIlCpWlRYkwDGM9xJATIuOQHILHgYy/bzY/L0nLxpT
         XprdiFfgjnEbL2iqcrR3CyuOCMttllB+nuEC7i7vWdyw6DQFbcthxZBG1vxnlVQoQPdx
         jUqdPBJJe85R3bsTur8V/anBkWkOpLAqFDKY83W09V4XSNpis0f1voLdQVcdn6jx6tBV
         sTqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707152919; x=1707757719;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2B0EwE29Y/gVn0u61jYyCj22f2nszmAtj1ZmQOjnVJQ=;
        b=T2IsyMYkA9sev5Izyh3Yspqft7WS2rUZOkYfCrvXxX5e0boHo0cQC8MFDmQ7QvhxAd
         R7xcrl1R8YxSEn/1JHnPioXMVK+0NmjHvJ+lh+2vTmpwQ+GkTfFhGvGpzQdPy7cMk1nF
         cZs4VHmBkSfEr3M4WWkb1u8Y4IvoAXkmy6q209S+A8lvrV9FxZxQiKmTQACQpHcHCx1p
         FFJYiAMnidm5qasApp7EGYaoXye5cFu4UIx6ac7r/MQ4hPe8rZEp/Tqf2UjKSvqBBwIv
         Jda2YkEm2jjLyv1qOKzpvbIl11FuVyFpWKGE6tVa8I5CyudYxMIyR6H9bm8c3PNLMnOm
         hx3A==
X-Gm-Message-State: AOJu0Yx7Q7zazWGXFqM8PiusgOBzX4yBefthWyul9nPK+Addwvka9kOs
	d/hyAt+CJBDIMs3ObhNOj8tMkaqESNp6Hdl21S1IPSZfkAufhrw=
X-Google-Smtp-Source: AGHT+IHzdKfXXFYtvoTWzVMs1vVQG88/83IarYQg0oCCTt2cy5C6Vdsbfg6VVzddkN4ywaPRtWTX4w==
X-Received: by 2002:a17:90b:120d:b0:296:a746:67f5 with SMTP id gl13-20020a17090b120d00b00296a74667f5mr2436pjb.44.1707152918949;
        Mon, 05 Feb 2024 09:08:38 -0800 (PST)
Received: from [127.0.0.1] ([52.159.142.203])
        by smtp.gmail.com with ESMTPSA id sz14-20020a17090b2d4e00b0029612f113b3sm209536pjb.47.2024.02.05.09.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 09:08:38 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <1392a4ef6a8a45ca3a920f933a12766283a828c6.1707144963.git.pabeni@redhat.com>
References:
 <1392a4ef6a8a45ca3a920f933a12766283a828c6.1707144963.git.pabeni@redhat.com>
Subject: Re: mptcp: fix duplicate subflow creation: Tests Results
Message-ID: <91213a7a-ef17-790e-82a6-f76eb3711ac7@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Feb 2024 17:08:37 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_regressions =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5560160119160832
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5560160119160832/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6686060026003456
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6686060026003456/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/75f455f724d8


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

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

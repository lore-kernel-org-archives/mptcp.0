Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D8A3C5838
	for <mptcp@lists.linux.dev>; Fri, 15 May 2026 03:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778815165; cv=none; b=uvQvsab4r1QCCOZs/7zfzszFxyaDrkaPhUai0EafVSeyP33gckcuQYwtgwf9iJmrXMrlVhD9b5Ihuc6HAdSuewtFf/l9EY4c0e648HAFScTpukkcwCsGjByl9Pe8fuTUEjiDcuKdQSUg3CXWgPmYsXoXM0kR/FEeWEQZXB196ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778815165; c=relaxed/simple;
	bh=JQVvwBxTi75sIXEQirV0KgKYioTeqd7Kfdbmd0HEmk0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=naapajYUsae7EWPW/3V6b+pEsAWjZ61KLJqiPOjjtHhX82PVPT6E56Bkhu1cLnJe1GK/4Tc4ps0BUElh007SHQLa6Y3a7lM/wYWkqlTVaJo4YKMzCiUCb0VbTundr1uN/qPTlwRQIxT2OGsbOwK2DHwg+pbD4SX9HcyuMCN5mR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=naRmFdtk; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="naRmFdtk"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-90d13fa59e8so410817385a.2
        for <mptcp@lists.linux.dev>; Thu, 14 May 2026 20:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778815163; x=1779419963; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLsZuYxbkFvp2M88r80nCvzFzBuxom8Uiew7w0JEeik=;
        b=naRmFdtk4Xx7Qyopf/6ih17jefD+SXPvoYDnPJANu8vNtQfGl8vQ8uyAGjiEVYB630
         SzGhCwiVhmTidWz8T8Juo73Oi1XZz9WNRdSdsol9vCJg/66FDLCikJIuIoxsUTndf7dy
         V0y8sBlPsAY2oZ+Oy7BILUlABWMFHHBOQUtJq9KyG/j3EeLS1ObtOLcd02EQQvbGWRPW
         O261bgurE+8tGeUjhx3RkqZflUdXLOXvxQxnM+prEpnaP5AnZoMSPXq9BUJb2Vc4e7wF
         i2QjkVQdjzLxvCH/Qe4yF36y1WCa4uWlg6kkpS2P1epTBmymuhPuHyrM3tQBOhTI9new
         ljaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778815163; x=1779419963;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iLsZuYxbkFvp2M88r80nCvzFzBuxom8Uiew7w0JEeik=;
        b=TnA0SFcVF3PdZuK4lRmS1Y3LFZ8t3kg8qxQMqvdc32kn8QlnArdMnEpsthcrcfimUD
         wgWlLaXvxvTUQWUC1TgnGPCbggj0i3n92kZ7NyA+CbznE80Kcm9/12y1z9PJWqYc28CN
         6hA54kIUuSU+UOi8WPPszAs1qiZ4+48nbJdls8ELFTS0X9fr97xaRXpO74ox9zvbeaUQ
         dbsc9lu+VHaTREzfcueFr5n+i1xiPR8jXvi1xpbh+eegqT0bMQ72AdMrLZyt9DR5XKYx
         FCwtzmv+vFofNNIU7crpBQtpzleS7h/noOaQ2snA40lSbq47bgvql1Cn3yxKq7NLe1fi
         qW3A==
X-Gm-Message-State: AOJu0Yzlkxfq+sa5DV44bb0zVzPHlSRXQmizmrT4QOGsKeMjBBNaRwGt
	DYRAQlUbhLtAeCU2DUlgIzxkIDAmGTPGLrBLwb98nv24YIc9XYVgulU=
X-Gm-Gg: Acq92OGIc1sKhwVkttAAT1JJu8V0f2G0d+e+U0zMwEc9RiaTgubPEi56R3zdmVeJJRf
	3d4qHu4UukIkXxCOehYrjR5SLhSaJMOnNb9j8bcPWp/8WkU48koOzZMedyUZeumfA0sfnEyaGox
	icgRf0RbB4otfcjwc7zOQTl0fVaR1AHsEtihXFvaKXGWLv7AhILZAUBJI4WZpXvEjmq14c5RObV
	e49JaTjugddVRGY7jYrDEv4fB7MzhlIGHF8dVSflMej2ElwdvG3I+oj/pvgz/cX2pQI6fXOiakn
	qanQAa1+g9GW0y1X9DVrtOmgnAKVJIqnlmmjjaQThC5O60McG8v0rjMmUtqRnOWFzrPW2hkVUmD
	1n07papdHOcC2PSRs+QNlDO7AV7SNXDQwqH/mZK0auXT21tn5Yzi/Nc8iXPx+1JjpDA5t51jQvv
	NfipHsXe5Bsl6W9/aYPl1gDdQ9A5qmi3kufHezQw==
X-Received: by 2002:a05:620a:cfb:b0:911:fc2c:c078 with SMTP id af79cd13be357-911fc2cd1c1mr209290185a.1.1778815162849;
        Thu, 14 May 2026 20:19:22 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.104.48])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910baf22315sm429077585a.21.2026.05.14.20.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 20:19:22 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260515022332.55392-2-matttbe@kernel.org>
References: <20260515022332.55392-2-matttbe@kernel.org>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-net=5D_Squash_to_?=
 =?UTF-8?Q?=22mptcp=3A_update_window=5Fclamp_on_sub?=
 =?UTF-8?Q?flows_when_SO=5FRCVBUF_is_set=22?=
Message-ID: <5cf06e3e-a8b8-c8e5-0548-60d3025d931f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 03:19:22 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_dss =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug =
(only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal=
 (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/25896939915

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/5dbc5bb49f29
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1095092


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

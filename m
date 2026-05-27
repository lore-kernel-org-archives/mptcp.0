Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D812ED872
	for <mptcp@lists.linux.dev>; Wed, 27 May 2026 02:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779847430; cv=none; b=caqCp/XSdimp6tBmGE3On7Aad9ARLbiz5IAw2Ubq4OlHIHwAN7kzwiFseJFGA/C6LkZG1amogjxq1XyEb6dg3f8Y8wuygb/nsxgRhsmJw7G5UuPoERSBUiGkvFvhqLwWyAg+EOKgg9Yhcf6UfjF2nbJPa8r9IBzORo6/1kBuPQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779847430; c=relaxed/simple;
	bh=e2gTfRMBHFsLz6xCiLhg5SEErt/nVHoXgCzkZAakiwg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=Pwt8AsRgaAX1VQQbHiZR/T1hMfxUbeQYYm24/pymckj0uTXfCM5O/kvG8pVoagv+pvYGEbyWuXB5w/bkYixkG9yIptyHyuYaR/Wauibxs6UZR6YI7PQwOOM5b7E2gEa0msiVN/o0e1/SLO0ZewsryrrzqSq9V6wzNxtpdPZMyOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rnAwsoHv; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rnAwsoHv"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3042a388168so3595227eec.1
        for <mptcp@lists.linux.dev>; Tue, 26 May 2026 19:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779847427; x=1780452227; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1qLTXoW01KdNa2WhHp7Y3i86adXdOwSJkezrgtPBjh4=;
        b=rnAwsoHvE9mWahhEr3qzwy2Xqhq/3H7NfH2Jfy/5WeklO54R5xhqLsML1cgBPZI53+
         KgYNOWrPZbGZG7+ONA5SET7cYGWrWn//rQD6yuQY7iBxbWPeLwnPojQt5AARcUK7L0Yl
         HHFx5dHnLwk/fxskcbgAOoNKBAi4FReEhrOWUVJQHAyQpv4i8jK4x2WZ0eRvdDEZTmUq
         p/4Nb9SS0WLuTkWEX0l8IFpGvXB57SUeYmAdK7JkHg5THdCWmxlFpzFD1Sjeo2379Iq8
         U2wVRBMrvf+OVXsXLa7+RtMsW8TscLuQFHszW7tQ6aYlmsaj3waWkYdK1RCQcGYBb5ZC
         hLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779847427; x=1780452227;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1qLTXoW01KdNa2WhHp7Y3i86adXdOwSJkezrgtPBjh4=;
        b=AL0p/vqu7haKgzQgyKoIqEDaHb8KyC28WO8NfL+iR/ZKfFVY5bv8vBkh28Qq4zMsjW
         2c7H2LE96EIoCJhlr8BlbtqtJe0UugnV03UPVy2TJBf9Kv+LIJ66yeOhWKo3SOfpga4w
         xPeQlKOgO/WSBbKKN8HX4TH5Xsv2t9VQ538vyyuasQjAQHfcTKCLAUC8Us1KkgBAz8dh
         fNp8S5pTBAAS32JP0qe8upDaijMQ3GTaOHE5iiOYveIPnxFS5QT3gc88KEC4iJj+Lgg6
         yeXUrEvJVt8gT+f3dmpjiSIxqiKbwZbBBhbrGoUAmDaGiRSkHe5LtAwRQMeyD+nH1pb2
         QI5A==
X-Gm-Message-State: AOJu0YzzPlU7Ky631QiULtxfLUVS/+3fMJbz8Xvy9ZHmmWe7mT5/E+jZ
	3eiCKtYHkmffvX7N07zqlWrUaZyklObMkhqiakyt3ZOE4qLs/njxjMU=
X-Gm-Gg: Acq92OEJJEiiQBOc4xeZ6cPEOnjVtPQGNlULPs6C8hZLHiNjwABiVok1bPxBZbBx2Zk
	KWYqSZRWD8s5n2yKDXF1PrsFGIBaDCKa/OySwXi9wF0ztUdX9O66MnqKDrzHpiZ6jW9hndGWHvi
	fHKAz9FLRPDkCQj7GCozvFssv1XeHU1JPtd1FSaHNzcFVJ/BV2nDP2pEDOm0keeoIarr3BO4Yl8
	6KaIwz4vAlQ1eiobN0ZtBKVZHSU7RR9Ow1HdzPYB4oT8b89uKk4KAMsJTA8gaHPBzo4TfQYiJmJ
	mhd6YjKJi+rw4g8NlBQ3VFAeGB7mrytv4Og+VNGef+pwwquXz8sKwY3ba1fWoy/6FvOxXyMlxer
	Ox9Oci841axXpHlq/zCHSrDCnkvYJLeMuTndELQYvs/Lwwe+5dg60qYLW1rMdCNdscQtVSvTV4u
	rjOp5z++LeWtYHCHlgDj84UBJizQGwUIwzQCmP
X-Received: by 2002:a05:7300:640b:b0:2f0:ee2:f6c6 with SMTP id 5a478bee46e88-30431095a08mr11304817eec.19.1779847427361;
        Tue, 26 May 2026 19:03:47 -0700 (PDT)
Received: from [127.0.0.1] ([104.209.5.147])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30451ef3273sm16109495eec.2.2026.05.26.19.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 19:03:46 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20260527-mptcp-sockopt-timestamping-ret-v1-1-8eda97e24562@kernel.org>
References:
 <20260527-mptcp-sockopt-timestamping-ret-v1-1-8eda97e24562@kernel.org>
Subject: Re: [PATCH mptcp-net] mptcp: sockopt: check timestamping ret value
Message-ID: <361a9091-20af-9894-2cc5-38c6e60747a8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 02:03:45 +0000
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
com/multipath-tcp/mptcp_net-next/actions/runs/26484035820

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/a87ee7f555a6
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1101306


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

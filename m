Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7394F8AD
	for <mptcp@lists.linux.dev>; Tue, 23 Jan 2024 22:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706047551; cv=none; b=W3Pck5+V72PIuwq9pg8xNE11K9NHy+WWUqdKscCvEnWOoLN1K3mmFvKMhOGQai4d/CWBrEmhgUT7oaHqhsqMh8nJ4D1QOvINLfI9bZOmwcUEUDE1iCpR3rR2xhaSpHA1Z21MeHXVQ3+zIlxfdEWxpCVXIs9W2j6sIkLWs8m7Afg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706047551; c=relaxed/simple;
	bh=XhYA08zMJ3NFRbeAOxBNxSkGYfUXIyJjLadK8rhnAMI=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=OLd419TEdZFHNEdyUBRQ5ZO64v13kFmpBv197TzD+T/EzRBBODvGhTqAW9ZzfDUPB+bTmFhbQ8IJ3kEgMfsDDgWAg5j9EcG4T66labgBFa6NwpUrMDts+9X13vQ7lz7Tb7ncyHDIyjYtG85XAQtFj9nkvCbAGg5V/U+ufqm+A5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3z2uBFe; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3z2uBFe"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bd6581bc62so3354796b6e.2
        for <mptcp@lists.linux.dev>; Tue, 23 Jan 2024 14:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706047549; x=1706652349; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KAwe/La4Eto6UvyIaUGqhXMpUykZDjgdcI3BTZyyd2o=;
        b=P3z2uBFeZqSsnv+v+OCgePwQZdAKTkg9VvFYxwwC0c0m2+Qo+cGf9FTZO/ps76vsxW
         weFN/VVCKJ/dcQ3ECzwh5oGrptC1YBjFIGJ1yzs2BaOITjg+HdmIVlRV1/X/mQHznt3n
         aiOdI4RmOYkhxmNRVGAnht1+ZPhFvG8K8Io1ZmPSuFbD4S1rX855UjlBp5Uiy8wD/rMG
         9zKKELbYSQPuUv9K3HRhnBo54zmnTih9U02dt3MWJeYsUCBUH7Ww7zZOZM0ZHiCqoxv7
         GF8jaGHcYiMT4s1u0w0lUaJo5q5ZzRXqEcHS7xdXbstzz0F45FxOE/+R4bJw3KhxuX48
         Er4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706047549; x=1706652349;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KAwe/La4Eto6UvyIaUGqhXMpUykZDjgdcI3BTZyyd2o=;
        b=O+ipw2NXLj+MMiX9AFCftHtzXOXW3gpxN5MOCsCQobgbHbDYlg7vrQBZin2JS42IAm
         IxIRzUQbaRbIU3K/mAPWAyolWdE412tQjI+lG6Ufp0HMx7huYuAE9fOWFB8PBmzo7SvO
         bt2l0go3HhJVhWPIHYbstH25iHD0BeQ5hYH/SHo6VCHL3kcCjN/7Drjn/B20ZsWR6vQ7
         jgP/Il51XnKLItvsCJPW5BiAQoiiFeyycaHD5JLsT+F6+ZUcey0rbcZqRSlFPr1Wagmr
         +0hbVjfI1eyTy/fdnL5og8swmhVNfcCdrcPC2Au3hdiT7/qNj2L6WQNOWwZLVpdNHG0N
         onnw==
X-Gm-Message-State: AOJu0Yw5bvRbT9qkqipB9GyKHwGS3LyRvMEwG27wCUkxZVXRlqv1F5A6
	IGTkFSZ+/N9OWHEbu/8+r9yRjaKpmTKdsC0GdH/Dw9rpI/RP3y8=
X-Google-Smtp-Source: AGHT+IEaonUXL+uAlnYz75fW4CiewftgATKsDcUyV2LaQvdRqhWU4GtZb8ZhxfXJV8hlXhlVr6CcSw==
X-Received: by 2002:a05:6808:1782:b0:3bd:9220:6b04 with SMTP id bg2-20020a056808178200b003bd92206b04mr624970oib.30.1706047549243;
        Tue, 23 Jan 2024 14:05:49 -0800 (PST)
Received: from [127.0.0.1] ([172.183.107.20])
        by smtp.gmail.com with ESMTPSA id de29-20020a05620a371d00b007835c9bf30csm3462758qkb.83.2024.01.23.14.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 14:05:48 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240118-selftests-mptcp-simult-slack-qemu-no-kvm-v1-7-f3a4db41c3be@kernel.org>
References:
 <20240118-selftests-mptcp-simult-slack-qemu-no-kvm-v1-7-f3a4db41c3be@kernel.org>
Subject: Re: selftests: mptcp: join: stop transfer when check is done:
 Tests Results
Message-ID: <73eba60d-f150-9ab4-cd9b-9770bdef2e62@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jan 2024 22:05:48 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7631904533

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/6c26191a31c7


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
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

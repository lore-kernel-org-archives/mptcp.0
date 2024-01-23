Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16AE2B9CE
	for <mptcp@lists.linux.dev>; Tue, 23 Jan 2024 23:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706052236; cv=none; b=EDIvX+hvRwiFr5WgLAmUJ/MsepZ9g5S55StROu06j/WN69zhvc9SbLW80vF91QT61vo1xdOiKM1JFXb+HiETU4Cf1NzHP8wWe2SDum6YBnWadQordwPR3x5ZhkszFp16/WcAU6LkPxFLjKdQ5VKWqnuyVpbLNsfukChyA9RLVYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706052236; c=relaxed/simple;
	bh=5YnnccsXBSg41q63QgWDyMga15amNKfhXmjsmSeyCCE=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=BXoZw0V0YK/EI1NJMaAY8pM9JPB3acuoHl0fBEj0ilC3wLr4pKZdgrSJz9b/uHs60WwBFxwohEpblQprJpwyaOVXDnP3RyPYzQKFsExRxLLQnOhVowQjTR02XooWqLX+r4hTbGh1TT5jJTnXo7KwndD7ZdAocWctaGDqqNf3dWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KY4o8NW3; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KY4o8NW3"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-598699c0f1eso2583077eaf.2
        for <mptcp@lists.linux.dev>; Tue, 23 Jan 2024 15:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706052234; x=1706657034; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C77+obUlLJ4FkI2xGakM4SFsAa/pZgdqJjooKETeRHo=;
        b=KY4o8NW3EpGbmwCyWJCzvw9JXb6+JEwWKrYUb53XsIY+co6m3yzlN+dRvvp2kiz1Nn
         YOToSkiK5hNna5cDWzc5NFRNLgx5iSiidjLN9nEXnol992pUTqoElA8Lvam7+5mzqU4A
         /E9hWHWe8KDb8NhzWaGAXqrmfMmyHRGQldXUixCfsXYyaCTXU+NnHWHK+mfgn3j7Wwve
         Jl52806jeWDYLaN58FYfCSCDl0kpR10gqhaYexUbjX8zxFYkBhsUKAksW0BEu3Hd3MJl
         tJ/3PmrexqPieiD7JMKLhGrV100ePwZpjTD4N611Hd3J+Mun24Hl4+Mp6yBk2ABsR6CT
         Sh6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706052234; x=1706657034;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C77+obUlLJ4FkI2xGakM4SFsAa/pZgdqJjooKETeRHo=;
        b=Enw1qfwvZ+ImtujN5XvKZwqFNtHCBxhd2eLzcZNTzcWs5EdYzC4VBDSz+AJQ9ybW85
         matbBEccuVwQ8uEYE6CWz67SnJis9c3Rkbr+o4Tv+p5z6Nbw6838yuMZv/3x5cz67VU7
         2GS2YQS0VdLAPj9sTAHg7iPjfq5O+Q5HvB6q1s6UmhAMxakt7OKSY8UkHCQ3eJFtACg5
         kCreBjAQt0rsqgTfC3EVoZxGteSO+wvtF2DKnJbLi6zbUg0cblV0Lg+BXI+fq5EYEX5F
         u+FZVoVOEqBcHT+fEZwmNop9axPefBR38M4Oym0zklcAptR3IIYcPCrEtlTNjJ3FjfQh
         aZYQ==
X-Gm-Message-State: AOJu0Yxj+4qf64pdXShJ4kRnCO6BGCDeb8t9JM7A2Px5bb3GahDBynqo
	byCMQhjgKXQqZ0uEtvyv/0c6lDuNIq9nukt3f6YaYrVOtpZyXb8=
X-Google-Smtp-Source: AGHT+IFzdo5JdEe/CGJ9SwCfmZKw17VGaHH7yDZOxwGG22hqrtRHinaXDrP++l+yfk+hvn/5S2kkJw==
X-Received: by 2002:a05:6358:9216:b0:175:6496:5e10 with SMTP id d22-20020a056358921600b0017564965e10mr5280341rwb.40.1706052233727;
        Tue, 23 Jan 2024 15:23:53 -0800 (PST)
Received: from [127.0.0.1] ([74.249.5.97])
        by smtp.gmail.com with ESMTPSA id ly4-20020a0562145c0400b0068688a2964asm2883688qvb.113.2024.01.23.15.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 15:23:53 -0800 (PST)
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
Message-ID: <0433482f-de9d-0765-adc2-8856b4d6b09b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jan 2024 23:23:52 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Critical: 1 Call Trace(s) =E2=9D=8C:
  - Task: https://cirrus-ci.=
com/task/6177496371036160
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6177496371036160/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Critical: 1 Call Trace(s) =E2=9D=8C:
  - Task: https://cirrus-ci.=
com/task/5895199780503552
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5895199780503552/summary/summary.txt

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

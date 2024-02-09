Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE8A567A
	for <mptcp@lists.linux.dev>; Fri,  9 Feb 2024 20:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707511611; cv=none; b=ITUHGI8OPwwdXWFl3APwaNc7bUYD2UjIos7cQqS3/OZHJVCbkYejYOlBXAUQZNpQZ1q63UJ+ReCCPX9OI2LOjdjgND3CRLmal2X3K7PVyf6yw3I91P/pLwh+8b5R9WB1n0BfvP/TozJVTlGpDiG7fFeir1VjYOPcFDPKQn6yfls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707511611; c=relaxed/simple;
	bh=snMmBqUyOZYl6PpWdSdLbSfCK0Y4cDj+iMw+FOnQQq4=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=INWv4OrGZFdjXtIeyp8xEtYg/XrRbI79JoPcUsdVEi9PoNgNdL19F23MeXStnnUoErCJ+nwj7IURJPP+zGxnhKlLmhN6dWqBktkMlxaEPy5NbBPY4WZz3Hkn1J48VhmhjAdJwkdclEPlY2izUjMO6Vb3kGoTfsrQZkEO3cbwGXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9X3AkLZ; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9X3AkLZ"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e125818649so630547a34.1
        for <mptcp@lists.linux.dev>; Fri, 09 Feb 2024 12:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707511609; x=1708116409; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1EqcEas3K08OoZjlHVXIfgPamn8rkUrWTdVlMiO0vXc=;
        b=B9X3AkLZYj7BPlJOtsWP6/t8Vp4pvWxPviwJM55OqpjIlb2fXhG4D0484NPs29I7qX
         yOvM1dvSWzZYSvinQnysZ6XtSrbnjVOb2+6Utw+L7ECs46/G76Cvc58vNdFQPWrnxIgI
         GC73xuJVO/2MhRWLbszOv+N4GlDJiE8LZTPX21QGk4yH6wxSW+eexAW4Cv37FmFsr5WV
         j876w11YLleluGaXsSrwMjO/GIuJfwwQkvpg9uCR0L1B7+1ner007sMSs3IlgqAxsJN/
         3VaaJu9lI9edabncLQGl9h2gwx+SV8zyyh93jMVYxwcayBT91/+5DmzHQo1hzvjCYx8H
         wl6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707511609; x=1708116409;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1EqcEas3K08OoZjlHVXIfgPamn8rkUrWTdVlMiO0vXc=;
        b=Jro99wD+u0A8qBxG6rI5/WiCghy/Uh8dXyHkk3znsnwnMi3O39+zz76B9037ot0YpD
         nTw4oXyeIKKTioh2tfctUwC2XNjnwT9t+7R3zo/PyGHzQBP5FKjgAIu4bfQtfI0bPPFO
         eGJwl375aQkWc5+Ja0ECULSRtk5HJjuNBSyjTNaJRSA4pIYIFt08zayA2cwLzyr3zhsX
         fzRBWfPKGeQpOrU69V6z95CCJs4EMEwG/Gv0ya+Nr8CWCTIBgvHCUNDRe+dtNuvFTLoM
         MPMDuNCZnk/NzvarNoSLoO9jPd2qhEmiHAgw3m1t7eFLYk2DHOeCp1nPvOCUP2D05Cv9
         EqMg==
X-Gm-Message-State: AOJu0YySaLOeToeq4wMWq6QeIwZ6w9tnuWfrFKL/q/RavfX+Kh5U0cox
	KhLmMWkq2kH2J/35nq1vy6JvTVOtCq2iVQqb8Yujp8UEDfNH0YU=
X-Google-Smtp-Source: AGHT+IH0S+uUVlFzWNbTJbpkbcP6Iw54ypioQ6ei+5llBV1J5ypMrjh1r94+kFZhC02YR9d5OQf4Bg==
X-Received: by 2002:a05:6358:d392:b0:176:a5f5:d266 with SMTP id mp18-20020a056358d39200b00176a5f5d266mr685328rwb.6.1707511609190;
        Fri, 09 Feb 2024 12:46:49 -0800 (PST)
Received: from [127.0.0.1] ([20.49.55.74])
        by smtp.gmail.com with ESMTPSA id i12-20020ac85c0c000000b0042bf5ec20f0sm980434qti.30.2024.02.09.12.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 12:46:48 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240209-selftests-mptcp-uniq-title-v1-5-e4fb3a3b5f66@kernel.org>
References:
 <20240209-selftests-mptcp-uniq-title-v1-5-e4fb3a3b5f66@kernel.org>
Subject: Re: selftests: mptcp: lib: catch duplicated subtest entries: Tests
 Results
Message-ID: <7482c9a9-40e4-ba11-6c2e-868341ed9ac7@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Feb 2024 20:46:48 +0000
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
  - Unstable: 1 failed test(s): packetdrill_regressions =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6628165980782592
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6628165980782592/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6733421603454976
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6733421603454976/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/27b6d52de8b3


If there are some issues, you can reproduce them using the same environment=
 as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

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

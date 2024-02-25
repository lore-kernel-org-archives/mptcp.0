Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B2B12E47
	for <mptcp@lists.linux.dev>; Sun, 25 Feb 2024 13:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708869115; cv=none; b=eM/G2TksvTARKxLCuzgoviCUetxbyCGwqISp/eqjhPnb7MwLjRClWUAHwwkIanxnQuMIiVv8wOAIqcICM4AoTA46XA6B3kcTEec8J/g9HJqyjV2Q7Skae6okLs/qP2Ml/FTMbPD6RZ17DNUY+2o4AmOc7W3gVg/kG/cGMekwiD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708869115; c=relaxed/simple;
	bh=SlIsLlgEgsZGst41Bcz1u94gICsQb5vLM/Qm2l81euE=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=FnfNE/1XV7zH7s1GWyNLL03dHjL5mTinwUaRVNyTE+Dd6DvlT5DQik79gZo4kDOKMwJhH3AXI3dWmBoe1BtH/++c9wzwebbC01SEAfwrHNMoR9uzjYcc40pn9cBq4EhKM3LebGAewcGG73dIDEMMvnOhn/vWpVu01QlZxX9hmOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8CdbaVJ; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8CdbaVJ"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-787d021f08bso25684785a.3
        for <mptcp@lists.linux.dev>; Sun, 25 Feb 2024 05:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708869113; x=1709473913; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=08yZWSOEONSTvwbkXZTCzgMlckv94p6WcMEEB25HkNE=;
        b=l8CdbaVJ6TugQBT/olZbgfWIAPOu2WImFWBtWNYyVY3wTRvKYGJjY1TfMlCLH5dnM6
         VkMBKcr6MJd+n2skH6i7luIRMROb17PpgSSPpxhk8+OqprGted0B17DtCoSJhs03uWU1
         rqFv4tsX/U6gxGFPL340SV4lGK/8iB/8StZVttNdf/W5DcOUlyZmFPWlY7JCYm1q1/Xg
         0hYZ2hiK27PXpsoTwRe3LYkzHLJ4CsIbzPc32bklHcsDE/jt9tUcRUvnW5FoWv7Q/WC9
         e/xxN5ZKB4/iBZhN/er6e8KhOr/pdpZbaAwSrTh4AuTfxolH8uEO/3J9OH/Dp28LqLA4
         ZLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708869113; x=1709473913;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=08yZWSOEONSTvwbkXZTCzgMlckv94p6WcMEEB25HkNE=;
        b=XSz/tUBSB+ESdiy/kJh4kEvl6xeCtZcmzAL7HQO2FrRs3h5XmOp/fDyCJ27nBGwjMZ
         mnqEwqqja5QLU1EfEMVULtNNj7+BHK3OJNu8F3Rgnbt1cSTWTpwQWXnoSUKsiHCjzjIX
         qOb+LiJB1aYPwFU6tOlkRChtBWZDBF/9moAdnlOzNk2sOlcmsXSmk8zlowT449RlP8yO
         3v3yzu8/IS62qJqPh1QeDCIe/r/RPBxGoSsCNVF92IIDjF3k1tz0KVhQX9zqDcoVwbfQ
         bfqQ6WPYqGAq2SOAer1ybEnJLb9nUTBoROMt2KLxdE3elbWYPvBC7iRixxp+bmEdFMUr
         icPw==
X-Gm-Message-State: AOJu0YxWJlMuNRlBod9pwY0ypZ5PCofJD+pgxq5LQUZdnvjaGeqbsQYI
	BR17EYZ3JL8eUFzYJ1A5m6LDI8hceQXC2OQ5Fnd/6U0LUVg/WTRHjbfykog=
X-Google-Smtp-Source: AGHT+IGPpA7Eliia+QhHJDBHZvYWqV21KS1IZ9ULOBk9mMJ2BTZzdlqtscatGkqyqSEjaclQpsB1AA==
X-Received: by 2002:a05:620a:56d3:b0:787:97a1:2056 with SMTP id wh19-20020a05620a56d300b0078797a12056mr5079825qkn.77.1708869112976;
        Sun, 25 Feb 2024 05:51:52 -0800 (PST)
Received: from [127.0.0.1] ([20.81.159.24])
        by smtp.gmail.com with ESMTPSA id vr7-20020a05620a55a700b00787b573f75fsm1505933qkn.108.2024.02.25.05.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 05:51:52 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <53f87e57c38fe571ca2d41bdf7a225357a6d05ad.1708866087.git.tanggeliang@kylinos.cn>
References:
 <53f87e57c38fe571ca2d41bdf7a225357a6d05ad.1708866087.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: use KSFT_SKIP/KSFT_PASS/KSFT_FAIL: Tests
 Results
Message-ID: <d9003fe1-9240-7ff9-817d-87781339a7de@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Feb 2024 13:51:52 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/8038266849

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/5790292bc277


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

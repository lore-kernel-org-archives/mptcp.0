Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728C71E499
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 11:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708082864; cv=none; b=dc1dSMQ/1+vNzEMhJmlUJWp3bDGpN7OLsMgtJsIT5kq03SNPqS+gD1jHhBuUHSJfJaeEpdoUkCyBYunI6FAyILdlEjqh1KL4cydi9LsCmgtmJgPNASTpwxhqcFnWxTV7e8EFc6DBcxhrMa9ENUOmG80PMwvni95pBN9n7HTpSxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708082864; c=relaxed/simple;
	bh=8BiQjfGfMk4Nlh9JlBATyo+XCF6EbSgqhi4stj5Oruc=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=KOdus5pKQE1/T36Ry27XlXK7vS+yXMSGUP88QqwukIrCEke4Jx1PptR6XLWsFn+a7t76OhLpQmTj7n79wMdIrhBfKwZOqisHoYb7IoLPGNC2hMsr5DLSwZbca5E0F+1ztO6NCVxZMLUSmTtNu1xnaHd9AqVWMVHoT8rWeKT1hRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Akv85KTU; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Akv85KTU"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6818a9fe380so11360076d6.2
        for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 03:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708082862; x=1708687662; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68vFI6GPJ16X7nyfTZ48zQw6XABfjnZMs/NS3FwVi8o=;
        b=Akv85KTUeWHgUVurqG3W6vof1q2U40ly4yrkOaHXeobu5BY0HWyhJgzkBRwP46kGgS
         2Dco3M/BlBFbsOvNsVjgDwe6Tv68bYt0SmEGCEYgfS316ouRxpNG3osqkTq0sXlWqmQt
         p9L45rQ1c8yv03vW1gT88aUhKiKgsdb5IiaUR3usVZkk8yTTXzeC/WDcAetk7/GHDRCy
         4BILbp7jdo+QYSkt8OpthA6OQXyPtdtcDw8k6sN7ELvt5DuLUehrMtCIyAFXtJSOvCxZ
         8UXaFCpx/eQAweUBvpV6G0/S0em5eTlWmgsN9SQOEzNZy8fnCSPySKKwR4rM0/NV42iM
         Y8Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708082862; x=1708687662;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=68vFI6GPJ16X7nyfTZ48zQw6XABfjnZMs/NS3FwVi8o=;
        b=P3rn5XXOB9XgC4ngxcwYmVfprEQgXFXBep3URMNuoKyqg/airAhYpVvIqjKe1oQ0ON
         09g1M20+w2ksfF36PMTJxf9Ggu2jZT/ACYCCOkmtwWrCJFY9IArUE6tvkgTnsAI/MZdY
         OX/EVfMKoFGMlQMTx49zZi5tuLh62uDj3niOkW9w04wfNeq6zK+xeNCRtx4baifcliyD
         gzhZE6Z82UApDcXjJyLJjMNG9ngQGOkhdNFB2e1ncQAcGW4YfT17weAz4b1sqo1ng0Pp
         Kckg6wSLwGRTFhrB5PzLvCQJOaZeBglLU27/9XygEOorP48TXR1xZ3GgZFlPN8G2qUms
         XTfA==
X-Gm-Message-State: AOJu0YzV4Oi5CjnAk8mPk1p7VAZQqwmE+7JIfamQpyk+Q3mBXUiVQRMJ
	1XEDLGLQJ2hIfUbNeD/spzo4kYWBfZaWDEqRQCW5DNxS7ut1d7zUA85Fdso=
X-Google-Smtp-Source: AGHT+IGBzS8uiheUF8G/21HjVMmaq8gG/aZmHL/7Af68hZDT8feZ1tPm8OeuDOAm7giqo/6EuDiWlA==
X-Received: by 2002:a05:6214:c4b:b0:68f:305b:8214 with SMTP id r11-20020a0562140c4b00b0068f305b8214mr2274502qvj.5.1708082862340;
        Fri, 16 Feb 2024 03:27:42 -0800 (PST)
Received: from [127.0.0.1] ([20.55.223.233])
        by smtp.gmail.com with ESMTPSA id or6-20020a056214468600b0068f24e38716sm1269063qvb.141.2024.02.16.03.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 03:27:41 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <f7ca03a3e2d9b8c8a49e9226d88b40c935875e14.1708076886.git.tanggeliang@kylinos.cn>
References:
 <f7ca03a3e2d9b8c8a49e9226d88b40c935875e14.1708076886.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: add mptcp_lib_check_tools helper: Tests
 Results
Message-ID: <d7389ee1-ec43-e049-62f8-a90adc48f78d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Feb 2024 11:27:41 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5488696795856896
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5488696795856896/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6614596702699520
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6614596702699520/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/c454c04a88cd


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

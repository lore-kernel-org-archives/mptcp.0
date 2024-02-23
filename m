Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672305D73D
	for <mptcp@lists.linux.dev>; Fri, 23 Feb 2024 14:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708698419; cv=none; b=sox+fvcr9Y5EVSDbkAtveGnRCyiSAL+gbpq33Nr/kk7Pr4G83f9cDybmDbkW2FNfPIqxkSFa9c9mGH/KQ2W9AdA5Rg5DnwNJpn64q7K6OKox2iOH7STzvp6vm00nMcuqK3pVEql3GyXEt/Op9P+GpeYiXjyyNWxzwB77Wk1PG4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708698419; c=relaxed/simple;
	bh=bNSe0jE8jr7q0N/axeFFx+sU1HonYR1gMdLiSm3tJ7Q=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Uj5p6xKMKcAwW+K5dkPWjIK6rfWUuuCtU9v5MxcHWfp3Wd2/a1QXi2N3TMSSWREZr+6Y0FFNQd2rWIWL4SmVKtY8vLud/IBj/n3z3wMPrizgjlPjx0AN3OuoXzlwZ9V4Y+KlXMviHEovVNMVjXUf8riLnkjr4DZ0Ie1QZTsWL7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPBRUsaH; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPBRUsaH"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-787a43e2e2dso51621685a.0
        for <mptcp@lists.linux.dev>; Fri, 23 Feb 2024 06:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708698417; x=1709303217; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krGhO6rWb8lo5iLBYBOZ7c4oIRR2tDvqdrqxYZ3bKrk=;
        b=gPBRUsaH0ubNA2cR4GHgdMFblJ/4TjHe0HG4Wae/XWO1fDi02/tRBIVfkyx0X9jUGP
         G75EKVgZdbIvrfbZqplu8DF+UsKOu5Fjdgw3qjgwSn9j0IDlF2Ab8j1gBQBmRf+6tNAq
         uI50lA4OVko87/7sRszVPCJ5SAoVFq39FZYCIkkEdT8HKuHmLxtYTVkafENn5MPyXgN5
         igqnVhPCg8uMPj3tVQnoDF5QpnvCD5sj0HkF9basDb/p4L2LzYmRMk2XSIU2NUQlnGMg
         45hetvPz68m7LV9TJ7bQQUfHEUckqyyeQzHvCw4GysePjwls9LKdZ+ztJZ9pKoDj4oaz
         gx0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708698417; x=1709303217;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=krGhO6rWb8lo5iLBYBOZ7c4oIRR2tDvqdrqxYZ3bKrk=;
        b=NCqJnLu8nkTU44YGZ/rMy1lzz47x6RHw7ZtwCZsqZmyAC/J1rsgISj/brbHqVTg9Z1
         1U5GoWKIR08ESTtc0aHDqRToZrlX9DHBZKARiF/loeENE0l4ElZrokbFbbceYCESAvHI
         llBM+DYei5RQbZiEMxggVYPAWKCtkyVCcdqq9NkC/+HCQU3RCwEl+GlaDGn6Ifit26+R
         rt3IT+1048A3yYzCA8lb6Q/1xf7XgQ2F8pTslsAsTQoxp/vwmXIAKvshLfMPQNVxLHk2
         uRvqcAX5QN4dhxhM71g/1udRHmvLPfT6j2n7/eN8OFUTWBr7D+g0w7toE8KNigtVMvw4
         lv/g==
X-Gm-Message-State: AOJu0Yx6iSZwdK1GrPtPxBcBfd5RwTY8CKiSVP/aJqiMwcLUs8QZ1TSc
	XcwkfANXAwfoWTi5E2OVCJcNRHevsFaYRcROT7dk01s7GImPqsf+nSZ3t04=
X-Google-Smtp-Source: AGHT+IHvUGJwxYr6alMZTcvdPD0SO1NIBmAFP7AGRBrxhCNVI2YRf47Q3o9yZbgoq7jPMXx5t1bu7g==
X-Received: by 2002:ae9:e50d:0:b0:787:4161:9344 with SMTP id w13-20020ae9e50d000000b0078741619344mr2081083qkf.5.1708698417085;
        Fri, 23 Feb 2024 06:26:57 -0800 (PST)
Received: from [127.0.0.1] ([20.102.199.96])
        by smtp.gmail.com with ESMTPSA id c33-20020a05620a26a100b00787b021007bsm831482qkp.69.2024.02.23.06.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 06:26:56 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <5253780363327733ee3ef1b57f56b4c6d8453ea7.1708657487.git.tanggeliang@kylinos.cn>
References:
 <5253780363327733ee3ef1b57f56b4c6d8453ea7.1708657487.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: add mptcp_lib_verify_listener_events: Tests
 Results
Message-ID: <15e533c6-ebe2-bc00-7812-5e1c7a2582ea@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Feb 2024 14:26:56 +0000
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
com/multipath-tcp/mptcp_net-next/actions/runs/8020155821

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/925e893d99ec


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

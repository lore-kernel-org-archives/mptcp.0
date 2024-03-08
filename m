Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFF9441F
	for <mptcp@lists.linux.dev>; Fri,  8 Mar 2024 07:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709881281; cv=none; b=tAsBZUV8l9rJUZGlyJCv5KlLofJ2egRvTfhJPkELKKSR8q2cXctnyXu3t3epjLjda0Vcl8dhqwqq4dxtij8P+Xk1H/yavJUFhARZUxLP2VMuOLveS3EV+jAXsOkA6lcrlz5TlryXofEh1lQwZauHyF1UD2HeWiuT8ID24hLsbLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709881281; c=relaxed/simple;
	bh=RlF1TcavhmMsfUWnfYwngOkIcq3rXSsr1oTpvoJ+jMQ=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=BA8rVy6bllPLpy1gSKu+juO4FL9rE8robWC2CvZ/J5ov0sveKICmYyzIAcbVfBPaIfRdRiqw8QYzpRUAC5HCtmCGN3ce5uqwhXkTOcw9SoUR28auAy9R9FR8w1G60Q4Ds971OuUbaMb97Lh7rlxqXZrna0NUE90yP3A8DnY8nZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Er3j0C2O; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Er3j0C2O"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c1ea5b42e7so247320b6e.2
        for <mptcp@lists.linux.dev>; Thu, 07 Mar 2024 23:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709881279; x=1710486079; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUHw2tLa1yIeU24tkYm6ls1BS4Ym/cFyKU7/8qsuhdQ=;
        b=Er3j0C2ODLbU22tksZ2R6Q3MeINAJ7cOX+Iw5TNmYeEhWTvc1NE+Yk/jwB2tCt28u2
         oclAgIJpFpPjASEBbYmNjCF7bd7eMnkEMeTpCOoPPdKmTNAtal4BivBnbK6N98WWeYQU
         qLPI11AJf3UqBEddGx5Cpy4jg15z7mwJSRXw27S2vVfykklz3ozR6jhNGzSHmiLEGYVH
         bfPXVcWnY3KEn+j8NvBxM29hguuFllf/50bxYPz8jMZ6uE6vO5RIi+aVYANuj31NuDRY
         boNu+KkZjyPyVYG+iVVdF5m28J5vtwhFsdwXewMHyM3LbVuYx927DY11XEUSljc1wa1n
         nMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709881279; x=1710486079;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lUHw2tLa1yIeU24tkYm6ls1BS4Ym/cFyKU7/8qsuhdQ=;
        b=bXRJcnkR9C70kscjtlNKtsRF3S5bnNf4YetGhj6InQh2eRu3h3APU4puiOfpLLjIxZ
         k81F7KL8ybXygtle3j7MjVsTxOZQxBWMTCwpy+7e7Baavw+waWFpn1dnsK+ckcAfvfK4
         FcqgkapuDqWF9Gsb3/b3PZiYdv6ZemYQn7KUgKeVR6Kf/f0hBuXdkl090bUSUjLYNlQ1
         N4rOQ8gLtaq0Cj8gn6tpgu3345lXvw+MZzHJdfX13RjRjQkE17FOyEEGqpWroyLIrJcA
         8fsKgraz7m+r0keqzu/hf3WHNZ7weeXCH0pAtkRlqUf2zK01UBXhFAnpJnNYycbMpSQG
         Ar4Q==
X-Gm-Message-State: AOJu0Yx3RtgBlYdSOYCODEe+TrTHZ3G57JYl8bHEfxszpirAXD1f+EEJ
	3IM2E+WgtNN2T14oqEGt1nUrNHsvTMuSZMUCrLVd9fULJSEfKWDCP1Mz06o=
X-Google-Smtp-Source: AGHT+IH3KM5uFTEpo34KLiTsCj+tnWSl8ABxubwEJ3k5pAhWHzRSgoV1NMA4aaw6/xgZH02/3lGTTg==
X-Received: by 2002:a05:6808:290a:b0:3c2:1659:5957 with SMTP id ev10-20020a056808290a00b003c216595957mr9188514oib.13.1709881278959;
        Thu, 07 Mar 2024 23:01:18 -0800 (PST)
Received: from [127.0.0.1] ([52.177.79.105])
        by smtp.gmail.com with ESMTPSA id r21-20020ac84255000000b0042ef9768d15sm4120574qtm.13.2024.03.07.23.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 23:01:18 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <1cbccb38bedfa1f606d0fd71ca992bc569f4cea5.1709876991.git.tanggeliang@kylinos.cn>
References:
 <1cbccb38bedfa1f606d0fd71ca992bc569f4cea5.1709876991.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: join: use += operator to append strings:
 Tests Results
Message-ID: <b0d48030-9a17-5cbe-98fe-bf710a5da09a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 Mar 2024 07:01:18 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: btf (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/8199507878

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/8829c80abe7d


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

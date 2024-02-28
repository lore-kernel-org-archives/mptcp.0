Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A077E38390
	for <mptcp@lists.linux.dev>; Wed, 28 Feb 2024 08:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709109212; cv=none; b=VMvRcOH3M6fYS/R0XwwIGW9ZlrfWexA0ZO2tlGIAipEajwQrBTyV0/X5evdXf44HC6gaoYC7tm0Fsb2snMQbt3mG0ra4w606Dc5Y8u6U50syMOqWgwg1jz4g7A0x+YfE/koV7RmrYGDrVuDHAaIvUK+7WyWvrbZ5EsUCOD4VR90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709109212; c=relaxed/simple;
	bh=b/fmC2ubx6dcb/NTMnbsPdtMOio8B20kPI9LdjvsR3g=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=iXdDtUlmngJTUFE6okheapWdWUgrS3NRZlR2c+o8BsP6g6fxHQ2Obuu8ZlQ3i2QU5RmeM4pGbKDqCzoWkmiNiI5E73xHy3w5/YlibCEh/uX2fzy2C4/LpfPYa0CDJTi/7iRGR/Fh4HrujBmBgRVxyMbm6mqbSNGpAuxXHBNKvQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=juPRW1zH; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juPRW1zH"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-42e8a8e9279so13268081cf.3
        for <mptcp@lists.linux.dev>; Wed, 28 Feb 2024 00:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709109209; x=1709714009; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JadfegLLJh+f3oH4jmEQXbZru0EZqcopaG0kt963ECE=;
        b=juPRW1zH5zZrk1p5+1svRp/niX/rgEOEotj+4bNJRZ73Fn3+txrIa/eaNhz9qv5MAC
         ys3xmAdr+VItKAGJM1No4AlHkn5FOhkJv8aww5ax/eo01bylE4t9yJT15pOjze7iEhuB
         e5xX6FwGc/cJuaFtJC2eZkMB9JkaJ2cM6Jr5aJo5ahkg7u+8wUguAy4VfFUICtcXw4zr
         0jrCZcAdDUwysEUy8sINHinmyaPYoORQml67jqhgK47uzHGGPhhkK+ybRPHuaoxSm6pL
         Nu4fwbhevQXP1HYsrePvw+5ExgGh6urcHuiUx+G6uLc8oUi5LXzdnoEXem4ppJ1feJUu
         ageg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709109209; x=1709714009;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JadfegLLJh+f3oH4jmEQXbZru0EZqcopaG0kt963ECE=;
        b=WItxUb6Abi2nuu3MLGiZqOKBPwEp+mmWxJXYygFr1QecRQQS4Iz0+s/6ACGwXPHC89
         nNJKzkne101YwOJ2z9tcvGt8xBSd5Hr2A4YZ4RhvITIttVC05I3nvNtt2fuYwIOnKAq4
         /pfqBLwlw36bMhTH55nm0N5XIPPkqZTyhxGvv0bsFLivyvllJw7EHU/gdqK6gjRY04sb
         258btIcN12pyxc7A3St1HhhIyOMkdHoSX8+CMagCPtRYttMbkojlTS/9H4P0IsikgbRS
         OzqjZxV2b/PfWWG9a8sN1U3U9lQvXIZDTnXC5dwqYLsdaK8jQUEpaqyZ6dD6Y01+1rYE
         m/8A==
X-Gm-Message-State: AOJu0YxgYWZgoWnQGVqNUiai6MMN+c7mpAVxfsQuY9IxgGRia+LTQlDg
	V1cMyjXMZg65G9MHYH3lCfXgrpvL46JXjjgb4pXWU2mjIXe+o5COVZnfhKA=
X-Google-Smtp-Source: AGHT+IH6T0ssCsOfK+VniGY7vESR+wtg65ryF8VAHnMaF3Y++y2sw+VjZ/ob3pLRjkPhPUSk7MCMyQ==
X-Received: by 2002:a05:622a:1c5:b0:42e:7ebb:eb62 with SMTP id t5-20020a05622a01c500b0042e7ebbeb62mr11574399qtw.48.1709109209252;
        Wed, 28 Feb 2024 00:33:29 -0800 (PST)
Received: from [127.0.0.1] ([172.183.122.243])
        by smtp.gmail.com with ESMTPSA id wm11-20020a05620a580b00b00785ccbb457esm4379576qkn.81.2024.02.28.00.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 00:33:28 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <111be8b3feb6b8410abe43468fe00d28a131c36b.1709105922.git.tanggeliang@kylinos.cn>
References:
 <111be8b3feb6b8410abe43468fe00d28a131c36b.1709105922.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: print test results with counters: Tests
 Results
Message-ID: <c023461d-1bf1-e36c-56c4-8e071738612d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Feb 2024 08:33:28 +0000
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
com/multipath-tcp/mptcp_net-next/actions/runs/8077035670

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/dc2846e6337a


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

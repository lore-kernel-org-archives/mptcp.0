Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579BCA920
	for <mptcp@lists.linux.dev>; Sat,  2 Aug 2025 10:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754131923; cv=none; b=k8cKfgvIkU37G55RNGV7j8TBOZRgiiUNTOdLAFfJs6euHn3lCPFSXi1qUaxBb3/10v7cqzu3DjcWsDwL+KKNPus51fgyxcfh627alRuONBaMdhmZepVZzRK9pTdVtJ8CNUpC7bMWIv94QhhWvOCDRVTrf6mTDzqRH73U4IsSYxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754131923; c=relaxed/simple;
	bh=yAQFFgQ5XmhQwfh8Mz3q7/2tJ4HbCJIuTSnpCxbMbqo=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=V0l0a1DjL9d6XI1GTqn4nWCwle2HWh+o3/lJsVpMqrcvnKpwN+prR3i+luVnJ2ARKbEt8mUQfyoCPSQ75PZ7J7VUTZNAhK6bm3iCluFEkZYzBuECj7V5MxxJx5aHxFA51f4zK4t12QfgPgHoK4hbFqrB1rD5NaX/a3X0R1FD5xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clZxAF6W; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clZxAF6W"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-87c017978e6so103981439f.1
        for <mptcp@lists.linux.dev>; Sat, 02 Aug 2025 03:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754131921; x=1754736721; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRTsawlW7ULK7AzJyMtWaZDnjINoTxAGiUhLWWO7WDI=;
        b=clZxAF6WapzRZcNN0aNvDpuQtvwQDw9jfQGxAwQqeOpMUgrinZNWgl1b3ViVWqGvih
         VlgaXI92WxhODPaDoywtrTm506gPa6dyPrCmp2cuuCA0tsstGI07DM2LiaB+JGPgq5Ih
         Mp5u1rAUsWFPUS0rStBBmHhhyxUXy4zeYLmisvKbzlB0JL/g7Du8zvCcMLQ2T1sYXpBH
         lpteakjicrZGkFJHtYwg2wuCvdgmYQuwCEvH6SL7iXzVpSIPrXlwMyc1shZqmLor6HsG
         h7r1vdfZjIwKSoo8aQXyEz7i4AifNfIPVn8fsjwOru5Q97+JkTZhyhuQTlILlzP9fcfa
         ixrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754131921; x=1754736721;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BRTsawlW7ULK7AzJyMtWaZDnjINoTxAGiUhLWWO7WDI=;
        b=bWEh+t6HbDgzqRVlaPogAKW5pXsv6LrHhteiFX8g+PvSQzLyxJd7DyaDkEGuIhTa7z
         Zf0bwtaSQpmdTdmtYCSyOP3AdOqW1OxGF5ULUqDYvNF3Wj/JPSZqDG1mP7C+5U8TC7Fi
         c8Z+Jq/2RDyQQyrFoBwKiOFjb+aoCPDvoM4ea0QJeAQBqvRPaqx5dA5614qmusFg/H7I
         HBv8jBw0XPH7AxcEFkymOkMrQRaztmK9UYxZUz8JuSehh6pebHMbhqPydEJFYchvByYg
         WQRACfHzMJSQGLYRErOrswlPUadZ4Q2tpRMBYHzlaspEhFgHkJq1L6+z5hh8rbgPQFZ6
         7PoQ==
X-Gm-Message-State: AOJu0Yw38E9SG8e3iNkthH4uv5gZ4xNfzLki9fUth6NvCi01yRhuB6VJ
	qIDolo9z/NgFGI1UVOBkiMo8UAuQTXvKr1X5iXLUeRpLPY1gtN1HPUFdxujWyws=
X-Gm-Gg: ASbGncvS48IOwLuraa5JCYJRf6m6MWwBfhtvuBNlTJPDu2mgR1+4eT8KVyyQy8zThv6
	xcpl+XEPQMVVGo8Mim+lQJlokHrQuN+vl2/eqyzw8b2BWIfOsXPbDEMYsnOALI/UcWfFVXODItt
	cwnNAGAnSgk5jfIE98t+HvQMJzPg1MV2KpOD3mDj6uYxuoJKMVwk0aG94NBvF8P6LumNj6byKdV
	owGv/ynwsCJ79USir1cWTnZQLlUvzrI0caKv0ORcf1isYUcQi2r57Jswnf+iwWD9mco64ZhsSr/
	clZJZhnIO5gmJm3SfHGzr+CSgNI/YzKBf42LDSH/gZGecoFno7XOTHErageEbJ8GWXu8Yqwohos
	w6CgKhjBhf1lUtTDZ8wXaMc+uialtVLEEjhs=
X-Google-Smtp-Source: AGHT+IFsldrJl8sPbfgshswKCngqjdiDGv2GJRgkaDxT0q4P0fP1T/prIUTpUVnPq8VgnItGicz57w==
X-Received: by 2002:a05:6602:1614:b0:881:4b5e:fa9d with SMTP id ca18e2360f4ac-88167e039bfmr490972039f.0.1754131921377;
        Sat, 02 Aug 2025 03:52:01 -0700 (PDT)
Received: from [127.0.0.1] ([52.176.139.81])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8816b8c6c1esm28350139f.4.2025.08.02.03.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 03:52:00 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <40706ad511220729207ccd7cf48e320e4d0d7dea.1754028199.git.tanggeliang@kylinos.cn>
References:
 <40706ad511220729207ccd7cf48e320e4d0d7dea.1754028199.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v2] mptcp: adapt ADD_ADDR timeout to maximum
 subflow RTO
Message-ID: <bed65315-5242-b1de-f0f0-04c7c558ba9e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 02 Aug 2025 10:51:59 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): selftest_mptcp_join =
=F0=9F=94=B4
- KVM Validation: debug: Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4
- KVM Validation: btf-normal (only =
bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/16692214960

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/7df5036763d7
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D987572


If there are some issues, you can reproduce them using the same =
environment as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

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

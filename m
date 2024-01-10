Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995124B5AC
	for <mptcp@lists.linux.dev>; Wed, 10 Jan 2024 14:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSSrsiHs"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-781048954d9so342370585a.1
        for <mptcp@lists.linux.dev>; Wed, 10 Jan 2024 06:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704896623; x=1705501423; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nkGtLt8d8RKAgoKlatt3BTfSiDpeSGnHsqt/+Jugig4=;
        b=nSSrsiHs/9P3pNVLITg1iNs31+oO8ibdM52A3CUEvopO2NAxz0yCTtwgSx+Qmq4ozC
         RZlqYziB+zebP3i59+dnNXaroqqiK70JqWMPKXRJQwLXC1rfeQcXWV0ZQvLpyDPo9fe8
         FflYk7hRYlaXIJ3xUJ0K54GgCxAcI6pPX0MrTjj9sDu0j3nBqS4+wSHtOtDUSobf7vOQ
         kEHW6fET1okLK0BOAVZW04FA+dqrYBq6DhgQK2epMq89m8DqFbRM0UMAKQKpg/Q6wDc8
         0aPHiCJ4bBlje3yqlqPFUL440MXRl94eP9S/zJQFSzXUw2vQTSZ4iTozZ8jCr5LBCUq3
         kIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704896623; x=1705501423;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nkGtLt8d8RKAgoKlatt3BTfSiDpeSGnHsqt/+Jugig4=;
        b=dZya5FVKn53N8sAEh1rlpmYArtcSS+BF+4C1bc8LTgJ561BpNwRuFzRALzWPHIHOFR
         Qnpbb+iUEgjTiLlG++0ykz4ZOsU3gV6gauAB00zclx1DZVdMn5/QjWurYSHjOrRDSlNT
         5Ry78105uTwXaaa6LQWKD1KVofMeY+bf9N4R5T+1M9oVeD73XDPMvu1ncdfdNN54Q2KE
         Xf+i9ftU1EzvMMwinunO0+B5WNrEIkO6qHz0fZ5vn1C3QzedZzk9tAfn72A74fa+uX8T
         s9SZb9bO6HKIm72TgBVuLf4lH/l0sdrRrtnhuCuT3lNq+3YlIURjfAPqLU+ov5i/mgoS
         ++mA==
X-Gm-Message-State: AOJu0YxlVTHkq7B5QMsYqvTp62jMDKCmfpm7A8axRVzUnm6bJkKeO0dI
	J4rNy905ukAFYRrvZJKE3Q==
X-Google-Smtp-Source: AGHT+IGCMe3O9m9JhPPzjDn/SokWbyBUSeF8j7uglJaa3xurzkm0/wD8/ejf5uSLXc7X0YZQ2kgrxg==
X-Received: by 2002:a05:620a:24d1:b0:783:3af7:17c7 with SMTP id m17-20020a05620a24d100b007833af717c7mr405467qkn.141.1704896623369;
        Wed, 10 Jan 2024 06:23:43 -0800 (PST)
Received: from [127.0.0.1] ([172.183.84.70])
        by smtp.gmail.com with ESMTPSA id b23-20020a05620a127700b007815b84dbb3sm1621524qkl.49.2024.01.10.06.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 06:23:42 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@linux.dev>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <45d5b581a58e29f4afebf09c685623be3108524a.1704892316.git.geliang.tang@linux.dev>
References:
 <45d5b581a58e29f4afebf09c685623be3108524a.1704892316.git.geliang.tang@linux.dev>
Subject: Re: selftests: mptcp: flush userspace addrs list: Tests Results
Message-ID: <6d8ccade-168b-b5e8-3a32-78375ab1344b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jan 2024 14:23:42 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang Tang,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- :
  - :
  - Task: https://github.com/multipath-tcp/mptcp_net-next/actions/run=
s/7475677105

Initiator:=20
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/3e911cc5cc90


If there are some issues, you can reproduce them using the same environment=
 as
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

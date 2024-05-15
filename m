Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6568433AF
	for <mptcp@lists.linux.dev>; Wed, 15 May 2024 07:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715756943; cv=none; b=BBqsyUhedl+75JW8NQGKDsH2gSwctofd9QaAw6k8lQtFuYS/K4CgOf6IMTB//1qy/5m02sOsUUpYpIJgBgy1Uu6mSnbZfCCcnhNzhr6YhbC9xw6TkcONjE5tjo6t74PgLRw8t4q5HNHBjT06n/gzf88SGzzU+bvPqLPapScf+eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715756943; c=relaxed/simple;
	bh=/rws+G6/ku7Izm8OqgMIp1zwGLp5FdHGCGoCsi0lTXk=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=tBD3ItPVNiQqGuxO+Mf7Fl+FHbxHlhnMu5ktepoSP7uCF4BTuyG1r25pqTX83qlmua2ISUdK7svS6rEx83PxJWPMrYMApQVXA21/CA9Ahr2eev+o6H8C3W+H0jpCOD89IBa3PEb6d/IzKgp1U9oMO6Ay/1tgZhSWCjoPyEWHgSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=elL7/ROr; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elL7/ROr"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-792b8ebc4eeso495554485a.1
        for <mptcp@lists.linux.dev>; Wed, 15 May 2024 00:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715756941; x=1716361741; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2ZFaRWPOGkEK3e6jDe+elfzzhvdd+BOQMY/UQVfgcE=;
        b=elL7/ROruYW7hxDnS6KYShWz99SWWRXzp2TfsdzdgACT3S5mxZhBDF1RFCwh8v4DQ7
         4Y2bztwXrRFXpSpJ3oqNL9Ptzt0gwxEU4kIu+kpY7+m6+ob1m6TZlaFLshg/4dk80PVe
         HTCvvmVlhOnvYFqmCCZI7wE2Np+CjUqG9zDHxXNp4EtaomvwEBpVDmQ3p6UhDQwbqgBd
         rW3PAue6+fsteAaIVpzEvlq9fKsSERivQfgWcyvdbfFjQg0yC65SWNjwwJKccKoX7GZ+
         G4W4Oxt0eeqMVlFhFCGPhLQ+O3Fy1k5clVpgGJE6mBrIcsQsrlIheGgrudjuZHwM0lHn
         3SWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715756941; x=1716361741;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E2ZFaRWPOGkEK3e6jDe+elfzzhvdd+BOQMY/UQVfgcE=;
        b=mq2t0psnq76Hcxy3oIj9xiXwzL8927iaHlEhYbYt1Gb18WQgV/eqjv9kBJhWjl1DNO
         LXI/9ukYtgaZL2frkdizmJALrdUOH0hIf/oTLU2oJCFbRAfJDdlGqT/ognus6qspvU93
         WCwhDd8SdC+VgAKRMc3VlGD1mXsWhkvml/9Up8h9KxGERpyk+bF4wiX6Urts9NyHVqzn
         sXb1WTgOce/60AVszwcgHc59+WqBTmT3R3AAQFf6yYG7psxVizu2/3VQL8MOgb5W4D3C
         ZmplnXunjnYWAOPc8noU0H+x9gGOSYTaJR+5GeE9561sCBt/IcoaHY9FJrimpqNTzmpk
         SQFw==
X-Gm-Message-State: AOJu0Yzx0IFkQsyOTaLWWaFu4OqnfSKt/zzqsVFB7xi2oMPIDzEqW6aa
	sfEC+jaD3GQekhf5XQ4RuBdFkOj3FmDuMH2gb3kUvpNwkf82KGlpc2lx
X-Google-Smtp-Source: AGHT+IHpKJoqVI2dIdB48jhkDt3FISHr2uG8yjrXEdVLFoKZUZc7asSwWYn9/sqNTqR7ay4vyHop+g==
X-Received: by 2002:a05:6214:2f88:b0:6a0:d2b0:7e2 with SMTP id 6a1803df08f44-6a16824507fmr206337566d6.49.1715756940505;
        Wed, 15 May 2024 00:09:00 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.14.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f194bf9sm61406896d6.58.2024.05.15.00.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 00:09:00 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1715753802.git.tanggeliang@kylinos.cn>
References: <cover.1715753802.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v5 0/2] patches for new MPTCP subflow
 subtest
Message-ID: <8b54db0b-53a4-71b8-2af4-6165802e82f9@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 May 2024 07:08:59 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Unstable: 2 =
failed test(s): bpftest_test_progs-cpuv4_mptcp bpftest_test_progs-no_alu32_=
mptcp =F0=9F=94=B4
- Task: https://github.com/multipath-tcp/mptcp_net-next/=
actions/runs/9091069267

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/95ddedab45=
20
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D853294


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
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

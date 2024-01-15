Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8565B18C03
	for <mptcp@lists.linux.dev>; Mon, 15 Jan 2024 19:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmAAZDk/"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7831b3a48e7so552472385a.3
        for <mptcp@lists.linux.dev>; Mon, 15 Jan 2024 11:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705347858; x=1705952658; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICUOqZUUSz3tcvAk8LzV55U7zlPpMVCFu2W7QgCYtkM=;
        b=OmAAZDk/vztZqGX90Voc9/FAx372QaHB8/HqL8VjwLey645tJ9XebvP1fUNMRaEUws
         JrGL5OJ4rPT7k9fCuLEIAuj9HR3Afzcn/HOPVWN2jhPpF/jy6OJTReT4cEMC6lsO4xLk
         oBLQqg+KGfHSQ0xCKA0pgfWRHAcOKRy3pFTk8vOvUXACTaTLxXfUOsmRF3kkOst7S4f0
         THz3zqbHpFpa5O+LYtU+pcxmGMinbysmhZzoA6vq54g9wYw8osAiZnwiqDlxRuh8hsgT
         G65XzrBgZdYS5siUC1+eQYOK4017Kt6i/pe5t5qpdTZ8mCvt8Rmhnc5gQG5guRDXirV1
         hQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705347858; x=1705952658;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ICUOqZUUSz3tcvAk8LzV55U7zlPpMVCFu2W7QgCYtkM=;
        b=c/ojgidG1nK/bC4QlNzSL/GLf40dMi6rOLg9o+zZO/woFGEdC0OC9Sahi+eJqNS6kP
         M+mQQ6hK/zfXecwJZYoueVFJ8shrl5dFt+uTi7H8AvEzZ8PU3wVv5ICfi+DFOa4XJlv6
         s/0BPQxQOrU7MtUWhU/5vpuN2T7HVhdF+G2N1J1JdYlqp5uzpshW5UpIe2i7RTualXmy
         1tEIdAahME/d1V5myhk826xHc5AX55ccP9ifiotHrUvXIzr6i1f9WHjXPhsaKXkHWKTk
         cW7nJ8WbByXQck4DIOLb0cbcckQ4DOqjG0rPmjCd5DHETrFEKqYd1UYG1Nru5fF6m6oP
         Gr3A==
X-Gm-Message-State: AOJu0Yxs1X32ZYCVu9MB0X1cjdYeKzCYw0mc4Yv9GHoJGUT6C8lrGvf0
	JdJwDsTwu66AdIjwVvyppjYTtoMJwA==
X-Google-Smtp-Source: AGHT+IGJSvwz7ODTFhdEw5FVttEExcT/Lk10yM/TvZspzal8oxVgs7op/fjqF2GMkFjXCGHCl2s4Tw==
X-Received: by 2002:a05:620a:40c8:b0:781:e4cd:3946 with SMTP id g8-20020a05620a40c800b00781e4cd3946mr5836527qko.114.1705347858386;
        Mon, 15 Jan 2024 11:44:18 -0800 (PST)
Received: from [127.0.0.1] ([74.249.6.31])
        by smtp.gmail.com with ESMTPSA id pe15-20020a05620a850f00b007830709340csm3149535qkn.2.2024.01.15.11.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 11:44:18 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <d97d56012abb6e277c4ffc5042ff2f414dbe7959.1705343249.git.pabeni@redhat.com>
References:
 <d97d56012abb6e277c4ffc5042ff2f414dbe7959.1705343249.git.pabeni@redhat.com>
Subject: Re: mptcp: relax check on MPC passive fallback: Tests Results
Message-ID: <61cbf9da-a70d-1405-ce52-1ea2d8d2f521@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jan 2024 19:44:17 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_sockopts =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5240716398428160
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5240716398428160/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6366616305270784
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6366616305270784/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/cff2320d6411


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

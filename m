Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AAF10A3A
	for <mptcp@lists.linux.dev>; Tue, 16 Jan 2024 05:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="es2dcCsQ"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-78333ad3a17so779599085a.3
        for <mptcp@lists.linux.dev>; Mon, 15 Jan 2024 21:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705381208; x=1705986008; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTTxVWewDCNCoqUsrgq82YhafCWjOQM4IrY85BI4g8M=;
        b=es2dcCsQgALoQXMWMCNhQadaPNfubAWUdYGVY73wHATXCW5IgogY6BrHs5+tn81Yef
         9p0YtgeEy3HgA54srQKE/r+Fwpzw55F5MM6+cm2G3lCoC/dhgpeG/y5YkdBDG7/n4HSh
         S+VhEpDs/2JD/Fsd5An/vtes9HV6czIUdm9wCQ5dUfU1VaXslQalgseyIqCEezW2b0uG
         ltdTk/AntOV4z025wk43UG9mC6Bltyz8OpObMzpUt7HPibKkzmixY0M6Ezme5xk0gd1E
         QhHzghwiYr7FGOhjNieovtdC0u/pwuZ2zy+WAbYXKLC8mmBCdF45oDeDxGFQE4Z7Htxo
         JBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705381208; x=1705986008;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qTTxVWewDCNCoqUsrgq82YhafCWjOQM4IrY85BI4g8M=;
        b=GYnvS0YRoGPBhjaLbRsyTVYwu7Ksa3i90ytDyh/XXDJUDyyuj7rPxfK/BTUQj9w3pE
         HB4JOxSF470KmMlSwi2sU3iCQQM/05CqQDJ/4WsSFZnD8o7nS8QKyW/13lSZ+0bKD/fi
         wTJdp5mWK28ZwlNbP7mEfgp2OmqdIzCLqJ7wNqI6/uzZR+YpAtSG1iAO+U9v1YdTpTw1
         BSomxju9TgT/VngbKacRLaqo/JsfCzX8gpe4A4gfMIp2N+TfE7aXwzxMbpspwDDrFYJ7
         7stg4mQiaF4fGK3/dtfyyiM5eYoxiBoyhCm8wGp8g7DUyEKEavh021gPcVNzxjDrsTsB
         Pz3g==
X-Gm-Message-State: AOJu0Yx6Xth+mmjg4xthfnNIAMgnw8mq+WbxXiFbUCsjFSCeE3tjpRra
	W+eXhH9q3SiWn4Q6Qoe1ylS+Qe6oYQ==
X-Google-Smtp-Source: AGHT+IGIZcQzrPulWEA02BYQMAhCmAdNt0QNjdPLUK3R5Icll2o4LM+RDOiWW8b7MskmWBMdLkdbgA==
X-Received: by 2002:a05:620a:4ad1:b0:783:3a51:a0e7 with SMTP id sq17-20020a05620a4ad100b007833a51a0e7mr7094784qkn.116.1705381208597;
        Mon, 15 Jan 2024 21:00:08 -0800 (PST)
Received: from [127.0.0.1] ([20.109.39.24])
        by smtp.gmail.com with ESMTPSA id de28-20020a05620a371c00b00783395ce1d5sm3381181qkb.136.2024.01.15.21.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 21:00:08 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <7bf6b2a10a756ce5fdc739663cf9eb2e3ae72d87.1705375746.git.tanggeliang@kylinos.cn>
References:
 <7bf6b2a10a756ce5fdc739663cf9eb2e3ae72d87.1705375746.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: flush userspace addrs list: Tests Results
Message-ID: <e4a4e729-2993-81a4-9261-2719738236fd@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jan 2024 05:00:07 +0000
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
  - Unstable: 1 failed test(s): packetdrill_fastopen =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5105488841408512
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5105488841408512/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6231388748251136
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6231388748251136/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/7a37e241bedb


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

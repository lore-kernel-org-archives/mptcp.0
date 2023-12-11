Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FC746BBC
	for <mptcp@lists.linux.dev>; Mon, 11 Dec 2023 13:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJKuCW1R"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d0c4d84bf6so24921385ad.1
        for <mptcp@lists.linux.dev>; Mon, 11 Dec 2023 05:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702301921; x=1702906721; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZMDeXYAEqlHG5T2KgMAWPQOKaOtxzgUtLmKprimQzqE=;
        b=aJKuCW1Rwo5rTWQvs2aRFNs51ChBJQ0EnOqrvznSMcqgPAq3vdpFpkuIWzuJIVT1ZH
         M+OID5dlbL0aiuvWH0aJ14nrO1l74zy/9vgf0YEw1v6I7F3XxKCx6kZrSIfwcc6uy57d
         /NatsI/z4YLc+CUXwCZfAzLftomlh0LSCiOiedKEschZcBmjQfLR6d6YHvuBsr4ICKiD
         +b9UQfivbYtHXTTktbX3Cn6xZRU+gl8HmeZs9kpHTtEluB6PDjBkfmejxqq+ND6G3RjO
         r55dR70b1UUnGQ0sNkkCL75tvliR+jlk5TuEmASdeoSG9/1MdnldCJZSmKlEqHEw27Fs
         E+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702301921; x=1702906721;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZMDeXYAEqlHG5T2KgMAWPQOKaOtxzgUtLmKprimQzqE=;
        b=Y8kBfYfj2kRlJKdCCQXHG3HSzcPpbzGuw9b7oupuivhLj7qo7PmayP3bgR8Dd27lef
         jVhtKQuZ5h7NlmlKSNr06aBSfPLa7CqCt3mR3OqS0b0OUIAJhSYXslNynZ3SUX04NoVQ
         83/pLIsoSKZLeR7fVT/g7g1mJu9lP7/GpMXWaf53ecTAMxnW5YiwpYP/B3ED8KoW+g/8
         rngdQMm+/zYL4DcTj4qsrtkb/hocWg0eALBKWRFF/5jF3pd+XVPm0B6oeCjYCcu4nXl6
         XPA1cdWLIgl3VOHmFA8QAHFxrZ5HJVS8RT0/CUQ9xtRoMrdwq6rblpT1suNcqJUalQHt
         6pGQ==
X-Gm-Message-State: AOJu0YwzIT9UbwSxGWJBGARLUwYjQSMx/2/2t58VRWOgKkYCnzZftEzT
	D/svuOJ/IKTfgcrjeUcPZQ==
X-Google-Smtp-Source: AGHT+IHd5GTNPpE6Ej3bWxDxomJA4wMoVnjYPvJBv0fvDB/HGUh2ySMzxsFlFCrx7CECs+Y/oCJAyQ==
X-Received: by 2002:a17:903:245:b0:1d0:94ed:f84f with SMTP id j5-20020a170903024500b001d094edf84fmr2231099plh.26.1702301920914;
        Mon, 11 Dec 2023 05:38:40 -0800 (PST)
Received: from [127.0.0.1] ([13.91.68.210])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902ee4d00b001cfc2d024edsm6628649plo.29.2023.12.11.05.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 05:38:40 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Maxim Galaganov <max@internet.ru>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20231211120309.20752-4-max@internet.ru>
References: <20231211120309.20752-4-max@internet.ru>
Subject: Re: selftests/net: add MPTCP coverage for IP_LOCAL_PORT_RANGE:
 Tests Results
Message-ID: <18a7a797-9b92-ff46-a232-b0af49ffc986@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 Dec 2023 13:38:39 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Maxim,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_fastclose =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5814574327267328
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5814574327267328/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_fastclose =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6377524280688640
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6377524280688640/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5251624373846016
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5251624373846016/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4970149397135360
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4970149397135360/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/36ace3f14b75


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

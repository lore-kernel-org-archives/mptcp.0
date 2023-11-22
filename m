Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688764AF63
	for <mptcp@lists.linux.dev>; Wed, 22 Nov 2023 18:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHcEg4RA"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-77d6f853ba0so12680785a.0
        for <mptcp@lists.linux.dev>; Wed, 22 Nov 2023 10:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700679191; x=1701283991; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fCe63ILXZYrZVLIbPWwF6nlx9tgjMfP4bQXtcHlkXFI=;
        b=dHcEg4RAdc0NT38S5RrVDHKfEzzYSfB/JO9BCYGeavytytnk8Pnc7R3k0mW8WdN1nP
         aWsaRtmRbgVXCQhoZ0a3Dn2F+tQgCOwaHMs6x5GkBFf5odPmYCoJ0DwXyLHG1hLfi2Md
         qPU4Rw+HkKGrw76aUW5um2UOAf8xMfpBo7Ehc369AEUn/vO9IBGTH2+69YPvxrDoPhzc
         i8YHT/LhrEECeml/DDDoUTlDnT3rOYYxXz+gDCerffpwjAUZitn3yHeArCN28gjYJu83
         41Ngq5AVx1fV/NuBVEo+Px7Mzg1UI2IMxg5R/wcoC4fcsal+pYwoa/BAj12dgmK06PMS
         ANAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700679191; x=1701283991;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fCe63ILXZYrZVLIbPWwF6nlx9tgjMfP4bQXtcHlkXFI=;
        b=R6CK9fs8+toB37h+9QsxsvU9dEY5e3rsrgRFGXTsqAAQQry2s1t73L7re4NzIztUMe
         l7TlKGieQb8WEWl2X2ngt/MylstifMaotQ5yxbFFe6bgpDcg25B4ZBZNjCX7bT2LR1sx
         BKCVtXbt9ngHpip5Mk8LMiZWawRdrXUcirriwU/W8rqM0oKYEQCQKwgFzb5z5wDlj26X
         sAN3Vk+AHeisrs0P2BW4f5I609QCSEokVZyXRXZMHjB2ti9gUei2fCjUpQWT3eRuXHDS
         Nx/T9LoVzsdfcqftk90JUxjyyqV7AS+bYl/0rEWN3MBdef6a4yPTED4ktpZHDjfmzK2l
         r74Q==
X-Gm-Message-State: AOJu0YwNbdRE4aCKNwB6cZFptKgCH5am/Ix/NoxgzDB6BvR72PaxPSpR
	Bn+0BeXqPPyjeUKY2nF9oA==
X-Google-Smtp-Source: AGHT+IEesKW2m5b7MOX3NfcYkWRWZRKesOdZW1Oz9Xteec5Mmotui+xFSbO+A/dJK1/2bIy65t/PDQ==
X-Received: by 2002:a05:6214:5006:b0:677:f200:b740 with SMTP id jo6-20020a056214500600b00677f200b740mr664355qvb.20.1700679191237;
        Wed, 22 Nov 2023 10:53:11 -0800 (PST)
Received: from [127.0.0.1] ([20.97.191.254])
        by smtp.gmail.com with ESMTPSA id w6-20020a0c8e46000000b00677a12f11bcsm11524qvb.24.2023.11.22.10.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 10:53:10 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Maxim Galaganov <max@internet.ru>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20231122155919.11393-3-max@internet.ru>
References: <20231122155919.11393-3-max@internet.ru>
Subject: Re: selftests/net: add MPTCP coverage for IP_LOCAL_PORT_RANGE:
 Tests Results
Message-ID: <e03093ad-83cc-a6cc-0a63-c00f94122e92@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Nov 2023 18:53:10 +0000
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
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6564641308934144
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6564641308934144/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4735053960314880
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4735053960314880/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/4851600313810944
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4851600313810944/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_sockopts =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5860953867157504
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5860953867157504/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/c5a4695af2fd


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
Bot operated by Matthieu Baerts =
(Tessares)

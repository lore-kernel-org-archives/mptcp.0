Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AFB7FF
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 01:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7sy7Bz1"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-778a20df8c3so165706685a.3
        for <mptcp@lists.linux.dev>; Fri, 03 Nov 2023 18:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699062204; x=1699667004; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88qJ3qc0KfzFpIyY/mhVg65tiLFaUk2Yt7zJZan6ePg=;
        b=C7sy7Bz1KcijEq+eb8TXnH0Sy/4vKz9HEmkeZXDR4ofY3sTGyX/LdTouZgIAu9Di+B
         mN/iNv+AMVqtcKSmfjRMsbLiUmP14geC0AhUh6zkW+ueHuOkYrD/LpeZ3UmMsJKMKt+6
         hsha1TDXQMoI0COX/l7v617PRMWncd/FBGXJOYk5KJpiDANIh9jstSxtZSJtkcxbXs9g
         pmbzBVdNW914a+m2qNnGSGanrtA4V+PBH3rReW6u8nVSgE3+5Qof1QNjraj39MEqO9Vj
         UGO3V/BVfg8f4G5q3fO94bcVsHt48LPFIc6orlg9BhSDELBZqka1lTquQcSdejA4s//1
         9tKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699062204; x=1699667004;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=88qJ3qc0KfzFpIyY/mhVg65tiLFaUk2Yt7zJZan6ePg=;
        b=cpMM/JDkuHcvOl1XXp9s9tEBqd8bI6VzV4l3SJK6IXdVO3UKcnNBuAGT2zetXsvTsw
         H8LxH1cx+Fo7tXy0O1WdI0p3GA0B4ZxR9msHvxPMu57tZPG3Ab3eqSmWT3g3xti8WKFK
         ac37j+WIOh+pFtTqcrI7SuhnZOEYaXlWZA4jNqNUWGXk3zKJ8QPrC0qWsFKtFgwLoZAO
         aOHC4UaMnPa9m0quynL3TytxJpsFmn0xmKw+ZWU2VSeTkwMqVnQj1+4/zY9ag7FtZDGa
         YnKtvWgEovxdbXjt5kczSQqCuq8BynzYsyFBhAxZOXYulRR6UJ/ZYfxzGAh7I0rCb4ya
         RVSw==
X-Gm-Message-State: AOJu0YzCQd4xSIdULm9RkpK42k0NpCXzCUOVYK6SVhDSHaafztiVM4Em
	xhbRzgpfqf331qkPpSPa4A==
X-Google-Smtp-Source: AGHT+IHqvDgBHfbuDhk4NQ7HxK8nIYj4ZqyLP34vhKySQBHfcaB+OwpO0wCNqrOE0nhQU1ynP1UE/A==
X-Received: by 2002:a05:620a:4609:b0:775:903e:388c with SMTP id br9-20020a05620a460900b00775903e388cmr28304922qkb.2.1699062204306;
        Fri, 03 Nov 2023 18:43:24 -0700 (PDT)
Received: from [127.0.0.1] ([74.249.14.209])
        by smtp.gmail.com with ESMTPSA id o18-20020a05620a2a1200b007743360b3fasm1222152qkp.34.2023.11.03.18.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 18:43:23 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <7492afacaedb042947485e17c1797558634ba60e.1699057244.git.geliang.tang@suse.com>
References:
 <7492afacaedb042947485e17c1797558634ba60e.1699057244.git.geliang.tang@suse.com>
Subject: Re: mptcp: drop lookup_by_id parameter in lookup_addr: Tests
 Results
Message-ID: <65216f52-33ea-51fa-9cf1-94e073d22e1d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Nov 2023 01:43:23 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6206636239355904
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6206636239355904/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4799261355802624
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4799261355802624/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5925161262645248
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5925161262645248/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join - Critical: 3 Call =
Trace(s) =E2=9D=8C:
  - Task: https://cirrus-ci.com/task/5362211309223936
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5362211309223936/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b9ad5e080071


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

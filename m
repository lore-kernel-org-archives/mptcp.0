Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F293158C
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 18:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXke64az"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6d2efe8c43eso1853a34.0
        for <mptcp@lists.linux.dev>; Tue, 07 Nov 2023 10:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699383540; x=1699988340; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tp5Zeqkg1UHwHqtQiJ570931dQjUAPNMnq5Oh8r4uqg=;
        b=YXke64azx0DWg8d/xR6392fQ4jtCslHXlVnxY6RKsI84FfTFg+cujbBhPOBpXdi6Zg
         Rxam4svfmQX9SeFbG5iNtrk+RNv/k6a8oCkNQYAdXM+yDvXqVMEvsgJSsw+aHX0mS+oj
         isdFtuJXh6Zxb0vH7ad4wGFFWUMCm7kyv2Str4G+agqCOXla+0UKPyn+b4EZ0cLHiTsV
         PUSNFXxu5Yu7OzhF0n9xnSyxPK1AW6iDIPCnce2dbRePdVc2kvKzej7FofDztTi7tkMT
         +Fqp0/NidJHgVc9ni+uwBEOfkCSUnjRVZJ79IZsofhT66A29ILKzZ0wm+Q3ppwnkHZes
         VoVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699383540; x=1699988340;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tp5Zeqkg1UHwHqtQiJ570931dQjUAPNMnq5Oh8r4uqg=;
        b=xCMZBqUwUuSL4DC64ngzBuzIOuHnK1bj7xzUXhV1z81GA6GWBWjWSX1hksY9iPbhui
         rCaLoQOFzR6u6w1t0HrPKq7NiAjF747WzKMkJ9ga8reFOviXEl/XaIQTYzVwmqgr+16/
         +N6JIFdFwAiXvw2kQoADERFBJfbt3ArjF2JqjTH3HjWEq2FWYuCTJDnECQ0/s1lO6US9
         FI5J7YrilREJ0g/fg/CFL3LNQLZkuZTUeofrxMDH6oX6XRNCDq2F4P5LrdTmcwVrMMUa
         Tx7Zl+xVPhf590el3/2v8B0OHJfN1s69faz/hho9Y9YHtXg2dqVFAwHquQZIduPIHz1X
         Q86Q==
X-Gm-Message-State: AOJu0YyhRA69V6dNCZTXYJx69tb7tru0Wpln7igohPy299I1E6LR+0jt
	lcvF0mjnil1T8bdvQi3oPOVOYadPkg==
X-Google-Smtp-Source: AGHT+IG0CjL0+H2hKtg0Vx0kH5ZF9qWf39aMkL8RYIWk4Clj285NVd4Oa4nWHASR3vUYIp/WMpgrbg==
X-Received: by 2002:a05:6830:e12:b0:6c4:56b4:e91c with SMTP id do18-20020a0568300e1200b006c456b4e91cmr1966590otb.7.1699383539997;
        Tue, 07 Nov 2023 10:58:59 -0800 (PST)
Received: from [127.0.0.1] ([23.102.140.48])
        by smtp.gmail.com with ESMTPSA id t186-20020a4a54c3000000b00587aaf6add7sm1230485ooa.9.2023.11.07.10.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 10:58:59 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <ce93989da39fd2e47baa4506fbbf4c2049c2da13.1698416467.git.pabeni@redhat.com>
References:
 <ce93989da39fd2e47baa4506fbbf4c2049c2da13.1698416467.git.pabeni@redhat.com>
Subject: Re: mptcp: deal with large GSO size.: Tests Results
Message-ID: <7783c1b9-e6c2-ab99-ba00-a6116daf4460@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Nov 2023 18:58:59 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6483594420420608
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6483594420420608/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5216957025222656
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5216957025222656/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4654007071801344
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4654007071801344/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5779906978643968
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5779906978643968/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/5ff408896290


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

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
Bot operated by Matthieu Baerts (Tessares)

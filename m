Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF392F31
	for <mptcp@lists.linux.dev>; Fri, 10 Feb 2023 12:18:31 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id f16-20020a17090a9b1000b0023058bbd7b2so5383678pjp.0
        for <mptcp@lists.linux.dev>; Fri, 10 Feb 2023 04:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZI/3AvUKHBuAANn3mC/heTJpluWYXcADZZvv+s5Ie5c=;
        b=FA+9hRL1FrTc0kHYZEOTM/IPnODkWsI0ZztdgAukJFwRXZV7jUqgCGT45NM/tFl8oR
         ooPan6uu/W8yO/bBub3RXZs/Wkxrd4cKDyng7+enEsul8nhACOi0NhhWmoccXrGjBhai
         g8fNz99KmqBlvgQE+uXl9f9figjzGLE6iL6SoG8v8PiIDVZ3qOjiU+BQQswuxkz36K5t
         4O2o+C7fVF3q5qJhgDNglW7Acfxm0OoykKgeHnqKGPhurZxFt/UcvrSI8iTvNF7lGc+I
         dbIhzfV9GXM2+lxk0DI+ZkuPYP3Si+zUZZRJp6IVzThUwzD5YEHBAo/v/QTd6yjwxvdy
         JfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZI/3AvUKHBuAANn3mC/heTJpluWYXcADZZvv+s5Ie5c=;
        b=3tX/GsQ+QprGZ4JWRQzCLkDzgfAAZbWM9Xmv25S5g8w4u1QMP0FauC6892k4qoiVJw
         HOr0x2cUQ82kr121W7hrc7iqQhI2p+rtA3CEi83SkCUQjDS1iNaqDwlcTJQ1D5bRaYep
         YzP4nDmgYo/jocbVRZ+3N//qUzMAG/T3+/Q8cfFmG1HMvhJMynE35F23QvXuj6ASfI8r
         Tq3f8Nm6bg2p/bdb1cDJp6IydcUXXJt1X7qxOyoOdDJORkhp4fna6+wNkRcNu8t17iyK
         HZban46HfeEEdhbwMW1TigFSJUaHfjOmJsPH8pe++MIyP5lLa3qn3GYAmNIcf0DvFkPH
         ipHw==
X-Gm-Message-State: AO0yUKWwsEkCVYqBsOroEsCFNgcy4K+CfrQp4JtkIkj0zZaHTXSdHu1e
	bq8JlrMR1YWE/l1cBTMhCQ==
X-Google-Smtp-Source: AK7set/97/6qiHcg80MdgbKOR2NxvgbbrxThzFQf/JIMIOZBvYASs1qmHwNnxqblblRFji+Lvi0qjg==
X-Received: by 2002:a17:902:f394:b0:199:512f:75e2 with SMTP id f20-20020a170902f39400b00199512f75e2mr6298305ple.26.1676031511455;
        Fri, 10 Feb 2023 04:18:31 -0800 (PST)
Received: from [127.0.0.1] ([20.172.10.65])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902bd8a00b00186cf82717fsm3267205pls.165.2023.02.10.04.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 04:18:30 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <ad634b00b9c4cfb0f8cd6c8ec57d1a7405ba3799.1675968499.git.pabeni@redhat.com>
References:
 <ad634b00b9c4cfb0f8cd6c8ec57d1a7405ba3799.1675968499.git.pabeni@redhat.com>
Subject: Re: mptcp: fix UaF in listener shutdown: Tests Results
Message-ID: <2cb7f6a5-5ecf-ec8a-c734-87c9fbdd1791@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Feb 2023 12:18:30 +0000
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
com/task/5943503453159424
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5943503453159424/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/4676866057961472
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4676866057961472/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5380553499738112
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5380553499738112/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_add_addr =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6506453406580736
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6506453406580736/su=
mmary/summary.txt

Initiator: Matthieu Baerts
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/017df44e3b70


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

Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E481365
	for <mptcp@lists.linux.dev>; Thu, 28 Sep 2023 17:26:34 +0000 (UTC)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-77432add7caso552446085a.2
        for <mptcp@lists.linux.dev>; Thu, 28 Sep 2023 10:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695921993; x=1696526793; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=215Mz2CM0ne2RfO7n3kN+teT0knkUOfclEJpXvkNIHk=;
        b=Z/yEJnmUMzPJbJnRi6YpcQK/wolN8r1yfAkyEquGAZeqOH1XMHrKEXIl5Faw/rB75P
         V2/TG/CwWPrEuzWZHuOlqA8gCJ1G5jeDzOLvhXhGPuZiNI/XLNhczTgBstb/Vc+tHSkL
         YcQcshhpeuSbZ+/1OMsRmb9pb7FTesSPCyDFUltuC8n0hoM/VcnJP0aOjVNS0+JNndVL
         /6FLMADZEH/vHjKDZM16N801OQxu/W6MLdCzqdOZFCeYRI2vvital8F08lLu+7EyzlfZ
         y/4+TMMCFY0sovw9HZ6ykTFUhgHWnPky0NwaIziKRBMBwvNXcqQz66mNFBw2wht2B69s
         qhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695921993; x=1696526793;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=215Mz2CM0ne2RfO7n3kN+teT0knkUOfclEJpXvkNIHk=;
        b=GZ5B9DCpud/6wTjI2OGgwR8J9D5/3qbkbnm7aNlYgwH46mnJCBbC39VkoWXHQG/us/
         n6WuilUALpyvTkfGsK5C2iTHtJxUJy7TL7K5weafA+xABh9AoU1/GKjQz0aJkVioRJNZ
         KsPvFXMi6rdCmZ8k49+U4Fu5BaN+kLd6n4TOeyPXeie1/QPrLJ9MI6b/MhbvuFMmjO5/
         t9ynh1Aggx5kk60khLhW/R5XlPd0qVJiOz+Qe7AiQ8J42kll2FX+ENTVvVjsF/zwxHk9
         JjlMeoeDMHC2Nhccz/ARes6AbDJ1pj3/t/NRGDzkWfne2sYY6Ae7TG4FOLRbza2BHlAY
         91sw==
X-Gm-Message-State: AOJu0YzL2umVWNXvBN4vwRAjlMKQSSQDb1sz0EMnIqhECvAw0eBEpMtz
	isBfgxnJVtdMZE56+0l/Uw==
X-Google-Smtp-Source: AGHT+IEGFx/D8DhFiNxJxli310hn+OB/l1qKnpSgItWHAAZXhQaMjnBjXxDEajE2JAoWd0z15HmT+Q==
X-Received: by 2002:a05:620a:40c4:b0:773:d4a1:c5c4 with SMTP id g4-20020a05620a40c400b00773d4a1c5c4mr2128896qko.54.1695921993314;
        Thu, 28 Sep 2023 10:26:33 -0700 (PDT)
Received: from [127.0.0.1] ([20.57.75.223])
        by smtp.gmail.com with ESMTPSA id vq14-20020a05620a558e00b0076efaec147csm1908225qkn.45.2023.09.28.10.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 10:26:32 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <56f04f69f7e7c37e0a1820787f7e9063a50bf937.1695911979.git.pabeni@redhat.com>
References:
 <56f04f69f7e7c37e0a1820787f7e9063a50bf937.1695911979.git.pabeni@redhat.com>
Subject: =?UTF-8?Q?Re=3A_Squash-to=3A_=22mptcp=3A_give_rcvl?=
 =?UTF-8?Q?owat_some_love=22=3A_Tests_Results?=
Message-ID: <1bcdf2a2-1a49-fe15-a383-4e91e8c69e89@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 Sep 2023 17:26:32 +0000
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
  - Unstable: 1 failed test(s): selftest_userspace_pm =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6195135847858176
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6195135847858176/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6121534134157312
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6121534134157312/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Script error! =E2=9D=93:
  - Task: https://cirrus-ci.=
com/task/5350710917726208
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5350710917726208/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_sockopts =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5113741331660800
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5113741331660800/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/afb4cb897fe1


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

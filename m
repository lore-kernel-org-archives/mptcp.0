Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98439ECB
	for <mptcp@lists.linux.dev>; Wed,  8 Nov 2023 02:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcteXD/L"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5bbd3eb2f8fso252995a12.1
        for <mptcp@lists.linux.dev>; Tue, 07 Nov 2023 18:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699412348; x=1700017148; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RpQQen4UaSUA8cbrvoNp62coj7paPx5Tqz3+5+rivjY=;
        b=HcteXD/LMpbfYU0FRT+ga6jbp25TVzEXgXQuVC45ROKEdGnu1bsbZu1/LS3hTuxPh6
         FPV0YQc/+pa3VNDdj240cU46aSbwUdq4uVwKvusM1wBzoxsVbTbOHb61FNcncLb0ZoA2
         T1GFqcByh3DEnkN3AA15qQs4R7sXv1OIeJFMzeuuq7DR1AsjTGk9It3cB0jc/oIIEXu6
         7ZaSoEJOzYgpIO99JGdK9srKIUq3v2Du4b0CAMc9DuhrMda12JoICgEVy5CoVN4iafYo
         Q7pWGn6neBNgVTkF/PI54p8vlHREeIdwJpTJC1PxI9cpTaM8PVryd9dxkLHM12akN1CI
         Px5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699412348; x=1700017148;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RpQQen4UaSUA8cbrvoNp62coj7paPx5Tqz3+5+rivjY=;
        b=ft+Xy4KghCsKDfe1rKFw+7jLo3Afqd3xg/JgQgksXU7cbk/YC/huUPdv6S7f+57y2Y
         HW9nj4/K48q4W/Vqz71dJL9ccuEt/DhzD9G6A4wJcJi3JLQoH2bOEbNEtr2O1yRD20uK
         Zhl+VKDzU7QFTGrgmHwn/Mkt9SnHZfnbTqi+hVvyrChyt//34sKZr55FyK5VhAYc0Ayt
         WVoh9RPQlnkesgqf7WjQ5k31mY82NeThKAkxVYUZBxdv2zInZiAXbYoZlDOJjvWKOdAj
         01aHJaa7WfZcM1HUqHNXOGcyKf9EE4SMnsA0RPf8OWw8Nz8KWKndV3dh4lavMD+h8Dam
         d6FA==
X-Gm-Message-State: AOJu0YwzV+q18zHs/tq75X5K8CilySkBu5UcP1MR0+4cjfMRLk3fLMqc
	7jtipfjNKMKdbIXBVFHc8pVm3aPCRw==
X-Google-Smtp-Source: AGHT+IGHo6mU2zGapRBRmMT4tZgnGSiX/2a+V7o0K9L42Aos+1SL7IeXuVjWXwOdN5wEonLCcasElw==
X-Received: by 2002:a17:90b:1804:b0:280:ca28:de58 with SMTP id lw4-20020a17090b180400b00280ca28de58mr1003076pjb.4.1699412347730;
        Tue, 07 Nov 2023 18:59:07 -0800 (PST)
Received: from [127.0.0.1] ([52.238.28.79])
        by smtp.gmail.com with ESMTPSA id ot13-20020a17090b3b4d00b0027ffff956bcsm481423pjb.47.2023.11.07.18.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 18:59:07 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <a345cc5ff04729307b7b5b3a26f81e4e653dbefb.1699408002.git.geliang.tang@suse.com>
References:
 <a345cc5ff04729307b7b5b3a26f81e4e653dbefb.1699408002.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests=3A_mptcp=3A?=
 =?UTF-8?Q?_add_mptcp=5Flib=5Fget=5Fcounter=22=3A_T?=
 =?UTF-8?Q?ests_Results?=
Message-ID: <a1897760-72ec-38f3-7e2e-1e7aae2c3d71@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Nov 2023 02:59:06 +0000
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
com/task/4930056766619648
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4930056766619648/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_mp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5493006720040960
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5493006720040960/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6055956673462272
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6055956673462272/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6618906626883584
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6618906626883584/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/5dc0ed7d806e


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

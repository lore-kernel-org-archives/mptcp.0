Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4463B3FE2A
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 16:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MT7c5EBP"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7788db95652so379721485a.2
        for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 08:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699979640; x=1700584440; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjEBmO+c98tMit2nr4FkuF16pDbS9vH4iQS8VUG7gaE=;
        b=MT7c5EBPs+rv90NwRSrjAjHmG88TbbR2g83s2tK4wEp8e4EhwAZ3WyLvgf1yvkBI07
         gt33ZQNntB2iV4SmqXxO8oKO/UTAzuOw6B0Hy447LErB52VYg1dgD6WABPLl/oWUN6O3
         lZue4fvJIJtchol7+SHY1LSS6+XMfZ3meh5FiHuy3ch5sRzsunUpGjXdaDjtoH210SCJ
         JQkegfwN3YW5F8I9slqfTtOSNsV65kFXVhbH/Ic+yI65fJ85ajQho6vA+3O0yQDqQZzs
         v9wQhNX6HIdInZybYuh2yD3rRD6CV55KQq0mnuNCfB/ttBGBEW26DTJmWb3M5UxRtuld
         7Rdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699979640; x=1700584440;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cjEBmO+c98tMit2nr4FkuF16pDbS9vH4iQS8VUG7gaE=;
        b=bobRmLzW5WS1WyQGPc1artu288AfuJIlN05k7U39rGIJ3sQ+z43izlbgQPSsb24zyj
         3Bz8K732UuzrYtQlP7OVgzm+sKeIitSaBZHRb7JIeg7vIcPkVerk/Dpry3QteDakrraA
         /YorQAcfwk/GQzcGdovM/PR4SwVI7gUYGwZFCR4oentJh0htJFWJygu3VJkzm38Obvus
         VqrpxDGAVsovb01EiBVN6RbN3xJEfa6vcTVWqXpKLpMHNQcKAnwkj3FgSANQapCtSiE+
         9j31zkDVT7zO6krOQZ3tTeNECI7jpp28SnTWBi2uSnEdA+OiTBCd2FyD/5mPwLGvMliL
         9brw==
X-Gm-Message-State: AOJu0YxfT9W3XLZe4UvHuzJKVzzZHF8i1OyB4Fa/r2Bbfh19UkNzv98u
	7eZPwKOcaQ4wLZxAROFrDg==
X-Google-Smtp-Source: AGHT+IHpzD/IbYKl9FOEdVYjbc/jMe6jlsnfROHLQnxENwpcRTHEgwNVh4Tffms6sfblhewTZUQzsg==
X-Received: by 2002:a05:620a:2887:b0:76f:1ead:e4f4 with SMTP id j7-20020a05620a288700b0076f1eade4f4mr2808404qkp.15.1699979640047;
        Tue, 14 Nov 2023 08:34:00 -0800 (PST)
Received: from [127.0.0.1] ([20.97.191.130])
        by smtp.gmail.com with ESMTPSA id d5-20020a05620a158500b007756e75b91bsm2768035qkk.78.2023.11.14.08.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 08:33:59 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <be920296c8454c2b3c3acddee67828e94a8aa32a.1699972742.git.geliang.tang@suse.com>
References:
 <be920296c8454c2b3c3acddee67828e94a8aa32a.1699972742.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: join: fix mptcp_subflow_send_ack lookup:
 Tests Results
Message-ID: <8171a501-2872-d58d-fce2-d066d5c5cbab@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Nov 2023 16:33:59 +0000
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
com/task/5761267424559104
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5761267424559104/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/4916842494427136
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4916842494427136/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5353618958712832
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5353618958712832/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5198317471137792
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5198317471137792/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/010239be11b5


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

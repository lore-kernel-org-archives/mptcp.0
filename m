Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4097120DF1
	for <mptcp@lists.linux.dev>; Mon, 11 Dec 2023 10:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DahM6ajw"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6d84ddd642fso3318707a34.0
        for <mptcp@lists.linux.dev>; Mon, 11 Dec 2023 02:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702290043; x=1702894843; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yh0b0bVTznGR8Wa4SWw+MyX4FLhKLXKl9URxXmGaBqM=;
        b=DahM6ajwN91FqL49F8bvrt1Mn/s+SEK6UIXlpQVNagf7uP9UOPl/vVOw0m2Nt/9tHX
         KoB4IjW5ReU5dLWc6jfKYPE81g+fahy0PFr5VwHhj0Wjdx0iVaYZvTW8+oVucXESui30
         Xg8pDvtNbtGK3eoXpNGNxNQzTS9Fv69fpUrcl/ITFXRCDKOlFDcgbg5BA99WOa41t2EJ
         twM53M1fC7wV3LQv4+r9IF3d2MFfQo8QRl14BUXOa2vbeyyIjHlpeP1A8Ib1g3ylgkyz
         iFtgt+GJjr8H9dgZStr+/7H0p7QIYkNFh5RY1AWRE6dXHrP+TQ03BoXQltorOBAe1JCW
         HvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702290043; x=1702894843;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yh0b0bVTznGR8Wa4SWw+MyX4FLhKLXKl9URxXmGaBqM=;
        b=eFhuiO0yEDoSKw9VA2dhqpdHVa3S9kAZ6XQaND8NLR+3aD7b/Oua84a2frBM8R39+W
         f0W2iNbGsbGaYA1q7YlHCutLIbKky6XjyQfD0PSpBlTGXooLo1sI1iB6biiUv3Uj/+3i
         /QXWJcuFAeJmEZdy39JixT3MWws/1y3IxLBA1ytVMYRMRyL6kI942zDbn9rIUtx3fxtS
         G8ts1LIgd+YHIRC/lClpCQ4vEDIwC/InF9CN8VEY2xvxqLNyneVfaGOO6SxSWWE8Xgcj
         JAzEW3sfAaaVvfT3BcdZcurjqZEHaHst5iwcJxtsAZq4zElBJba8UE7cWaf6Zfb0jyE8
         vk3g==
X-Gm-Message-State: AOJu0YzIUGCdSVkMYhwp0w5SCH6zs8MEMCwk2C7degh4mBdeybiKvHeX
	u2V3/lU1KVQO6bGpdnJFGQ==
X-Google-Smtp-Source: AGHT+IHdID/m+kgo5acK8uNPEltH8Pub9JJDEU7OViVCXNTk3uu7Eoyg6pZxLiczc2v7SSpXX5DWug==
X-Received: by 2002:a05:6358:249b:b0:16f:f2e5:a76a with SMTP id m27-20020a056358249b00b0016ff2e5a76amr6875369rwc.16.1702290042953;
        Mon, 11 Dec 2023 02:20:42 -0800 (PST)
Received: from [127.0.0.1] ([138.91.70.182])
        by smtp.gmail.com with ESMTPSA id h5-20020a62b405000000b006cdb8ef2db6sm6137897pfn.94.2023.12.11.02.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 02:20:42 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@linux.dev>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <887df28eb56432c25ae6cc64da4817667562a020.1702282928.git.geliang.tang@linux.dev>
References:
 <887df28eb56432c25ae6cc64da4817667562a020.1702282928.git.geliang.tang@linux.dev>
Subject: Re: mailmap: add entries for Geliang Tang: Tests Results
Message-ID: <335bc947-9c85-61aa-9036-c7fdeef524cc@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 Dec 2023 10:20:41 +0000
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
  - Unstable: 1 failed test(s): packetdrill_fastclose =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5674158290370560
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5674158290370560/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_fastclose =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6237108243791872
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6237108243791872/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4829733360238592
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4829733360238592/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5111208336949248
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5111208336949248/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/4c07d2e6b010


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
Bot operated by Matthieu Baerts (NGI0 Core)

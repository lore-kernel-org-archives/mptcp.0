Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910F11CA93
	for <mptcp@lists.linux.dev>; Mon, 13 Nov 2023 10:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4XZzdvD"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-66d0c777bf0so27178896d6.3
        for <mptcp@lists.linux.dev>; Mon, 13 Nov 2023 02:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699871414; x=1700476214; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0Cj+gh4qzyJXQksanvl2wcv2L46fTktPg4wD6jled4=;
        b=F4XZzdvDX4iTj4NNcVs+eqts2BFo2enpwKTfIKsFIMMm9fTohAMFUDEruHzv5hiTTJ
         dHnN+n/A3lTpNGpHzRsZr4oXMZ6h3Yuy5H/Nx5NK5q/WTDRhu66OVjDbD65AXOjqgkZR
         Dq2jN/5vwHq/eTO0ZcguWS41Ru9N/POzZijySWFFDAomXbXAlZABD4T7ShQ/Mggv5qpo
         jvL2duUHP8XVsR01jqV75cewZBXTqxOyuS6VUX3Rl+348NfwPFzu0Lk+JLnrHEN9Zum7
         +Bp7kFHs1vmoj/eDbUiMmQtnMpX6EqJCNZhAQXBs3Ixl21FZEHL3WMn1sMDjz+WeiKUU
         mEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699871414; x=1700476214;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a0Cj+gh4qzyJXQksanvl2wcv2L46fTktPg4wD6jled4=;
        b=UJz+R4kh03jQui0kG/XU3byTQqj63VAtzgaGSo41OxT0Gyr1cmGAgnEHvdxjy85aas
         pzg4qnHQj1e9vbl4o0H27UzfWeQZBcO+4TiC2PJ/H2cvoc05kcXXCck5bmRVOEJ3Gd67
         QNc4MynIKP4w/I+nXZs1RCtz9sVkdP+Nd+SJx9FheHxlu7wFYjiMJ5t6nSBcPBgUP1+z
         6DyaS1UCSNruQQfdN1ST8gqj68GAy+uJdAjv7jBYR6FyW8EbUxQ2cX9ncgACmVUSrkJJ
         okF8ehy1DDBdjqxyHvKewhJxA9k7JtRQyewEP4PBAHTWm8jJ2z8izyKPc4uMn+lR/UxW
         dJsA==
X-Gm-Message-State: AOJu0Yznc2GvGw0r9r4jHCrY+vs78ZpBNQvS6jZwyMN4jJJZ1ITqRTpn
	pM5JffMJCNSFrqSQK3aCHw==
X-Google-Smtp-Source: AGHT+IH/oH55puA8JA56aNtLs6+C2FWKk++nUlMTqpY+Id2z8XjzDi/+9kvKZqB+BGZ1fCRVmJUKuw==
X-Received: by 2002:a0c:c588:0:b0:675:b3aa:edd3 with SMTP id a8-20020a0cc588000000b00675b3aaedd3mr6049716qvj.27.1699871414432;
        Mon, 13 Nov 2023 02:30:14 -0800 (PST)
Received: from [127.0.0.1] ([20.55.46.112])
        by smtp.gmail.com with ESMTPSA id fe17-20020a0562140b9100b0066d11743b3esm1958018qvb.34.2023.11.13.02.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 02:30:14 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <720d67a275179d96aba05cccd56a98f10da47aa1.1699647725.git.pabeni@redhat.com>
References:
 <720d67a275179d96aba05cccd56a98f10da47aa1.1699647725.git.pabeni@redhat.com>
Subject: Re: selftests: mptcp: fix fastclose with csum failure: Tests
 Results
Message-ID: <2898ae6b-38dc-c711-6b53-08269c7acc7c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Nov 2023 10:30:13 +0000
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
com/task/6537406518657024
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6537406518657024/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4707819170037760
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4707819170037760/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5833719076880384
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5833719076880384/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5270769123459072
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5270769123459072/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/490670fb7f27


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

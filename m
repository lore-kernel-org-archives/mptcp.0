Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5622ACA59
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 07:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxCm3U5z"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-77a277eb084so356381085a.2
        for <mptcp@lists.linux.dev>; Mon, 06 Nov 2023 23:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699343702; x=1699948502; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plA/neLFi0Z4urBFoRwzCESrdtEKfymBjLBmqlBfX+w=;
        b=jxCm3U5zkj6Z+VeSmawIWX7CAC8xZrycST+V+O0oBJNy3h+vse4iZXcJMTJTzhvWdT
         4UxmTt0e/2ShZB0ssVyf9pawP0IbMI9Qj170BnP6CRIAmv/Pf/lHI0tfwi9y1apTqODO
         Sw7UdRXqHoikz8+2Mi6NHvKRvNPaGa00jVFMEqLIy5u2KDoIs1XFLcUTnX1y4sR7KEqS
         UnkjlLBJBsZLVgDpxVVVm7GF00fXNKbu7yCW+j5aOCG4DRx+roD6iaq3l/xFyOHtgNWU
         FzCVAnwacLaGoToriJqvMl8EZcFQ045ZT2GIfwCCcucpHzL9jvGv9iv7Z6MLMZmmu7aq
         DG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699343702; x=1699948502;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=plA/neLFi0Z4urBFoRwzCESrdtEKfymBjLBmqlBfX+w=;
        b=AavtTkpONqZo569t0WtwMD+s3eLT3hUlOhu9uKY/apXIZs6avzLnN2G3U8hQcefwRk
         xIOsR9FVwAiuIjVIxjg3PzoAbdmL5RBPOoY1wzEYS31bZWKJ1JhH5BJAx9vbBl99nz+7
         lq3W+wJy7DKYu0apwaLsgDUbt5JjxwWWwWXZVr6wKKR2HkUbrZQGMHSX7UmPD/DCOSEa
         I/hszRgxee9ld2dlAqpkPuby1XPOn/XaPghrA/VS/Vu10qooejCyl7N+N7Y+5ekIE2+D
         O0G+g/tOPgerjrFwyuXCNNhw9J4tIdSbWzaCA+PpumS9/nFzOrbWCM712MqynVd5wCyI
         cuCg==
X-Gm-Message-State: AOJu0YyAL032f58LNgz/XYVk6vNN2k/nddxZJQS6z0gN+FEbHaf9nM28
	wEg09DZshHNGheACsJFNTg==
X-Google-Smtp-Source: AGHT+IE3jQedtWW2g+S0WwVHppjsWVEDjtGL6E6G0oWewCdmiC0pzi/ccSLo8bDmqtqBBVodqhhO6w==
X-Received: by 2002:a05:620a:1662:b0:777:7314:ee19 with SMTP id d2-20020a05620a166200b007777314ee19mr28707468qko.21.1699343701987;
        Mon, 06 Nov 2023 23:55:01 -0800 (PST)
Received: from [127.0.0.1] ([20.98.6.128])
        by smtp.gmail.com with ESMTPSA id m16-20020ae9e710000000b0076e1e2d6496sm3988816qka.104.2023.11.06.23.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 23:55:01 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <d50ee79d99f6d35352223aa9d2f212ae3aea4219.1699336526.git.geliang.tang@suse.com>
References:
 <d50ee79d99f6d35352223aa9d2f212ae3aea4219.1699336526.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: rm userspace addr with random order: Tests
 Results
Message-ID: <ce75a4e6-8227-5d2f-002d-15e4c045e168@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Nov 2023 07:55:00 +0000
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
  - Unstable: 1 failed test(s): packetdrill_add_addr =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4724648009531392
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4724648009531392/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_add_addr - Critical: KMemLeak =
=E2=9D=8C:
  - Task: https://cirrus-ci.com/task/5287597962952704
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5287597962952704/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Critical: KMemLeak =E2=9D=8C:
  - Task: https://cirrus-ci.=
com/task/6413497869795328
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6413497869795328/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5850547916374016
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5850547916374016/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/f5593d67807f


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

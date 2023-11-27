Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77B515AD2
	for <mptcp@lists.linux.dev>; Mon, 27 Nov 2023 17:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXH4ECbH"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-67a095fbe27so32718376d6.1
        for <mptcp@lists.linux.dev>; Mon, 27 Nov 2023 09:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701105902; x=1701710702; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5VDq6VSr4diSA0zlqBz+mIJdjWbmdkN3ClYB0G3q/I=;
        b=fXH4ECbHeSgZAbRkCM5qSQihO7WZ9K9PdOLezh2og7/JwetZ+PJIjPCgcQOQtge42h
         aPghG9PzYq5YjbBuwq1VdUY3gwGowDg2cNXvX4b1409pO0tFAwn/xMU/nJo50MHSNX0q
         8JDVC0I8wQ5o1J9ti4fARUxTvwpBgLM1rubq/uiTgL54jw6jS0TVO7HXxWzHg8OX8JRm
         NTetpLFmwDYdhqN1NEndazFhhs1a5vmOqi01N9er+/3GTGmDgec/Adb8KruGVdcCKs4q
         tOac3AP7QKuIVLUm0ClCuyJMpYepmpTDBxu4rwTaD/brUeovG/6jHEfc/20FpSpRaYmh
         CBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701105902; x=1701710702;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N5VDq6VSr4diSA0zlqBz+mIJdjWbmdkN3ClYB0G3q/I=;
        b=Es9vgQ196t+38VHQg+/W1BLvBpZBGn3Y2aa8JFoYQAkmkYcdPq0ihdeONvIpb8C4nC
         8IzzZGOXgmXzVIeooIXNPrVkRI6XYySoHM2Z0fwXC1fbJXnmP+kQ1yt+nKz3YEHtYq5X
         xr4QyLaQcYP2guySLbrB04/vb4/bTQrv69TSbx7Uk48/y/tcdrPwLfbvtVTFUdGDby2Q
         UN/UxVPMkETP64YyZueNwiOjS53dRHYjoWlRWjHTu8gVM1iKzxuhdp17YaGsDzJI+vD3
         9D7kDKjUa6ZeQUM/Z1GooSWU4EEVwmphl6raj7/r2TIV1hZ7XrgHa//f4PSAQotjr8eM
         LAsA==
X-Gm-Message-State: AOJu0YwZQik0//mbrXSFMQbaGHZUDB8QPT//qtdpJhUzbZD9Tp2w+wjd
	z0Zk4izPuCzKq4Dfwo5FpzSU0oRWXQ==
X-Google-Smtp-Source: AGHT+IGyQxNDhPxQ+VW7AGD6zC7KCLiGDwvX06abRMudrIifJVplbHSmLpqg6p6bGy/hNnaL3Kngdg==
X-Received: by 2002:a05:6214:20c7:b0:65a:feb1:ec46 with SMTP id 7-20020a05621420c700b0065afeb1ec46mr28371372qve.6.1701105902639;
        Mon, 27 Nov 2023 09:25:02 -0800 (PST)
Received: from [127.0.0.1] ([172.183.88.191])
        by smtp.gmail.com with ESMTPSA id k6-20020a0cd686000000b0067a31760f5csm2292749qvi.113.2023.11.27.09.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 09:25:02 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20231127-mptcp-module-desc-v1-1-d2209921bf9e@kernel.org>
References: <20231127-mptcp-module-desc-v1-1-d2209921bf9e@kernel.org>
Subject: Re: mptcp: fill in missing MODULE_DESCRIPTION(): Tests Results
Message-ID: <e9411230-e814-a062-4ca8-0fbcf4ffa534@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Nov 2023 17:25:01 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6256691835043840
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6256691835043840/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5412266904911872
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5412266904911872/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5975216858333184
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5975216858333184/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4849316951490560
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4849316951490560/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/c7a02c02a522


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

Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B115D15A5
	for <mptcp@lists.linux.dev>; Sat,  6 Jan 2024 02:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ee0hUOHA"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4283ad9e7cfso1605461cf.2
        for <mptcp@lists.linux.dev>; Fri, 05 Jan 2024 18:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704509728; x=1705114528; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmxcLTyMSWqDcCOVDzOVb2z1kk2G1fcCqLvgbHXIFCI=;
        b=ee0hUOHAyeJFM3YSL8DZgW5PO2Qiy7um/hyb+h1EQ8MP2A5oClg+IPAeUhKQLfTbGL
         40pHhOX1iYRoqOZU/FYxzRFD26FO214pKTP2CL7UhKfJM7GAfsNThWZGqP9xyes30HTH
         7WDBip/Da1JT9uyv+sUhRmQhsmVnYQmKsPSAfC5ztHIUU7UVBin8uNzVav+eOiCc4d2l
         H49jPbEyl7QY4LzPhnGn8srHkgvdXeBjvlg1Dd2moXfJb50k9jrEa2kTuaw7s8+BvzrR
         /iU98Hv+K8Maqp4PVum2daiV8MvIPNn2GtCBJQWc4bbNw9AERZTawtKWBbvX/hjSdH9Z
         GWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704509728; x=1705114528;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dmxcLTyMSWqDcCOVDzOVb2z1kk2G1fcCqLvgbHXIFCI=;
        b=MtzYJM2byJ9wKPkW2yKBqwFmoYIM7j6KBvh9k9HomnO8BEbh97sXrY+Du3u5lOFgdi
         ICeQ+Z61KNF7Rr7z5fIgqWJfie4y0NrkfYRoVN63wv4bQxUi2RRm1Phg7d9UpwOMVyB8
         EdMlFNUHvHkrmld5KFrQ5dKLYQyDF0OUIMmfOQwvD4QdwaSP+EvF+c7kY4dKj3mJTK8Q
         3NsEQu1raH/xc2rzSnsGqzTA28B3fCnoCMJ21l+ayAEn7jkno/uY8JRTbiUkqEHFgcg7
         4vzHCdFOkgtugDmDYuqVS6QsxKhWr8d6bdiC1prJl2dznsj+KlboejsgPndO4RmbtB93
         1z8A==
X-Gm-Message-State: AOJu0YxlLG2jzAqtR7aDsIL8bJXjuO4zKDPUAKdLHB1GRqIwu8pzzluv
	WsIh8G5HAWWXqN4+dICVj68XO8hhRQ==
X-Google-Smtp-Source: AGHT+IGxfNm3Zo8cBA/lXDOYTRMPNfskUi6BTfLwtwHTPBZvKsXhp07W13FZkZH7ftAiAkVbhqnY+w==
X-Received: by 2002:ac8:5f50:0:b0:429:8026:6ef9 with SMTP id y16-20020ac85f50000000b0042980266ef9mr547408qta.52.1704509728501;
        Fri, 05 Jan 2024 18:55:28 -0800 (PST)
Received: from [127.0.0.1] ([20.109.39.17])
        by smtp.gmail.com with ESMTPSA id fz27-20020a05622a5a9b00b0042545c7beccsm1281403qtb.59.2024.01.05.18.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 18:55:28 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@linux.dev>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <21d0da867665e8fc693b12e3cecd4610efced6e2.1703904325.git.geliang.tang@linux.dev>
References:
 <21d0da867665e8fc693b12e3cecd4610efced6e2.1703904325.git.geliang.tang@linux.dev>
Subject: Re: selftests: mptcp: flush userspace addrs list: Tests Results
Message-ID: <7d8e07ec-c609-36bd-5fd9-ec074a124532@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jan 2024 02:55:27 +0000
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
com/task/6049456726999040
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6049456726999040/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5486506773577728
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5486506773577728/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4782819331801088
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4782819331801088/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6612406680420352
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6612406680420352/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/81319ae06031


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

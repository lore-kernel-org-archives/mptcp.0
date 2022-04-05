Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CF77C
	for <mptcp@lists.linux.dev>; Tue,  5 Apr 2022 10:23:26 +0000 (UTC)
Received: by mail-qv1-f44.google.com with SMTP id i15so3716910qvh.0
        for <mptcp@lists.linux.dev>; Tue, 05 Apr 2022 03:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=4ANT0LX+N2syx4U4DJ6mRr6oQKs1d9WN+Gz5tshq5Io=;
        b=aMsdXLVyf+e/UWlz8SGkDTOwjgdedNyQJkG9xdv7YAZ7cZdLqkne7W6cyNbMXQCvmV
         RwZeEk3tebjuE0LJ7ie4+9xJVQPPArFqC4eSv2Kw+uR1+UFvsbipIrBirAwXHUfjC+w8
         I+s3vq8bkWIPCM0Us9j5WI9LvPjEWCc0IIEOZAvyY1xVcVDm6uUl8oXLGIbzTaQVs8ce
         xRvlfudmXQkzy6Vz3m0xtj70rerPa7l3na/JGYkQFt3qLjxpebHV8l1I3r6dfUiH++YJ
         5CuF8z0iNkqYlgWb4K/24Nrq3L6yci6E5U7KvArjZ3QVXL+qUMGh+dlqasXviwAJJ8uG
         9kcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=4ANT0LX+N2syx4U4DJ6mRr6oQKs1d9WN+Gz5tshq5Io=;
        b=CA1Zd1lSIu0FiKNTr6HrZjtGbDSXm8PwRysf1/aS9RlSYjFYkbhW1PZx5Vv1bxsAwO
         l2kud903EecIXJHP967HLIzLmXo1qkc+wvcfQlytXZmZrAnFcv3ED0sJ79hYsFrJj+Ev
         9qF7tU3xIFVzSc9+B6xChoRhqV2fpzWVfxvoVafKMKAzRpdOjEExDEgygoJpzFp90IJE
         1Uq4alYiM3GQkD6yk+0p/4HG3uKDVQJFbu3HSSZPHVY1vY/PRYWtxXGhd70+m57FLyeY
         LxRjIuxn8QIj8im79aqll6xmE7qvM83qoQZRhdNzNteBKtfARRrYnXyWHbRfpMT2ZXgK
         /Eig==
X-Gm-Message-State: AOAM530DAwfBg4GAaG/U1CETmRjfQqyA4N9CW/cJ/UC/mHpXpeQcjmqE
	tgKVK0kGOOM4GybNWO0r9Kpgiq2uTQ==
X-Google-Smtp-Source: ABdhPJzdrxDZ8N2Zq+R/guof9Mb69kR+bvza5ni1oQd6QyZH46gKsNKAcEf7km/VfCiDWrB44TiFOg==
X-Received: by 2002:a05:6214:29c5:b0:441:260d:f632 with SMTP id gh5-20020a05621429c500b00441260df632mr2104745qvb.121.1649154205102;
        Tue, 05 Apr 2022 03:23:25 -0700 (PDT)
Received: from [127.0.0.1] ([20.98.203.42])
        by smtp.gmail.com with ESMTPSA id l18-20020a05622a051200b002e1e5e57e0csm10632670qtx.11.2022.04.05.03.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 03:23:24 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <0d834717492cdba59f67be88f9647c7535aff90f.1649037838.git.geliang.tang@suse.com>
References:
 <0d834717492cdba59f67be88f9647c7535aff90f.1649037838.git.geliang.tang@suse.com>
Subject: Re: selftests: bpf: add bpf_first test: Tests Results
Message-ID: <ae547b82-1af3-fa36-fe08-759f1029c9a1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 Apr 2022 10:23:24 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/6452376256118784
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6452376256118784/summary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5045001372565504
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5045001372565504/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/1a4b8dbb4120

Please note that despite all the efforts =
that have been already done to have a
stable tests suite when executed on a=
 public CI like here, it is possible some
reported issues are not due to =
your modifications. Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)

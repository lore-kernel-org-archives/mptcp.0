Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F548A45
	for <mptcp@lists.linux.dev>; Fri, 14 Apr 2023 09:52:58 +0000 (UTC)
Received: by mail-qt1-f169.google.com with SMTP id cm23so8578577qtb.3
        for <mptcp@lists.linux.dev>; Fri, 14 Apr 2023 02:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681465977; x=1684057977;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJ/m6QgUS09KPJ6C/YrDwVF36qyq+23tKFUAFy86J5U=;
        b=m8gCx87TxwTfcxCnHJWQikc2CelPd7+SRCJ5Wdq7+jOzXE6S/mcqPC0zBlJRYyJlWC
         4NGTykYPst18y78yj7nkBW74bBEDQrA70zaoxJbjQHUai0Zk7Du+gGCiOl3P3/kemy4Y
         SzZ5wuXl79sRe+HpfSQDclp8Q/EhoI7udLgwJdRS1XhWdzL8XTGR3SeuAFUFfNhZcWKZ
         fP8yeb0s9tMOcF9VIAgbXylmUsqyKpIXMD1c6Jyk3pv1J7+y+/93ry2y0rPgjM6dOHay
         tnxQ1fhRypFZKK0Cx+FVevEfn8DLSbOVgRV+x8qk0mxISN9bue8FrudF3f0tD72jUWdT
         Epsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681465977; x=1684057977;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TJ/m6QgUS09KPJ6C/YrDwVF36qyq+23tKFUAFy86J5U=;
        b=Yic/snnLr93Ltq2y++Dx5SwHZV9VLJqBkrYOmcNbAdiIrC87+chaBANANYBL6rCyCH
         Mkaa/NYDP3FZ4IlGh26XPlVOq70dEbxks6BT84J+Jj+zvf2pJOnJj4XF4vEZVHtPpqE9
         w7jg2OjS3ofvCHcliftvShdtwCehtbzKxJi0+DVyIYJ8PdwjjRZ9s37KFzaW5sljZwKn
         f6d3ACS1ntD44S5PvHexg12GHWxnqW01kjY72tkS0ZhHdbka/ihCXVhztuNnx7dl0aT/
         IIQq8Swn+qNFVGFf8qj+yOEiM0n9/vVIYa0MD1U1/tXihL8xAmQtQtVmOTsgPEXh6b/Y
         6pjA==
X-Gm-Message-State: AAQBX9c5toGoESuWk+QL6FYgroc9LMX9WSU9F8DlPOgrtNsU8Ltw6MVg
	6XTYEuYdCxmvUe7LWY/F+8idhM7M/HaE
X-Google-Smtp-Source: AKy350YwHgIljfgiL3dMYzNEqfGz2zSRMV3kCd6+8Y5ygA8nykqgqiPVK7XdYP000rbxKyFRbBvXYw==
X-Received: by 2002:a05:622a:1042:b0:3b9:b817:e9a8 with SMTP id f2-20020a05622a104200b003b9b817e9a8mr8352027qte.27.1681465977384;
        Fri, 14 Apr 2023 02:52:57 -0700 (PDT)
Received: from [127.0.0.1] ([172.176.196.120])
        by smtp.gmail.com with ESMTPSA id l12-20020a05620a28cc00b0074235386738sm1119962qkp.37.2023.04.14.02.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 02:52:57 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <3ddbc897e2e5a766a2b4df591e747126288661ff.1681463340.git.geliang.tang@suse.com>
References:
 <3ddbc897e2e5a766a2b4df591e747126288661ff.1681463340.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: check userspace mptcp_info: Tests Results
Message-ID: <a24b497d-c088-66df-0e43-453776706c3f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Apr 2023 09:52:56 +0000
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
  - Script error! =E2=9D=93:
  - Task: https://cirrus-ci.=
com/task/5081880182128640
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5081880182128640/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Script error! =E2=9D=93:
  - Task: https://cirrus-ci.=
com/task/6207780088971264
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6207780088971264/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Script error! =E2=9D=93:
  - Task: https://cirrus-ci.=
com/task/5926305112260608
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5926305112260608/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Script error! =E2=9D=93:
  - Task: https://cirrus-ci.=
com/task/4800405205417984
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4800405205417984/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/aa4e473b1157


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

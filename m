Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1A16118
	for <mptcp@lists.linux.dev>; Fri, 24 Mar 2023 14:25:50 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id kc4so1926397plb.10
        for <mptcp@lists.linux.dev>; Fri, 24 Mar 2023 07:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679667950;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtGGDOvyo+eR7GAJMwbN9JbB//aUQ6Cb9jioUTJsb/Y=;
        b=LbViHqx5IQ5DxUo0261AwhlV+kkY1NpyF7mMSqh6Qm8uKaDNZ8UANrhCDo3LZb+PiH
         Ni5MxqQrYmhf8hozCQu40jIpuVhwSWlQG/EWF2bx+BtarV7sSxxaXGdlv+iVpBWZQXpz
         lIc52tCDTf/7Zed9kfgNLXFMrT+ze6mvMdGAjTjWM9cH6v+/JXi6vOJfPvpYm2OID9pm
         FR4M84sxxcZW0T+PPaVaK8OVEoOV20GEMlnQcgjvzXESwfTShl0cPbcW6iKApGcwJcEl
         GzVOoyaFSRXtOE3xGWFT2K3KxgTlKH7Cis5OANacU3Qtxxeu149vZnFaXQE9Onh3NjN4
         jQyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679667950;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dtGGDOvyo+eR7GAJMwbN9JbB//aUQ6Cb9jioUTJsb/Y=;
        b=OHtHySKKMAyiC3Zsnwgu/CmLtUqZi9kN8nKu+SFjzQzkn+OirDGxj8tmB4mEEMMfXo
         K/huvVKXJTOUByl7fYvnP9uAp9jMIy6YFJTbEFeLVqHoGiNV073gMWEZO90mx/58bk6M
         L0DEAfaCpysjzJmxy4W0wfmENRua6TT7P6l3G4xmGeAj+8HAtQRRaQvclwMu/Og5eBYh
         EZz9K3B+hMWjJTLhbDkp5UFius9mgUrC1voF7y13yExqlQ4Ss3m9lV+Ka+Dd52gPnirS
         ATfHhN6w0KlBM3KPbhFyb5bqehXhKOH1m73igQiZ1UnkbiWDkL7oBlt1pWstylvDGIZj
         eYmg==
X-Gm-Message-State: AAQBX9dOXyzI8g6fY7iTC4whjsQ4DE+Ios+pOe3Do4u9yeadxsfJqQeR
	yNHbCsP7q06kA1MzU5dYZw==
X-Google-Smtp-Source: AKy350b4G3eR5JvloZPUc7mqXhccqcEBxrXu9dBLEmOjIga52+eONsNqUEe8bLCosxEn7I0tZSHRhA==
X-Received: by 2002:a17:903:4305:b0:19c:f698:8564 with SMTP id jz5-20020a170903430500b0019cf6988564mr2607327plb.17.1679667950255;
        Fri, 24 Mar 2023 07:25:50 -0700 (PDT)
Received: from [127.0.0.1] ([20.171.107.96])
        by smtp.gmail.com with ESMTPSA id c20-20020a170902b69400b001a1faed8707sm3838469pls.63.2023.03.24.07.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 07:25:49 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <10b158069455d831d9efc547bcdb3a6379234f1c.1679654040.git.pabeni@redhat.com>
References:
 <10b158069455d831d9efc547bcdb3a6379234f1c.1679654040.git.pabeni@redhat.com>
Subject: Re: mptcp: stricter state check in mptcp_worker: Tests Results
Message-ID: <c129ab4e-bc3f-46cf-f3c7-cf495d5fc74f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Mar 2023 14:25:48 +0000
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
  - Unstable: 1 failed test(s): selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4772230790381568
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4772230790381568/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6461080650645504
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6461080650645504/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5898130697224192
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5898130697224192/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5335180743802880
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5335180743802880/summary/summary.txt

Initiator: Matthieu Baerts
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/2f4d5b686cc8


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

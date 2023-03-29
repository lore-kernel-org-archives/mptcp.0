Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1232F49
	for <mptcp@lists.linux.dev>; Wed, 29 Mar 2023 18:32:56 +0000 (UTC)
Received: by mail-qv1-f53.google.com with SMTP id m6so12343553qvq.0
        for <mptcp@lists.linux.dev>; Wed, 29 Mar 2023 11:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680114775;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=egd9q+CbRMibBt5TSrqyVnWEObnCEd9/4QE0Gp6MVfs=;
        b=K4UK0JAFPHGjw8M+/e9K6ceQ0JGqPjVuhyHG3X+vIZYl+Zd1JZOdEZcCJzy7UEHwGq
         mIqKci9H7PS2vbsARQlnvfdHwIFcDchRbqGbPM+fLQmmDD8g+hCPgajjSu3TQEeTYC91
         afzZ/9RanLY0kpl9qkeVuFP8Trc2KO7IxvMXJLEVpReK2u6o4rzWRFI9UpRosPcrix54
         uWov3u7PqRsxwACzv3mUAceiUUgwndhDCN5tAoBbMg41cwsDFc+EQ6C1sNp1YdMlimNU
         4elsRIARlJjC7DrkWkGrM3H7bpVfJAx0Jmc1zgik0cHqLAACmZq9/J7QPM40fBZPGHl4
         mOPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680114775;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=egd9q+CbRMibBt5TSrqyVnWEObnCEd9/4QE0Gp6MVfs=;
        b=t/XuSKAahZPp9bFrdnS2G2CcIXJ5RPaY3pkTGrlN2x0plJcKQjuGpqTgZ8uZnPiKlj
         pt3rpHFS1l99QLsxOqeWFA/mpequyVhaoXbuT5upR0ap82Dtsc8yW9z4gGZYtFun2fBu
         5ZT2fVAOjb0jk+wozUnNjfWncOQTaGINXuaEPIndnS2ePqPmdSZD5lf1TTeW3fPBZTFH
         n4uxwzHoKgjTNvi6qzf6vtanYZZzbkUbAOAeNpE2kP1xX5l6Bu4lnG4msbFQyMg/MyDq
         Ez1XaVFb5u6ziKKbamhP6U8j66GeDloVsFDdytfAva6Hyvw+m888mA1zRHfMcTZrv9ex
         jeYQ==
X-Gm-Message-State: AAQBX9d+2ZxWOelAwPLZJvueNXHD66ELBqB/BushioxGBix/Km7XF3JW
	GvVS2nnUafRj5dZ+Yq/7Mg==
X-Google-Smtp-Source: AKy350ac27knldBvE8WaHFPL3u35AL/1z5Z6dmSg6iZq1/MBc5Ua9JwEC/6jNyJ6iw/jvTh489EyEg==
X-Received: by 2002:a05:6214:5299:b0:56f:796e:c3a5 with SMTP id kj25-20020a056214529900b0056f796ec3a5mr33658618qvb.4.1680114774995;
        Wed, 29 Mar 2023 11:32:54 -0700 (PDT)
Received: from [127.0.0.1] ([172.177.114.138])
        by smtp.gmail.com with ESMTPSA id qh5-20020a0562144c0500b005dd8b93459bsm4832195qvb.51.2023.03.29.11.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 11:32:54 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <93685516f6f6d543c831013f957a03a21f774fd9.1680110912.git.pabeni@redhat.com>
References:
 <93685516f6f6d543c831013f957a03a21f774fd9.1680110912.git.pabeni@redhat.com>
Subject: Re: mptcp: fix accept vs worker race: Tests Results
Message-ID: <3fbbf187-4ca3-1da5-cf3f-6aca5c971b14@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Mar 2023 18:32:54 +0000
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
  - Unstable: 1 failed test(s): packetdrill_syscalls =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5132270852374528
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5132270852374528/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6258170759217152
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6258170759217152/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_syscalls =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4850795875663872
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4850795875663872/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5976695782506496
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5976695782506496/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/de04f3705017


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

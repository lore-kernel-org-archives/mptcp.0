Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E397E
	for <mptcp@lists.linux.dev>; Sat,  7 May 2022 07:48:23 +0000 (UTC)
Received: by mail-qv1-f49.google.com with SMTP id h13so7008088qvh.0
        for <mptcp@lists.linux.dev>; Sat, 07 May 2022 00:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=GXpjtIiwUtxsAjGQqugFoqXl0XX+PccXHnH2tV+kTQg=;
        b=lyn322vzWdfkcYr73yRIMubH2ZLJrKCN/37adeLCb+2UEnuMjdIIQiMLOZIDcxCrv4
         3l1ywqALLM6n9QS8zi4cOaLgc/+sZdng5B/fwZfBdpSs/FhfQRLEyQYXpNskLkroQCq5
         IsdaWso8K2sWMzJwl4jr1TxMvDgv0Nacvh+lNEOq390bbcOxR+yussNjZ+rhXr7EAdau
         AJ3rfYzcV0enwcX8On7QlN+d08MhHTRgBNpHMb2wkDx/fB95bx6OxkfQYlh/XG+cH2wl
         fi0O7Z69pv6W45QjbZy+x+exJW0KLma9yrrD0yclRdqeia8dDhbDbQZerPe4A3kYKf5Y
         i61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=GXpjtIiwUtxsAjGQqugFoqXl0XX+PccXHnH2tV+kTQg=;
        b=OkyhiA/d9fd/RzZKJDULyImWW9sHXQW+mQ5HVJMvIn9NC8hRnmTBs5cw/4n4jws9xd
         NxZr3qDpe9zwmsS2zoQx5knpaguyaU+QHthovKqyrpY/eBuST+5deLaJmifqSWvrG9i9
         vTqKGinUrL9nA/1c8b5oAlgm7jwlL/ws5eF0miNCV5/xM6rQiN/dP9TBp1vP3ae8Cqad
         e6NTmV47iBYbr9iY/3+ss8IDNyJzRG0ZVBfsvof56TnU0h1qw/KYo8JfXzpeXkv4uOCF
         zx8217bO6THqKOEje8QI/a8mI3gGyxj4o7ESYJN1GVZXW/ZTWJzrE2IAYzPHKcKkPVSn
         jH2g==
X-Gm-Message-State: AOAM531cXmMRqutMFodYBBfhAVmp5ARrCEFTq/l9Piub0Nso8Y2MDyQl
	CIjK67EEDe28oJzNAZ2eCQ==
X-Google-Smtp-Source: ABdhPJwM+pPXiFDSv9o86v8Cr5v0h8c+oNDbeo6Kg0GKqn/4htQfFHVI3VgUQK/HAOs+79fr/aCO1w==
X-Received: by 2002:a05:6214:1ccd:b0:443:652e:69d with SMTP id g13-20020a0562141ccd00b00443652e069dmr5651402qvd.114.1651909702153;
        Sat, 07 May 2022 00:48:22 -0700 (PDT)
Received: from [127.0.0.1] ([20.62.112.106])
        by smtp.gmail.com with ESMTPSA id r184-20020ae9ddc1000000b0069fc13ce230sm3699940qkf.97.2022.05.07.00.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 00:48:21 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <c69a81a2105542dcd9979f4d722e9d47233ec851.1651904180.git.geliang.tang@suse.com>
References:
 <c69a81a2105542dcd9979f4d722e9d47233ec851.1651904180.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests=3A_bpf=3A_a?=
 =?UTF-8?Q?dd_bpf=5Ffirst_test=22=3A_Tests_Results?=
Message-ID: <505b5a28-7438-7506-8a67-d140ae9693b0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 May 2022 07:48:21 +0000
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
  - Unstable: 1 failed test(s): =
selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5655336475426816
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5655336475426816/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s): selftest_diag =
selftest_mptcp_connect =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5092386522005504
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5092386522005504/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/1b53ef6d4efc


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

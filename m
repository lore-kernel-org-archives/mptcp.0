Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A867B
	for <mptcp@lists.linux.dev>; Thu,  9 Mar 2023 02:56:59 +0000 (UTC)
Received: by mail-ot1-f43.google.com with SMTP id a4-20020a056830008400b0069432af1380so315338oto.13
        for <mptcp@lists.linux.dev>; Wed, 08 Mar 2023 18:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678330618;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QhLRI4EqoXs+Bf1avXg4/Z7wTcHhPWgeMRFfW4VVEb4=;
        b=RdsJhuW1dxWTBAt4h8QbNEhxaapwWRmpQvVxrKRNfof0g12TUdiWNWUPs2gxKgREHr
         LtipLV2U9+cBSDXcW6QE1OmOMim/lZFBBeI9WHcOD8ObKEevRVGbfhwivIIKfO5tdPEq
         sd1bYyNxSVcANEioMH7FvosxTpSQvCZrS6RxDWNBL8glLOyfiX/lswBEDJW9qGdT7NJj
         8J+x0iK+b6H7i3LE5vraxQ458hyvqtKWQxYuyypq5LnKQL5ZkWSse3Ko8eFXS4AyCt5l
         QCoKUWqwoA+dCZhAT5wi4WpMpE9fHLzp7oaupKZR+h801WZtFJqL6Nm6YtXhgToaDGF9
         yLGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678330618;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QhLRI4EqoXs+Bf1avXg4/Z7wTcHhPWgeMRFfW4VVEb4=;
        b=h6uSO3IIirZYymFuQj4VTLvGdYS8XHVjvrwImu0OEJRw2ZJf1Eh8eMTM0fbMdBGWEQ
         45UGDIA13vuzt7Gq2xEiD367MEz/67Vxcv4nmPIGQDfMlSUX0aKuvoKgy1XCN7BLlERY
         852uZDowBth9wFNLGe1+4Nu8UpfG74wiDJogk6xUq91cHM7Dt8mnv+O1xCW+zdzZfBhC
         +wWh2GkZZDDpRuy8IVuCX7UKr68RodmAmO6B1fPHnpD7FHZxW5bOkHu1+IwzoxLnErSH
         sgKhp7LmNPhW7iNuEKlTzRk6cB7LHus9WCMkjYi+UTuk3d7vKcHxfIg7CKsNF7Dc+J7r
         Tb4Q==
X-Gm-Message-State: AO0yUKUFDIxAnloxN45HPnxs3ZmREp5OA2uEiXghvXTtUkDRDJwM/H2F
	pSLDcJcNbTeeYTcJ5190sg==
X-Google-Smtp-Source: AK7set82LCJWvazCOn+T+VDcZ1OaT2SO1KVL7pXP3og3Ru6KdCag3e4gEAYFsANDb6amOItNiwH3KQ==
X-Received: by 2002:a9d:7103:0:b0:690:d498:56d2 with SMTP id n3-20020a9d7103000000b00690d49856d2mr8446803otj.4.1678330618548;
        Wed, 08 Mar 2023 18:56:58 -0800 (PST)
Received: from [127.0.0.1] ([104.210.133.26])
        by smtp.gmail.com with ESMTPSA id h27-20020a056830035b00b0069488fab83dsm2240655ote.42.2023.03.08.18.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 18:56:58 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <9b5a84ef14899800a8a0036cceae0406e016596f.1678327360.git.geliang.tang@suse.com>
References:
 <9b5a84ef14899800a8a0036cceae0406e016596f.1678327360.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: add mptcp_info tests: Tests Results
Message-ID: <02747bfe-f5d2-f946-edec-eb7b049df495@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Mar 2023 02:56:57 +0000
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
com/task/5535635054788608
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5535635054788608/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5746741287321600
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5746741287321600/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6661534961631232
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6661534961631232/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4620841380478976
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4620841380478976/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/f0fad2020aab


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

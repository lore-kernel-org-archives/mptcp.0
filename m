Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02840EC1
	for <mptcp@lists.linux.dev>; Fri,  9 Dec 2022 10:35:03 +0000 (UTC)
Received: by mail-qt1-f177.google.com with SMTP id a16so3230063qtw.10
        for <mptcp@lists.linux.dev>; Fri, 09 Dec 2022 02:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6cbtJgpR/Y9WfhSAHZ3csh9RC+8YPhJGfbXj10T0Vb4=;
        b=j3Xzl6o3RDqlgszP1Kwf8yxT43So2GBmjIhRoE/r2n90eHoMieCZQfbhlmgJp5w7GM
         qHk9Pb2LL3/9e5cR9j1AetZCUCmhxjYhbqUF7dij95uBEeYuWGbKo2sVJufqlxKSsCF+
         FXZFUwfjUftv5KGRPWn6Bes6BJleH6AWWyRzhytNQNl18FTtNrt2PXMFMNu0ofDkUYRz
         wq9UGEOM8zujzIUDkof6IMvQpAB9KQNb7vIBrlABlM50cTGnCMibyqu8u3AcrtxM3hsK
         dZnU4eWsZILoZ27GtbHXbtjhHoqaAIqLX0BUVSrcV3QN26Aae2360K6MfU7Moy/HXPkH
         IHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6cbtJgpR/Y9WfhSAHZ3csh9RC+8YPhJGfbXj10T0Vb4=;
        b=Wg1PK3G3v49jVicq0s37BwcHUX3uuBNy9ID/X+x+YQeBhioy02Z7sr6jffxMqAM3dv
         sNIaXFCBV11j77izHlOMKg20+UpL4+ltp8ItsoNOTw1ofk4gruGi1QqdoPJIA+1G96S4
         35TZQBjRn9WYX7z2k9R0QIQ974pA1RBNso/nbuM8A2o47UYi3s/C/BcH/zVZoZNXzy5K
         OU5kUEdt3edpBe72W5ECQiQqdsflu5hlpypUM8vbuNz5fi9f28mGz9ZnxnHlab2FASbJ
         c8hXYmu0eBQrxoBXCFOSAnQJ3ypoBg/Gnbyqy2n3sVSXThSRO73egVwIcIF/0RqTUAYh
         yf0Q==
X-Gm-Message-State: ANoB5plriyXsHjHlVbNN2zKy2VXcLDebXoNEssiSbRoZbv1i5peAosve
	eb5IuDwGp5vzJ+yWGgN1Tg==
X-Google-Smtp-Source: AA0mqf5QucD3DsL/HFmSYScyQCYJC6hKui/utjES/63oWXAqbMT+l5zywcZLTm626U+TZPhxYSto1Q==
X-Received: by 2002:a05:622a:4d06:b0:3a5:20b1:e306 with SMTP id fd6-20020a05622a4d0600b003a520b1e306mr8832838qtb.16.1670582102881;
        Fri, 09 Dec 2022 02:35:02 -0800 (PST)
Received: from [127.0.0.1] ([52.255.184.69])
        by smtp.gmail.com with ESMTPSA id w4-20020ac843c4000000b003a606428a59sm610371qtn.91.2022.12.09.02.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 02:35:02 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <0802393e224df13d9ac71e5fe7524e40d262b8b5.1670575887.git.geliang.tang@suse.com>
References:
 <0802393e224df13d9ac71e5fe7524e40d262b8b5.1670575887.git.geliang.tang@suse.com>
Subject: Re: mptcp: use local variable ssk in write_options: Tests Results
Message-ID: <37eecc62-d6c2-ae4b-53bb-efc399da2717@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Dec 2022 10:35:01 +0000
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
com/task/5379541095415808
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5379541095415808/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6505441002258432
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6505441002258432/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4675853653639168
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4675853653639168/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5801753560481792
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5801753560481792/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/f35030a60281


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

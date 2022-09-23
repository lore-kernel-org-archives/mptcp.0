Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C1F15B0
	for <mptcp@lists.linux.dev>; Fri, 23 Sep 2022 01:49:50 +0000 (UTC)
Received: by mail-qt1-f172.google.com with SMTP id y2so7588256qtv.5
        for <mptcp@lists.linux.dev>; Thu, 22 Sep 2022 18:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date;
        bh=vQ96nswQMOV8loZdUxQcjLLCHZLBdoNxfbRQBCzKKTA=;
        b=X8oG5vCbJwgeeyNhou+MapDx828NgWbJWzgSO8bYLnSCgXm4f1QzVJ8o0j+IMJ/Ky7
         3c6QxWHDghra4mLmr8chPcsGrC7i6gH5j6SFhYFyh454fuWWVKRlB+oq07S0sSV5KfnO
         TdGuTed5ynp1aJLHJHcEt1IDtyAHu9zOE1t897VkDyNlM1lDjjYyZ0y0pbYK779hVMJk
         V3rZg1j369RSI0oXL4M3cOCM+SEeQaPyRHpWj2yT5JcRz0EoqSR56DGXKFXdVihdvoKQ
         Hoj5dgctvFgKteGOXEc9xqDBf1MifUroRlJvQSg8D+6HwFYimyJT6KH+2hV6L1OTkeP+
         lBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date;
        bh=vQ96nswQMOV8loZdUxQcjLLCHZLBdoNxfbRQBCzKKTA=;
        b=1gYcqtzAOmjpQaHzIxvFbKK3AWz9eG3FUZLhKDkEqfEumlHOmWYOUaO5u00Wufzv8M
         kH2hLQ5dqGUhmymCAbOGFWWdDEZaCtAeItfcUCR9d7u1uJKOj9ssoURoLPHlIrkpCutO
         RmAdNFAvwfog0bbTPoMRjgwvvDcLUKn2VmSEr+VMu0wZmYI8WYZZLqJXEEowqvbX7nOl
         MCn1ZAhiQzubXMQiKNJB75zGATbb9UwHSsGTfaUggh/yJI1PtLKhV4KZaGwez1eBxgZi
         JwfSbhq55Mm8qENvkrzhzH5hlrMX0cgRP1POJA4OmNbiVfmj2MXxRs27qzfrKNuO3a1d
         1UnQ==
X-Gm-Message-State: ACrzQf3M89CbJIQfkTX7f7eQ29q4W04Prbdec6+o1xkx48eJg/Suj+5o
	Wqr0NAtmaOHGqNTsyTLzcA==
X-Google-Smtp-Source: AMsMyM7Vecs3uYx91KoD8FqGBDIz/fUXTDr+Jm4iyG6VmpETfi5Sb4oQUnImwXhPHw58kvhyKxS1eA==
X-Received: by 2002:ac8:4e8e:0:b0:35c:f6a6:7c8e with SMTP id 14-20020ac84e8e000000b0035cf6a67c8emr5431354qtp.373.1663897789826;
        Thu, 22 Sep 2022 18:49:49 -0700 (PDT)
Received: from [127.0.0.1] ([20.1.196.107])
        by smtp.gmail.com with ESMTPSA id v19-20020a05620a441300b006b945519488sm4780602qkp.88.2022.09.22.18.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 18:49:49 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Dmytro Shytyi <dmytro@shytyi.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220923001530.9722-4-dmytro@shytyi.net>
References: <20220923001530.9722-4-dmytro@shytyi.net>
Subject: Re: mptcp: reuse tcp_sendmsg_fastopen(): Tests Results
Message-ID: <7ec77f05-2684-741f-001a-cc8164a8dba8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Sep 2022 01:49:48 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Dmytro,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/4837384788377600
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4837384788377600/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s): =
packetdrill_add_addr selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5963284695220224
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5963284695220224/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/d6a6496543d4


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

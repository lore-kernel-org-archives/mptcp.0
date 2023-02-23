Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0367A2F2A
	for <mptcp@lists.linux.dev>; Thu, 23 Feb 2023 17:32:49 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id h31so6051914pgl.6
        for <mptcp@lists.linux.dev>; Thu, 23 Feb 2023 09:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/EYtKqh8lKl+cYguSy8IIS7sMjGSP2YqfIJc1dU4cQ=;
        b=MUhzl7uI/6o1bXdmmdLCz4clw0IH4CuWrN3X+VOKO7zTiPtPazB1kCT1oQIuVVYLQP
         SHaR9OmOaPlSjXAypC4ot2+EYv6MphwAyMNqXuh7AmWl3nrRN0EdiWm1iGMDrTxi3zOQ
         RFEjHWf9d23XUAxGrvOTQ1lat5eWKnM+P//XcDFxb5FJ8msXSH6epLQLgrPes9KV4eF3
         DRFbZFMWKmoZLr/G9/Q3bfW4gK68hlUxMBwlA0va7WPifA4E89nU1WLL9aN+N3HON6T6
         s2ng6KkvD3dQWWzgfep/Te/OAh1HwmhNM2S/lhhK6aBKLlD/kkwM771FL6u1qLsi9/F4
         nbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B/EYtKqh8lKl+cYguSy8IIS7sMjGSP2YqfIJc1dU4cQ=;
        b=pJ7LdLf+J7A6T6lXq/+WvgbpNfxIJ+OAN7+2Diuwk9zHYpNfIIT4xKZUTDw9+v9ik7
         LFndr+WpTSkJttFGUS9HTH/0N4xljqVPByicGOSuPjIn7+4PTQqJdWVbEi5wtryXHc4h
         yOV6a4AVwyzvxYuS4PbBMvwV6EZdXTC6wRu5iz7o5WG3dsXJlQEztj09/MpFmPyZLUgr
         KnMG2BSF3Ug7/xOKl4fXhxpzRF4q2KOUpAXctLRsTd8s95S1E7MegFtSRqo4sEDeNf3k
         k5HrhOdJqj9ZQNKZSVJfevWY2qWXCT4XFUDG5YJrH6BeHxTpXcyiIYOWOS7cka6+pMZi
         Am3w==
X-Gm-Message-State: AO0yUKU9fJu11hLC/F1z9eLbB2w0g+dvQLKJpO//B5tRth055VhuXrxJ
	eVXeOu10ikgwCI193XAUQhBVRA1Xwg==
X-Google-Smtp-Source: AK7set89HlhLF5MIil8aOQxA71GepprZHY3UKtErCwJaZ2wwq/79nAXvazrHJYwYV/iE98nYjuoz3w==
X-Received: by 2002:a05:6a00:4194:b0:5a8:cc39:fc58 with SMTP id ca20-20020a056a00419400b005a8cc39fc58mr11300732pfb.6.1677173569213;
        Thu, 23 Feb 2023 09:32:49 -0800 (PST)
Received: from [127.0.0.1] ([138.91.230.179])
        by smtp.gmail.com with ESMTPSA id 12-20020aa7914c000000b0058837da69edsm6276594pfi.128.2023.02.23.09.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 09:32:48 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20230221-mptcp-warn-tcp-done-close-v1-2-d248242b29b6@tessares.net>
References:
 <20230221-mptcp-warn-tcp-done-close-v1-2-d248242b29b6@tessares.net>
Subject: Re: Squash-to: DO-NOT-MERGE: mptcp: use kmalloc on kasan build:
 Tests Results
Message-ID: <742ff8cd-8ad7-17e5-4662-4184fc0dc2c5@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Feb 2023 17:32:47 +0000
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
com/task/4764422489505792
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4764422489505792/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6453272349769728
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6453272349769728/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5890322396348416
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5890322396348416/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5327372442927104
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5327372442927104/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/9877464ec3e6


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

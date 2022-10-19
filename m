Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AC228E8
	for <mptcp@lists.linux.dev>; Wed, 19 Oct 2022 12:03:09 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id m6so17052803pfb.0
        for <mptcp@lists.linux.dev>; Wed, 19 Oct 2022 05:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6CSpqkBkTdbbJiKX3nvD9+aRePkoBomkCbjFhOoFQI=;
        b=E5UfmgTWPexBeUjUTwHqAnCK3eP04E8IV+H58wT4FkhCG6Q04S1DMjOR+NmEOl5jNi
         PMsYjz5UXrUVWgflUc0cKK9sfbaAAqFtJJFe7Rg1xEFZU+yd0MIYwiK2lbOc8P/Pr28T
         a72dZPNxljGXlUHdV3YkojMjLdbLz9sn26Yk7JAvyhA9F0rqcVivojIHT9MTAg5W++CC
         +WZ06MEME3JU2mlTOnZBPuwCTDm0j+mulUYO3rPgJnB2vIhVrjg+wsWd/AP6Fz1TqXAe
         trwKB9w9rcDufwsZ+z7XEwi7NhKFaXpZI+r/1bIQWXNs29sUBgj5SHCvDkzazeGL6LZS
         X5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g6CSpqkBkTdbbJiKX3nvD9+aRePkoBomkCbjFhOoFQI=;
        b=civKbccCsBg+MY5DhvMhEW7iPABK1/aQ5k3nPs3wAdGShV+Rit0gP1i5WoxUfs39ri
         EaUQyF9M2ClnzgLLBmQOh4meQxu5TTwkcNUSY9BptOcgJSS9nKQuc39KBVK0RUFXcl4S
         CEYG88IKAaFleRZGuwoZKfTwaGlHphuiniHKNDBgjek5+SIZ8IUnmycepsrWiwa+LIcq
         M2im3AHHc8KldUpj3cOd/EfNPvHW+OuY9FhmZPOU5SGiN026zR8L6QIBbg+Dt7hBiHyE
         P+SzDpJlm5rc6lLLx6biDL6Fd4Q2Rrr4YugKvMvKF/ExvR3aQj3lsrexmFasYxGaghkV
         Gvbg==
X-Gm-Message-State: ACrzQf0CydH8pa3k6IBd91c3ioLhoqvXU+/tc7sf07VkbZ3OBtcRp35U
	rHRCiagG8EF+4unBMd9a+Q==
X-Google-Smtp-Source: AMsMyM69QZv851FMw+hR7WH+EeS7UbxpHaVwK1g+p2sMTApcJo/XRG10YdUO0xW9L6xZj5IeTOj5DA==
X-Received: by 2002:a65:464b:0:b0:42c:b0:9643 with SMTP id k11-20020a65464b000000b0042c00b09643mr7121211pgr.232.1666180989417;
        Wed, 19 Oct 2022 05:03:09 -0700 (PDT)
Received: from [127.0.0.1] ([20.245.174.141])
        by smtp.gmail.com with ESMTPSA id i3-20020aa796e3000000b005625ef68eecsm11149816pfq.31.2022.10.19.05.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 05:03:08 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <dafe09ca2e14c4ab45f3d9db56b768e06750e382.1666173045.git.pabeni@redhat.com>
References:
 <dafe09ca2e14c4ab45f3d9db56b768e06750e382.1666173045.git.pabeni@redhat.com>
Subject: Re: udp: track the forward memory release threshold in an hot
 cacheline: Tests Results
Message-ID: <ba705d5a-f8a6-3270-40ad-b9b3a4a5b544@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Oct 2022 12:03:07 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 2 failed test(s): =
selftest_mptcp_join selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5122545217699840
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5122545217699840/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/6248445124542464
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6248445124542464/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/bac2aa631e4b


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

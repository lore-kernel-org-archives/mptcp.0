Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8344F7E2
	for <mptcp@lists.linux.dev>; Tue, 25 Oct 2022 02:20:41 +0000 (UTC)
Received: by mail-oi1-f182.google.com with SMTP id n83so12753988oif.11
        for <mptcp@lists.linux.dev>; Mon, 24 Oct 2022 19:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6VffDsQLcKYLv9aOqoqPsZiMIwsyKwmYJbMR3qvicU=;
        b=p/3Fd7ZqgQsqifYM3CR83VB+JHCL06GhY7yV6yrjNXS0Rp0lI0P3smjK0ZMOBFvSgi
         CIfpLmftetqZwVigmub2AhDrYTA17YjC60Rd/sjpEhqted3p8vG0IICSpJV23o8VKLMj
         Sz3q2HZuoLzTH2aa21Kj2J0GZCToM7adAojsUt0f0gblAZS6AjOdKCLWOpkqSzLIP/ly
         vYe+Y4h8ImC26QkDlIC+3Qi2xEgp0bt/BR39fyPzBD39T6DVfE4X3xZhwU/uEBDqG4AM
         PrrNH/A+JP/+eZR+nUtCccDC6tWUXXOxBLhLqcHTnGt3D5ikmD1w7WpihXtnNDhwVmyi
         Cy/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W6VffDsQLcKYLv9aOqoqPsZiMIwsyKwmYJbMR3qvicU=;
        b=vTit+rAsNhiWixo1uIeHB1jHqOxcAAqhFJaGI//fwBpH9ZXu8De1xlkO1Ko1H1lpZ2
         5c1/OQ+IK5taaxEIbuGbYA1e8afHJnM+nlWKlahPrFBfOMV3HhatsLz6pQmtQ6VJLRcH
         VQ87pJYaftmOZSlFZNzyh/iLCtZx1WbYYzgAxiaDR5qYTeTv+pU2aiM9MIdL2psQirME
         WCr48lCfw8rILPedBJUm0Q4DwWjgkQHSTzhuzkkuSRF6+YlhQSSE5SFGi0RdAxe/I+ce
         7L0yhscY41dm5z0HmpYaQ1QkyYCmMR0tZJrRselRctAmBuYVw+34tNP5Py4f+VYIBC66
         0ZlQ==
X-Gm-Message-State: ACrzQf26KwVQAyy65/2+Qj0ga4NG18U/bCH4Lphh45qGSskk96mQHxLk
	r0L7iBxHmQN7qIv0UqjSCw==
X-Google-Smtp-Source: AMsMyM6rC91U1F9CF+5ktVgEDB716UkxYXHZqR7ZS3AewINMJgP1yrdpUueQsE8DzPX5B2mlH56O/Q==
X-Received: by 2002:a05:6808:1295:b0:355:367e:d2ac with SMTP id a21-20020a056808129500b00355367ed2acmr21084888oiw.223.1666664440586;
        Mon, 24 Oct 2022 19:20:40 -0700 (PDT)
Received: from [127.0.0.1] ([20.97.14.209])
        by smtp.gmail.com with ESMTPSA id r25-20020a9d7cd9000000b00661ac94f187sm497470otn.42.2022.10.24.19.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 19:20:40 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221022133528.31996-1-geliang.tang@suse.com>
References: <20221022133528.31996-1-geliang.tang@suse.com>
Subject: Re: selftests: mptcp: use max_time instead of time: Tests Results
Message-ID: <23b5db67-91c2-cf93-95f3-81ed842c55d9@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Oct 2022 02:20:39 +0000
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
https://cirrus-ci.com/task/6536517840535552
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6536517840535552/summary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/6259775448023040
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6259775448023040/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/4f37eaa09fcb


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

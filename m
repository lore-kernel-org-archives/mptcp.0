Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530731FC0
	for <mptcp@lists.linux.dev>; Mon,  9 May 2022 16:48:32 +0000 (UTC)
Received: by mail-io1-f44.google.com with SMTP id z26so15963639iot.8
        for <mptcp@lists.linux.dev>; Mon, 09 May 2022 09:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=vE9gWrIOGyVkXXXfqaV2b2a7Q8TKiLVMfJbn9w6GtSk=;
        b=OGpWvOD0jXgX10RAffU/fANQPfRDtkesSoBz08xCHJlD/34mqrr8FnD+YHu/jdniX3
         dhFiSVdOIyWetFcpavAkgaakg9jrmueoqkYkI9K+MuFlDWvKHLb/cZx2+vC/PADni5Kl
         zkAaMg9OqJY32E1TY5Yw0lTsYhJYJHOA2Lci7FEH9VB/wExHf84c6ixtX9nrf5WvQ6uH
         qsPinkdNTyzFRgFqYVCUZp/A0uE9cAh0cT9kF3DSkdNCyfNYgnE3B3u6GFV9CKU6M/gw
         TwbYcVWOelWHUMqr8h78H54ijrkcr3yqcmOtbz2IJrMtVxOoGyASlmveklv0eYn2KoHU
         HIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=vE9gWrIOGyVkXXXfqaV2b2a7Q8TKiLVMfJbn9w6GtSk=;
        b=TBRXtlykqoCDWresQeA+tg1j4Nx1cY0imzfdiS6NV/mEXeLBISPJW8wP1ky6rT63VH
         xOupBypwPOE2VHpUOISLpjn/MaFdgejHWsKPvtnHSyz0GP3S8Onzag695vb+kaIbWf0f
         U3U/3nVu5Ri6CTrmIerZFd5zI1GXWjhSH8xkDrRLZfd1kM9P2li/k2hku9rd7kktOdlr
         v3c2kOm8byLZgWqXL23xge3+pw5GroXiOCT5TGHWp20ehqgUUbq0PzqPaDXmr1JdAdXN
         PQ4FRjx+N0BHFE5xfakJ7khkFd+Xq/uU/3fKVEfCnpXQrAErNi4xfAjJPA7OgnDj+RMC
         Cxrg==
X-Gm-Message-State: AOAM530IGeK4X4v/8GtjpSubMXzXqqET+diQuUu8g0n2BIwMzrdyLZPr
	MUPIni0fmL6XpY6uB4qI+huv0GEP4A==
X-Google-Smtp-Source: ABdhPJxTYGOlJL/Ys1w/hToxds1Y6blK6K9tQvxXckUAfd8yaX1gcdLXZhDX7wMWd5fzJzDfK17sCQ==
X-Received: by 2002:a02:a507:0:b0:32b:543:d66 with SMTP id e7-20020a02a507000000b0032b05430d66mr7218025jam.146.1652114911342;
        Mon, 09 May 2022 09:48:31 -0700 (PDT)
Received: from [127.0.0.1] ([52.173.183.144])
        by smtp.gmail.com with ESMTPSA id d4-20020a023f04000000b0032b3a7817a3sm3682331jaa.103.2022.05.09.09.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 09:48:31 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <96f9ac276c4f24d2ef189987522dc0c987266c94.1652107942.git.geliang.tang@suse.com>
References:
 <96f9ac276c4f24d2ef189987522dc0c987266c94.1652107942.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: add bpf_rr test: Tests Results
Message-ID: <50b3a977-8bea-071d-0c95-e9f3c6f479a3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 May 2022 16:48:30 +0000
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
https://cirrus-ci.com/task/6702307382394880
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6702307382394880/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): selftest_diag =
=F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4556060684976128
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4556060684976128/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/4c681daf367a


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

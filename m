Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C542F32
	for <mptcp@lists.linux.dev>; Mon,  2 May 2022 19:19:03 +0000 (UTC)
Received: by mail-qk1-f181.google.com with SMTP id c1so12074071qkf.13
        for <mptcp@lists.linux.dev>; Mon, 02 May 2022 12:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=q570yDlT9/XhwN9Jb1yAQGyTh22FzsB+PIS5SDA2WBU=;
        b=b212Ziw+xCvgMlcvq4E/BIhQcglszGntzUGVnDSX7Sb0Me1d3AkdHoPdFpJiQvrswK
         T4gP79qwtFBv78G71vB+7YD4vwau8kTI4Ud0KtqIpZ7zKmKKo4Dgzi6+PjbKAj7uSz5Q
         3q3Wtvcn8hCciws3IusNgoSd95wAAc3BJJNuBeUzOr+5xEO8IZUehzzGltAPT9sJGYnB
         JnsGzeU//ppuGongkuCk8b/YbcphmU3nu5aJasUB856hV5KmYl01NrqdPNSeXsNG5vJM
         GNEsaoQpzHWBl8mkpWEPYeN/dNKO34NjCC9NyI9nMLRd9B7rtx+53vZYBGN5Qo8JGURr
         9OBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=q570yDlT9/XhwN9Jb1yAQGyTh22FzsB+PIS5SDA2WBU=;
        b=6/C8sVxMKOv1xc5zmZmtCCrBch1eBmuiEB1l+SF21XuRzre3Q6lZKvaZxgGMmPvXEA
         /PMYcZoSRoKO8P+Dk0iAVURO/F1YiMvDufA/kHpgUyoVBdvTiE92PTnHeSOqLEm+HYle
         ef4ASo55EX0/NmKRvDRlLbBG+cPFUKq+hjdZiDWooklyVHXSF4umJT6JVqppRXO8Z3u0
         SxA9Uf4vGJCA/bn5fUaGeIUvmTX/t3r4BY0JnbIWvJMLUq3xXBPLptr+rVbqmWFHbCEf
         86c8OqWem3BgEU5x4K9EmdxR4sz49N6zFldH0Xurr/po+ddBmdOhaKA4vAqBsC/qM9Qf
         DUVQ==
X-Gm-Message-State: AOAM5301JjgtajIx2WQkujkC90aN5p/BQPRQYyT1c89qDoMvaAB2WiyB
	ear7tm9Yon2ohuRCZJroF3+N0xfB9A==
X-Google-Smtp-Source: ABdhPJxpamOwmPmfV7CahsRE/yjPkdueuRHDkfAmJxK2sljDTKbxxwic6SJ3d6sfOhf7+TTTglj3Bw==
X-Received: by 2002:ae9:ee13:0:b0:69f:3130:643c with SMTP id i19-20020ae9ee13000000b0069f3130643cmr9745246qkg.22.1651519142160;
        Mon, 02 May 2022 12:19:02 -0700 (PDT)
Received: from [127.0.0.1] ([20.25.78.186])
        by smtp.gmail.com with ESMTPSA id d25-20020a05620a167900b0069fc13ce1d6sm4607908qko.7.2022.05.02.12.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 12:19:01 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Florian Westphal <fw@strlen.de>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220502163624.6110-1-fw@strlen.de>
References: <20220502163624.6110-1-fw@strlen.de>
Subject: Re: mptcp: sockopt: add TCP_DEFER_ACCEPT support: Tests Results
Message-ID: <558e4939-6555-f8a4-c673-5882aba241c4@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 May 2022 19:19:01 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Florian,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5574170854555648
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5574170854555648/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 3 failed test(s): selftest_diag =
selftest_mptcp_join selftest_simult_flows - Critical: 1 Call Trace(s) =
=E2=9D=8C:
  - Task: https://cirrus-ci.com/task/5084536747851776
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5084536747851776/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/5259e61b6ad5


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

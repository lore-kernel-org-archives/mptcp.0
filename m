Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF0B7B
	for <mptcp@lists.linux.dev>; Wed, 26 Oct 2022 14:43:14 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id d59-20020a17090a6f4100b00213202d77e1so2730898pjk.2
        for <mptcp@lists.linux.dev>; Wed, 26 Oct 2022 07:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUSd7xQYJIBPD3eYGjFY/3NITA/ZCcS35JNl15RsAgk=;
        b=ZdSUaNzQONkfJZkhtvkhj5ExYsyS4VtbMkfaApsmrK3F6OM+LVwKx4wEHlLlUMV+2g
         fYf5qmSy9nxtPPKGzF8QT/78RbzCVaI6aFjCG/zB4OY0T2QS21Xdgf2LMGDaRMF+nicT
         v3aV+CzfAvVTrrXAA6roCGbjM62wzHfrdgipxkd1ghBg/Fwu/WeqCURTJ9IfIyERG7E1
         fziMGWJzAeTrHnAw6H2u5v7YvD5otx/lY8c6YDjCI6rPZLbH3808Ab1qu4pVxHqnhS8a
         FIAHFuEuj1g7XJjGlejxO8CDgISmaVvC0021HaePPvIUCCACQH/xdQArHqGYXaBskSQe
         SW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JUSd7xQYJIBPD3eYGjFY/3NITA/ZCcS35JNl15RsAgk=;
        b=2soG0xZ2KoRHrn9Ba7CLkY2AjkTXo1YJmaN3HdI5sCWXIw7Xzpo2enlCQOFsXXd37O
         YgtZbMpoi24+uzJ699SppAGarnkfVn6cPtf7Heo13FAhSEKIwadRsSeH7AD0ppXJIhdT
         ck5wVwd+j0gtJHflzJs6wP3xUT5/ypP7ShFVQtNlzyYLQFTUHHzeOkxwUqI+llBsKe8N
         58g3J+MrheK3DI9CxHC2NJHCQUrZ7On/ysLdXeK8eR1InrhzMREQ7RwJrIp1kUs6uY0f
         9wubByqIHreuI+Az8yA+x7XkOqQQYhkOwIXaj3xlMdnssfc2FYZu38N/YQmtL0NajpyK
         ar4w==
X-Gm-Message-State: ACrzQf1MdbysGrnYAfYuNBxlG1SAqRVDFJiiKH9AIJ9SKZ+vh8MBsfRQ
	1aP1s7sFouYH1dTMqSIdFA==
X-Google-Smtp-Source: AMsMyM5S8aISUWGCLfT0x9OV0xqii4rMTuHEWaNr/ZbiK8T5j/f92Tmw1YnOTI97f2UYDxFRQ64hGA==
X-Received: by 2002:a17:90b:3b43:b0:211:2d33:685d with SMTP id ot3-20020a17090b3b4300b002112d33685dmr4520197pjb.93.1666795393797;
        Wed, 26 Oct 2022 07:43:13 -0700 (PDT)
Received: from [127.0.0.1] ([40.83.201.13])
        by smtp.gmail.com with ESMTPSA id g1-20020a625201000000b0056281da3bcbsm3164713pfb.149.2022.10.26.07.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 07:43:13 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221026124114.24816-1-geliang.tang@suse.com>
References: <20221026124114.24816-1-geliang.tang@suse.com>
Subject: Re: selftests: mptcp: update userspace pm tests: Tests Results
Message-ID: <ac4f0f79-a681-d79a-17e3-d10d9df61176@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Oct 2022 14:43:12 +0000
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
  - Unstable: 2 failed test(s): =
packetdrill_add_addr selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6262628314513408
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6262628314513408/su=
mmary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s):=
 packetdrill_add_addr selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4855253430960128
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4855253430960128/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/2efefeec47ef


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

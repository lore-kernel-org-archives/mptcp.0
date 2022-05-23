Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A79637
	for <mptcp@lists.linux.dev>; Mon, 23 May 2022 13:33:33 +0000 (UTC)
Received: by mail-qt1-f173.google.com with SMTP id y15so8222750qtx.4
        for <mptcp@lists.linux.dev>; Mon, 23 May 2022 06:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=74i8lvZjc9gw7O/4a1rhySayXe1bNqlsJTRDXk9eR4M=;
        b=d/e0ua+3gmRKPZS7ZiOXycI2CHCZAI4sqI2QbHI6hnWliVzZ6Q1hQ2iNtlWIFHiQv1
         PKX0gL7Zc3dSHVH28a7Tn3MPXEyhBfVfAABpCPCM0q7+6nA6QQ8haQqIYhzATvtRY4V+
         Ey9WQh9AWEwIDVu8gqEk2UD0j9ZO5n1yUDzCxMEdn4hzzxPFqTXXOqI7gNR+5JAp024U
         ApdzYNkWxSDfoZJPGieP4hwm3FqCBrmJOhduY/oalEWIVrVUyll0GzSv7LS7Ikj7jpWp
         56lpzpTZ/z0FK0RRe7B/GrCoC+NODCqGS0nRSLirmuQZEGI2RUSNcLm+feqgbNZPG6rm
         wWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=74i8lvZjc9gw7O/4a1rhySayXe1bNqlsJTRDXk9eR4M=;
        b=rJzgwLCt5zcHFWU7NKRoSTU6rTXrij144dzuWhJYXd5E/LkMBTXQPYL2NvOnZWv7hG
         PFyFAH1OLX16Qr0vy1bgL5rvwQp+L/QOPU6LYmEHsqLBz+OHhSAce4A7xVnTGTe3ATdK
         94Sdctol+WteeJcYFIMrDtw+uTNEHiSfD5MDhmYO0eXJ+J/uwRfMHCydm2KgnNhMv5HV
         du6ajf22EsTwCC5ayd2uyMiOu+VU8ouAg2jb2OFoGlRSVg/+16eqJ1NEPWZbhoArvTzk
         0+VRO5R0RL+pbxlaL/6+pB3/djhYgcBr2mx0chOVal79pFjsREyey1swBOvxakhdgtFT
         akpQ==
X-Gm-Message-State: AOAM531AXyQQGGmLHpoY3c7nPtYViM41X+pOCRnC8kY3B0V/HYCRPm/4
	zKgdfZgAwuGbh3jrtBWv/S+CBbI/PKqx
X-Google-Smtp-Source: ABdhPJxAoPa/rWK8KwibM4VIX3NvbHPJcVgAxqK8sG1daj9TNjJRXmlVwbpQWAX91/UUzE3d7IHaJw==
X-Received: by 2002:a05:622a:1787:b0:2f3:f7cd:f59d with SMTP id s7-20020a05622a178700b002f3f7cdf59dmr15980858qtk.594.1653312812236;
        Mon, 23 May 2022 06:33:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.68.147.228])
        by smtp.gmail.com with ESMTPSA id w6-20020a05620a128600b006a3996e7213sm1491709qki.100.2022.05.23.06.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 06:33:31 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <94abb5c4207ee3fc0827c77816648ad37dccf5d0.1653305364.git.geliang.tang@suse.com>
References:
 <94abb5c4207ee3fc0827c77816648ad37dccf5d0.1653305364.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests/bpf=3A_add_?=
 =?UTF-8?Q?bpf=5Ffirst_scheduler=22=3A_Tests_Result?= =?UTF-8?Q?s?=
Message-ID: <0d258806-96a9-bfde-6bd4-4a75a4fb20d5@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 May 2022 13:33:31 +0000
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
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/4735571141591040
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4735571141591040/summary/summary.txt

- {"code":404,"message":
  - "HTTP 404 Not Found"}:
  - Task: https://cirrus-ci.com/task/5861471048433664
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5861471048433664/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/06c3387f9972


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

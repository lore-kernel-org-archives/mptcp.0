Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96C6180
	for <mptcp@lists.linux.dev>; Fri, 20 Jan 2023 00:14:51 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id p24so3875270plw.11
        for <mptcp@lists.linux.dev>; Thu, 19 Jan 2023 16:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XyBHF4YrRq8YKGid81d5OcTvI9nU5A+xRjWNnYUBft0=;
        b=KaRvmEC+ZoxiA/KzbRdeq7CWMEnO2YfwjG/EjBx3EG4Q+BMYkxoy7YBGRXY6dE6Fm6
         SHvgfD+zP2dw8HlWxSfZD7N7mQc7/DL+wx2QQx6yn/OTtFHVwafG35acigClQ2mgghum
         q/BwGvfSbB7gaVVs9p9lOkOPsedzWWjHEhQhlHnxmhC8p0yQuEzKKvfzc/5HgQhk7zxS
         LKNUp13tBtffgRzr4jtIkeJH1C6/XuWjJYaNPz6ssXgojz5RUzUhj77DtwIZGQjqUoja
         FARgdw+ZhJVOUdC/g7C+//OkfSG4fhVB3yMOzIeDSod/jw09NvmJ1Bf8xFhMmiA5CCy4
         6Hww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XyBHF4YrRq8YKGid81d5OcTvI9nU5A+xRjWNnYUBft0=;
        b=XpqAAb/s8lMXLaP1D3r+KFrRvbTqqDV+NGJ5fCRliDJF1pqn5648v6uBuj9QCctiqP
         5HfdFUIBnSK+8zhETxJp618KtqEZr/FBqgTXAu7daZp9MZSHSbhpsRhJRsvBoiWZbuzm
         H8kug+hbUASGnaJhGGefSUyBXJD5BluH60Fxh4cPUZhl2rQhAH3SadI0+3zw1DjCgCjy
         zK7m2PwpgyNdiTwAQjJOdOswIQ7EnVapoZQWLgE2cB85w2KN5GqtiGRD60QFms9QmZiI
         fB1rzxsG7gSXwU3TzRP96w1hHnbme27bSYuqp4UArrlVFleAb7TYGog6TzgmYRPUMs6V
         F4/Q==
X-Gm-Message-State: AFqh2kqBFgsXZ8jEwFhG/77ydEraIle2cb90HmUJNTKaouAZ/PtzbMRl
	0JjGCu13vSemqPEOgcyotw==
X-Google-Smtp-Source: AMrXdXszSBgxIaD4bvRZsJC0DMxpRSItoEVAgdl93HplEG5lN5GOafZf1/yU1y6IXkTMn77+dhp84w==
X-Received: by 2002:a17:902:e54b:b0:194:7efa:702f with SMTP id n11-20020a170902e54b00b001947efa702fmr17790278plf.53.1674173691042;
        Thu, 19 Jan 2023 16:14:51 -0800 (PST)
Received: from [127.0.0.1] ([13.88.61.210])
        by smtp.gmail.com with ESMTPSA id j6-20020a170902690600b00192aecb231asm25636261plk.121.2023.01.19.16.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 16:14:50 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230119224411.24410-1-mathew.j.martineau@linux.intel.com>
References: <20230119224411.24410-1-mathew.j.martineau@linux.intel.com>
Subject: Re: MAINTAINERS: Update MPTCP maintainer list and CREDITS: Tests
 Results
Message-ID: <a35cbec3-b5c9-8449-a675-3c186ebf1d41@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Jan 2023 00:14:49 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Mat,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6277750156165120
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6277750156165120/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5433325226033152
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5433325226033152/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4870375272611840
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4870375272611840/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5996275179454464
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5996275179454464/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/bfd054965396


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

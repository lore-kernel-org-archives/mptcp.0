Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85032EB35
	for <mptcp@lists.linux.dev>; Mon,  5 Dec 2022 11:26:05 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id w37so10230282pga.5
        for <mptcp@lists.linux.dev>; Mon, 05 Dec 2022 03:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vn8z1sHKZ8Xc+XcK1tJN+535OzGDm4ShfuMVqavtM9c=;
        b=Si1fBA66rGAQ0zA8G+iftOfQJp2wiDxO1eRE7pFwp6S9jAvTKaOlxAKOeldXAotXK8
         OT36XLvt0FO0mU3w65EkTXMczLUFuh1DVYZNQM2x/UHCe0FjBP5ZXsdGLHc8RzPIDMH0
         yZnQwReUgu6lmlusLeP1kwLLr0aZD4zNHVS8lJOUn9T0BC23RotPDkF5bGCsz0Y4dc7E
         4v9CjX7aeCdeoFqBr+/Bv7w5DgtlrD+lnz/F0iauhzei9+QQ5vP50wZh0Fl25C5QUMFX
         xQd4+jL2QVvKe4/je1WtK6oX9IEwS/L+7glTVjgK2cJhXv8MQN3CusjZeDbNs9ksGItM
         39Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vn8z1sHKZ8Xc+XcK1tJN+535OzGDm4ShfuMVqavtM9c=;
        b=A3blVG8yfLtJm35THKd/yVPXROczGIregw0Uj10vfEdUlvY+U5NAM5aNSyxxuiwSMn
         W/0AGZqE0W8Vz/FLjM5ln2Covtvo6ydNJHeEqL3j8qi1BjJ1TFWG8EQYgrhQrih17/kV
         sXEz6BDb2BrVyyIUzTQgFUOQPP/agZF/qzTrgib3TEaHYo9I+9n2qeRyrOq/e9wtte88
         qNvkENDWCTRatdcAq8J8yNG/txUU5SC1Mkz/la+5tZkr6tb7o3zT//XeaORjSQyduXIR
         0F37Um/U4qtFgg7vdUBOCGqEudTfHTtT7UPWIUHVApBxHVT6OYqP4NT8Cw9xUlqcqRQe
         SyrA==
X-Gm-Message-State: ANoB5plNzK5E7A0WjYuscGqkk0lE6ZMMUpT1Lsj5l4otqR3WCWADFWp0
	FqpD6vKwsz/nHJ58vBpZ/w==
X-Google-Smtp-Source: AA0mqf6NPmf3zoUyq1oVoZ8O8QVDxJ2Yx38CyNU0/jYiQ9gAfyY97xpULVde4IOXzSvHIIYi8kSJwg==
X-Received: by 2002:a63:5153:0:b0:41a:4bd4:f43f with SMTP id r19-20020a635153000000b0041a4bd4f43fmr55999731pgl.460.1670239564839;
        Mon, 05 Dec 2022 03:26:04 -0800 (PST)
Received: from [127.0.0.1] ([20.245.254.235])
        by smtp.gmail.com with ESMTPSA id p15-20020a170902e74f00b0017f57787a4asm5690303plf.229.2022.12.05.03.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 03:26:04 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221205101002.2620762-1-matthieu.baerts@tessares.net>
References: <20221205101002.2620762-1-matthieu.baerts@tessares.net>
Subject: Re: mptcp: return 0 instead of 'err' var: Tests Results
Message-ID: <515184ea-986f-04fb-2491-e2179b2dc0e9@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Dec 2022 11:26:03 +0000
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
com/task/6075817906667520
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6075817906667520/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5512867953246208
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5512867953246208/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/4598074278936576
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4598074278936576/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Critical: 1 Call Trace(s) =E2=9D=8C:
  - Task: https://cirrus-ci.=
com/task/6638767860088832
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6638767860088832/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/9fbf63562082


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

Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518221859
	for <mptcp@lists.linux.dev>; Fri,  4 Nov 2022 13:53:30 +0000 (UTC)
Received: by mail-qv1-f51.google.com with SMTP id ml12so3243489qvb.0
        for <mptcp@lists.linux.dev>; Fri, 04 Nov 2022 06:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6cHqKvnv09OEWF7th/+9LPWgpllQnvnSD+opIsN8N2A=;
        b=VB5QFqUFYHv6i5NZmUiH2hoWbl1+nipGbag9h+80tAUoZwisGGGuwwyzY9XilZ8DVG
         m6aqyPCrNF+rTdV5Z7zZ3WAQZ0/qE9s31yBcvQyfQL5cKg6K5AYmQJ81UDBGYCuRVcMA
         q+fS10ljIdCv0XWDxGCMwP7kw33bHJDt4ZsAi1z/Oa5t7H/897DcWL2YNoFxcf0CWgK+
         J591dAKxH8buYsHOH9cBLS4u3Svk9vGLssunE0ebp8i+3kWkrOEPaqp100mgm1lQ6bAP
         wIAudguHXM60mDLLZaEIZcGXIfAkkfIpDhs2Wu0ItnHCKnnye6c6L+wet4O2hqSqzs4I
         4iIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6cHqKvnv09OEWF7th/+9LPWgpllQnvnSD+opIsN8N2A=;
        b=Sykw9uvBisPx+1WtfLlp3+2anm4VSWxGwW5fHKcCBmh7Of8QaYOZGizNYF4UGJrt+k
         YpW0H8xg6LYoHnskncY1qJ9wRH+GMnKTqGYgQKMoSwDjlVJoCigfpAHkYVuyaOzwEBaN
         /oWwRebNx63EMEx89L4SVukO18aBLNNnoFIjrEWg4Yt//peFVBJG5FfjIRq+BRgl7FRa
         6/FkyIu8EQv30QF7X24H1LBpXhGgM0h6pKjgE1pqU3HoSV3ctEC+uAaKoUP005DvdtFY
         v/THc2rfTJB0yqgp/bsARjMq2SR1UTg+Kr/ewzUhJXkrRr+JqTP+JrIxdWcVtuCXnsQI
         tkcQ==
X-Gm-Message-State: ACrzQf3S5dR2PuqYn8S+pF+vdsBxe2lWpcTjL93o5k8zbTdlTkx0Ov3I
	b+dfdwXsDsC6p7oAy8G6VA==
X-Google-Smtp-Source: AMsMyM4xPabQBDm5UEldDLgeTUIGbTNlUqWiyjtGm1eJYMkf/tL9cyNdoMcDYfI1b/kORBFpCu+6oA==
X-Received: by 2002:a05:6214:4104:b0:4af:8576:e65a with SMTP id kc4-20020a056214410400b004af8576e65amr32413517qvb.70.1667570009181;
        Fri, 04 Nov 2022 06:53:29 -0700 (PDT)
Received: from [127.0.0.1] ([52.242.87.116])
        by smtp.gmail.com with ESMTPSA id x18-20020a05620a259200b006bc192d277csm2906154qko.10.2022.11.04.06.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 06:53:28 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221104115354.3413-1-geliang.tang@suse.com>
References: <20221104115354.3413-1-geliang.tang@suse.com>
Subject: Re: mptcp: use entry->lsk directly: Tests Results
Message-ID: <bff36cb1-0d5d-4d70-af3a-4ecb986acebb@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Nov 2022 13:53:28 +0000
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
https://cirrus-ci.com/task/5039064876318720
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5039064876318720/summary/summary.txt

- KVM Validation: debug:
  - Critical: 1 Call Trace(s) =E2=9D=8C:
  - Task: https://cirrus-ci.com/task/6164964783161344
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6164964783161344/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/3dd3db3d01db


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

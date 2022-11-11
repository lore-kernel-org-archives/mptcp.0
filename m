Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17B462A
	for <mptcp@lists.linux.dev>; Fri, 11 Nov 2022 02:59:51 +0000 (UTC)
Received: by mail-qv1-f42.google.com with SMTP id u7so2714621qvn.13
        for <mptcp@lists.linux.dev>; Thu, 10 Nov 2022 18:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCncq1BlwvEYGuP1A0YcAWDvGEc5MA5mJRDj6OXbUB0=;
        b=VyxCJ8tmI5YwjX7UXIHLVOhEQNs+VNguRZ2FXg91/JSlIj7yc1z/JC9PepH+1wRNx5
         M7J9RiHWDpAXEsSFnYFmscm21aDLJC4b/a31SokStcDSQ8leGTVdAv/2vBcmt6BqGT09
         HJ9TyIbKhuHXHntU03hbnBGcsfAXBVBAK7vT83BCGYkDCRtaodpJOUGu6Pd6SHKIZMEX
         mGtNatrx6rY19FGfmIIsTn7stDqKX1IVCBW3CqHS0zO3+ULhDVaLKcsuRvEEOFx+aWPY
         8SGx8YSsJECAAD+w42odL83O8p0khrncfADWPaKO7ByXM12r2YwcOl6zYdMIW31ql+xp
         6G1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jCncq1BlwvEYGuP1A0YcAWDvGEc5MA5mJRDj6OXbUB0=;
        b=4vvXaVB01ZGRGYFks7bAnxIjOAPOKSWoeokiGWh59ug+E/zoAl25famljHr1/X7m7H
         O9SgNClpX7X9wL36vqT4HZJuKTShjJmvOCAR04Q80lXQoEXrl+BPVuyBBfGi4vqGjtb+
         83YrzcgXg5v7UXgq7vJPl7LC1oUroakG18LGdLj5ZcnDdw6tBpx9E4a1WMlQnhzLZXDs
         ef8tkFORa2mxjfJy0aFMZwf+nbeGlr4ObyGs/j0qMcqkOao7sWAn7Xf/mhpg39U+iG4v
         WtpkzWpBinxaxnYEVRIuXyn56OSEUL8DUSDDr7ersVjZEdce/dgH+Ga8d9fuPtFf6ulS
         9lDQ==
X-Gm-Message-State: ANoB5pkeQh4T7Hwo0rVs5Vd2RZ+uroaplcbfg4G4F0uloV6gv/TrzWEd
	GQAVgOL4nEtz+nlNu/4q6g==
X-Google-Smtp-Source: AA0mqf6YenlK057fKrUM//d2riVIyLGWIWtf/xo2ClbE4RzZAryFFW+8Aw1ND55Cme4DVu8akzADQQ==
X-Received: by 2002:a0c:ebcc:0:b0:4bb:b301:2d5c with SMTP id k12-20020a0cebcc000000b004bbb3012d5cmr435289qvq.115.1668135590768;
        Thu, 10 Nov 2022 18:59:50 -0800 (PST)
Received: from [127.0.0.1] ([20.127.129.73])
        by smtp.gmail.com with ESMTPSA id x1-20020a05620a448100b006cec8001bf4sm782841qkp.26.2022.11.10.18.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 18:59:50 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221110175857.3953994-3-matthieu.baerts@tessares.net>
References: <20221110175857.3953994-3-matthieu.baerts@tessares.net>
Subject: Re: selftests: mptcp: declare var as local: Tests Results
Message-ID: <9974bbb0-44ef-82da-c611-3aa4b11fe251@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Nov 2022 02:59:49 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
mptcp_connect_mmap =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5794716590538752
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5794716590538752/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s): mptcp_connect_mmap=
 packetdrill_sockopts =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5231766637117440
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5231766637117440/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/7ac100f71c2e


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

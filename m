Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B3C3203
	for <mptcp@lists.linux.dev>; Sun, 22 May 2022 18:59:12 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id c2so11330298plh.2
        for <mptcp@lists.linux.dev>; Sun, 22 May 2022 11:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=BLiM61C41hniiDDprJJfhZm0Lf8dE1THggE/JF2LaGA=;
        b=hmXSlCvJUlCI6eYUirb3Z3swrFJcdTKLHjL/bSgkMzvFui5e1ChySFWszZPU/NCo8X
         cIznEbq6fYdbgyfluI24006Khhidfi5+3Gw/oscrxyKOmbf96ZqO238Cw3wY86uRNSWn
         rm01LagfJPAFud+OcvR5xVsfsOqvT3cNa5F647H+oug0arvK/uXozlj4GvFPcrAB04tk
         uLeHTJI3NlNguXDDV9TJ0qH9CLbvdAlEEaLxfJlyCEQBfrNI1t74T8QmWq3DX6kvYkMi
         mpRAjieetZcCsef3V3S4UFCB1dyZ+ey5dPyWXlmkCzCvSo32a+iENwPgiaNctvNUN9BK
         6/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=BLiM61C41hniiDDprJJfhZm0Lf8dE1THggE/JF2LaGA=;
        b=Er1gqfIxfHSp+9liamiU9hCTNU+RgXubN2QoYF5Nxkrtu9rsCirQsEO4h3/EHga6/d
         H/oTb6OjFyklLu+QlB10Qu7cuYIS6Wn/FatMAIPiJq6+v4aPvWpfkXPp4+B80SCStV+Q
         NjjKXTJe4HumIcgIkTDgn21ew6BJC3EiwDcnu15U4AkSZsYurl+jwfXUHV04T/lAEnIj
         Il/JF341ZT6J83vJdC1uDb9Lm7NxBTNO3qYIQPBx7s6PSRHuzawiSbsqU8Lcltye4P6/
         zE6ZlAVLXYYusbMT3ekV3ejC5b0fIGF+spbXmE6nx5DPRreFgmWWutJhT/eBntZGEwtQ
         EoZw==
X-Gm-Message-State: AOAM533rXcuptsk3gC+ce5ONC7VFrRqMPgh+HjkLW+6Z175H/w1wNrE+
	1OVWmiFH46rAXTGpkI/3tGX2Xx0HWU2y/aw=
X-Google-Smtp-Source: ABdhPJzbMkzi900Cj9w1eCnsWpDG3Km6kG8fCFgTf+WaV9kegpd4c5fT9VzKMMnqCIgJ+QjUCbmFBQ==
X-Received: by 2002:a17:902:74c5:b0:161:5061:9d93 with SMTP id f5-20020a17090274c500b0016150619d93mr19323653plt.171.1653245951950;
        Sun, 22 May 2022 11:59:11 -0700 (PDT)
Received: from [127.0.0.1] ([20.106.125.164])
        by smtp.gmail.com with ESMTPSA id p188-20020a62d0c5000000b0050dc762813csm3196150pfg.22.2022.05.22.11.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 11:59:11 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Dmytro SHYTYI <dmytro@shytyi.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220522183921.103526-1-dmytro@shytyi.net>
References: <20220522183921.103526-1-dmytro@shytyi.net>
Subject: Re: mptcp: Fast Open Mechanism: Tests Results
Message-ID: <6e2935fb-fb7d-8746-9aef-5343658b0720@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 May 2022 18:59:11 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Dmytro,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: Script error! =E2=9D=93:
  - :
  - Task: =
https://cirrus-ci.com/task/6196328442101760
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6196328442101760/summary/summary.txt

- KVM Validation: Script error! =E2=9D=93:
  - :
  - Task: =
https://cirrus-ci.com/task/4788953558548480
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/4788953558548480/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/d3cb28a0acf1


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

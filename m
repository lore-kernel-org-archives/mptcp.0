Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41207A
	for <mptcp@lists.linux.dev>; Fri, 10 Jun 2022 06:59:39 +0000 (UTC)
Received: by mail-qt1-f182.google.com with SMTP id c8so18783303qtj.1
        for <mptcp@lists.linux.dev>; Thu, 09 Jun 2022 23:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=WSqpZlornu9gWB6X7jDiBXIwYqL85yfcy9z5NcC52Fo=;
        b=LPHeWL1oC+EUKaLYv95BuFvgUIpVN1QB+GT6dJ6icT8jPuPNm1ducOuCEyXo1t3THc
         EczeeF2izpJ0SUkJ3yLQQccBNvfII+JP2aLMT4hafT2DV+ldRq3v0/njVLa+RnBPbAKL
         oKPSYVcSY293b8egP/r4rbIMQLtvCR85aHzgSB8kWsbe9mASUy2qCxmH5nZdJPmINN6F
         eJwHxFAb09rm9RE6Bj034PLPZypH26SxAuLbT51dOuTgK8pmycJIx8kFmjUUk3Afc0VO
         mhuKhUohMiBoHzLm9ju+Vp0XNkL6LNpa8ErtYgGfdgimDdBkeBsRT18glyvSW0hDN0pN
         XrNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=WSqpZlornu9gWB6X7jDiBXIwYqL85yfcy9z5NcC52Fo=;
        b=PjvWDR810GOJCkuvXRohlAaFcF2RmX6SCxWSijRbXXiHBQjAI3tbDIXn7nTRRs9XT3
         SDf/osCtLl2OgCpIM1A07ktLv+SvSwJvoP3OFyNgEwzDdC6Ca8pl5ngTchIRJDlvsftL
         dlw3Uf7PN25dKuzxjXgXHosH9wtdnGqjk0i0vY7IlHSKMltkeMDV5tf2YEQ5386n6/AP
         BguPdrkh6s/L4Gel12lP8sHSxii+7pDfljdo9s8bw9usY/5Jg5xCT02JxO/A8TV53gpd
         HEOnD7BDPKI6y5BScxRsRAYZNBaqCJzGDHb7AdCQhtEZT5/KczZM/04q7FefnYYmPtnm
         8QDA==
X-Gm-Message-State: AOAM533ehft8yyb5w0DhH8H/HsnuO4/Q8mutj847eIKYZrSsm8DVW3/m
	zUZpxex5KLaDj0D+whnkFiGMq908u8PMPfI=
X-Google-Smtp-Source: ABdhPJxy1ZIfCg9WPHPD1K8IHfY2JWDc+WbZrKz+OF5J70aRkDQ3yAC61e1f9KEWZ5/03bUO9EyqlQ==
X-Received: by 2002:ac8:4e51:0:b0:305:754:9f99 with SMTP id e17-20020ac84e51000000b0030507549f99mr9053395qtw.684.1654844378772;
        Thu, 09 Jun 2022 23:59:38 -0700 (PDT)
Received: from [127.0.0.1] ([20.115.28.70])
        by smtp.gmail.com with ESMTPSA id u25-20020a05622a199900b00304f1a39429sm8611937qtc.26.2022.06.09.23.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 23:59:38 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <ba3d782f8fd64867c37a64202dce2565067c9740.1654839195.git.geliang.tang@suse.com>
References:
 <ba3d782f8fd64867c37a64202dce2565067c9740.1654839195.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: userspace pm add_addr test: Tests Results
Message-ID: <865f3987-1c42-d36f-97ef-5a4ae1a4b834@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jun 2022 06:59:38 +0000
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
https://cirrus-ci.com/task/6499682049327104
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6499682049327104/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): selftest_diag =
=F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4670094700707840
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4670094700707840/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e9d448ee0fa3


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

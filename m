Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F8C7B
	for <mptcp@lists.linux.dev>; Wed, 29 Jun 2022 22:55:10 +0000 (UTC)
Received: by mail-qv1-f52.google.com with SMTP id cu16so27162923qvb.7
        for <mptcp@lists.linux.dev>; Wed, 29 Jun 2022 15:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=ilkNvGZ7S40nWPnb2+HTyWJFik4u9EX5C3e78EmcHj8=;
        b=RP3XASQzhNpOUUVetfReRloBZrcXfCzb/tlvdlxZw2b3miS3MpZIMwewbdz67TJGJn
         NEYofB5sqrR413+N0QoAcFmu0GVHeGR2/x6TE0ClVE1Tl1ySThslkl0HdDylfl8yQ53a
         GMkU1M4gekVqZ9ui4nOpW0Iv/h5Bn+FCPbosYtDO2ddxGrq7Fv1KRkred0riD7z9pY07
         y5htFthNCcz+o3BR/pYzahvB58LILbGN4CqZ6jPtRk8582wdLfm6xqAL5zttux0+KZuj
         NF5eC+NKph+OgGYP4KsUNJjgc9uNittk5hpKE9GWrRD/FymMKoF147zFmztwK/vpDsEN
         uSgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=ilkNvGZ7S40nWPnb2+HTyWJFik4u9EX5C3e78EmcHj8=;
        b=Zo+2+VvJ76wUDkNN0AhU9szB8IOspNmqB6Aw/qaNPvfVuC0YkSBELvHMG0So56fHhx
         M8oO5gxc1NLd2ZjGqwCmuLd72Iso5yo0yISG0tYnbQeJgZJfJy/wpHqB8cOK+pWmq1r4
         ii448eL7p9B80Il+UvCE3zDTq6wLQcmEcelloeP2uCy5HPJ7z9gfhWR1A9whWwiYBg1+
         /LjllvGXR5V/GcMU0k66voc4zkZCfYo/F81Z1gTqPlrVS910zHt7Cb4Hz9J3chgYEQOR
         WzVO5fe1Qny3Q5A+C2VNoKchXJYCD9ABPlTKsZ4Y/QtuzKFB7RNJWujtm+HwJkBGdCoJ
         bOuQ==
X-Gm-Message-State: AJIora+yXHhBKQFnoObUosGQOvoyzrtJS4rrt1sFIvUmY4mobw2m4NSF
	6OZea16BbLcxoxeWLKAUeF54yJEwrxpe6as=
X-Google-Smtp-Source: AGRyM1twnL8emRxAt6QKsmESnadX+ufihfrvoFiL5C24+keZII4daf7EmaSnrvUw7AHXJyp9JJ4M7g==
X-Received: by 2002:a05:622a:2ca:b0:31d:2ac3:fb19 with SMTP id a10-20020a05622a02ca00b0031d2ac3fb19mr660654qtx.449.1656543309522;
        Wed, 29 Jun 2022 15:55:09 -0700 (PDT)
Received: from [127.0.0.1] ([20.185.88.46])
        by smtp.gmail.com with ESMTPSA id bs24-20020ac86f18000000b00304fa21762csm4028836qtb.53.2022.06.29.15.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 15:55:09 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220629223550.655928-3-mathew.j.martineau@linux.intel.com>
References: <20220629223550.655928-3-mathew.j.martineau@linux.intel.com>
Subject: Re: mptcp: Acquire the subflow socket lock before modifying
 MP_PRIO flags: Tests Results
Message-ID: <15ca1394-b763-d8e0-9625-83825a6532c1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jun 2022 22:55:09 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Mat,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/4719806531239936
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4719806531239936/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/5845706438082560
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5845706438082560/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/2c27d7a3c28d


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

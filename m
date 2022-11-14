Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCDC15A1
	for <mptcp@lists.linux.dev>; Mon, 14 Nov 2022 04:13:37 +0000 (UTC)
Received: by mail-qt1-f179.google.com with SMTP id l2so6178490qtq.11
        for <mptcp@lists.linux.dev>; Sun, 13 Nov 2022 20:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBf5U92Cr4T078pSUn7TLgOVd4yeiXmPPKXij8bo/dw=;
        b=FsgmmbVlQguLHz78b+0+QbFBx7PaSd/KFY65fG0+Z0wGRkuBhd4nSMBtzBNf4Oqhts
         vKbHahXB6xkSUVTOpMB3atuA7gYEvBIMZpk8lMIfUecZTsubHdznlmnJcWd1kIbV13ok
         K0f37LPPYrC0uWlN50g6eDiJFGCA5BMfKg4O6bznVGG9SpuBnP/j4yfAM7RLWe2fJMGW
         SPPpsJlX8Z+IQ1Zhby1wQwofIawTSUz9Ac9Qo5PMLZhUlCjgqwFvNf7OZNRha7gui65q
         7wICXzPgu1uFgyOVZOFjfWySXIPZt4KvPna2GSj1dlXYohFb46qtQYGPoJFBOZxdhfkA
         TZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dBf5U92Cr4T078pSUn7TLgOVd4yeiXmPPKXij8bo/dw=;
        b=0zOJlVJsp88Fn0TGrDwiyi38dDJOfNziEGVbXIJBLHIAMAebMzIEnw0DnaEstyOnWM
         onGxFQ9huVpm6r82JGYNAWFH3CteF9Jj104Jb6UPUD6l7FVqnJDBvRZ/ABqHvLWcklEW
         e97wiap8zW8eog9lFnPi7t+erNeaOhit25rFyv7dyabg//G9ayeSPB5pF6AwRyFhtKGH
         uciM1C5MzlcaeJudmMwhgZw8VnMpV03uGlRAL2n1k4i6SY7NZ8wzMHiT2HFa/uEpYVQI
         xVwMMhqym5r5mcbKLa+98pwvjxmyHAL1Wr7wNqdQ4vTkMH9DQeCqw7ziqCHG/PXvMcL2
         u9HA==
X-Gm-Message-State: ANoB5plEq1m+i41/MwZsUgcj4O1+VXEF85kOFFGTbyiHZYSEOYAzRDCD
	bCqya4+R/8FUea+Mxuc0RQ==
X-Google-Smtp-Source: AA0mqf6nTpdPnS27Zsaz0MOrT+LOAc3Vapz7JrLdj1Z86bW7uiT0C/gygYsEriAXWDDnFBdUEN6T8g==
X-Received: by 2002:ac8:4753:0:b0:3a5:2967:f8b6 with SMTP id k19-20020ac84753000000b003a52967f8b6mr11076376qtp.86.1668399216883;
        Sun, 13 Nov 2022 20:13:36 -0800 (PST)
Received: from [127.0.0.1] ([172.174.0.26])
        by smtp.gmail.com with ESMTPSA id x12-20020ac8730c000000b003a57f822157sm5057275qto.90.2022.11.13.20.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 20:13:36 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221114024005.26661-1-geliang.tang@suse.com>
References: <20221114024005.26661-1-geliang.tang@suse.com>
Subject: Re: mptcp: don't fallback when dss validating fails: Tests Results
Message-ID: <af18335c-6cf5-1aff-fba4-5a6e14e2b531@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Nov 2022 04:13:35 +0000
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
https://cirrus-ci.com/task/6482477422739456
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6482477422739456/summary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/4652890074120192
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/4652890074120192/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/703087448a53


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

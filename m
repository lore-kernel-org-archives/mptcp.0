Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7332B6AB3
	for <mptcp@lists.linux.dev>; Mon, 28 Aug 2023 12:07:35 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-68c3ec0578bso885217b3a.2
        for <mptcp@lists.linux.dev>; Mon, 28 Aug 2023 05:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693224455; x=1693829255;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dqXqWFRsVLwL+DGVbXbcu40c0QHsxWY2q27z9MqAnE=;
        b=q+/8+xHloCqNS+bbGPzmczauC80+KN7IDmvF+ySbdgIt5NR/AunJ5QT6tlYHNkEr1x
         8efoLa9IT5qQXwHGtqivJ9C/ijTEHFuZaBfyCdbOKwyJ0hMG3tCRKTNCcXNDER7IrMtx
         /RjvCUivqQpIlgtnNIY57hmMgmkOXXLd2dP8RmR2VGh2YJK/tRdLPBEAkAvO2vnVGHGT
         tz60cc8PgaqJ+6seoXH/oU/kIKyRpUby53GhvQzLFigAMPGrNIpoGqdhuF2H6qfQMnaE
         mXiK1hD/kKNWVqzVBAYsSzhsMBjeWzFZksFtXFvxWF2uow0hAXo+PNoTyojAeQjv+AMs
         rQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693224455; x=1693829255;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4dqXqWFRsVLwL+DGVbXbcu40c0QHsxWY2q27z9MqAnE=;
        b=GTW+AaHsK7vCxU22gnaxzM6PUlER1Xv2gku90bz6rLGaykaTefHqL5DO6d9aAvAA9H
         JvxBBexUxipIr7i6xNrHiFp+t7mN4kJU3ynZKOgWhmQt4ICz+7R/CF83ehS/sau8IXsX
         AlsgZBpdwugpSWaccbOXfCkCRow1rv1BtOaQviZCj7RExPsCf/QfgcpkW+TjqeB8f1Z3
         mQmNGh6+ecv3SRFzsZv/Rh4jX+pwJyBABadPSOdQSlmq4blnH7anOdq1T4Irh3fJTIpb
         fbHQV9bU597rUKxVYBd9IfRs2ty5Ty3mYGb9YJPOvrSeXOJScTjAmU46YEwdCey/F0iX
         ifzQ==
X-Gm-Message-State: AOJu0YzxPup9NQAWzHrBq0O4eMCBZADZDxAOv6w9ppFsGdLJASXLxgkE
	z94Xj15P236sbuGZeQnouxvfZgxaJMRX
X-Google-Smtp-Source: AGHT+IHq6/ChoN7pyvFTKERVnHFWNSsCLkTLIZBJyczuSVVrK5paAuxOu9msyqe5yakDV2P6rccYoQ==
X-Received: by 2002:a05:6a00:1808:b0:68b:bf33:2957 with SMTP id y8-20020a056a00180800b0068bbf332957mr15715614pfa.22.1693224454710;
        Mon, 28 Aug 2023 05:07:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.88.59.103])
        by smtp.gmail.com with ESMTPSA id u9-20020a63a909000000b005633311c70dsm7138908pge.32.2023.08.28.05.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 05:07:34 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <3938489d3e2bd740135a72aaf8c07263294405d7.1693220454.git.pabeni@redhat.com>
References:
 <3938489d3e2bd740135a72aaf8c07263294405d7.1693220454.git.pabeni@redhat.com>
Subject: Re: mptcp: implement connection level timeout.: Tests Results
Message-ID: <1f3ca480-4fd9-0d57-3fa0-254000cf5f4b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Aug 2023 12:07:33 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5391080623964160
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5391080623964160/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6516980530806784
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6516980530806784/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5813293089030144
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5813293089030144/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4687393182187520
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4687393182187520/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/5c4086277f75


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

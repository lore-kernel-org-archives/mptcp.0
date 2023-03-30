Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3409AD304
	for <mptcp@lists.linux.dev>; Thu, 30 Mar 2023 23:31:56 +0000 (UTC)
Received: by mail-il1-f174.google.com with SMTP id x6so10687771ile.3
        for <mptcp@lists.linux.dev>; Thu, 30 Mar 2023 16:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680219115;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hC6hPRweCVfAeCQNWCHgC53od1IhNQwjoHZnS3AfdFY=;
        b=Zictit/ICJnpJI/4vMbA576vmFqAuDIZEV6otTjWopIl18LeCjPfQRnz9UMKfCNjbc
         sb+76TrMZif6t93uPV4l2H197DtqezLzjWxhr5yX00x4drUMy9JhscEei+/WyUS32ASV
         SbGz9SAu28AhPukyHI2SO1kWJDEM5DXwmqYaJnaZyQkU4nqvzNcXvwT+KpPnkf0TOtvv
         rIeVwGzgJe6cZ8fltq1d+s3dntuu7rmU72qSStQuOHKfDpC8MwYZcPum6rbRSMfnRULf
         5Kg62mvYICv3iJruptqveUk3LeMRwulYZl0k72J0WZd2dx43RfuLVdyRGBgFnlMfxyYk
         c0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680219115;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hC6hPRweCVfAeCQNWCHgC53od1IhNQwjoHZnS3AfdFY=;
        b=HZHfgSOiCNvVRBqtiyNh0lJhFBSzai8ImN8JkmLc/LvewHljLMsKuR2ga8QIAJjfA1
         pCu6/6ZZNGahTIFDoDWPCvf7kRpaLtloMUkWbH8idSKzKdqJaxFzH0Nja8vZTdjIDZye
         Q80QjgFflnnJuttrgdCRyoXrxEJo4n7+0VrMeKiSKS0sC/8BcAI+P8q7oYXaNhlFUOT9
         Puq0jludKmN3brqDUKTyQ9webeT+1GEvGUrMrgcsG1itK94TWVVgkEFEkhsNd/va35db
         iABmb2rssvMtFHrryCl8zOgD4nviYVlirzpI632qGXuuy7bdg7xAHm2hanYwCL5E9D7+
         YeVA==
X-Gm-Message-State: AAQBX9c+tctSSaMxVDmQsOhms+fsZfZ834g30nDiFW7gOO/Sb8mwHTk9
	+RGPX0G8p0qM5pLtkQTYL/HzozoDHOir
X-Google-Smtp-Source: AKy350b28XVlByC2jZ6ccuuN33aMp+8NrELcoqayUCctI39RQaBsg/yNvAW1uHPKavO12oqXNI4Fbw==
X-Received: by 2002:a92:d688:0:b0:323:aa7:bef4 with SMTP id p8-20020a92d688000000b003230aa7bef4mr18705960iln.29.1680219115267;
        Thu, 30 Mar 2023 16:31:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.86.22.96])
        by smtp.gmail.com with ESMTPSA id y13-20020a927d0d000000b00313f1b861b7sm34768ilc.51.2023.03.30.16.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 16:31:54 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20230314-doc-checkpatch-closes-tag-v3-4-d1bdcf31c71c@tessares.net>
References:
 <20230314-doc-checkpatch-closes-tag-v3-4-d1bdcf31c71c@tessares.net>
Subject: Re: checkpatch: check for misuse of the link tags: Tests Results
Message-ID: <82dbd969-6c42-7f30-51d8-92ffbe1cdc74@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Mar 2023 23:31:53 +0000
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
com/task/6300055515168768
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6300055515168768/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6018580538458112
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6018580538458112/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5455630585036800
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5455630585036800/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4892680631615488
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4892680631615488/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/65a9f3f24295


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

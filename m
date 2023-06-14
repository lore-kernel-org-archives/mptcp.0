Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B68B1C14
	for <mptcp@lists.linux.dev>; Wed, 14 Jun 2023 06:22:48 +0000 (UTC)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-19674cab442so4652611fac.3
        for <mptcp@lists.linux.dev>; Tue, 13 Jun 2023 23:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686723768; x=1689315768;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozJv5+A8qYYWizcCaX9ZEm5jz5hbg+TKdSGf1PO+9jI=;
        b=lM1zWxSP5cI1pF6E8eHnSWaG8twN4o1VXkeOLk6GlVAL2LIIysRb+B4CRVdbz1TGRI
         TVELhBsbIDktruQpkNCUh1tJyQyDT1wBLDcOQIoq+lpZjvWKzDaWCA5WCk83tg9Mx0o2
         +S74YQUMjHJscYbfwo9EMcZ+uJagxKZqtv2XMrrLg6YT93tX5VWjIHVd/58p5hRU20Rc
         7MPb9NpxK9qWhjS2WHgix+Y1+ctyoDATNo0osbBtnNADjGL0g8KlElKHANKgKdipeWt5
         O/YxllEGMt9SF3pDUVdA4NExYX4PElwSDiZBWEb5GlF035ecaJNLnBuL+Omi5uwUSzGT
         MhGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686723768; x=1689315768;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ozJv5+A8qYYWizcCaX9ZEm5jz5hbg+TKdSGf1PO+9jI=;
        b=IBtDll/OWp7q+uJHtriHgDFF15zR1HmBvb1CU5LxReShXlI3pn+jLvc6YhxUGWk6Yo
         /kOz4zzA7r/JmkKBDTbEGOcwvStGqFFAnmRHO3Bx8hFXa6qaOHe7J7QCOdr5I2qB1jmT
         njQq0tBMUqD9j5cf5+5Ul3ot66EQj5wwhGlyUEEu5+xgI1P3RRmgzbE70pFjNHvhmWsH
         qwQOcLW/BNax2VqXSwa7TNhIluQrQBFctrYI8ImrDWtwqhSpAswO21I7cyMvsY5Xhqxc
         foDov5go+Y2nsF78qwyP9Tj+uiTeL46KvKdP1nLyU58KOugSuolQzrWu1tjKhuyxdHr1
         +pnA==
X-Gm-Message-State: AC+VfDwf5l3uGJ0WtcktxI7zHsMnfDUX8tDxVXfZi2Fjlya3IHHfd59S
	pb5KFGfd5J6+rG4Ie8oiUkxgdUslteJE
X-Google-Smtp-Source: ACHHUZ6hgkdmte7G7Wa8GTHWPDytoznEgsXuGztOj4UROFlT6q5pQeYhFzX5E39P0OZ89j2VCAutmA==
X-Received: by 2002:a05:6871:3d6:b0:17a:b61a:4300 with SMTP id a22-20020a05687103d600b0017ab61a4300mr8209401oag.22.1686723767858;
        Tue, 13 Jun 2023 23:22:47 -0700 (PDT)
Received: from [127.0.0.1] ([40.84.219.145])
        by smtp.gmail.com with ESMTPSA id n36-20020a056870972400b001a688176403sm3905877oaq.47.2023.06.13.23.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 23:22:47 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <bd10b96d43aef97369c5f197ceb1085c99dd4fab.1686709116.git.geliang.tang@suse.com>
References:
 <bd10b96d43aef97369c5f197ceb1085c99dd4fab.1686709116.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: Add bpf_stale test: Tests Results
Message-ID: <69fdaf66-dcdd-edc9-ad47-509f0c0540f0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Jun 2023 06:22:46 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6422467376316416
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6422467376316416/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5500646263095296
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5500646263095296/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6626546169937920
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6626546169937920/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6063596216516608
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6063596216516608/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/45a9e0e26856


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

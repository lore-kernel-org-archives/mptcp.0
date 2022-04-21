Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658DE46AA
	for <mptcp@lists.linux.dev>; Thu, 21 Apr 2022 07:56:13 +0000 (UTC)
Received: by mail-io1-f48.google.com with SMTP id q22so4479077iod.2
        for <mptcp@lists.linux.dev>; Thu, 21 Apr 2022 00:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=5+23ZPtPQ9w73YubzoMEcFnDvf2ux/T1NLo5I0EyrkY=;
        b=ZOVXQ8e4WyYrsVJSmZcU7hzitrY1ipAb/cCE64eoU+QsbxT3ync+I9/DLNhsOCZ9aB
         jxSovdleRj0ZPMcViESfhL62gCn3BMDD724Xeovw1UFo33LE5RIOJS8qxPCD8JsB3f8+
         vN4yBHcztUg0hVcdPlUHQjlkWyIECkJACk/mczUZ5o+DKJyS14UDmFKFDgGMeZ5HsAIL
         XNiGRgTGxa7l38LmM2Ldt6hGOkTu7v6YdtquNnzds6oTzJBaKdlaWyd+8D2YuVsXOCGQ
         m1eHWI9q2oc5IP/gxC5S3DBg93ySPxAbMrx8O2ECrduzJHoFyV4WVi4fyIHbmQdRvw0v
         Qt6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=5+23ZPtPQ9w73YubzoMEcFnDvf2ux/T1NLo5I0EyrkY=;
        b=vjAL3Nev+TyGx79j6kCm6qOvtHYT8NpMdPA2lLUDGEXHWS0frGCzqK8U+HvvkafjB/
         1cNiJ0vZJYUDMZcew0pzIaVtwDbrx/35Ki3SLm94oioK0Iabb2jtyMI5HlOoT0YyZjXn
         Gm9BgDcv3NOSKU2m/yfWCcKtLIqphBcIl3kr/juGjCKPNKkG5WAbn+4RB7u47lplKOfd
         wa+DznAChMgkqIcBPsQjAqcsCgxGxbzzONoFGBooHcC8gpHsxwX+2GpzQsg6aVKKNUwP
         D98y9IGpOK7NHoVConK1qVnreoetRj05w3yH1QWAKwoEdHLhndxjXPnDhps/0/MsQuDI
         DQ1g==
X-Gm-Message-State: AOAM533n7P4bN24kyXUbxJNz42xl9D+F53fnShx8EQ/PsqWqGmh8R0mO
	Ou4qPXWGk9DCj/EKGxUKEwIX6QtV9Q==
X-Google-Smtp-Source: ABdhPJweTJqT3XPa7zhTGFmsN47PX9y8Lom8Kg8YqDPzwteDBQl/S25lXPGP84YsiGm4Y7YgHf71hw==
X-Received: by 2002:a02:ca14:0:b0:32a:8a32:cfc2 with SMTP id i20-20020a02ca14000000b0032a8a32cfc2mr3400666jak.119.1650527772402;
        Thu, 21 Apr 2022 00:56:12 -0700 (PDT)
Received: from [127.0.0.1] ([40.69.142.140])
        by smtp.gmail.com with ESMTPSA id x3-20020a056e021bc300b002cc507aacddsm3699848ilv.66.2022.04.21.00.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 00:56:12 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <b3a671f28c27972d1aabbadf53057bf6a1f9cb1e.1650521788.git.geliang.tang@suse.com>
References:
 <b3a671f28c27972d1aabbadf53057bf6a1f9cb1e.1650521788.git.geliang.tang@suse.com>
Subject: Re: selftests: bpf: add bpf_first test: Tests Results
Message-ID: <38209431-73f5-0d09-dc5d-aa38f9b91afe@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 Apr 2022 07:56:11 +0000
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
https://cirrus-ci.com/task/6700592348266496
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6700592348266496/summary/summary.txt

- KVM Validation: debug:
  - Critical: KMemLeak =E2=9D=8C:
  - Task: https://cirrus-ci.com/task/4554345650847744
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4554345650847744/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/96d2ca054d7e


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

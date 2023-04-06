Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7234CD52F
	for <mptcp@lists.linux.dev>; Thu,  6 Apr 2023 20:46:07 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id l7so38326324pjg.5
        for <mptcp@lists.linux.dev>; Thu, 06 Apr 2023 13:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680813967; x=1683405967;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mz6hp5VUap/f2tR6UtDy1seiI1CESZofdPZ4vSCwOd0=;
        b=XQD6n96x2PfGZmKvv+fiBqfKj+g+TbZWH36G/kT12kHzgOGmjsFlCYfiMjSDXPua7g
         GJi4Zt3NDV5KJ01QvYtLesSA/+xlhZLu6hcwghnaEeytvAnMFPxDkz+fKzLEy65ZWyWF
         YhIN2n6Gj253EnI52RNPWlA6MKkkaRhI1NuGXV5f0PBml4TSwjEXUrdEbrCVw5QkT1XO
         Pol0GvDcQjHh/uYqHYBqnWKIEWvYbcwGLuDh2X2k6lqVGLH0DnNgToj4cyQZWTMwxOJv
         xyPVZfK8Zjn9k76pFoNNMC3mRMqModgU8G6dPga79YlFGN52KsLWihRi1M5QcR4JntkZ
         fVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680813967; x=1683405967;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mz6hp5VUap/f2tR6UtDy1seiI1CESZofdPZ4vSCwOd0=;
        b=SqF7UketCf725v9ldnIGNTMxbM3culno8+n0BpEune2o3QjFYyyvJh+IQ0N7ZgAtzb
         Ky1AByH5sZhBVnG2l3JXVB4ySWWjDrsKnC9StlQV4fWOBXJtLo66NF8V1S5dRgCXGXI/
         U9sPAArzLS1soPpm1F2qJ11t4lQbos6jbej1BkDN2pRRDkI2WDDZaVhmKDBL75fUZFiz
         5erNhKwxciNOrXc30lW057f67GEpD1LK9cu9Ya4jHsUl83w28RmDy4pJkLvmJDkrvGhh
         jB+gB9PvBunZ9R2inKh1qbwX6pTxlFnSCVk3yt4Q1JcVq86Kx1Hp1VSq0mqjcLmwZ6Np
         O82w==
X-Gm-Message-State: AAQBX9cSKCFBQ3Xh8ism8mzVQL4TCFoV5Yu/0iUuO1lY2JIGQhZAC46N
	y7NKVgmGVRNQ14AA+G2uuA==
X-Google-Smtp-Source: AKy350ZW4xQBl54+sa+DTVYuogZigjuISheDrvKRcJTUatDlzkDBQ0JVtFstKBFI7Kn1IB7BRZf/QA==
X-Received: by 2002:a17:902:d153:b0:19e:665b:2514 with SMTP id t19-20020a170902d15300b0019e665b2514mr322667plt.43.1680813966867;
        Thu, 06 Apr 2023 13:46:06 -0700 (PDT)
Received: from [127.0.0.1] ([4.154.90.105])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902ee4c00b0019c32968271sm1776126plo.11.2023.04.06.13.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 13:46:06 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <a0b61938d72605d35cd4d988ac533b88f45d7f89.1680810015.git.pabeni@redhat.com>
References:
 <a0b61938d72605d35cd4d988ac533b88f45d7f89.1680810015.git.pabeni@redhat.com>
Subject: =?UTF-8?Q?Re=3A_Squash-to=3A_=22mptcp=3A_fix_accep?=
 =?UTF-8?Q?t_vs_worker_race=22=3A_Tests_Results?=
Message-ID: <a5cce5a1-4843-c9f4-120d-4f69ea7ca673@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Apr 2023 20:46:05 +0000
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
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6313513459646464
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6313513459646464/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4906138576093184
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4906138576093184/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4764250036502528
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4764250036502528/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5469088529514496
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5469088529514496/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/4338375c43fb


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

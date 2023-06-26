Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF107464
	for <mptcp@lists.linux.dev>; Mon, 26 Jun 2023 10:14:11 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-668709767b1so1692923b3a.2
        for <mptcp@lists.linux.dev>; Mon, 26 Jun 2023 03:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687774450; x=1690366450;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5caa+WCuhOD8SUpyDHUZCK56n8FouoZau7I1an8krA=;
        b=nzB3YXWYwZoIUgfmx93sqdo3N6dAOkuYJ9o8zm+SFqu9H5GHLf9AeHVMTVAdWPpbfw
         q0/p81ZcH90gZHo0MrHQVvqH9HrCCw0IW1zord/OTXxSKSCZoS4bJQU5rrs/qx32FVaB
         3PNXShk8l3irBVTsJTO6jgdCPcVrMDNFSgq/YgfX/9ddqellEsnmgw79E8cNrLwFhiuG
         xbGFjx/KuABiX9rgJ8gjO/Ey/0thaZY2IdOxlaiwfqy5LSEzm8WP2fWry2k1Llijv6ft
         2iUsqpMvhY4P3vClswTajQ9wUBAx6P5bOrdEirvRBvNuFa7KUAOFqxhiD/ooA0hwVl5e
         cS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687774450; x=1690366450;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b5caa+WCuhOD8SUpyDHUZCK56n8FouoZau7I1an8krA=;
        b=ahA3zsgRFGwEfBntyEBdgv+Z2vnkhs2piTrQMdnujEsRDdXigv9+REdj8KTE8HptVB
         qoK+OuoIT9INQ305Q3jScRxTTclA4g6u1B7+DtVFdci8CR5N1kk6MtZ8WB4LsdGNEUU/
         2N15922PJpjiG5lhjs6Qu77hfega1RLv+1Noy4TrQWJGtk7iUPVNPR/R1x2rqzwy3HT7
         YImwweK99wgny9xp+A1y/Rn1A14os3irJl02dar0B2O+k0NWhJ5aG5RsQqyHIvYrN1dg
         b6TyJaMdHolkH+7fXEMIAlUdn4iue740uW2wm4MmFInAdz+oc7OCzMRBq/obVhApJlfx
         GLPg==
X-Gm-Message-State: AC+VfDyKvdL0lmofzjF+zih2bvjLc7WQzCeRKC13z56i56kXSsyUEyV4
	KRYm0qf3FhBqg81lFqbBUKFB3b4VSw==
X-Google-Smtp-Source: ACHHUZ4/1HW7eJSJPTwcGBqljRZnzefJpn+6pCqld2kX4wBzENFBKdANx2AL7umt+sdOxtcXe7GrVw==
X-Received: by 2002:a05:6a20:7da4:b0:11e:f740:b988 with SMTP id v36-20020a056a207da400b0011ef740b988mr27818076pzj.59.1687774450520;
        Mon, 26 Jun 2023 03:14:10 -0700 (PDT)
Received: from [127.0.0.1] ([4.155.128.254])
        by smtp.gmail.com with ESMTPSA id e25-20020aa78c59000000b00675701f456csm1960872pfd.54.2023.06.26.03.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 03:14:10 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <cae101ed32a7f97ffcd7d4e25e7c96cd85819e87.1687746021.git.geliang.tang@suse.com>
References:
 <cae101ed32a7f97ffcd7d4e25e7c96cd85819e87.1687746021.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests/bpf=3A_Add_?=
 =?UTF-8?Q?bpf=5Fred_scheduler=22=3A_Tests_Results?=
Message-ID: <b5d40f92-a759-2a2a-ea67-93400e684548@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Jun 2023 10:14:09 +0000
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
com/task/5075409738399744
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5075409738399744/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4793934761689088
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4793934761689088/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5919834668531712
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5919834668531712/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6201309645242368
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6201309645242368/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/be983431b4a0


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

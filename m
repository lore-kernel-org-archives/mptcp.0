Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0937B
	for <mptcp@lists.linux.dev>; Fri, 15 Apr 2022 18:05:36 +0000 (UTC)
Received: by mail-qk1-f169.google.com with SMTP id 141so7136088qkf.3
        for <mptcp@lists.linux.dev>; Fri, 15 Apr 2022 11:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=zFE4zIfK6gyqO5A9oNuAAZ5I82mcQlJK/7v2ixVkPtA=;
        b=eCipBEsjbTqQtXsWW0aRvYs86Winfk6bo/4opscPxVMTsTNRQ1JVdMKRhvgsBOxNLW
         LVuyAjOivJmf56Q80dEe73+90QlXovMVBD+kKO0vK8Xpii77ykVjJcr7lnwx3EVOn6nL
         hoG2zjCmGPE2G37VkcoZH6fvi8b/OaF1kt577GTZmWzHUKvw9jp//n3Pwja01GLgVsOh
         j1R2j6ijSeZFhqo6Xmkw6aOsjaBXjCY+xXpeAXD5DljrElb2UNegnJP08qiuU/8I1vZq
         dn3FQfbqUA/iMZSgSUnCc1wKy2InUFku1A1EtyJ+WFspHcKrwMsgwV4p3EdgCfTjqSz6
         vveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=zFE4zIfK6gyqO5A9oNuAAZ5I82mcQlJK/7v2ixVkPtA=;
        b=y63z8TNAQPCJImJwd2Hwk3mGnvesVZG7c+cL34LR89LD8NSAZLb0z17+QvT4pQ/uJ+
         nU5M57QIWXmSBD7QmLEku+KV3r8VG+k4bK73NHiB79nHzbYFe4/eqcAUnr/WUrLz4wUe
         LHubdllmwYByRqFxPwhKblS2MX/y2Id+dzmkvKKZ3R19CM3DDup0qVLWGHdtxblRiqf0
         4VsurC5qoymfAK6C3RQENgVsjD+7owdV2Gmi4gcJS2LatYrY+fQMmrANdyG6mRf/UmpM
         K8MvmJbr1u+t+pTMLRnAl5XpBHBD+OUre5AuJ6HumZZY+fEy6CY7YLYfiBMKJbvzXE5G
         6osw==
X-Gm-Message-State: AOAM533nEB0BvT9lcUSMvWrdXU9h0i1jR+zrhmyovF24qndAdH3e6vD8
	fZPDjdUIQubcaUs7V61TxUfqH6lNLQ==
X-Google-Smtp-Source: ABdhPJzSi6mgHYnNrGAuscOK6zQWjjsOLJxyMZqNnBCARzxuzyPd8aT5UIpzTvmicLdXGZLRE7EsLg==
X-Received: by 2002:a05:620a:2888:b0:699:b9a0:b618 with SMTP id j8-20020a05620a288800b00699b9a0b618mr123909qkp.358.1650045935308;
        Fri, 15 Apr 2022 11:05:35 -0700 (PDT)
Received: from [127.0.0.1] ([20.119.172.229])
        by smtp.gmail.com with ESMTPSA id i7-20020ac85e47000000b002e22bad4717sm3253245qtx.1.2022.04.15.11.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 11:05:34 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220415162801.1675860-1-matthieu.baerts@tessares.net>
References: <20220415162801.1675860-1-matthieu.baerts@tessares.net>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22mptcp=3A_netlink=3A_a?=
 =?UTF-8?Q?llow_userspace-driven_subflow_establishm?=
 =?UTF-8?Q?ent=22=3A_Tests_Results?=
Message-ID: <38827e0c-7d32-7a5a-afe6-73612173c9fb@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Apr 2022 18:05:34 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/6623082751197184
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6623082751197184/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s): selftest_diag =
selftest_simult_flows - Critical: KMemLeak =E2=9D=8C:
  - Task: https://cirrus-ci.com/task/6151526950371328
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6151526950371328/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/4cf51d33826d


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

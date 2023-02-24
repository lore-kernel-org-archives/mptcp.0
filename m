Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081013C26
	for <mptcp@lists.linux.dev>; Fri, 24 Feb 2023 10:20:28 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id cp7-20020a17090afb8700b0023756229427so2357250pjb.1
        for <mptcp@lists.linux.dev>; Fri, 24 Feb 2023 02:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l2H/J5frKcluwIau/W9ZNnWZvZMan9NjTH8Ub9/5/4w=;
        b=okgGTH3d+GBxLobzCPcAEBVBRam+TmkpA18bN6a/THzOIgcxIgVV0li0OgI05EqR0e
         9/EjUP8NdOxI7mJZZR7xm+Pc//DVW8z1ZTiazBFKoa1Hd+iOpOBtz9lPj3EZOy/aUTjq
         iJQP1b1pAvrsukdb2LSxXzVKZQ9zMu1er0MjwGKRTb51gtaqSK/3QLLVUE4nWI1YVdLV
         mAKTcSi32Wnfk5gZqa/+UdDrYsmZT0vYtmL3XhLd0sS8B/u0Z2s19KViPv/Xvehn3ZL7
         lRg7hYJuZ0p39gkJhCmJUUP+MElpmI8oHBashX3iyITeWR/URFZzEh68FnJ9CEc+5+rz
         kjKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l2H/J5frKcluwIau/W9ZNnWZvZMan9NjTH8Ub9/5/4w=;
        b=CxK48SZpcgrBX/M0VNFY4tyGjmRe+kE6XnYyffW1rlL7vayQQKCQZSGq9qH+AeH7Df
         gMmPwySb93ucU3Ma1Ky7Qci13ew03bN95eMMRKgq/D/tU52maV7BZfkci/ChKcEyAEf4
         1PS4uBRShcC71TP0od8wQ1v7M4ZC8T8/xKCvmlPyC4DhOh43xMp2rd7taR2PfGDtAb83
         EUGGOJeBAfQ4EWca3M3J4ztPHRkWFBBOtCW2mntgSKOO9T6yhDYCF13p3mOE0hiEAFVY
         2OHsqQg4bEJ4ny8Dc1290v+O1QXmLQu2rmGQqTaQ4hLPJ+KD8y4iWeScQtxpn6Uo/9sK
         p4Ew==
X-Gm-Message-State: AO0yUKWEo/gBB41mPGG4IL5z1/KCjophMEidzPMvGffcqyl/+8DzKfZ0
	3DZy58mQNeAmhJyI38eBt4l+aJVwNPwW
X-Google-Smtp-Source: AK7set+ugE0c3tJ29cEvss3Eod7cvJSwTbIxq6RfKh8bTw44ouG/zoJFGuOFfyMtblp0naGl8MVM0Q==
X-Received: by 2002:a17:90b:4f4e:b0:22b:fd64:c48e with SMTP id pj14-20020a17090b4f4e00b0022bfd64c48emr14532256pjb.14.1677234028327;
        Fri, 24 Feb 2023 02:20:28 -0800 (PST)
Received: from [127.0.0.1] ([20.172.43.81])
        by smtp.gmail.com with ESMTPSA id u5-20020a17090a518500b00229bc852468sm1237533pjh.0.2023.02.24.02.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 02:20:27 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230224061343.506571-3-liuhangbin@gmail.com>
References: <20230224061343.506571-3-liuhangbin@gmail.com>
Subject: Re: selftests/bpf: run mptcp in a dedicated netns: Tests Results
Message-ID: <112d8bdd-6109-8782-3a6e-878fc196a419@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Feb 2023 10:20:26 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Hangbin,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4837629401759744
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4837629401759744/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5139978573840384
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5139978573840384/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5400579355181056
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5400579355181056/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6526479262023680
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6526479262023680/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/371547334aac


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

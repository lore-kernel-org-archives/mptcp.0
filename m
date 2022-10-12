Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7FF28EA
	for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 16:41:23 +0000 (UTC)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1364357a691so13575042fac.7
        for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 09:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1LeQQ+sbb16TQRWPGy5tfP26yAap/JqI6ASvinTUI0=;
        b=VoEY3GEre6IIJEkLFOhEyjQ/V2iD7B6ley7/fs95b4hDaKxChrDgFkXjkeTbIX0l45
         0LY6q0XjBy5yDSEsD5DVi5+1vqfM+XhFzpBMtfnQJ+2zJpuyxuiD9PhPyXZ73abEqCV2
         yAREcVtDh0HZqyUhpWZgIccuGhBmWHxoFDDHzgK1kz0dWRWGXeFvM+7Pk0xlV9hh63xb
         WyS1y4zZahxjiZGAlyMniaPXHrbgEUCw57xa88H8hcFv3PlkWd20rQ5+G97yrQCp5wZP
         6SiUJzDAohgBxunOejodwPFCqiF/OLj4/moaYcPeNdHqcNF5f8njGsR+5jTlX6rKzd9L
         dCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y1LeQQ+sbb16TQRWPGy5tfP26yAap/JqI6ASvinTUI0=;
        b=flaPew6rPoI07vmH88C7W6M81TneJ69LnoRyAMT8AqwZE2WYXHTubYplG+8Bd4bEG/
         MLt3RVN9u9FrnJuJ3riimQDplpl1/RoK84x8AJRusX2Yd+gtKfieo7VqYDwCRwkCPrxq
         UqD+eERk+fv1Is9E8+Kq7BdOrbWFKRjZPJWN0iR91Uh6iAM68YTYEFPuMfLmYJVpzuvs
         45k2E0IFjcRMQ/1oKU+F+fiT/S1gm1/UM7T7vvcAvDluhJ4eOfcKv2V/EgymBkyXPtIm
         vPh+fEfZKaibdeFoxRyCgMLbmzdsZaQGgQWuEBQ0Q+8VbOD8+oiD6GbI+q7x+kGsyR3S
         Yz0Q==
X-Gm-Message-State: ACrzQf1rqzjq4Cy0PC9bglWFXuTbY6w7e2/u1Ewnvd/iQI9afOSl1yRg
	yjPd9effdJP2Cp2bZfHEPA==
X-Google-Smtp-Source: AMsMyM595S2ejWRWJVqQWQVSLNB4D7UNUiOgtdpWp27JkCUmBUxLpvX3TsLLOtxWkwvhfBqaT7Ch8A==
X-Received: by 2002:a05:6870:344b:b0:133:2265:780c with SMTP id i11-20020a056870344b00b001332265780cmr3015912oah.164.1665592882706;
        Wed, 12 Oct 2022 09:41:22 -0700 (PDT)
Received: from [127.0.0.1] ([23.102.168.125])
        by smtp.gmail.com with ESMTPSA id j17-20020a9d7d91000000b006619533d1ddsm4398411otn.76.2022.10.12.09.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 09:41:22 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <7c61250080c052b9dfb42a023c85dc36d4450daf.1665584136.git.pabeni@redhat.com>
References:
 <7c61250080c052b9dfb42a023c85dc36d4450daf.1665584136.git.pabeni@redhat.com>
Subject: Re: mptcp: fix abba deadlock on fastopen: Tests Results
Message-ID: <983afd92-1a27-82e9-f1b7-5b53d7871a0e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Oct 2022 16:41:21 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 2 failed test(s): =
packetdrill_add_addr selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5983248810508288
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5983248810508288/su=
mmary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6153658013319168
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6153658013319168/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/90ea741b4f08


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

Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55954690
	for <mptcp@lists.linux.dev>; Thu,  6 Oct 2022 17:46:02 +0000 (UTC)
Received: by mail-oi1-f182.google.com with SMTP id l5so2838511oif.7
        for <mptcp@lists.linux.dev>; Thu, 06 Oct 2022 10:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date;
        bh=w/7KsQP5eIdsscrE2euaZxlpMwOSkz3uZddJhyzFqtA=;
        b=pQv1bOgJ+lwPyj8UoiWNePC66jKWxr2W2YDPpcqaELPc5uCjRZ9d4p6cq9PyCzm2/z
         s44uGuqrS4nhbP0HH0AGX75ddVH/cL0py4br59rpnTnpRRD0qMVLeZhRA8CDiaTEmmri
         K9yqp3/wlXBleyBzY8PC9VCnisTUzmqe4TnweJujvKDw1RhEphRJxqUXcHml+mKnLnnD
         zFDytvG4iKzeTrwfA1kwvlww2BE0KlxI0BlML4Y19YTqFAGKwpAU7p3M+YveoQH3c8UG
         Ia2ptthmPFfGbdqKUOZeTfEUTn+LDmhs7KeXno6WBkU1rZ3m/xRIBlEM8UDqhywiDsZp
         OjLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date;
        bh=w/7KsQP5eIdsscrE2euaZxlpMwOSkz3uZddJhyzFqtA=;
        b=Ozzv0+IZyUfNQAZjDhmaDHa3+RGIDdapl4su43l45xEbRDYRrZwo3OZzUVrGXoH0c8
         D7prXe0Bg5robJLA1cC/kFjel8D68wjPkFG0FqKT5+6I77kP7ScV3D5U2bI8S0xIoVcv
         4pUVfckPxzI5QQ9TRrhkmkdJ+lf3vpO3DvGB1WiWN+83Gg1ptM8VwYLW7A+shlEPUj4F
         w3mnhwUBEdjFTNKEjWB5ObdHlsPoWjR4gTmFgkSoKz65dLEKAcgAvWPDF33yIXYLZhwv
         58dwbx3eYB6yXSlU2ZbIdQDedL6Z1Ihgsy4F1P0J/9wAgJvUohcYV+ReXL+QXEDdOP4N
         Zp0g==
X-Gm-Message-State: ACrzQf09fSF2kg+rhsx/DkNYml+qwXFV5vEcGVILKh6IAAKh1Gq3au3y
	iy66ieXgthU+2BqLk/2mkg==
X-Google-Smtp-Source: AMsMyM4NqufcpikVtpmHS4e90xtwR/TQ3xBPrdw0XzWssxf1uSJRT0gKl3HbxLrrbaDEjjFkG/plAg==
X-Received: by 2002:a05:6808:10d4:b0:350:9a40:5743 with SMTP id s20-20020a05680810d400b003509a405743mr5680438ois.125.1665078361875;
        Thu, 06 Oct 2022 10:46:01 -0700 (PDT)
Received: from [127.0.0.1] ([70.37.162.231])
        by smtp.gmail.com with ESMTPSA id z8-20020a056870738800b0013191fdeb9bsm105544oam.38.2022.10.06.10.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 10:46:01 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <51380f56ea152f419218b8f58951b5f848d982e7.1664463491.git.geliang.tang@suse.com>
References:
 <51380f56ea152f419218b8f58951b5f848d982e7.1664463491.git.geliang.tang@suse.com>
Subject: Re: mptcp: simplify __mptcp_subflow_push_pending: Tests Results
Message-ID: <65766fd1-4eeb-7cf9-cd17-45c4dc79b652@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Oct 2022 17:46:00 +0000
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
https://cirrus-ci.com/task/5897416976105472
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5897416976105472/summary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5334467022684160
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5334467022684160/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/95535e05c593


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

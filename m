Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DAF5CB0
	for <mptcp@lists.linux.dev>; Mon, 10 Oct 2022 21:36:47 +0000 (UTC)
Received: by mail-qt1-f171.google.com with SMTP id z8so2724551qtv.5
        for <mptcp@lists.linux.dev>; Mon, 10 Oct 2022 14:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yB7DvxJJKl3TybwR0usCqFvOrJO/LH8m4XxNNIUq/tY=;
        b=oOG5Ny/cG2Mas5UPCqzyHoQx2/0aXZCBvYOTS2j8NaT3stu/HmhSxX2Ezd3KtbCsct
         Ta9PJkmO1dOCsZ+fusoLlBS7w8KMzfIFNCRLPd1XDaQS+go30QpW856o60WnauNdTTiO
         dSaoYESH7xHpChziiGokct5jX309LOwklsCOqRze7I3qotTEpcF78WonOZO439KtUTcL
         kRcAeraNu2pRCzmjeOKK24APWnGcn7bf1nfa0R8hRQzYIGuHyqJIBEJ+IpTJWzg4n5Ck
         EdzQoMyhgThAkb0Req3yvYrHL30Ms2QPNb7qlM12R0qegZr5/aU3/mmLn3SCA0ZiB9ly
         FA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yB7DvxJJKl3TybwR0usCqFvOrJO/LH8m4XxNNIUq/tY=;
        b=XDunQzv0hqAsFe1SN0mUQ7JC5JEIMv7m2w15bZixzI8zYCG4J7Fx5eGDeYqrqhe4dZ
         BTciOq8SysUuPeeEcjlFgNdVDkod2bDcwVdujWOKWHJxVrlAzlQrTUOJXsig9bIZk16c
         EilQ0i7dukcud8sxl6YQ2tL/C8j4gtb502AfC/cJWfiUJr+Y3bB2uFJvRdAakW3jw9Fy
         r0BQ9ItHsnSy2HifKLI1w/iI5bO2bFX7OCFV49LtLYXRK8RD9Mn+1D9eaNByoreyO33l
         fwQkQnVdS1agmwpyepeGbz5D6vM0XGFGmYZ2Qc7xDo3sUb4NxmGi9xYTUriiCJTlu9KX
         WQ+w==
X-Gm-Message-State: ACrzQf3OlG/0cK45G5JkSWVRF0sFNLvjEI9ElD3o39V3y4lFwx7iun2v
	ogIkrdDrrD+9oplS/40ChA==
X-Google-Smtp-Source: AMsMyM5nnewiU8p9b8yFGaqVWxIsKh8MCvzYIKFhtt5VBHUSEQtWEkp8IQLH3SudUFTrrd+CNp6+gQ==
X-Received: by 2002:ac8:7e84:0:b0:35b:a902:57c3 with SMTP id w4-20020ac87e84000000b0035ba90257c3mr16435360qtj.37.1665437806917;
        Mon, 10 Oct 2022 14:36:46 -0700 (PDT)
Received: from [127.0.0.1] ([20.172.193.171])
        by smtp.gmail.com with ESMTPSA id g11-20020a05620a40cb00b006ce813bb306sm601554qko.125.2022.10.10.14.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 14:36:46 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <f5e8bfe9878d3948df9328870fc35daec6388e2b.1665431162.git.pabeni@redhat.com>
References:
 <f5e8bfe9878d3948df9328870fc35daec6388e2b.1665431162.git.pabeni@redhat.com>
Subject: Re: mptcp: set msk local address earlier: Tests Results
Message-ID: <ec1c0025-8b98-367e-9e64-a61e65274743@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Oct 2022 21:36:45 +0000
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
  - Task: https://cirrus-ci.com/task/6015508108541952
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6015508108541952/su=
mmary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s):=
 packetdrill_add_addr selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5452558155120640
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5452558155120640/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/33d6013f6eae


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

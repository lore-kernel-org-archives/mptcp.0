Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE4F7F
	for <mptcp@lists.linux.dev>; Thu,  5 May 2022 06:26:32 +0000 (UTC)
Received: by mail-qv1-f43.google.com with SMTP id p3so895435qvi.7
        for <mptcp@lists.linux.dev>; Wed, 04 May 2022 23:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=yN9tpUiEGm9kvTtVQOSi3Yjn8g84vLW7FmtiVjngfGU=;
        b=Lb+FOBdVOgmy22Aewo2hpi6QKChSrNUWUp7jG8b4GgeE4lCPLAT5F+uSBR0W8xQLRM
         m0nZuDz8fa5ihJAn48MSRhhqJ/7VQpOd/NLWEAIYfEIiYuFYS4+xjsrJ1g97iX92TfRj
         Gn2zpqdIb9DMcdxhtbXqwGpfYNk7FqyNOryeDjzvT7ffBQjEmdnVO22kCYtRPB57uzhJ
         aBnebHenVW1wj6/N71VUj9/q3D2ljkux1WmEf/ZXcXm6rRmsqugWWhioPeco95yhrHv6
         7b6KeYOsiWudEhHFuScGnbcZ2P+sUE9+U/i7KA1sCdZhnHZ7dEmj/9OYx5d1heeIpj5n
         A4Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=yN9tpUiEGm9kvTtVQOSi3Yjn8g84vLW7FmtiVjngfGU=;
        b=1QiBjtfgYkrOQgAXO2Fj35KXh+iys/cx+NV1CyEV5IZATLOZKjzp3UexdLZYQdu7fL
         bwQb3XpZ9+ieloH2CLD5LmpC5oARV+wwYcc1I/SZ2Xnw+gfitSATzGPuAQ+rQICBKxrx
         WLRfErdPRcK6z/KkP/6hx2eSZwDCj+4yNY6J3iP5wNgDoZ8YBArwt+IaBxHIbC0Q0f6z
         iclvshVtOoE6XZKPozjy/UkNI+gXEC6qugqhbMiRsL52NdDaXzBwEwXhrtm6vlPtA9OK
         JyUjyVKAZpLjbd1ehq/eHhxQIO54wstbNuwsn8IB2LIVDXZ2+tJI4fVtvHVehj+JAt3H
         7KyQ==
X-Gm-Message-State: AOAM531FZ7AQMqhai2j+rz9QxKinp3sZ+eFMy8D9PnWm4mOiiwdaswUU
	imN9RxmRJjglJosMpDjNGA==
X-Google-Smtp-Source: ABdhPJwcvFVZLAde9wrRUWiBs2GrLM9/wsdwFjVgRZQCKEIns1iTzzTPgthd2mvZUqFMRFPNJV5KYg==
X-Received: by 2002:ad4:5ca4:0:b0:45a:76f5:dd69 with SMTP id q4-20020ad45ca4000000b0045a76f5dd69mr20386643qvh.131.1651731991688;
        Wed, 04 May 2022 23:26:31 -0700 (PDT)
Received: from [127.0.0.1] ([20.242.82.243])
        by smtp.gmail.com with ESMTPSA id l12-20020ac8148c000000b002f39b99f67dsm381314qtj.23.2022.05.04.23.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 23:26:31 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <89c1a1cb213959a3a59fb7ddffab8b043ab5f3ca.1651724418.git.geliang.tang@suse.com>
References:
 <89c1a1cb213959a3a59fb7ddffab8b043ab5f3ca.1651724418.git.geliang.tang@suse.com>
Subject: Re: selftests: bpf: add bpf_rr test: Tests Results
Message-ID: <f694e8b5-c80e-d3b3-f2da-c6131c326f46@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 May 2022 06:26:30 +0000
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
https://cirrus-ci.com/task/6384460542246912
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6384460542246912/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 3 failed test(s): =
packetdrill_add_addr selftest_diag selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4977085658693632
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4977085658693632/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/5dd02ab25990


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

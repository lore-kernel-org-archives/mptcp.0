Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1BC7C
	for <mptcp@lists.linux.dev>; Wed,  8 Jun 2022 08:15:23 +0000 (UTC)
Received: by mail-qt1-f171.google.com with SMTP id hf10so14384330qtb.7
        for <mptcp@lists.linux.dev>; Wed, 08 Jun 2022 01:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=hWZ28emr4iVoQhFOiTvvrw/r6mmzv2XHKkcGHsVAJS4=;
        b=Ge+4fjL6hpYkzxaaPnCHttlN+CdxG5imOFqo46A3lLzgRK+1r9IpCEfyqWcbnxWyXK
         DXYBOVnDd3gbdhD/FeYweZziqWZq0sl+vxdQSav+zIwcXVcX1XfGW3PqK6OEg+Q2cOnI
         oUNYdYAGDy2RzcNFggudEEzQUke6zze0gcjhwgfLw3PWsrwGxhzwF59WjI1B6JItRiQX
         VjXA+oTEDZk86GjUoA6ZyzSoRjkA0kSu+sN7g+pqm963WLmaY0WOKi69Pq6mfnj3P31F
         +nfGXom3RGImv6DXPkJdZVlDAFY+/MGvv7fWBh5P6/1qOtrwa5d6Pe4Jbaj1pwK+DYEZ
         nRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=hWZ28emr4iVoQhFOiTvvrw/r6mmzv2XHKkcGHsVAJS4=;
        b=3SgfTWKcgrrUO+v93IM1u4V5bhaNBgGRIdpO1al6EKezqO60VO59XWN4aX2F5M7Xkn
         bTIKN3vdJRU3rzg4U8VlEnsqJYE/jX7H0oSQA8v2EBVIvPh6pbyGF7mXKjqeV8h2Nmke
         en/G/izpDdkAMlpJmoAW1VSfWc3VdFHbgOfIOmf3lmH9Q2gGE/HuH6d3dE83MDYSUgLo
         FrzOLFQ7LsVbq8F5sd9Np9Z40tui/AmhStOja7n3dV2hRjrWa39MH/fVU+NXAxOWcQkc
         qr6EI9oGISItd7OeQgLWnVhKaayvj2ww+98X2HlFogEeyZo0AKqA/IFaQZBSdAwH7HXn
         V36g==
X-Gm-Message-State: AOAM532xtr7LACa96Mve0LD9+gbYZTfx9WoBIkoko4Ny17gPnCHq2yhX
	Uc8ib7thnWVpaYE1VUgs3zM4KR4wijA0hp4=
X-Google-Smtp-Source: ABdhPJzSJoyKzmojl0246RfqNjBbfESalC30uPG6vBZ2xhwTQbAqEUfjW/bbVWSthyFgwZbpGmahNQ==
X-Received: by 2002:ac8:7d0c:0:b0:2f9:2d58:d973 with SMTP id g12-20020ac87d0c000000b002f92d58d973mr26349066qtb.234.1654676121685;
        Wed, 08 Jun 2022 01:15:21 -0700 (PDT)
Received: from [127.0.0.1] ([20.242.48.190])
        by smtp.gmail.com with ESMTPSA id v1-20020a05620a0f0100b006a6a6f148e6sm11762738qkl.17.2022.06.08.01.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 01:15:21 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <2e7b890b45f548567894a01465ba6ea86dae55e5.1654670172.git.geliang.tang@suse.com>
References:
 <2e7b890b45f548567894a01465ba6ea86dae55e5.1654670172.git.geliang.tang@suse.com>
Subject: Re: mptcp: call mp_fail_no_response only when needed: Tests
 Results
Message-ID: <c80d8dfa-ea79-d67c-87e7-3f0f1e229d9c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jun 2022 08:15:21 +0000
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
https://cirrus-ci.com/task/5856398490730496
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5856398490730496/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 3 failed test(s): =
packetdrill_sockopts selftest_diag selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5293448537309184
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5293448537309184/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/527585a8ae40


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

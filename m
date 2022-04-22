Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F6B23A4
	for <mptcp@lists.linux.dev>; Fri, 22 Apr 2022 09:44:03 +0000 (UTC)
Received: by mail-oi1-f172.google.com with SMTP id z8so8459660oix.3
        for <mptcp@lists.linux.dev>; Fri, 22 Apr 2022 02:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=18ZL+1sf8jBVGLQnyTRp882IpNHLftbW1j8VAoi5vQA=;
        b=GoSTc2dwzM7CEP3DALjhYxK7a0GTyjqREuNusEGga/ZAmhQyNNcH7Bk0ZGGKpwGsz4
         83Vc0yvbxv1R7DX/y8rxOyiFKVYlzMZE2cNEzMNWFhXSjqEhDsQ8710Nc0B46//HEr5+
         KjGbDMD/8qCawxv+JKPesdHcdgZOsw3WaVKs9jTRRQWjLyJfNbvA/jHuNzmfxhb5fxQo
         VyiJ3tjZ/XAkL3+kdve3Tliw85HNhN19kI65WnKFs5BI20F8DeeLGdiIF7tyv3r57cGR
         dEBm4ZwIaJbZ3WQ7QNiikb5jXv8Fc2hgQlr79h8UMSvFw8FB+1uYdEfItr/rI/uRPs2Z
         PW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=18ZL+1sf8jBVGLQnyTRp882IpNHLftbW1j8VAoi5vQA=;
        b=eLPZiEQEFNPVVsFJgD4riCRPre5cRh9CsvDDpaIT2dJcH3PZ9CmnoxZ3leuuIzhMWF
         2B8gDDwjRO6/Fd0L96SM7jbtDyC/Hay8N2pUv9kEL51IYywPkmzqKcmWr5IqKFjQnknT
         EVH4QbVGSSAH7Tc+zqPkc0M44tDiOKACOlVinUrlr6TdkbDgqk/hS84DWf+aJEQda2wB
         lV5TuAfKYXnX/pciuS6OTZR0meBrEploFgGk0a2lX4/wY2MN3EVpD/3jQ9II+O+MpW/4
         60wmSjGt0J2i4MzmrPzpwiQl3UzUIfynbKnAzwkFOC5EjDmk5mcVBlARaO+uLWeBrp/u
         9uTQ==
X-Gm-Message-State: AOAM5322tvBx+kRRrqyY87ANKbAU+PUN93XBjBHQccVYwpGKNggEn7vv
	IYaSC8Nzxq+2xphxwCZ0JTn3WY/J9A==
X-Google-Smtp-Source: ABdhPJy+qaeWIgH7WHvm0q+8JqFrayDfILb17VEEJGZn6qsmHEiL4dq5dOqyt04u0QRHKmD/aFXReA==
X-Received: by 2002:a05:6808:1386:b0:2d9:a01a:488a with SMTP id c6-20020a056808138600b002d9a01a488amr6197897oiw.213.1650620642423;
        Fri, 22 Apr 2022 02:44:02 -0700 (PDT)
Received: from [127.0.0.1] ([20.225.217.187])
        by smtp.gmail.com with ESMTPSA id a11-20020a056830008b00b0060546411473sm538228oto.75.2022.04.22.02.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 02:44:01 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <2032cab8c752d0258ee16a6b9b2825ef21b51d0e.1650613135.git.geliang.tang@suse.com>
References:
 <2032cab8c752d0258ee16a6b9b2825ef21b51d0e.1650613135.git.geliang.tang@suse.com>
Subject: Re: selftests: bpf: add bpf_first test: Tests Results
Message-ID: <4c906833-e1b9-fee1-ff2c-489e1d41cc33@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 Apr 2022 09:44:01 +0000
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
https://cirrus-ci.com/task/5523459722706944
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5523459722706944/summary/summary.txt

- {"code":404,"message":
  - "HTTP 404 Not Found"}:
  - Task: https://cirrus-ci.com/task/6649359629549568
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6649359629549568/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/30e36d25b43f


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

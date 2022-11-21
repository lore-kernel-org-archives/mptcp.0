Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B115E1C02
	for <mptcp@lists.linux.dev>; Mon, 21 Nov 2022 11:54:14 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id 6so10934245pgm.6
        for <mptcp@lists.linux.dev>; Mon, 21 Nov 2022 03:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cqrzed4dd/XCyd5hgjUiviwgeSdMu10EK0b26hF/l9Y=;
        b=jbUnhzi8gaVUTLl/0R383TW4VAwtXtCeyWisU695XHYbjwhch6s/KlKBBsE5g+1vOo
         l913X6PpnoMN101ENh0kSYGhWx7/YgZpiv5QfQJiVqInbFSf4sg9bscHLCemf2WDF/mY
         zfrXU5oRW0hgQJ+UuspcO982joQqZ/GcgLDZ21NmQieoxv7xAeBiaRdoSCrt4RFRrtGm
         1UhXXdVDWLolKs/dihpyM72O2CY3l4TRuQH3PUG0nzcLrU8zctVO1TzTE4iuE6tC816y
         sQ1RoivdJYZAGj4XT9DcvCIwUhPw/S9TTfRLEGNpZTiLwIuTnafo8W1+hT4LnW1wBqpc
         G1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cqrzed4dd/XCyd5hgjUiviwgeSdMu10EK0b26hF/l9Y=;
        b=gRBGPHafmbDW7ksNCIrXBwqqyclehepj/XXARhCYTg7b7VdDpuGoEDhuHqh/6EXWUo
         dUF77TFGYIL96IptuUjEt4QRG9WI/i5R8l5dCbKEbAR+22YoTj+XEHd5v+x/cLFmDNqj
         YmdpE7xeO217a3bnLL+Z43Z02fhAxomT2VXkGPc68K03CrfirD0d3tEnETMBGJkNvL6T
         nQaGzimCOvj9Yi/3JQPI8w/48VVn73+W0rtGEJADsbv7s2dZUjqe1Wk5fTgB6DRlQfRm
         CL1Rs4uBfZA0KYPUZyiWlrE9qmAj9FlTOhlx8jXxYdbupAJWrgWWTi1x8FnlGu3A+975
         90/Q==
X-Gm-Message-State: ANoB5pmY3810Lkx15cSUEmdkIYSBveXGusYe6yMgwTYkJrRBVSTSLBeq
	brDauYAYPEFTGQveHsonAfJgJ5UWXBT3
X-Google-Smtp-Source: AA0mqf4ENjLe2b0BjapT7KOyrEWTNDL6pv+XnKC8j7wDt4YIq6ZCqyKBDmiSKb3VeC7i8CXsSx3ccA==
X-Received: by 2002:a63:5f4c:0:b0:450:3c0c:b17c with SMTP id t73-20020a635f4c000000b004503c0cb17cmr139985pgb.64.1669031654142;
        Mon, 21 Nov 2022 03:54:14 -0800 (PST)
Received: from [127.0.0.1] ([20.66.69.211])
        by smtp.gmail.com with ESMTPSA id c30-20020a056a00009e00b0056b3c863950sm8568442pfj.8.2022.11.21.03.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 03:54:13 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Menglong Dong <imagedong@tencent.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221121034140.548112-1-imagedong@tencent.com>
References: <20221121034140.548112-1-imagedong@tencent.com>
Subject: Re: mptcp: don't orphan ssk in mptcp_close(): Tests Results
Message-ID: <22386b32-a405-ec90-2f88-dcbe754948ec@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Nov 2022 11:54:12 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Menglong,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5471374876606464
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5471374876606464/summary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/6597274783449088
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6597274783449088/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/6dbdc9ee6d06


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

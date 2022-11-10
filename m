Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0C31A612
	for <mptcp@lists.linux.dev>; Thu, 10 Nov 2022 17:55:31 +0000 (UTC)
Received: by mail-io1-f42.google.com with SMTP id p141so1828669iod.6
        for <mptcp@lists.linux.dev>; Thu, 10 Nov 2022 09:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3GLdlBUmgQRluNLCs0+JQ7KWgD63vepDsWUgdvwo5Ok=;
        b=Y3ul8qRys4TVPVxT73zYtZxCc9PNzePKNDCaP5ZjSQNkDihYmca9/V9pMIbHg0D4PH
         0Hs7scvkylUhIDCc/qsIfHsxD7YWVlDTYRLjiF6NcFdXQwpqYHrODtveBhFjk/+PZ0bg
         gRvSwpEIN8ORWIXTrG5ceWtCvZ2lwal7ItkJjNSSFsXulKv0Eu6D8eo+SXM8qf45/Qxx
         w2E6TB/mP0thzSupZ1mzgIXjBaV6VGA4v2duGfZ5hMLE9uotbOftxuEOZs3EuCPwnnPe
         O59mLOmHICuPTCmVnPNvjIyELAKcjuyzYiV0AdJu2MIZ4mpvveOz29+IP2LxuPuBG107
         E6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3GLdlBUmgQRluNLCs0+JQ7KWgD63vepDsWUgdvwo5Ok=;
        b=YT4lgdLrZ9WZ/k8J8yNTNRwVjgCHJjVvnffhSoFUFtxwDDcFxVqYus6ytBXM4dOUsO
         5xbF2+3tHH2dekS6rHDe5hO3niWGwolKiTm+aES5BBoz0qrVhVM+zJDWm3d3Qs2UMVhg
         tBne8f3U7jyUyDMcFgshUxHRHT6cCofYpDGvz288XPunbu5ivHy88adcCG3gjW039Uwq
         sg1JRD3fCAbQ8abFtJAdS8q360JSi/AXkKhRZnRgDZBxG4gGFLZmRpyUqpIhH/TXl9TU
         ooWvETfYayUHw/kNZUcV7+wgIA6H0STye1hejO7pYzfCyTpcO23ZvEw52U7m0sTLpwUn
         stmA==
X-Gm-Message-State: ACrzQf2by6DQFne/dx0YFXyyi2fC1cNhQUgfTdwT9c1f8KPuXBagSliI
	7VMP83eSigE5klnM0aSP+1fpgvK1kA==
X-Google-Smtp-Source: AMsMyM6aem+Z0TbLZLX/ffgu2puKyYn5RzYS/lFRPxi24//bdweatvGMKotvslRhN0KvCMO45jPdhg==
X-Received: by 2002:a05:6602:3812:b0:6a3:e352:d51f with SMTP id bb18-20020a056602381200b006a3e352d51fmr3195106iob.199.1668102931068;
        Thu, 10 Nov 2022 09:55:31 -0800 (PST)
Received: from [127.0.0.1] ([40.122.75.103])
        by smtp.gmail.com with ESMTPSA id a14-20020a92c70e000000b0030237bcb9bdsm88646ilp.12.2022.11.10.09.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 09:55:30 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221110160017.3641527-1-matthieu.baerts@tessares.net>
References: <20221110160017.3641527-1-matthieu.baerts@tessares.net>
Subject: Re: selftests: mptcp: fix mibit vs mbit mix up: Tests Results
Message-ID: <19c60342-e878-a0e5-250f-baae72b0c6f4@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Nov 2022 17:55:29 +0000
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
  - Unstable: 1 failed test(s): =
packetdrill_add_addr =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6122416422780928
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6122416422780928/summary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5559466469359616
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5559466469359616/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/d274a6a1623e


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

Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28E972
	for <mptcp@lists.linux.dev>; Thu, 12 Aug 2021 06:52:41 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id d11so9470776eja.8
        for <mptcp@lists.linux.dev>; Wed, 11 Aug 2021 23:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:references:from:subject:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=jdXKThuxDSah++67PCas9Gs+/cvXjAUOhPPoou5bMVs=;
        b=rYGqbiCNHcIbAPTg38qhaOWh5skD+SicrCPp71uY4DfJh0+X83i6LhLk2gt2QG2iWr
         TS3DlKw1ovZ4bjRRZClFzXw4dr8U31lpdQazOuTHpi20cX7DO+0QKnfTWEX3rxZSfmlA
         pgDwPN1RwsxkCuL2VMPi2R3k8J5biXzkurPV0Qi4Jp1Zu05wmzw7VN4KkZLWzabsDwd7
         dCQzFMM+ABKfzhOCWVbwKeOAIPt6K3cJdUQ/9K54Ouvco1AqimY0MtFRw9VOPT/7SbEq
         1J3emZVENsLnIKvbmMxLvtDO2SG3GjWysQ1sbNNimx5BvWoFJgQyJM6LSrRBOXfoYxZh
         24ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jdXKThuxDSah++67PCas9Gs+/cvXjAUOhPPoou5bMVs=;
        b=V4Mud4pJGW89dpFLbuB+z20IjO9emn9V4gr6uHBw227GumCTuqEV3DLk0fx/o0yh7O
         rkQWFDQmIgOSEnxnnyMhWDI5nOV36cdEsnPKhJKbDt7+78clSDHPvHtDLx3VI4xmWopG
         dwczmuMqmYEAvwkfFq7bcz5BF/cCsVJf2AUzhntFjj0Q9wx6EVo7K+83DLMuqP15kRSz
         lJK9aKUWydhwoYcmldSrrqBFZbxdWi7Pr/iU9pTXov+8/Ki6Dizb53nr2tMxmuQhFtXq
         Mxl/Z6IA8tqs3Wl/hJiUAomIOtToPFrZxImtysDPKEUjCpC/vJEc2KXKp3zzg9yKWYjh
         kAcA==
X-Gm-Message-State: AOAM5323FTaN1FhBeapes14npMrk3BsOwN5J8HBityW0zahn598+fHX0
	G9VmWA5Je3LUeGWeteQUZzjQuk8m1TbXAOPi
X-Google-Smtp-Source: ABdhPJzjUZs7xp5IA/sjLxg+02MXo9ggh4S3DRk5CSI6VX7N572FQ6kyKTAp3CQ7smHeMjAynM03sw==
X-Received: by 2002:a17:906:aada:: with SMTP id kt26mr2246855ejb.199.1628751159826;
        Wed, 11 Aug 2021 23:52:39 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([213.211.156.139])
        by smtp.gmail.com with ESMTPSA id l9sm678824edt.55.2021.08.11.23.52.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 23:52:39 -0700 (PDT)
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1628673891.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH mptcp-next 0/2] mptcp: some self-tests fixup
Message-ID: <3ce19709-451a-f369-c53a-516ccd59448e@tessares.net>
Date: Thu, 12 Aug 2021 08:52:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1628673891.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Paolo, Mat,

On 11/08/2021 11:25, Paolo Abeni wrote:
> The 2 squash-to patches try to address issues/221, at least
> for the root cause reported in the github tracker.

Thank you for the patches and the review!

Now in our tree:

- 3b6b8c96b67c: "squashed" patch 1/2 in "selftests: mptcp: add testcase
for active-back"
- Results: e41bc27ecfa9..c636d849945e

- 32c3e4d50806: "squashed" patch 2/2 in "mptcp: move
drop_other_suboptions check under pm lock"
- Results: c636d849945e..3e7443d82746

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210812T065059
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210812T065059


> Note, I can still reproduce some self-test failures, on other
> link_failure test case, but with lower rate and different
> cause - to be investigated.

Do you prefer to keep the issue #221 open or should we open a new one?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

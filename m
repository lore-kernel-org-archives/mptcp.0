Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06522186B
	for <mptcp@lists.linux.dev>; Fri,  2 Dec 2022 06:43:42 +0000 (UTC)
Received: by mail-oi1-f179.google.com with SMTP id r21so4410496oie.13
        for <mptcp@lists.linux.dev>; Thu, 01 Dec 2022 22:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WA3Zx/K6rjQxwFl6PY81C5/ohpgaP9Zjcq5R4O49D74=;
        b=HrKzv3ZRqsRCC3U1/PSWuEVryjgAzzPSGWHzNHsYt7Y1C4Eca7KgFrqZ9XdDWVy4Zl
         d5fW7BXVHmTVIUu/ISEdxvv+7+kF1Dwg54FlHBaTrK7Tv0axDaNDAdz5ldRNOHP+gHZQ
         nHrG2QjosKVdHwLVxSavEpEoPPCpPnla9M1dFj4NpZAi9BWmmvR+hc/GJpOfY3N9iVbh
         eojyGznYrarE7XkpgY0wTwhCtzwgJU64K5I5zEnnpoLpV8VdQ92mODHluT8NaoS/nWXU
         obNf4kESuosriZrQiVTARNLsAF4lBNJsilUjl+ynfIfpD8BORd+J7kCFvzGp8sJirdAD
         40zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WA3Zx/K6rjQxwFl6PY81C5/ohpgaP9Zjcq5R4O49D74=;
        b=w8NTctoM3BbYf7MJodCmoKRNYMIyQXz2rs9uvtfqYfbNd4BiDLo8VhDozMOpYWeLvi
         NuCaBmsahjSCiPnEDrjwIMKhb7FaWLSPi/JG5FH1Mu7EC6/JmAb/fFgAHEcDLu0OdJDJ
         z3LPNlhYc5ij7eODghdSapjOBLVw3DGk3acmRrzGynRT5yeiNfpbKzJd/jSA6eqAMmwv
         VOTX2iwqSiEyE2Utk7bl87gsk6BrmD+ZJC4Y+FsOaSFkz69Y+DWsABytGhw3z/elc3rI
         RNnfc4stmpKDxOzKwxjq+7SZf9l9+RMFUyuufEgIG3RW6UI2xW8Ee7f0yRa/Qb0JPa/S
         N97A==
X-Gm-Message-State: ANoB5pkzMxkS/20lSuSNjcnCGVA7wzUbGFJKNdp2rA3d4ZVVs0bNa5GT
	hjShLyck2NKveyTrEpqBOQ==
X-Google-Smtp-Source: AA0mqf6Q3N4t2KD+rV3a1woYYQeXfyVckBvEOLokd2DupCUcclQjyjf1lGRcblHWZWMZdKrREOqd8A==
X-Received: by 2002:a05:6808:2226:b0:35b:b24f:a002 with SMTP id bd38-20020a056808222600b0035bb24fa002mr11594476oib.226.1669963422106;
        Thu, 01 Dec 2022 22:43:42 -0800 (PST)
Received: from [127.0.0.1] ([20.225.236.99])
        by smtp.gmail.com with ESMTPSA id y19-20020a056871011300b0011dca1bd2cdsm3790787oab.0.2022.12.01.22.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 22:43:41 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221202053736.2980-1-geliang.tang@suse.com>
References: <20221202053736.2980-1-geliang.tang@suse.com>
Subject: Re: mptcp: use nlmsg_free instead of kfree_skb: Tests Results
Message-ID: <6afd1e2b-8e02-afe5-9dcd-294436a5fbbf@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Dec 2022 06:43:41 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except:
  - selftest_mptcp_join): Success! =
=E2=9C=85:
  - Task: https://cirrus-ci.com/task/6119246869561344
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6119246869561344/su=
mmary/summary.txt

- KVM Validation: debug (except:
  - selftest_mptcp_join): Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6682196822982656
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6682196822982656/summary/summary.txt

- KVM Validation: debug (only:
  - selftest_mptcp_join): Success! =
=E2=9C=85:
  - Task: https://cirrus-ci.com/task/4641503241830400
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4641503241830400/su=
mmary/summary.txt

- KVM Validation: normal (only:
  - =
selftest_mptcp_join): Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5556296916140032
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5556296916140032/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/041d29699a40


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

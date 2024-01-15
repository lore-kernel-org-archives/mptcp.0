Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1908717C61
	for <mptcp@lists.linux.dev>; Mon, 15 Jan 2024 17:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBw05vWl"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d3f3ee00a2so41734875ad.3
        for <mptcp@lists.linux.dev>; Mon, 15 Jan 2024 09:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705338461; x=1705943261; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mjz7TbW4plsyl0mkatMkDMKce7HbE9LtugtipteGK0g=;
        b=RBw05vWlUFSLQzCUvJPEfjqJh6aDHU/p97pWEH3zUF2zXiI71Eiuk6Qs+yHIeZBKIj
         Okcs158hHZFYA22h8Xgs2K1hFe3rm8ItF6MzXe/+q+M8LNPuZPjJhfI6eZtIfbBNYUYP
         mfhZODmw2Cm229mrbhV2Cgca0Sf2BLhTyx0WbatkiGgB8SqHfuSXU6LWNRDG2ZCMiJev
         Ac4zzHv74w+YzJxhLU6Yf3wrT18iG3gTSkCrwUa37MmgqGo9DT/cjVl5P8RuAzDuLeP9
         zIzfMmvV3UnwSOtJreQY2lEpcOmhsMxbZdDih+u9tSGOzcFQkTGEZTWkMR8mSFpugAtj
         baqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705338461; x=1705943261;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mjz7TbW4plsyl0mkatMkDMKce7HbE9LtugtipteGK0g=;
        b=YtmoSJKYiZLluhRgwpzhBsVKE11xpqfyLfg8j4jAzneEgJq9HTGdL03/6SHqH8saEE
         O38UKhSZ5usZ2uAyD53EqcWk52Hq89/rCjLdz4z5TdCRpb7phHnQd6xJOoy4gQstYW0e
         HBGP84CpCfJAmdZT9phhRCetPS9Y9T4V+ZgyU2fOhMgShEdQHfBwQAVv6EXk+u4LSvgl
         ZK8dxDO9T9jILiI8Leo0IAOPw2lhXkHWvIk2c9xJuatCibRSkxcO3UnLpRVeoGpfjip9
         XUDb8wmYxOZpcu9NwDatGRafSg0439j46ugfBiyCEtmhc3/UpuUEkDNNcmdq6Qlwcucw
         nrwA==
X-Gm-Message-State: AOJu0Yxlnxg/+rHmR2VG+aJp93PTgfgPueZxon2TES5ML1zsy+jS5a5+
	vy5tS1zkCUtQdozxGJhaYA==
X-Google-Smtp-Source: AGHT+IFjpyrUK2TB2op8BA5XWJPvAWxSyuPBlcNGDNygKnDe/OyOjyziik3g29h24VZSTmrdd9FbXw==
X-Received: by 2002:a17:903:2092:b0:1d4:6276:d29 with SMTP id d18-20020a170903209200b001d462760d29mr2475119plc.81.1705338461161;
        Mon, 15 Jan 2024 09:07:41 -0800 (PST)
Received: from [127.0.0.1] ([13.88.99.129])
        by smtp.gmail.com with ESMTPSA id g12-20020a1709026b4c00b001d08bbcf78bsm7707336plt.74.2024.01.15.09.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 09:07:40 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <56241fbd64982b15aed04269c8b963206661acea.1705331716.git.pabeni@redhat.com>
References:
 <56241fbd64982b15aed04269c8b963206661acea.1705331716.git.pabeni@redhat.com>
Subject: Re: mptcp: corner case locking for rx path fields initialization:
 Tests Results
Message-ID: <d540cb17-a0b9-c22d-aaf0-9684f491157b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jan 2024 17:07:40 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_fastopen =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5162165229846528
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5162165229846528/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6288065136689152
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6288065136689152/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/61ffb2fba924


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
Bot operated by Matthieu Baerts (NGI0 Core)

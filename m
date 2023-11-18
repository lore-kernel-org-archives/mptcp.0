Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F50C179BE
	for <mptcp@lists.linux.dev>; Sat, 18 Nov 2023 15:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0QKe8/k"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-66d093265dfso3333456d6.3
        for <mptcp@lists.linux.dev>; Sat, 18 Nov 2023 07:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700322182; x=1700926982; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JgfS0Emzo2QmCo7RzntW+m3iwlb5kCEms5MCXqfxqa8=;
        b=M0QKe8/k1FzDb+dDQcqzHsOrk0OFFew+/ScFFZoILWW15oZJ+cX6x8/fAxPN9yU3/Y
         BFxwJNirQbQ7T6tQ6J2/Pay2729mkSSc/eW7j4buUF3cQ3GfJPfmFe6jnKjY4IJxC0/x
         lLQXxkcsK9ULYAQJVD2z8Tok1yES9eJXWedO33I/fwBEBfUizl/+TjwIjVjJC9vpAW2H
         ER0xX4/IPMAaI92I6xz+Rfo3TI6qybTSx9VaixmKrWZR9O4x42R9lay+ZKhPV40aZK3Q
         XMnQexQPiAPpXrqswMdbmdzUBibickvVLqvE1aMfjpgR6Wb2JPmKbgpiBQYsvTXP7ql2
         XVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700322182; x=1700926982;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JgfS0Emzo2QmCo7RzntW+m3iwlb5kCEms5MCXqfxqa8=;
        b=SeJ48BxO8dujUcaNbX0EpQNGJJKU9ctM164SwWZMqx1l1YuW0T7CMVc/7bSzuLm/qG
         ZT6gpOVN7Y28BrxyLULM2webzqL4ExqQIRlTTM2/FqY57KxVbw5G7nGcXdl3defgqeUX
         UXNvERtI81w3ccMAsGxs15jOJld7gbdluzAJhBVViZNk/qjjN7jrLZqSfvlx2gIJ5yfm
         EdgKOmWfPQmJw9pYrkzx99iyaBtxHc1+ZQBtCJU1R3vjgEp2A05rvXr91vZg09p4Qam7
         EXsLIa6E0/SWkYOWYHbPYAHzvB68TZhqow49PC1broBW+Eid5pRyTHn4wFGnAnf3SqZ7
         8Xkw==
X-Gm-Message-State: AOJu0YxJSs0BYPVsxV3qybbA6pmvpCeoKPK9QdIf7jAW0Bpjjq8IsKWn
	Y5dqYY4GVIbTAtsHBnQfAA==
X-Google-Smtp-Source: AGHT+IEN2TTUJEHcHh+WaDyWDr4dFOp80z1vnyx8vwFRTsbte2Dq6ssUCPnE1vGeS/fKdDPdCAjnLA==
X-Received: by 2002:a0c:dc13:0:b0:66d:63f8:255f with SMTP id s19-20020a0cdc13000000b0066d63f8255fmr2607835qvk.56.1700322181997;
        Sat, 18 Nov 2023 07:43:01 -0800 (PST)
Received: from [127.0.0.1] ([172.183.131.18])
        by smtp.gmail.com with ESMTPSA id pz12-20020ad4550c000000b0066d15724ff7sm1471463qvb.52.2023.11.18.07.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 07:43:01 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <e1ed5ed2d12a875bf6807d2c973784ed01ac6658.1700312872.git.geliang.tang@suse.com>
References:
 <e1ed5ed2d12a875bf6807d2c973784ed01ac6658.1700312872.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: rm userspace addr with random order: Tests
 Results
Message-ID: <69611eb5-29dd-6280-d290-14d2754f48fe@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Nov 2023 15:43:00 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5025140900102144
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5025140900102144/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6151040806944768
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6151040806944768/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5588090853523456
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5588090853523456/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6713990760366080
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6713990760366080/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/4aa3e7cfdf1c


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

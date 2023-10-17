Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A981FD5
	for <mptcp@lists.linux.dev>; Tue, 17 Oct 2023 04:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crfzIZNz"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-77409065623so303920285a.0
        for <mptcp@lists.linux.dev>; Mon, 16 Oct 2023 21:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697515719; x=1698120519; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uKMECeapINOlbqvTjQlcMsdmk9e5HLsQ6AupVx6huH0=;
        b=crfzIZNzrhrcgrgycsXdSkh2PM6wZle87FO2BrClfSBz8lTMx6AVamcvuUOfJ4U60V
         VniLNkVjvDlyIuOdafTGr7ViXbJB1EW+eGskyOV8a+HsOeMskWwvOrKYPSz12fM4Jmo2
         PYNtw/4y4dbG707UjFNaXAipnARAE+x4t6579suWfx6ikayYT7ZlWAbtnf7bNVRMhItV
         lbKXmkXBOK3uGIMg7JLBUkwqCTTGmdEqS9T1SX883HOU+Tqj8OShKiHGN16Sf4B5dRfi
         OHohvoeiUfz8MbEXU/Dx8U2lrF0AEctBgUzayDp/QnZ8KLJZkCtKDG7OBTBxTmQNd1xn
         bToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697515719; x=1698120519;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uKMECeapINOlbqvTjQlcMsdmk9e5HLsQ6AupVx6huH0=;
        b=IIAXdnIV7Z8DAJVHq7ZnGh+V6iHm/NJAUtKZo3Awsqa/qO7jY+BY5YySe/wxN5gJhi
         nw15UaJ0QCdCFQgcalnhBOU0wfoRUURp7+9dAKTbmMOu4vqpGu4+REO0iCM+Wat/hiBu
         M0c8sUu/Vqq2T1S/eLagC9OD/dqwI4qPyMFjBspt7xBRfhedozx7PBXMggl5+3QmD53w
         IHVzKbS1TarCxAp7kFXpWlHId782ctqX/ZMhlmQ8x4TeGOzkQGXPmozcOVADgjIRsflG
         NwA5O07/kcSJHq5/vRXZjptKbjG3atyUtx4LDccbnS7D/rbrmpvRKUj0IgB90uIy7L8W
         jBSA==
X-Gm-Message-State: AOJu0Yy/ngMYmxfUjrNjluU23WEWfOczajVqvgs5sBijAHAFWx/1sT0o
	zYajGif/s2tnjgfxpYCvWjqKesfD6g==
X-Google-Smtp-Source: AGHT+IHG+EPP9+sZj57YMuVWDYbboyt7DupYBexnigH+ammx6xaxjkhmJhPXb5IXJ+ksGTNRa4KSBw==
X-Received: by 2002:a05:620a:2406:b0:774:16fc:65eb with SMTP id d6-20020a05620a240600b0077416fc65ebmr1360078qkn.4.1697515719253;
        Mon, 16 Oct 2023 21:08:39 -0700 (PDT)
Received: from [127.0.0.1] ([20.57.44.125])
        by smtp.gmail.com with ESMTPSA id u22-20020a05620a085600b00767d572d651sm316532qku.87.2023.10.16.21.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 21:08:38 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <d85a4f247289d84da2c6a8235afc46fa144a91e7.1697511436.git.geliang.tang@suse.com>
References:
 <d85a4f247289d84da2c6a8235afc46fa144a91e7.1697511436.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: userspace pm send RM_ADDR for ID 0: Tests
 Results
Message-ID: <dd43ecbb-0915-fb87-4013-8ae173d3f8a7@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Oct 2023 04:08:38 +0000
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
com/task/6363765940158464
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6363765940158464/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4956391056605184
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4956391056605184/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5519341010026496
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5519341010026496/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6082290963447808
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6082290963447808/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/32eeb039f540


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

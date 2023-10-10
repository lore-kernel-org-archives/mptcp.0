Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5842FE07
	for <mptcp@lists.linux.dev>; Tue, 10 Oct 2023 17:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7huOrnx"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1c8a1541232so25677005ad.0
        for <mptcp@lists.linux.dev>; Tue, 10 Oct 2023 10:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696957454; x=1697562254; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gI7aKbvWV9fjNFnI3voeTQJGfMaYkYbNlkGysY97fVw=;
        b=J7huOrnx413Zi6L1AswPf34H/XCt9RKnr1ZiRVZ518sJ0shoft1th8EuWzsWvITWwQ
         sQ7TTk55/U7up6YkkVL2bGfTotxd49DqVehqParv8kyLrZehqFlzYphWFUkF6blPBy9K
         UBRAg3NOI9aIInUJW1yXDKhk7FYd6InCtRKfTd1HJyWB0S7BKYmLJ/evxHHsrl0RGmhg
         s/0kO0wDpIpLqoq7Yg3/J5uIU3+5723Tvl1gnPMOuFqijcTLOFcwJGkFtLLxL1m36DFt
         QK8+hIjSinLXkSBL/3So2fcoXJDAw4F4DMGkAtZ8UsbeTmW/2U/G4oUhpohMsPoBCn6n
         +FPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696957454; x=1697562254;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gI7aKbvWV9fjNFnI3voeTQJGfMaYkYbNlkGysY97fVw=;
        b=AyfpECTPcYjw8z7ERbDwborMMXzBsBBVo80Rlp1PxnR9R8NAxXNwTMzPX1nRLSSUn/
         GlquxOnGdNxSs9mjglUdDMkPpIiWUlEYa30NwhOxn8/oOlSg+L7qJ7ZXFAfEEI5SX5JE
         N8uCXE2VtPwpVrX3D2SvLEPrgHB6DVwOQxsX39HYj5KbWsNJF3R88BPSKn6qyDLkeOLk
         tnH0FTuENH/YiLmsSGF7UVluOVS8DetG1vI7h1bKoFK0ySETNj0lAywIRgir9mOqMP57
         A9lTAHV2EU58HmKtTqqCgIcOsQTFaebuJRXz5nRupDHL2MQ2MO4tR1XeSt/0STWG1Bjv
         ROGg==
X-Gm-Message-State: AOJu0YwJAFNSLR3zL5gMuJwywQVdkFyLfwtScddxeHZazp/umGcETQbY
	BRMZ/iLyjgoyOlLhytSCfw==
X-Google-Smtp-Source: AGHT+IEoShsjLRiFyTEy+6OXXSmOE48MDsA2UxCBI3HDnEWiMeMOHTVSSw3ClOdx5uEnVQLbKBHlCA==
X-Received: by 2002:a17:902:74c7:b0:1c5:6309:e1e2 with SMTP id f7-20020a17090274c700b001c56309e1e2mr19627867plt.48.1696957453443;
        Tue, 10 Oct 2023 10:04:13 -0700 (PDT)
Received: from [127.0.0.1] ([4.154.90.102])
        by smtp.gmail.com with ESMTPSA id l13-20020a170902d34d00b001bb9f104328sm12048342plk.146.2023.10.10.10.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 10:04:13 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <1d0e4528ab057a246fd8c60b91cffd34f277b957.1696848602.git.pabeni@redhat.com>
References:
 <1d0e4528ab057a246fd8c60b91cffd34f277b957.1696848602.git.pabeni@redhat.com>
Subject: Re: tcp: allow again tcp_disconnect() when threads are waiting:
 Tests Results
Message-ID: <70ad4b7b-a21c-13a9-9b2a-5481cd957eb5@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Oct 2023 17:04:12 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4553811692355584
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4553811692355584/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_mp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5116761645776896
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5116761645776896/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6242661552619520
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6242661552619520/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5679711599198208
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5679711599198208/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/0483d0f88d12


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

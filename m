Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04213C8C3
	for <mptcp@lists.linux.dev>; Mon, 13 Nov 2023 04:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXw8qEqV"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6b20a48522fso3195287b3a.1
        for <mptcp@lists.linux.dev>; Sun, 12 Nov 2023 20:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699848340; x=1700453140; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1aPbE06PDxDgaF/2T02R/ZRtl6Vllp0tMT8AHSTYYE=;
        b=gXw8qEqVELqLlNCdW/bx013An5mLBl6SuXhXDSaxochWC5cI8s3GPf3vxfpeLIGWdO
         d9zq9isNg1fv/O0lUlSW5SUTS6zPgCuQkstg6lLiZnhr0BM51WylBbRbKrVJ6QS9HAs6
         TbCdFme+NjTUszr8lRWHuFKzjw/XTSj11jaaXCUvnTgX/ea0G4joqVjXBuANxAVcRFw2
         Fu1JA21/vnrjFoM5XpPRRzzbTgef/vmFge87400Di1S8KjDI3UyF31TcDW9D5MRCNv1P
         I1GNlpzj7mYi0zZksVlScwaDHrLK4yhBjiK/kVoSB8CxGmo5CKSeKOEvCru0IbTuQnYH
         xAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699848340; x=1700453140;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N1aPbE06PDxDgaF/2T02R/ZRtl6Vllp0tMT8AHSTYYE=;
        b=mV9dmA4SaXH550ytRHdkPqJ7nxj0bLxYUgCAW08SqhLhzdUG/uUQ5c/gxwSd2TGjYR
         mZeIwmmS5sDDAsXGcVe15FZ5FVWTPhcwn/ZMH8Tk4rOB5IpUj37OY+f0QwfGQ7op7CxX
         RJOm0nFHR3QwY0KHjKvREpqcxtEEQCW/67osugZjwW3HWj5sZ5VCRFgBDbUYcq3b7aEV
         uYzhYfVmwyQlHr6/NZoXCE9v98WZ7C3CnrFSvOuKJEekMlkpmH1TfTfHXYnBsQjc928E
         XTEPAYhsd3oMGysT7gZx2+w1p8J3SFOdxb1udTNwaerd+wvxqUgGPNtWpxzOIBumDUjU
         DiJw==
X-Gm-Message-State: AOJu0YyRIBUXMYaX0DMF8Q5U+EFNafckcozdQHNYb7bWirOn6s4q3EIm
	M0/ElqKboWtHCL+xgFD3Q0ZMKUkTKA==
X-Google-Smtp-Source: AGHT+IHjF4Kb7mUEDGvLg4HkbcgR2My07phqSJin94Tr40euX5GvYWUFPHSieiXNWl5J3ckTxwEoUg==
X-Received: by 2002:a05:6a00:1b4c:b0:6c2:cf23:3e14 with SMTP id o12-20020a056a001b4c00b006c2cf233e14mr2769251pfv.15.1699848340129;
        Sun, 12 Nov 2023 20:05:40 -0800 (PST)
Received: from [127.0.0.1] ([20.172.0.32])
        by smtp.gmail.com with ESMTPSA id g12-20020a056a0023cc00b0068842ebfd10sm3082948pfc.160.2023.11.12.20.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 20:05:39 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <27e54f7fe28b65996b69566847e9cc8675a43d43.1699843617.git.geliang.tang@suse.com>
References:
 <27e54f7fe28b65996b69566847e9cc8675a43d43.1699843617.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: rm userspace addr with random order: Tests
 Results
Message-ID: <d7303fb7-1b87-d0fe-6747-1d486bd0561d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Nov 2023 04:05:39 +0000
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
com/task/6031376642736128
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6031376642736128/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6594326596157440
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6594326596157440/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/4764739247538176
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4764739247538176/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5468426689314816
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5468426689314816/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/1e45f73d9483


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

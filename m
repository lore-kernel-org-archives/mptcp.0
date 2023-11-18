Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED62CA7C
	for <mptcp@lists.linux.dev>; Sat, 18 Nov 2023 04:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFCDxC74"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1cc3bc5df96so21672655ad.2
        for <mptcp@lists.linux.dev>; Fri, 17 Nov 2023 20:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700281421; x=1700886221; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCQVWfsMQLK+3mVwiZCskc9Vq6tEtVpv8GECRCXSmyA=;
        b=YFCDxC74GouHyNYNxBULYdSyV4ArcrgGj7Q5abifPyJepvQIgsIS5uuKJsMmJKPOT/
         hY7LP21uPvxJ4wvOw3Qbgda87tPvOmgZX96UdRvcWuergls0qsqMPE1GDWHwb7iUrfHc
         zTO9mqhOIoNwAVLSZUJXvGdxBabzFf9+zBWEXIq0jGshL5cAo6+IyyqpTAr13WxB3nh+
         YsZqE5Xv9telr5WVPxfDkfFQKyKQdQGKAZ4nZ5Qgh0pzKlXV93FiiYFytp8+gT6O8NlU
         VXl4z2coMkAVdfLFvhyPH/FyOUZqk5z9MN41kGl4e2q7ZhAZat141BQBkktLvJAA9myA
         e3eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700281421; x=1700886221;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FCQVWfsMQLK+3mVwiZCskc9Vq6tEtVpv8GECRCXSmyA=;
        b=sxBqvwdKXLNM8SyvglA/INOCKytDBgtcUfw0n6wpfiuFsUCpUPPQPVoFWOxiNfP8j9
         qR+nJ5bBRZKCJls8XcUVwSB/toW3BZmrS8MC+3U8UWhu5I5bHGBuFgs7ZIl672JaZSrb
         TlreCDWihmb11hMhKu4IxTPGKYZOLDGOHN0H+S39gQTqOC7cMBwuddq7Ck3Ov+gje4e8
         5uCQLfja/0L7wJx9v3wvoJg+xGHSjfoCLxnT82cZnM/n1eLLmB3IU2oANEjTsRCAd10a
         hDalD/h1mdm0cSVjb+PMykUfGj/aq8X6ewl8O+IaYWdIXae2xNv48mV6m5MelAdxwxhi
         NWxA==
X-Gm-Message-State: AOJu0YwiSvrCb7sU6RDj4AhI9mob3IPMDwJLrQ761SYhrwIxCSbbOtQc
	k+rz6dr3wqgVvHY3GADFeE7KKOLNpA==
X-Google-Smtp-Source: AGHT+IGKQV8B14G8Q6wIA9duXB/sqPk1wAyeh4mWTKgOYxnn6jqSdBsfRNfEMDwYABzAPeBblA7llg==
X-Received: by 2002:a17:903:2349:b0:1ce:5b6f:168b with SMTP id c9-20020a170903234900b001ce5b6f168bmr1610544plh.57.1700281420678;
        Fri, 17 Nov 2023 20:23:40 -0800 (PST)
Received: from [127.0.0.1] ([20.172.5.81])
        by smtp.gmail.com with ESMTPSA id a22-20020a1709027d9600b001bf8779e051sm2101203plm.289.2023.11.17.20.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 20:23:40 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <4bcf528d5ec4163c0ed64bc62566d8574e7f09d1.1700277365.git.geliang.tang@suse.com>
References:
 <4bcf528d5ec4163c0ed64bc62566d8574e7f09d1.1700277365.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests=3A_mptcp=3A?=
 =?UTF-8?Q?_add_chk=5Fsubflows=5Ftotal_helper=22=3A?=
 =?UTF-8?Q?_Tests_Results?=
Message-ID: <c04585e4-b30e-69ce-7d71-1504b9b4ce23@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Nov 2023 04:23:39 +0000
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
com/task/5512708926210048
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5512708926210048/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6638608833052672
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6638608833052672/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5723815158743040
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5723815158743040/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4597915251900416
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4597915251900416/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/edb3c8cd0a32


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

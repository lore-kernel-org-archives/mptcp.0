Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CF1C8E2
	for <mptcp@lists.linux.dev>; Fri, 13 Oct 2023 06:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V26/3Hib"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-d81dd7d76e0so1843433276.1
        for <mptcp@lists.linux.dev>; Thu, 12 Oct 2023 23:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697180268; x=1697785068; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5tRJ4VWNQcF9V2GtrGPFNLRN2nWTk0C6fqaFsfvMlo=;
        b=V26/3Hibqx8XS16vS2KgmEbVlXp++LXSlie0L+q2IaoT7IlQBOQSMLtkFhhTAHlAvt
         j5oEDM+j6i0y8AwUUPKUAvP7HS4NvEy+epndOg5n/OVLUN4fw0vDWO4X8ycH0KP8f2+N
         nDhGZuRuFUpck83zkPrCsQo5jiQug+snuKpzDNyWz6gpdCQkrx7nmYBmVby0nYkPNjxo
         1qo5Z1i0E/kpFdWiYE0oYKpgcliQFF4prSDD++UdRPvs94mjRVrcOBqJ2x5no1q98c1/
         RxD1VQTf8xTKKgjWYKdge3rJn0ee2a5FvYwIcsugI4qxciUU1/BHSidwKRDuWpcPatOi
         LMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697180268; x=1697785068;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T5tRJ4VWNQcF9V2GtrGPFNLRN2nWTk0C6fqaFsfvMlo=;
        b=ffRwgnPVIIZBkSdcKRNthhPLRSZf8PYSzYOVHyU6cEN2VUWgOgr3tTbP2QT1MI64FB
         8/8QKr/vZJI1BFD1OggMPMceJ0PmpatFfK0RdDHuihGB/1DEZX7nOSUYGMlXI4aafDwL
         a7UuR9DQlPeo3nEhtvcyEMV6UvP4wf+WyHDTz47T1pUJfR8LTWUJpb+xrsT0jtVJyRKf
         ch6WfSJn564D3bRopYF/iUeup/v64hWbWFSWU7ST5kwVCIP8sMj5UCmCsWYpGsRmM7Vq
         EJaLcNWBVjyQAw+hZDcQ72Mio74M9dutXblUXopqWeYYk752Xiz+8rQv2YJrw9WZMWNs
         8vFA==
X-Gm-Message-State: AOJu0YzobbDItICYrnTz2anI+k6CMI7bkpcgBS8wYicYXN+WXeQ5fFPx
	cQT8mqtI9NfE0lMKy9Va7A==
X-Google-Smtp-Source: AGHT+IFZtQADvIHdZ1K1LYub9nYI4Zv7xswYEa18mmMhPLpLNKhpg7hGbkdyuhAQhZ1dIjc8x2DxwQ==
X-Received: by 2002:a25:24c9:0:b0:d9a:4ae7:bd68 with SMTP id k192-20020a2524c9000000b00d9a4ae7bd68mr10164194ybk.21.1697180268351;
        Thu, 12 Oct 2023 23:57:48 -0700 (PDT)
Received: from [127.0.0.1] ([4.155.40.28])
        by smtp.gmail.com with ESMTPSA id fm3-20020a056a002f8300b0068bbd43a6e2sm13281859pfb.10.2023.10.12.23.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 23:57:47 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <594e783ea19b4a53fe4b4d77a449077dc932fa45.1697175899.git.geliang.tang@suse.com>
References:
 <594e783ea19b4a53fe4b4d77a449077dc932fa45.1697175899.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: userspace pm send RM_ADDR for ID 0: Tests
 Results
Message-ID: <fb4af826-5d5f-4df5-4167-78ff39ac1cde@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Oct 2023 06:57:47 +0000
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
com/task/6399951429697536
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6399951429697536/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4992576546144256
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4992576546144256/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5555526499565568
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5555526499565568/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6118476452986880
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6118476452986880/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/6458a1f8c548


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

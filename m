Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A541EC05
	for <mptcp@lists.linux.dev>; Wed,  9 Nov 2022 16:42:35 +0000 (UTC)
Received: by mail-qk1-f179.google.com with SMTP id f8so11266304qkg.3
        for <mptcp@lists.linux.dev>; Wed, 09 Nov 2022 08:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwLB9DY0ATKiJAV1DjVNIGhiT7qmQRVzwh0jMnUGlO0=;
        b=bl6XdSHyC3fo0ZWjRcn4DzMJlysjXBMiqHltRMTsX+wIrBSsBbuWqvGs8mA4KusfMF
         JBxN8lzhcIZXqtT+aMoyQBI+UienYQDbP3X6e2hUNv/VEsDOOBE+4JnDTkWsJVnP9ZBu
         nTG7uyPoE8E/RIpJ9qZ/9EW5RPA0VO9mOx3ZryHiXz2C/ioyWW4cX8xRuZbhncSCo6CU
         awWaQDFkFep1aUVOo9sq8Mz9t2H/oPxS3nq/TX9KGuZRZmSYE1KWxNg3qKThZjGolvCp
         HKjd7Vx5R8j0gOoezJzLogTK9sonEFGRdLoUw0eRuUCAzZnk5LwGWBg4LO3EGnH43G0o
         2G/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nwLB9DY0ATKiJAV1DjVNIGhiT7qmQRVzwh0jMnUGlO0=;
        b=G/4sryY4RWkRY8rx4VjgAliXY5ZnDjM2+OJTVDw10OVa9LjCmLEVG9FWWcsgaROtK6
         tH1YwAtTesSfbmG2nSOKbvv6VVaXQUUDxPgIh0bz/ca22ROb0OaSMAxFy/bPz4uB0lSQ
         vIXnstkhphgtupbvDzNASBzYTSsZPl73gs1oh1qyMXP3H6QwVe14LOsU01OhMeLRa8A0
         HWDIKLm7sZrEsTr3t672ZwTj44NcfDHZGg4HeK4SLSw4XaH5E4Dubrv9cTW9cv5YO/Fv
         uxPIhlidh2En45BaU6SOd/KDdyKyUAowPLJW/DOrMu248K+TLBQs1+LZZQyVvi6c3OhQ
         X0nA==
X-Gm-Message-State: ACrzQf2BhDlhVBpDdj4Cidsq/+xn1a13340n3X2u8BsjBDrCMGVmwTyA
	LZHsGbVurK4IP/KB+C97Ca0z1ZNVi9RyiiU=
X-Google-Smtp-Source: AMsMyM5n31EebovdGGPQxyNpo7dlYXDPQ2EhO6wUfhyGN0Vq2EuxDyuNtgLxrSGD8EjDSAw8EAcQ+w==
X-Received: by 2002:a05:620a:2889:b0:6cf:5798:e126 with SMTP id j9-20020a05620a288900b006cf5798e126mr44583343qkp.588.1668012153947;
        Wed, 09 Nov 2022 08:42:33 -0800 (PST)
Received: from [127.0.0.1] ([52.152.164.173])
        by smtp.gmail.com with ESMTPSA id r3-20020a05620a298300b006eecc4a0de9sm11810401qkp.62.2022.11.09.08.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 08:42:33 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <4edc02c8a8e040d0ac212ff61d9256c8148f2429.1667993416.git.pabeni@redhat.com>
References:
 <4edc02c8a8e040d0ac212ff61d9256c8148f2429.1667993416.git.pabeni@redhat.com>
Subject: Re: mptcp: track accuratelly the incoming MPC suboption type.:
 Tests Results
Message-ID: <40d8ce34-c0cc-796c-2d59-6125b1b3323e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Nov 2022 16:42:32 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/6400536625807360
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6400536625807360/summary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/4993161742254080
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/4993161742254080/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/7a66b9b991d0


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

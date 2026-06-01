Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F861F0991
	for <mptcp@lists.linux.dev>; Mon,  1 Jun 2026 09:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780306893; cv=none; b=Oxk+bqrvYG7jZhrkkgsKCuHqrmvIs96TLK0ucqrQJl6u33hFOqqO8VNf7eajmWX7Lefa+mLAk4hvxFVeUfqVIv19GcMhDM1L7uoJ+vCppBbznEJWJnG6yfp5+q8vUPIxWqCkL84erxqSmdH6P0/6ELiWzQ2HSzGCcHFApYkLpck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780306893; c=relaxed/simple;
	bh=x5Um+Ru/FPOCkY9h0zkWlKGON06uUjPRRBtpwoqURrk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=QdJK1mNO17eAnKW8+Ora4DhhC7Q+/0fFdnRT+T+szFKB+8h7CTCv+yQpdVhbpEiGjq92n16JDs2GRYXw4xL4KP3pDxQS3p7u3SkTh1RKZcuEYHVg8iIdd1v4hF7I705JjXhO//MmatSJzMUMEjDn/KJqYMbo7hWH85P7f7cZXnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lEj7Gh9h; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEj7Gh9h"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8ccce57762cso50314606d6.3
        for <mptcp@lists.linux.dev>; Mon, 01 Jun 2026 02:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780306892; x=1780911692; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Cn++HWNxtdDMJIdeLI9JmBkxe3KMrod+rXybl3aGCA=;
        b=lEj7Gh9hUHAWuGoQz8YIVfpoKh3djZiNzIaUHagFK6k7riJz57ztqHjlewPercrE3z
         16NoSQCR0+kgIESk6qdwy9+R0v5ZUo1k52+fRyYJznWLQXzlsttth7KiG/PdQPMQdUK5
         aLweAr3fa1kEP19z3ReJyCQ9RaTE6smTmt+NSmfXGuiah8oSq2GRfif68xuBwKF7B98L
         ZYE2JlN+X43Vl+jW2UTaaQf2BzES319/ajpfIzEjmexUvIyKIzQmBEALl7lxR0p6rijO
         Jvau/0ipzaTMCy0j5yfUYg+RdFCSiUO2y6p65EsWqB5XzVGnNAx6W8p90S2Kf9Ah34xa
         vGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780306892; x=1780911692;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Cn++HWNxtdDMJIdeLI9JmBkxe3KMrod+rXybl3aGCA=;
        b=URLTApnxRUMFqwK4SQM+C6Mw/UPXg7v2Dsxw06LzKIB6jHWplChu6sFb5mCxpSAcRA
         sVrfC4/TUgCBfe607RaAiu9vVTPcXzT6nV/oMZtO18hNaJeYSIRYwLt954mTNtac24zp
         j0aEeIkWDEyTo9797/VhatOZfRth+NMOGIoAGpHUqObnhp93/w7JfezsFZxvziAef5al
         j++zFbICEvl7WLdp7kAGqU9Ib4lZpM4gAqCZaqaD088LJlQup8YOmVZSMml18m8CmUCH
         xR7bWAdBZ0pift263b1JPrrSIT2B0ux4OIUNR/wpOE7MIHY5rZoPhY/7Mlm6WTAuqSsl
         Rxdg==
X-Gm-Message-State: AOJu0YyS/xxMCwbQVF345TYSiMGWvGsLd6ZeX4PBaO3tUfcaR6ivYI6q
	ttbbwIDdd/Wib0BCPV+o7tOZTJx9kt4ltBEBEwmNSHA1Vu9aj5RW6nApJGIZ
X-Gm-Gg: Acq92OEC0iF96GVpFW7W/B2eLygnTQDlefiD8MnsxPdfi0zqMXsY9TVh/MgLl/+UGtX
	y/ZjV0/wzL90a78+qlz9RX5Cw2piBVBGLcCSMHjFxoT24E9E4jsxwxBhwvfa7WhCb/0GBVNXjos
	ZuukXMDoBChY0s+wQYzcJAW32QKk66nGXnwOvVdpjasd3Ut9lvxfaBdX6ANGSBLt6WgBgMAk3OD
	/vbZT8y+QQsrVhQb5Cho0Lb4nDFovkZxJEEzPyJCr8VDbjc2wcAeB7F1MaCbEHLkDAqPgdhoBmh
	9pLxD+X5gJG3mvFV2+A4n/aQ/EzL+5UZ9K8Yc7lUBW1yBOvmlPNDXNNsOCYw53z+5EdSYJDuz4Y
	fSrqx+ZSlVmsnTD4susw3LiCSuqURkyNu3GJNLFw40EFS6HeVZ2zo/gUkBaUJ9JAlW5WpzoKdjW
	41TWZqldl5g7sVunn2z61P+Iyk7CiK9cHx1qQ4ZLxnD/x0BBcjpA==
X-Received: by 2002:a05:6214:48e:b0:8ba:2c02:f9d6 with SMTP id 6a1803df08f44-8ccefdb724amr159057446d6.35.1780306891650;
        Mon, 01 Jun 2026 02:41:31 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.211.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea0451c7sm87961486d6.6.2026.06.01.02.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 02:41:31 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260601083010.924938-1-kalpan.jani@mpiricsoftware.com>
References: <20260601083010.924938-1-kalpan.jani@mpiricsoftware.com>
Subject: Re: [PATCH net v4] mptcp: fix stale skb->sk reference on subflow
 close
Message-ID: <48014ce1-06f3-f075-f509-2df703553e58@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 09:41:30 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Kalpan,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_mptcp_connect_checksum =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/267448=
12858

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/60889317c233
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1103840


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

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
Bot operated by Matthieu Baerts (NGI0 =
Core)

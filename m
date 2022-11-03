Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D6C6FD6
	for <mptcp@lists.linux.dev>; Thu,  3 Nov 2022 13:21:04 +0000 (UTC)
Received: by mail-qv1-f43.google.com with SMTP id x15so1081179qvp.1
        for <mptcp@lists.linux.dev>; Thu, 03 Nov 2022 06:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UjUbsdFZ3YziyFmdy9/XRTGWCbuCzDiRhGFIyfPvHr4=;
        b=GvJoHoGwN/f69bNDeApAgWXFyX9tyjTVXFrfkJf1kzApIEd7xnPs6tu4DS2jONR4an
         PctZD7Jj90dIp4NWKJGtWx7KPGX3iVLYBq05lX1H/qt++e/dziKrnKbD5jC+YHb5KtS/
         YML3MAn8zH2krunbellWj9lYyjo2zIKuFPavpcyaX+KwCsDMpLmHWJ/boEa9a5+WTMIl
         ljJ0bNeEqyLBaDh0s1ZT2zU5YL+JhXGt7Gr8p5C3wP92n/de9LBaRJq1mR95mmbCPLAF
         pFbEWyWXYqr48mNYvFVmIsKFiUf7w7GuzcFKcS/jjSNFJiGnSPLZoIbkFHrENHd1Fg14
         xAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UjUbsdFZ3YziyFmdy9/XRTGWCbuCzDiRhGFIyfPvHr4=;
        b=vmUQFTARPZQBSblSREmP3L+9sK7nBDQSwuO0LkTm5ac75vR6uf+73ajRRxv155nsPK
         HBMkBeJ2xL+H/jaftpdZZUp31S7nlzVB75T0+PX8C5VNRlub6hzY9HEG2fqRpAcjM96T
         n1rdm52khSeafauPnLXR1WJlgsZ4MCFNrPi3n4sSo3F1jNfJtMfaBIJHwbvKgfrUdmOL
         7egSVsCC/A81nLahMsCOcPrRX71OvT7ezGq1jRV5B/ncbEhKnZahKEyF/KMpKZ2ZOFb9
         ZPqa2qU+FSMyXjaYYhD3/oyMQbbhTbBpOQKJePeROT4F6eZKKQwi+K3UMxiVzFPBYf0G
         rcBQ==
X-Gm-Message-State: ACrzQf2eqpTnuPwH+PhrmGHGx9UOmFyZmEp0Jw5uObTS0txnvCAl7YaC
	r2V7aI3h+SiFOwvAGBp+jw==
X-Google-Smtp-Source: AMsMyM7YsJ00Yd5m69hUBObarfVbUj+NFeluUu8zU/Z3NWtVVlv0WL6OIz4UuW8uLswOWE+uNtdlUQ==
X-Received: by 2002:a0c:ab84:0:b0:4b3:f42b:2f18 with SMTP id j4-20020a0cab84000000b004b3f42b2f18mr27365561qvb.125.1667481663886;
        Thu, 03 Nov 2022 06:21:03 -0700 (PDT)
Received: from [127.0.0.1] ([20.10.177.148])
        by smtp.gmail.com with ESMTPSA id h8-20020a05620a244800b006eeb3165554sm778176qkn.19.2022.11.03.06.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 06:21:03 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Menglong Dong <imagedong@tencent.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221103110649.299284-5-imagedong@tencent.com>
References: <20221103110649.299284-5-imagedong@tencent.com>
Subject: Re: selftest: mptcp: add test for mptcp socket in use: Tests
 Results
Message-ID: <20c04c0d-8110-535b-0ce9-65eca5bda725@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Nov 2022 13:21:02 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Menglong,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/4909154062565376
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/4909154062565376/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): selftest_diag =
=F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6035053969408000
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6035053969408000/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/aa327877c6f9


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

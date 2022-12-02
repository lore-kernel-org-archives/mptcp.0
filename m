Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A158B4C8E
	for <mptcp@lists.linux.dev>; Fri,  2 Dec 2022 19:32:46 +0000 (UTC)
Received: by mail-io1-f44.google.com with SMTP id n188so3704674iof.8
        for <mptcp@lists.linux.dev>; Fri, 02 Dec 2022 11:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qxPS2JUBYZ49BeIodutrE+4nJMauF95fNcOYivtZ8E=;
        b=lau58CDCN4LHyhbL3brWckOCbUIDRdW/xqN3n0kh2JD8oU6bF+6ySh+cLLALKaWjLY
         TrERge6ysaol9ElpiAaOubS0trtuAQ/GjbsduoBAz9hktVEP2kW+EJrG8gYwVeMHvXOu
         thyJLJWxFNqLOjveLuWvDrCQY2fMBqpk5FL0Z9J41I2zUMxnnGYYkIdJgqySyLwXyNIb
         x7OxsiCtSbmw23jreBnZHii06otZpVo44pakjeUhUkqeq8SH7ognNA25fVF4CUgs/k3H
         PErRRb13UEl2avnB5A/eru1tEfK++EEgRjs7sh/Qc31bLn8bn9+T4pNmo46vfVW5vmue
         cIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3qxPS2JUBYZ49BeIodutrE+4nJMauF95fNcOYivtZ8E=;
        b=hFTWaz1zw3Dqlw5Ava0zowRKLZbf1pP0dkJCJSgWD66xztHo1BULfSWjkFM5z2LTzj
         oSjcUb43q2RKZzIzJSqqxUIz6Us03uMRzSrMBTg1Pqh3zAlNGYaddgD3E8LKkMUdCRci
         97uBIEMu/NPSxTCQ+rA3hokfuc82FoTktxCoN5be17an8P6D7UV2Fn4A2DStT6lBajMZ
         kV//W23GZQDhZd4GwAdbSnmHgvfqAMbDSOvzEiTyjvag2RdKAZM8uJMDPGzjxvpRn2Vo
         rDV/G5Z5E83k3MHtEv3aM29T/XoXF4dxhg4tJ2EurWQicKwkzpRq34bxIlPQe/xx5gUQ
         1L7Q==
X-Gm-Message-State: ANoB5pl5Hr7pUvqRCrcSxOm1Qu8KrKyAt/dFM44KWc7ImXsY+jRY8pBy
	jaCJ8oppeXQ09LtYIBiHXw==
X-Google-Smtp-Source: AA0mqf5ile2myI2kshspoRTa+SBVy/I038+CC5VKlQ34cr/BBTgVH5T7HI7gkZB5L4ZGiHbM4p9oPw==
X-Received: by 2002:a02:cd12:0:b0:389:cc3d:51da with SMTP id g18-20020a02cd12000000b00389cc3d51damr16927561jaq.303.1670009565691;
        Fri, 02 Dec 2022 11:32:45 -0800 (PST)
Received: from [127.0.0.1] ([104.208.39.39])
        by smtp.gmail.com with ESMTPSA id y5-20020a5d94c5000000b006c05ff4cd91sm2965964ior.35.2022.12.02.11.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 11:32:45 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <21c1eac505e089b2628539dc5e4d9ab2ed1379f8.1670005632.git.pabeni@redhat.com>
References:
 <21c1eac505e089b2628539dc5e4d9ab2ed1379f8.1670005632.git.pabeni@redhat.com>
Subject: Re: mptcp: fix deadlock in fastopen error path.: Tests Results
Message-ID: <68462f55-f41e-a232-7487-e47a4d72580a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Dec 2022 19:32:44 +0000
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
  - Unstable: 2 failed test(s): packetdrill_fastopen selftest_simult_flows =
=F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6580586486693888
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6580586486693888/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4750999138074624
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4750999138074624/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5313949091495936
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5313949091495936/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_fastopen - Critical: 1 Call =
Trace(s) =E2=9D=8C:
  - Task: https://cirrus-ci.com/task/5876899044917248
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5876899044917248/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/797ad66382dc


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

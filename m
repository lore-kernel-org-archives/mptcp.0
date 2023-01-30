Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0488746A
	for <mptcp@lists.linux.dev>; Mon, 30 Jan 2023 19:10:11 +0000 (UTC)
Received: by mail-oi1-f182.google.com with SMTP id bg12so4299245oib.5
        for <mptcp@lists.linux.dev>; Mon, 30 Jan 2023 11:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VCHQaEXUwkFW/5mK48bKswXF5ACyPwsrJn5FCosKwU4=;
        b=EN8DeuKp6ERdTohOykmxqNFupy2DPEAMnuOcyDwwhZK5bOIfpgQsviGO1nkrgUrPsL
         DQ8QFfO52UF8rRSsyNBhGaaR7eNDiSZrn1VL/Wp7rggmhJF7BDybZcgRY7Dyu3JQw1gU
         GpQ0Gve91eYQN2EFDZ6I7duysqF1PLsj2RPTS9hdH+Px17re/uYz2+xbcjnfxGfd1xJD
         rJF1D0sOUCPK9El8NK1oFroKIGdD/8LBfRLK8pJ4xOK5Q//kntbvgS1NnDcF41GL4wYn
         DqNhZRZGyZ9FdIshG8jaznYE5wdgGXXw5EdqFMi+uCJn0D39YFXBJQ3ieJnP0ovH67uT
         c5kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VCHQaEXUwkFW/5mK48bKswXF5ACyPwsrJn5FCosKwU4=;
        b=MzkxSPQ5OY9ohAJldoIOU/CiOFBamFOCveX/RkZXhhgQnrZSSVasF+9z17AqSTmi3u
         mxk/sek2C0enm5aUiyA1Ov0pAHrYP1UPxNR0YzXvKUi+Y2ReXTcq5tItgIiBBuq3UXDV
         9bq0/GRp7vqLTk0AZ/VD9/fbqoPCc1ihunCqdk/Js1fqChADjXas3IKiQX+md/pe/FSe
         GE4UlhzkrH892Tm5EX8ZHPRhsuR3g+fRhnpJOaMy4Ck2RWiWsoGVUnepBCl69svqCOmr
         eYgITTCJkBPkOmIdGKNEPiLDosqvdzl0P8RUT0s2CwiaUtnW1iZPxAwfimdu4cHYZyCU
         QrwQ==
X-Gm-Message-State: AO0yUKUrD1xsSoYxblM7s+FRFVTclIe76atBRZZnZY1VgnZ5/eJ/hRDv
	kr0FEWsMszGjTvvvUR3SaPUQPeW6rLOc
X-Google-Smtp-Source: AK7set+fRqaTmho6cICtwoUmBGGRawqSu/2c+MpnJM/2bg/wWZkNtDF2SyP+PtZvgr/TubC/mR7M9w==
X-Received: by 2002:a05:6808:ab9:b0:378:69f4:7f6c with SMTP id r25-20020a0568080ab900b0037869f47f6cmr1096731oij.43.1675105811064;
        Mon, 30 Jan 2023 11:10:11 -0800 (PST)
Received: from [127.0.0.1] ([104.210.133.20])
        by smtp.gmail.com with ESMTPSA id v7-20020a9d6047000000b006705829996fsm5646873otj.56.2023.01.30.11.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 11:10:10 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <9da09e4407af3ccd51489686c71a3c07c2cb6d3b.1675101940.git.pabeni@redhat.com>
References:
 <9da09e4407af3ccd51489686c71a3c07c2cb6d3b.1675101940.git.pabeni@redhat.com>
Subject: Re: selftests: mptcp: allow more slack for slow test-case: Tests
 Results
Message-ID: <8c833adf-70f9-a50b-852a-d79a02803016@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 30 Jan 2023 19:10:09 +0000
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
com/task/4537600099221504
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4537600099221504/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5663500006064128
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5663500006064128/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6226449959485440
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6226449959485440/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5100550052642816
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5100550052642816/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/c50fd91fa646


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

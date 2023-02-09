Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862492F29
	for <mptcp@lists.linux.dev>; Thu,  9 Feb 2023 18:57:31 +0000 (UTC)
Received: by mail-qt1-f181.google.com with SMTP id q13so3140578qtx.2
        for <mptcp@lists.linux.dev>; Thu, 09 Feb 2023 10:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49YvE/uxMhXrR5b2yG/Tl9hCg3mhnGDVVFOfbi7+RvU=;
        b=ELKZliFzTWpt+1AEYbatPUpd4mhk05mC8RyuLQyjrCxNi2MXq+3jQvBnf4HoItDgoJ
         /yXfC3Zvz1XX8GTo+R6MtI48dVvo4Hq1PDLOWFQR2JXlHLOndr9itFwMbcXsfVT3FElG
         6eP0wKrQV1YnbEmOf6DslAkCnH/IFpnmoeeLzbhc7DyVd/i3cNtq/m+0exVp+HIYS4Gm
         vbpEtpeZcE8SqF/0yQL41utulS8sRTln0BK8dYNmZG6EmRkYj6eFAigd9N4XfG/I26Di
         srrJR0+5I4IoQlq9V/jrzbytHQPN1K+WtaLOMTJrw1Kh+EYOEnQH65XhrNZEciknJhEu
         V2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=49YvE/uxMhXrR5b2yG/Tl9hCg3mhnGDVVFOfbi7+RvU=;
        b=LF4j3PEd33IHMY1XkTXjKaXdzWcQeCzT528hLeQh8nXjFpL/ZoOWGjWyC4NvYgU8vs
         6AiOI4u4DCOhjlX2uK7S+cF8xo/ZwTLXhT7UjhuluHcLJvLG/fPJaPz8kX6uqgC3U/1L
         OuZIOrg+ilt6Tp+w+2oBhSHBiBCeMOf4Ft/oVNJYcZsmjDJ0ldX/FC731zBD3DEsEiHW
         4tk7rRjb1Uhqiv5KUdgfjQuE9nmXqmQHWhEQEsps5upWNK3XirkR5lgsvkw6m+LsBNOM
         yAVrjfXnnmKsWeV64dumWA26flDuwfh53qkPxnXRgPgswUIS2nJqf7lsNjZkGI50EhOS
         Z7UA==
X-Gm-Message-State: AO0yUKX7QKl6zXnEAWgr3xlJWYortWt/l3QRbGZ5f0suS4QtTg6iQJME
	HvTkywe5/wVsTn9xZvkBHA==
X-Google-Smtp-Source: AK7set/UnvGQzeeDByTUBo2uFpYM5GieNfA7tYmfRk2ymRGmBbr+jvMYdOWb/wvQpnmDrO66mbFtDg==
X-Received: by 2002:a05:622a:244:b0:3b9:b450:61f6 with SMTP id c4-20020a05622a024400b003b9b45061f6mr19078401qtx.62.1675969050446;
        Thu, 09 Feb 2023 10:57:30 -0800 (PST)
Received: from [127.0.0.1] ([172.176.193.178])
        by smtp.gmail.com with ESMTPSA id d186-20020a3768c3000000b006fa7b5ea2d1sm1881966qkc.125.2023.02.09.10.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 10:57:29 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <e65dfb17e0aeed03dbbebc4ef4559fe3ca349354.1675892307.git.pabeni@redhat.com>
References:
 <e65dfb17e0aeed03dbbebc4ef4559fe3ca349354.1675892307.git.pabeni@redhat.com>
Subject: Re: mptcp: fix UaF in listener shutdown: Tests Results
Message-ID: <d3666b9f-636c-2415-0b83-e57529047adf@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Feb 2023 18:57:29 +0000
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
  - Critical: 1 Call Trace(s) =E2=9D=8C:
  - Task: https://cirrus-ci.=
com/task/5329004899598336
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5329004899598336/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Critical: 1 Call Trace(s) =E2=9D=8C:
  - Task: https://cirrus-ci.=
com/task/5047529922887680
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5047529922887680/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6454904806440960
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6454904806440960/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6173429829730304
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6173429829730304/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/cbc3e5c367d4


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
